using Microsoft.Practices.EnterpriseLibrary.TransientFaultHandling;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Threading;

namespace TenantManager
{
	/// <summary>
	/// Helper methods for interacting with SQL Databases.
	/// </summary>
	internal static class SqlDatabaseUtils
	{
		/// <summary>
		/// SQL master database name.
		/// </summary>
		public const string MasterDatabaseName = "master";

		/// <summary>
		/// Returns true if we can connect to the database.
		/// </summary>
		public static bool TryConnectToSqlDatabase()
		{
			string connectionString =
				Configuration.GetConnectionString(
					Configuration.ServerName,
					MasterDatabaseName);

			try
			{
				using (ReliableSqlConnection conn = new ReliableSqlConnection(
					connectionString,
					SqlRetryPolicy,
					SqlRetryPolicy))
				{
					conn.Open();
				}

				return true;
			}
			catch (SqlException e)
			{
				ConsoleUtils.WriteWarning("Failed to connect to SQL database with connection string:");
				Console.WriteLine("\n{0}\n", connectionString);
				ConsoleUtils.WriteWarning("If this connection string is incorrect, please update the Sql Database settings in App.Config.\n\nException message: {0}", e.Message);
				return false;
			}
		}

		public static bool DatabaseExists(string server, string db)
		{
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(server, MasterDatabaseName),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "select count(*) from sys.databases where name = @dbname";
				cmd.Parameters.AddWithValue("@dbname", db);
				cmd.CommandTimeout = 60;
				int count = conn.ExecuteCommand<int>(cmd);

				bool exists = count > 0;
				return exists;
			}
		}

