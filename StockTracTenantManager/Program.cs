using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Diagnostics;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement.Schema;
using System.Text.RegularExpressions;
using Microsoft.AspNet.Identity;

namespace TenantManager
{
	internal class Program
	{
		private const ConsoleColor EnabledColor = ConsoleColor.White; // color for items that are expected to succeed
		private const ConsoleColor DisabledColor = ConsoleColor.DarkGray; // color for items that are expected to fail
		private const ConsoleColor DangerColor = ConsoleColor.Red; // color for actions that are dangerous invoke

		/// <summary>
		/// The shard map manager, or null if it does not exist.
		/// It is recommended that you keep only one shard map manager instance in
		/// memory per AppDomain so that the mapping cache is not duplicated.
		/// </summary>
		private static ShardMapManager shardMapManager;
		private static List<string> userNames;

		public static void Main()
		{
			// Welcome screen
			Console.WriteLine("***********************************************************");
			Console.WriteLine("***          Tenant Manager    ***");
			Console.WriteLine();

			string integratedSecurityString = ConfigurationManager.AppSettings["IntegratedSecurity"];
			bool integratedSecurity = integratedSecurityString != null && bool.Parse(integratedSecurityString);

			Console.WriteLine(integratedSecurity
												? $"***    CONNECTED TO LOCAL DEVELOPMENT    ***"
												: "***          CONNECTED            ***");
			Console.WriteLine("***********************************************************");
			Console.WriteLine();

			//}

			// Verify that we can connect to the Sql Database that is specified in App.config settings
			if (!SqlDatabaseUtils.TryConnectToSqlDatabase())
			{
				// Connecting to the server failed - please update the settings in App.Config

				// Give the user a chance to read the mesage, if this program is being run
				// in debug mode in Visual Studio
				if (Debugger.IsAttached)
				{
					Console.WriteLine("Press ENTER to continue...");
					Console.ReadLine();
				}

				return;
			}

			// Connection succeeded. Begin interactive loop
			MenuLoop();
		}


		#region Program control flow

		/// <summary>
		/// Main program loop.
		/// </summary>
		private static void MenuLoop()
		{
			// Get the shard map manager, if it already exists.
			shardMapManager = ShardManagementUtils.TryGetShardMapManager(
				Configuration.ServerName,
				Configuration.ShardMapManagerDatabaseName);

			userNames = SqlDatabaseUtils.GetAllTenantUserLookups();

			// Loop until the user chose "Exit".
			bool continueLoop;
			do
			{
				PrintShardMapState();
				Console.WriteLine();

				PrintMenu();
				Console.WriteLine();

				continueLoop = GetMenuChoiceAndExecute();
				Console.WriteLine();
			}
			while (continueLoop);
		}

		/// <summary>
		/// Writes the shard map's state to the console.
		/// </summary>
		private static void PrintShardMapState()
		{
			Console.WriteLine("Current tenant database names in use:");
			ListShardMap<int> shardMap = TryGetListShardMap();
			if (shardMap == null)
			{
				return;
			}

			// Get all shards
			IEnumerable<Shard> allShards = shardMap.GetShards();

			// Get all mappings, grouped by the shard that they are on. We do this all in one go to minimise round trips.
			ILookup<Shard, PointMapping<int>> mappingsGroupedByShard = shardMap.GetMappings().ToLookup(m => m.Shard);

			if (allShards.Any())
			{
				// The shard map contains some shards, so for each shard (sorted by database name)
				// write out the mappings for that shard
				foreach (Shard shard in shardMap.GetShards().OrderBy(s => s.Location.Database))
				{
					IEnumerable<PointMapping<int>> mappingsOnThisShard = mappingsGroupedByShard[shard];

					if (mappingsOnThisShard.Any())
					{
						string mappingsString = string.Join(", ", mappingsOnThisShard.Select(m => m.Value));
						Console.WriteLine("\t{0}", shard.Location.Database);
						//Console.WriteLine("\t{0} (key {1})", shard.Location.Database, mappingsString);
					}
					else
					{
						Console.WriteLine("\t{0} contains no key.", shard.Location.Database);
					}
				}
			}
			else
			{
				Console.WriteLine("\tShard Map contains no shards");
			}
		}

		/// <summary>
		/// Writes the program menu.
		/// </summary>
		private static void PrintMenu()
		{
			ConsoleColor createSmmColor; // color for create shard map manger menu item
			ConsoleColor otherMenuItemColor; // color for other menu items
			if (shardMapManager == null)
			{
				createSmmColor = EnabledColor;
				otherMenuItemColor = DisabledColor;
			}
			else
			{
				createSmmColor = DisabledColor;
				otherMenuItemColor = EnabledColor;
			}

			ConsoleUtils.WriteColor(createSmmColor, "1. Create tenant manager database");
			ConsoleUtils.WriteColor(otherMenuItemColor, "2. Add a new Customer database");
			ConsoleUtils.WriteColor(otherMenuItemColor, "3. DELETE Customer database and its user logins");
			ConsoleUtils.WriteColor(EnabledColor, "4. Exit");
		}

