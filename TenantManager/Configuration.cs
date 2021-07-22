using System.Configuration;
using System.Data.SqlClient;

namespace TenantManager
{
    /// <summary>
    /// Provides access to app.config settings, and contains advanced configuration settings.
    /// </summary>
    internal static class Configuration
    {
        /// <summary>
        /// Gets the server name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static string AppServerNameProduction
        {
            get { return ConfigurationManager.AppSettings["AppServerNameProduction"]; }
        }

        /// <summary>
        /// Gets the server name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static string AppServerNameDevelopment
        {
            get { return ConfigurationManager.AppSettings["AppServerNameDevelopment"]; }
        }

        /// <summary>
        /// Gets the server name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static bool IsDevelopment
        {
            get { return bool.Parse(ConfigurationManager.AppSettings["IsDevelopment"] ?? "false"); }
        }

        /// <summary>
        /// Gets the database name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static string ShardMapManagerDatabaseName
        {
            get { return ConfigurationManager.AppSettings["ShardMapManagerDatabaseName"]; }
        }

        /// <summary>
        /// Gets the server name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static string IdentityTenantsServerNameDevelopment
        {
            get { return ConfigurationManager.AppSettings["IdentityTenantsServerNameDevelopment"]; }
        }

        /// <summary>
        /// Gets the server name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static string IdentityTenantsServerNameProduction
        {
            get { return ConfigurationManager.AppSettings["IdentityTenantsServerNameProduction"]; }
        }

        /// <summary>
        /// Gets the database name for the Shard Map Manager database, which contains the shard maps.
        /// </summary>
        public static string IdentityTenantsDatabaseName
        {
            get { return ConfigurationManager.AppSettings["IdentityTenantsDatabaseName"]; }
        }

        /// <summary>
        /// Gets the name for the Shard Map that contains metadata for all the shards and the mappings to those shards.
        /// </summary>
        public static string ShardMapName
        {
            get { return ConfigurationManager.AppSettings["ShardMapName"]; }
        }

        /// <summary>
        /// Gets the edition to use for Shards and Shard Map Manager Database if the server is an Azure SQL DB server.
        /// If the server is a regular SQL Server then this is ignored.
        /// </summary>
        public static string DatabaseEdition
        {
            get
            {
                return ConfigurationManager.AppSettings["DatabaseEdition"];
            }
        }

        /// <summary>
        /// Gets the edition to use for Shards and Shard Map Manager Database if the server is an Azure SQL DB server.
        /// If the server is a regular SQL Server then this is ignored.
        /// </summary>
        public static bool UseElasticPool
        {
            get
            {
                return ConfigurationManager.AppSettings["UseElasticPool"] == "true";
            }
        }

        /// <summary>
        /// Gets the Pricing Tier, aka performance level, aka SERVICE_OBJECTIVE to use for Shards if on Azure SQL DB.
        /// If the server is a regular SQL Server then this is ignored.
        /// </summary>
        public static string ServiceObjective
        {
            get
            {
                return ConfigurationManager.AppSettings["ServiceObjective"];
            }
        }

        /// <summary>
        /// Returns a connection string that can be used to connect to Azure Storage.
        /// </summary>
        public static string AzureStorageConnectionString
        {
            get
            {
                return ConfigurationManager.AppSettings["AzureStorageConnectionString"];
            }
        }

        /// <summary>
        /// Returns a connection string that can be used to connect to the specified server and database.
        /// </summary>
        public static string GetConnectionString(string serverName, string database, bool isIdentity)
        {

            SqlConnectionStringBuilder connStr = new SqlConnectionStringBuilder
            {
                DataSource = serverName,
                InitialCatalog = database,
                UserID = isIdentity ? Credentials.UserNameIdentityUsers : Credentials.UserName,
                Password = isIdentity ? Credentials.PasswordIdentityUsers : Credentials.Password,
                IntegratedSecurity = IsDevelopment,
                ApplicationName = "Tenant Manager v1.0",
                ConnectTimeout = 30
            };

            return connStr.ToString();
        }

        private static class Credentials
        {
            public static string UserName => GetUserName();
            public static string Password => GetPassword();
            public static string UserNameIdentityUsers => GetUserNameIdentityUsers();
            public static string PasswordIdentityUsers => GetPasswordIdentityUsers();

            private static string GetUserName()
            {
                return ConfigurationManager.AppSettings["UserName"] ?? string.Empty;
            }

            private static string GetPassword()
            {
                return ConfigurationManager.AppSettings["Password"] ?? string.Empty;
            }

            private static string GetUserNameIdentityUsers()
            {
                return ConfigurationManager.AppSettings["UserNameIdentityUsers"] ?? string.Empty;
            }

            private static string GetPasswordIdentityUsers()
            {
                return ConfigurationManager.AppSettings["PasswordIdentityUsers"] ?? string.Empty;
            }
        }
    }
}