		public static bool DatabaseIsOnline(string server, string db)
		{
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(server, MasterDatabaseName),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "select count(*) from sys.databases where name = @dbname and state = 0"; // online
				cmd.Parameters.AddWithValue("@dbname", db);
				cmd.CommandTimeout = 60;
				int count = conn.ExecuteCommand<int>(cmd);

				bool exists = count > 0;
				return exists;
			}
		}

		public static void CreateDatabase(string server, string db)
		{
			ConsoleUtils.WriteInfo("Creating database {0}", db);
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(server, MasterDatabaseName),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();
				SqlCommand cmd = conn.CreateCommand();

				// Determine if we are connecting to Azure SQL DB
				cmd.CommandText = "SELECT SERVERPROPERTY('EngineEdition')";
				cmd.CommandTimeout = 60;
				int engineEdition = conn.ExecuteCommand<int>(cmd);

				if (engineEdition == 5)
				{
					// Azure SQL DB
					SqlRetryPolicy.ExecuteAction(() =>
					{
						if (!DatabaseExists(server, db))
						{
							if (Configuration.UseElasticPool)
							{
							// Begin creation (which is async for Standard/Premium editions)
							cmd.CommandText = $"CREATE DATABASE {BracketEscapeName(db)} (EDITION = '{Configuration.DatabaseEdition}', SERVICE_OBJECTIVE = {Configuration.ServiceObjective})";
							}
							else
							{
								cmd.CommandText = $"CREATE DATABASE {BracketEscapeName(db)} (EDITION = '{Configuration.DatabaseEdition}')";
							}
							cmd.CommandTimeout = 120;
							cmd.ExecuteNonQuery();
						}
					});

					// Wait for the operation to complete
					while (!DatabaseIsOnline(server, db))
					{
						ConsoleUtils.WriteInfo("Waiting for database {0} to come online...", db);
						Thread.Sleep(TimeSpan.FromSeconds(5));
					}

					ConsoleUtils.WriteInfo("Database {0} is online", db);
				}
				else
				{
					// Other edition of SQL DB
					cmd.CommandText = string.Format("CREATE DATABASE {0}", BracketEscapeName(db));
					conn.ExecuteCommand(cmd);
				}
			}
		}

		public static void DropDatabase(string server, string db)
		{
			ConsoleUtils.WriteInfo("Deleting database '{0}'", db);
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(server, MasterDatabaseName),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();
				SqlCommand cmd = conn.CreateCommand();

				// Determine if we are connecting to Azure SQL DB
				cmd.CommandText = "SELECT SERVERPROPERTY('EngineEdition')";
				cmd.CommandTimeout = 60;
				int engineEdition = conn.ExecuteCommand<int>(cmd);

				// Drop the database
				if (engineEdition == 5)
				{
					// Azure SQL DB

					cmd.CommandText = string.Format("DROP DATABASE {0}", BracketEscapeName(db));
					cmd.ExecuteNonQuery();
				}
				else
				{
					cmd.CommandText = string.Format(
						@"ALTER DATABASE {0} SET SINGLE_USER WITH ROLLBACK IMMEDIATE
						DROP DATABASE {0}",
						BracketEscapeName(db));
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Tries to get the ShardId of the specified database.
		/// </summary>
		public static Guid TryGetShardId(string databaseName)
		{
			string shardMapManagerConnectionString =
					Configuration.GetConnectionString(
						Configuration.ServerName,
						Configuration.ShardMapManagerDatabaseName);

			if (!DatabaseExists(Configuration.ServerName, databaseName))
			{
				// database does not exist so return a new Guid, initialied with all 0s.
				return new Guid();
			}

			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(
					Configuration.ServerName,
					Configuration.ShardMapManagerDatabaseName),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "SELECT [ShardId] FROM [__ShardManagement].[ShardsGlobal] WHERE [DatabaseName] = @dbname";
				cmd.Parameters.AddWithValue("@dbname", databaseName);
				cmd.CommandTimeout = 60;
				Guid tenantId = conn.ExecuteCommand<Guid>(cmd);

				return tenantId;
			}
		}

		internal static bool InsertNewTenantAdminUser(string userName, Guid tenantId, string passwordHash, string email, string tenantName)
		{
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
					Configuration.GetConnectionString(
						Configuration.IdentityTenantsServerName,
						Configuration.IdentityTenantsDatabaseName),
					SqlRetryPolicy,
					SqlRetryPolicy))
			{
				string role = "Admin";

				conn.Open();
				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = @"INSERT INTO [dbo].[AspNetUsers] (
											 [Id]
											 ,[UserName]
											 ,[NormalizedUserName]
											 ,[Email]
											 ,[NormalizedEmail]
											 ,[EmailConfirmed]
											 ,[PasswordHash]
											 ,[SecurityStamp]
											 ,[PhoneNumberConfirmed]
											 ,[TwoFactorEnabled]
											 ,[LockoutEnabled]
											 ,[AccessFailedCount]
											 ,[Role]
											 ,[TenantId]
											 ,[TenantName])
											 VALUES (
											 @id
											 ,@userName
											 ,@normalizedUserName
											 ,@email
											 ,@normalizedEmail
											 ,@emailConfirmed
											 ,@passwordHash
											 ,@securityStamp
											 ,@phoneNumberConfirmed
											 ,@twoFactorEnabled
											 ,@lockoutEnabled
											 ,@accessFailedCount
											 ,@role
											 ,@tenantId
											 ,@tenantName)";
				cmd.Parameters.AddWithValue("@id", Guid.NewGuid().ToString().ToLower());
				cmd.Parameters.AddWithValue("@userName", userName);
				cmd.Parameters.AddWithValue("@normalizedUserName", userName.ToUpper());
				cmd.Parameters.AddWithValue("@email", email);
				cmd.Parameters.AddWithValue("@normalizedEmail", email.ToUpper());
				cmd.Parameters.AddWithValue("@emailConfirmed", true);
				cmd.Parameters.AddWithValue("@passwordHash", passwordHash);
				cmd.Parameters.AddWithValue("@securityStamp", Guid.NewGuid());
				cmd.Parameters.AddWithValue("@phoneNumberConfirmed", false);
				cmd.Parameters.AddWithValue("@twoFactorEnabled", false);
				cmd.Parameters.AddWithValue("@lockoutEnabled", false);
				cmd.Parameters.AddWithValue("@accessFailedCount", 0);
				cmd.Parameters.AddWithValue("@role", role);
				cmd.Parameters.AddWithValue("@tenantId", tenantId);
				cmd.Parameters.AddWithValue("@tenantName", tenantName);
				cmd.CommandTimeout = 60;
				int count = conn.ExecuteCommand<int>(cmd);
				ConsoleUtils.WriteInfo("{0} Admin user created in AspNetUsers table", userName);

				bool exists = count > 0;
				return exists;
			}
		}

		internal static bool InsertNewTenant(string databaseName, Guid id, string companyName)
		{
			ConsoleUtils.WriteInfo("Creating new Tenant {0}", databaseName);
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
					Configuration.GetConnectionString(
						Configuration.IdentityTenantsServerName,
						Configuration.IdentityTenantsDatabaseName),
					SqlRetryPolicy,
					SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "INSERT INTO [dbo].[AspNetTenants] ([Id],[Name],[CompanyName]) output INSERTED.Id VALUES (@id,@name,@companyName)";
				cmd.Parameters.AddWithValue("@id", id);
				cmd.Parameters.AddWithValue("@name", databaseName);
				cmd.Parameters.AddWithValue("@companyName", companyName);
				cmd.CommandTimeout = 60;
				Guid newId = (Guid)cmd.ExecuteScalar();
				ConsoleUtils.WriteInfo("{0} Created in AspNetTenants table for {1} with Id {2}", databaseName, companyName, id);
				// Return the new Id if successful, otherwise return an empty Guid
				if (newId == id)
					return true;
				else
					return false;
			}
		}

		internal static bool DeleteTenant(string tenantName)
		{
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
					Configuration.GetConnectionString(
						Configuration.IdentityTenantsServerName,
						Configuration.IdentityTenantsDatabaseName),
					SqlRetryPolicy,
					SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "DELETE FROM [dbo].[AspNetTenants] WHERE [Name] = @p_TenantName";
				cmd.Parameters.AddWithValue("@p_TenantName", tenantName);
				cmd.CommandTimeout = 60;
				int result = conn.ExecuteCommand(cmd);
				ConsoleUtils.WriteInfo($"Deleted tenant '{tenantName}' from Identity Service/Secure Token Service");

				return result > 0 ? true : false;
			}
		}

		internal static bool DeleteTenantUsers(string tenantName)
		{
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
					Configuration.GetConnectionString(
						Configuration.IdentityTenantsServerName,
						Configuration.IdentityTenantsDatabaseName),
					SqlRetryPolicy,
					SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "DELETE FROM [dbo].[AspNetUsers] WHERE TenantId = (SELECT TOP (1) Id FROM [dbo].[AspNetTenants] WHERE [Name] = @p_TenantName)";
				cmd.Parameters.AddWithValue("@p_TenantName", tenantName);
				cmd.CommandTimeout = 60;
				int result = conn.ExecuteCommand(cmd);
				ConsoleUtils.WriteInfo($"Deleted logins for '{tenantName}' from Identity Service/Secure Token Service");

				return result > 0 ? true : false;
			}
		}

		internal static bool DeleteShard(string tenantName)
		{
			string shardMapManagerConnectionString =
					Configuration.GetConnectionString(
						Configuration.ServerName,
						Configuration.ShardMapManagerDatabaseName);

			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(
					Configuration.ServerName,
					Configuration.ShardMapManagerDatabaseName),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();

				SqlCommand cmd = conn.CreateCommand();
				cmd.CommandText = "DELETE FROM [__ShardManagement].[ShardMappingsGlobal] WHERE [ShardId] = (SELECT TOP (1) [ShardId] FROM [__ShardManagement].[ShardsGlobal] WHERE [DatabaseName] = @dbname)";
				cmd.Parameters.AddWithValue("@dbname", tenantName);
				cmd.CommandTimeout = 60;
				var result = conn.ExecuteCommand(cmd);

				string message = (result > 0) ? $"Deleted Shard mapping global record for '{tenantName}'." : $"Shard mapping global record FAILED to delete for '{tenantName}'.";

				ConsoleUtils.WriteInfo(message);

				bool deleted = result > 0 ? true : false;

				cmd = conn.CreateCommand();
				cmd.CommandText = "DELETE FROM [__ShardManagement].[ShardsGlobal] WHERE [DatabaseName] = @dbname";
				cmd.Parameters.AddWithValue("@dbname", tenantName);
				cmd.CommandTimeout = 60;
				result = conn.ExecuteCommand(cmd);

				message = result > 0 ? $"Deleted Shard global record for '{tenantName}'." : $"Shard global record FAILED to delete for '{tenantName}'.";

				ConsoleUtils.WriteInfo(message);

				return deleted && (result > 0);
			}
		}

		public static List<string> GetAllTenantUserLookups()
		{
			List<string> userNames = new List<string>();

			using (SqlConnection connection = new SqlConnection(Configuration.GetConnectionString(
						Configuration.IdentityTenantsServerName,
						Configuration.IdentityTenantsDatabaseName)))
			{
				try
				{
					connection.Open();
					string query = "SELECT [UserName] FROM [dbo].[AspNetUsers]";
					using (SqlCommand command = new SqlCommand(query, connection))
					{
						using (SqlDataReader reader = command.ExecuteReader())
						{
							while (reader.Read())
							{
								userNames.Add(reader.GetString(0));
							}
						}
					}
				}
				catch (Exception ex)
				{
					Console.WriteLine(ex);
					return null;
				}
			}

			return userNames;
		}

		public static void ExecuteSqlScript(string server, string db, string scriptFile)
		{
			ConsoleUtils.WriteInfo("Executing script {0}", scriptFile);
			using (ReliableSqlConnection conn = new ReliableSqlConnection(
				Configuration.GetConnectionString(server, db),
				SqlRetryPolicy,
				SqlRetryPolicy))
			{
				conn.Open();
				SqlCommand cmd = conn.CreateCommand();

				// Read the commands from the sql script file
				IEnumerable<string> commands = ReadSqlScript(scriptFile);

				foreach (string command in commands)
				{
					cmd.CommandText = command;
					cmd.CommandTimeout = 120;
					conn.ExecuteCommand(cmd);
				}
			}
		}

		private static IEnumerable<string> ReadSqlScript(string scriptFile)
		{
			List<string> commands = new List<string>();
			using (TextReader tr = new StreamReader(scriptFile))
			{
				StringBuilder sb = new StringBuilder();
				string line;
				while ((line = tr.ReadLine()) != null)
				{
					if (line == "GO")
					{
						commands.Add(sb.ToString());
						sb.Clear();
					}
					else
					{
						sb.AppendLine(line);
					}
				}
			}

			return commands;
		}

		/// <summary>
		/// Escapes a SQL object name with brackets to prevent SQL injection.
		/// </summary>
		private static string BracketEscapeName(string sqlName)
		{
			return '[' + sqlName.Replace("]", "]]") + ']';
		}

		/// <summary>
		/// Gets the retry policy to use for connections to SQL Server.
		/// </summary>
		public static RetryPolicy SqlRetryPolicy
		{
			get
			{
				return new RetryPolicy<ExtendedSqlDatabaseTransientErrorDetectionStrategy>(10, TimeSpan.FromSeconds(5));
			}
		}

		/// <summary>
		/// Extended sql transient error detection strategy that performs additional transient error
		/// checks besides the ones done by the enterprise library.
		/// </summary>
		private class ExtendedSqlDatabaseTransientErrorDetectionStrategy : ITransientErrorDetectionStrategy
		{
			/// <summary>
			/// Enterprise transient error detection strategy.
			/// </summary>
			private SqlDatabaseTransientErrorDetectionStrategy sqltransientErrorDetectionStrategy = new SqlDatabaseTransientErrorDetectionStrategy();

			/// <summary>
			/// Checks with enterprise library's default handler to see if the error is transient, additionally checks
			/// for such errors using the code in the in <see cref="IsTransientException"/> function.
			/// </summary>
			/// <param name="ex">Exception being checked.</param>
			/// <returns><c>true</c> if exception is considered transient, <c>false</c> otherwise.</returns>
			public bool IsTransient(Exception ex)
			{
				return sqltransientErrorDetectionStrategy.IsTransient(ex) || IsTransientException(ex);
			}

			/// <summary>
			/// Detects transient errors not currently considered as transient by the enterprise library's strategy.
			/// </summary>
			/// <param name="ex">Input exception.</param>
			/// <returns><c>true</c> if exception is considered transient, <c>false</c> otherwise.</returns>
			private static bool IsTransientException(Exception ex)
			{
				SqlException se = ex as SqlException;

				if (se != null && se.InnerException != null)
				{
					Win32Exception we = se.InnerException as Win32Exception;

					if (we != null)
					{
						switch (we.NativeErrorCode)
						{
							case 0x102:
								// Transient wait expired error resulting in timeout
								return true;
							case 0x121:
								// Transient semaphore wait expired error resulting in timeout
								return true;
						}
					}
				}

				return false;
			}
		}
	}
}