		/// <summary>
		/// Gets the user's chosen menu item and executes it.
		/// </summary>
		/// <returns>true if the program should continue executing.</returns>
		private static bool GetMenuChoiceAndExecute()
		{
			while (true)
			{
				int inputValue = ConsoleUtils.ReadIntegerInput("Enter an option [1-4] and press ENTER: ");

				switch (inputValue)
				{
					case 1: // Create shard map manager
						Console.WriteLine();
						CreateShardMapManagerAndShard();
						return true;
					case 2: // Add shard
						Console.WriteLine();
						AddShard();
						return true;
					case 3: // Drop Shard
						Console.WriteLine();
						DropCustomerDatabaseAndLogins();
						return true;
					case 4: // Exit
						return false;
				}
			}
		}

		#endregion

		#region Menu item implementations

		/// <summary>
		/// Creates a shard map manager, creates a shard map, and creates a shard
		/// with a mapping for the full range of 32-bit integers.
		/// </summary>
		private static void CreateShardMapManagerAndShard()
		{
			if (shardMapManager != null)
			{
				ConsoleUtils.WriteWarning("Shard Map Manager already exists");
				return;
			}

			// Create shard map manager database
			if (!SqlDatabaseUtils.DatabaseExists(Configuration.ServerName, Configuration.ShardMapManagerDatabaseName))
			{
				SqlDatabaseUtils.CreateDatabase(Configuration.ServerName, Configuration.ShardMapManagerDatabaseName);
			}

			// Create shard map manager
			string shardMapManagerConnectionString =
				Configuration.GetConnectionString(
					Configuration.ServerName,
					Configuration.ShardMapManagerDatabaseName);

			shardMapManager = ShardManagementUtils.CreateOrGetShardMapManager(shardMapManagerConnectionString);

			// Create shard map
			ShardManagementUtils.CreateOrGetListShardMap<int>(shardMapManager, Configuration.ShardMapName);
		}

		/// <summary>
		/// Creates schema info for the schema defined in Structure.sql.
		/// </summary>
		private static void CreateSchemaInfo(string shardMapName)
		{
			// Create schema info
			SchemaInfo schemaInfo = new SchemaInfo();

			// Register it with the shard map manager for the given shard map name
			shardMapManager.GetSchemaInfoCollection().Add(shardMapName, schemaInfo);
		}

		/// <summary>
		/// Reads the user's choice of Database Name.
		/// </summary>
		private static void AddShard()
		{
			ListShardMap<int> shardMap = TryGetListShardMap();
			if (shardMap != null)
			{
				string databaseName = GetDatabaseNameFromUser();

				string companyName = GetCompanyNameFromUser();

				Console.WriteLine("Please enter the Admin user's Email.");
				string email = Console.ReadLine();

				Console.WriteLine("Please enter a strong password for the Customer's Admin User.");
				string password = Console.ReadLine();

				GetSystemOfMeasurementFromUser(out int systemOfMeasurement, out string systemOfMeasurementName);

				int dataOption = GetDataOptionFromUser();

				Console.WriteLine();
				Console.WriteLine($"Creating: {databaseName} using {systemOfMeasurementName} system of measurement");
				CreateShardSample.CreateShard(shardMap, databaseName, dataOption, systemOfMeasurement);

				var tenantId = SqlDatabaseUtils.TryGetShardId(databaseName);
				Console.WriteLine($"ShardId: {tenantId}");

				//Insert new tenant row in IdentityTenants.dbo.AspNetTenants table
				var success = SqlDatabaseUtils.InsertNewTenant(databaseName, tenantId, companyName);

				if (success)
				{
					InsertNewTenantAdminUser(email, email, password, tenantId, databaseName);
					userNames.Add(email);
				}

				AzureStorageUtils.CreateTenantStorageContainer(databaseName);
			}
		}

		private static int GetDataOptionFromUser()
		{
			Console.WriteLine("1. Create blank database");
			Console.WriteLine("2. Create demo database");
			int dataOption = ConsoleUtils.ReadIntegerInput("Enter an option [1-2] and press ENTER: ");
			while (dataOption < 0 || dataOption > 2)
				dataOption = ConsoleUtils.ReadIntegerInput("Enter an option [1-2] and press ENTER: ");
			return dataOption;
		}

		private static void GetSystemOfMeasurementFromUser(out int systemOfMeasurement, out string somString)
		{
			Console.WriteLine("1. This customer uses the English system of measurement.");
			Console.WriteLine("2. This customer uses the Metric system of measurement.");
			systemOfMeasurement = ConsoleUtils.ReadIntegerInput("Enter an option [1-2] and press ENTER: ");
			while (systemOfMeasurement < 0 || systemOfMeasurement > 2)
				systemOfMeasurement = ConsoleUtils.ReadIntegerInput("Enter an option [1-2] and press ENTER: ");
			somString = (systemOfMeasurement == 1) ? "English" : "Metric";
		}

		private static string GetCompanyNameFromUser()
		{
			Console.WriteLine("Please enter the Customer's Company Name as you would like it to display.");
			Console.WriteLine("Your entry will be displayed on the StockTrac app when users from this company are logged in.");
			string companyName = Console.ReadLine();
			return companyName;
		}

		private static string GetDatabaseNameFromUser()
		{
			Console.WriteLine("Please enter the Customer's Company Name as the new tenant (database) name.");
			Console.WriteLine("Your entry will be converted to all lowercase, all spaces removed.");
			string databaseName = Console.ReadLine().ToLower();
			databaseName = Regex.Replace(databaseName, @"\s", "");
			return databaseName;
		}

		private static void InsertNewTenantAdminUser(string userName, string email, string password, Guid tenantId, string tenantName)
		{
			// Hash the user's password
			var hasher = new PasswordHasher();
			var hashed = hasher.HashPassword(password);
			// Verify that the user's password was hashed successfully
			var result = hasher.VerifyHashedPassword(hashed, password);

			if (result == PasswordVerificationResult.Success)
				// Insert new row in IdentityTenants.dbo.AspNetUsers table.
				SqlDatabaseUtils.InsertNewTenantAdminUser(userName, tenantId, hashed, email, tenantName);
		}

		// Summary:
		//     Compares the string with values in the userNames list.
		//     A returned userName indicates success.
		//
		// Parameters:
		//   userName:
		//     A string containing the new userName to lookup.
		//
		//   result:
		//     When this method returns, contains the validated userName if the conversion succeeded, or zero if the conversion
		//     failed. The conversion fails if the userName parameter is null or System.String.Empty,
		//     or already exists in the list of userNames. This parameter is passed uninitialized;
		//     any value originally supplied in result will be overwritten.
		//
		// Returns:
		//     true if userName was converted successfully; otherwise, false.
		private static String TryValidateNewUserName(string userName, out string result)
		{
			if (userNames == null)
				return result = 0.ToString();

			if (userName == null || userName == String.Empty) return result = 0.ToString();

			if (userNames.FirstOrDefault(users => users.Contains(userName)) != null)
				return result = 0.ToString();
			else
				return result = userName;
		}

		/// <summary>
		/// Drops the database of the user-entered customer, related logins, and image storage container.
		/// </summary>
		private static void DropCustomerDatabaseAndLogins()
		{
			Console.WriteLine("Please enter the name of the Customer database to DELETE.");
			string tenantName = Console.ReadLine();

			Console.WriteLine("Please CONFIRM (enter again) the name of the Customer database to DELETE.");
			string confirmTenantName = Console.ReadLine();

			if (string.Equals(tenantName, confirmTenantName, StringComparison.OrdinalIgnoreCase))
			{
				if (DeleteTenantDatabase(tenantName))
				{
					SqlDatabaseUtils.DeleteShard(tenantName);

					if (SqlDatabaseUtils.DeleteTenantUsers(tenantName))
						userNames = SqlDatabaseUtils.GetAllTenantUserLookups();

					SqlDatabaseUtils.DeleteTenant(tenantName);
					AzureStorageUtils.DeleteTenantStorageContainer(tenantName);
				}
				else
					Console.WriteLine("Database DELETE cancelled.");
			}
			else
				Console.WriteLine("Database DELETE cancelled.");
		}

		#endregion

		#region Shard map helper methods

		private static bool DeleteTenantDatabase(string tenantName)
		{
			ConsoleUtils.WriteColor(DangerColor, "WARNING: DATABASE WILL BE DELETED AND NOT RECOVERABLE.");
			Console.WriteLine($"Please enter 'YES' to confirm deletion of '{tenantName}' database");
			string confirm = Console.ReadLine();

			if (!string.Equals(confirm, "YES", StringComparison.CurrentCulture))
				return false;

			ListShardMap<int> shardMap = TryGetListShardMap();
			ShardLocation shardLocation = new ShardLocation(Configuration.ServerName, tenantName);
			bool shardExists = shardMap.TryGetShard(shardLocation, out Shard shard);

			if (shardExists)
			{
				SqlDatabaseUtils.DropDatabase(shard.Location.DataSource, shard.Location.Database);
				ConsoleUtils.WriteWarning($"DELETED database '{tenantName}'.");
			}

			return shardExists;
		}

		private static ListShardMap<int> TryGetListShardMap()
		{
			if (shardMapManager == null)
			{
				ConsoleUtils.WriteWarning("Shard Map Manager has not yet been created");
				return null;
			}

			ListShardMap<int> shardMap;
			bool mapExists = shardMapManager.TryGetListShardMap(Configuration.ShardMapName, out shardMap);

			if (!mapExists)
			{
				ConsoleUtils.WriteWarning("Shard Map Manager has been created, but the Shard Map has not been created");
				return null;
			}

			return shardMap;
		}

		#endregion
	}
}
