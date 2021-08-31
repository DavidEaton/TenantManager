using System;
using System.Collections.Generic;
using System.Linq;
using System.Diagnostics;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using System.Text.RegularExpressions;
using Microsoft.AspNet.Identity;
using TenantManager.Enums;

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
            GreetUser();

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

        private static void GreetUser()
        {
            Console.WriteLine("***********************************************************");
            Console.WriteLine("***          Tenant Manager    ***");
            Console.WriteLine();

            Console.WriteLine(Configuration.IsDevelopment
                                                ? $"***    Connected to local development    ***"
                                                : "***        CONNECTED TO PRODUCTION        ***");
            Console.WriteLine("***********************************************************");
            Console.WriteLine();
        }

        /// <summary>
        /// Main program loop.
        /// </summary>
        private static void MenuLoop()
        {
            shardMapManager = ShardManagementUtils.TryGetShardMapManager();
            userNames = SqlDatabaseUtils.GetAllIdentityByField(IdentityField.UserName.ToString());

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

        /// <summary>
        /// Creates a shard map manager, creates a shard map, and creates a shard
        /// with a mapping for the full range of 32-bit integers.
        /// </summary>
        private static void CreateShardMapManagerAndShard()
        {
            string serverName = Configuration.IsDevelopment ? Configuration.AppServerNameDevelopment : Configuration.AppServerNameProduction;

            if (shardMapManager != null)
            {
                ConsoleUtils.WriteWarning("Shard Map Manager already exists");
                return;
            }

            // Create shard map manager database
            if (!SqlDatabaseUtils.DatabaseExists(serverName, Configuration.ShardMapManagerDatabaseName))
            {
                SqlDatabaseUtils.CreateDatabase(serverName, Configuration.ShardMapManagerDatabaseName);
            }

            bool isIdentity = true;
            string shardMapManagerConnectionString =
                    Configuration.GetConnectionString(
                        serverName,
                        Configuration.ShardMapManagerDatabaseName,
                        isIdentity);

            shardMapManager = ShardManagementUtils.CreateOrGetShardMapManager(shardMapManagerConnectionString);

            ShardManagementUtils.CreateOrGetListShardMap<int>(shardMapManager, Configuration.ShardMapName);
        }

        /// <summary>
        /// Reads the user's choice of Database Name.
        /// </summary>
        private static void AddShard()
        {
            ListShardMap<int> shardMap = TryGetListShardMap();
            if (shardMap != null)
            {
                string databaseName = GetDatabaseNameInput();

                string companyName = GetCompanyNameInput();

                string adminEmail = GetAdminUserEmailInput();

                // TODO: Password Validation
                Console.WriteLine("Please enter a strong password for the Customer's Admin User.");
                string password = Console.ReadLine();

                // Hard-code SystemOfMeasurement user option until Menominee needs it
                //GetSystemOfMeasurementFromUser(out int systemOfMeasurement, out string systemOfMeasurementName);
                int systemOfMeasurement = 1;
                string systemOfMeasurementName = "English";

                bool includeDemoData = IncludeDemoData();

                Console.WriteLine();
                Console.WriteLine($"Creating: {databaseName} using {systemOfMeasurementName} system of measurement");
                CreateShardSample.CreateShard(shardMap, databaseName, includeDemoData, systemOfMeasurement);

                var tenantId = SqlDatabaseUtils.TryGetShardId(databaseName);
                Console.WriteLine($"ShardId: {tenantId}");

                //Insert new tenant row in IdentityTenants.dbo.AspNetTenants table
                var success = SqlDatabaseUtils.InsertNewTenant(databaseName, tenantId, companyName);

                if (success)
                {
                    InsertNewTenantAdminUser(adminEmail, adminEmail, password, tenantId, databaseName);
                    userNames.Add(adminEmail);
                }

                if (!Configuration.IsDevelopment)
                    AzureStorageUtils.CreateTenantStorageContainer(databaseName);
            }
        }

        private static string GetAdminUserEmailInput()
        {
            Console.WriteLine("Please enter the Admin user's Email.");
            var validEmail = GetEmailInput();

            var emails = SqlDatabaseUtils.GetAllIdentityByField(IdentityField.Email.ToString());
            bool emailExists = emails.Any(e => e.ToLower() == validEmail.ToLower());

            if (!emailExists)
                return validEmail;

            ConsoleUtils.WriteColor(DangerColor, $"'{validEmail}' is already in use. Please enter a unique email address.");

            while (true)
            {
                validEmail = GetEmailInput();
                emailExists = emails.Any(e => e.ToLower() == validEmail.ToLower());

                switch (emailExists)
                {
                    case false:
                        return validEmail;
                    case true:
                        ConsoleUtils.WriteColor(DangerColor, $"'{validEmail}' is already in use. Please enter a unique email address.");
                        break;
                }
            }
        }

        private static string GetEmailInput()
        {
            while (true)
            {
                string email = Console.ReadLine().Trim();
                bool valid = email.Contains("@");

                switch (valid)
                {
                    case true:
                        return email;
                    case false:
                        ConsoleUtils.WriteColor(DangerColor, $"'{email}' is not a valid email address. Please enter a valid email address.");
                        break;
                }
            }
        }

        private static string GetDatabaseNameInput()
        {
            Console.WriteLine("Please enter the Customer's Company Name as the new tenant (database) name.");
            Console.WriteLine("Your entry will be converted to all lowercase, all spaces removed.");

            while (true)
            {
                string databaseName = Console.ReadLine().ToLower();

                databaseName = Regex.Replace(databaseName, @"\s", "");
                databaseName = databaseName.Trim();

                bool valid = DatabaseNameIsValid(databaseName);

                switch (valid)
                {
                    case true:
                        return databaseName;
                    case false:
                        ConsoleUtils.WriteColor(DangerColor, $"Name '{databaseName}' in use. Please enter a different name.");
                        break;
                }
            }
        }

        private static bool IncludeDemoData()
        {
            Console.WriteLine("1. Create blank database");
            Console.WriteLine("2. Create demo database");

            int includeDemoData = ConsoleUtils.ReadIntegerInput("Enter an option [1-2] and press ENTER: ");

            while (includeDemoData < 0 || includeDemoData > 2)
                includeDemoData = ConsoleUtils.ReadIntegerInput("Enter an option [1-2] and press ENTER: ");

            return includeDemoData == 2;
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

        private static string GetCompanyNameInput()
        {
            Console.WriteLine("Please enter the Customer's Company Name as you would like it to display.");
            Console.WriteLine("Your entry will be displayed when users from this company are logged in to the web client.");
            string companyName = Console.ReadLine();

            return companyName;
        }

        private static bool DatabaseNameIsValid(string companyName)
        {
            var shardMap = TryGetListShardMap();
            if (shardMap == null)
            {
                return true;
            }
            var allShards = shardMap.GetShards();

            var database = allShards.FirstOrDefault(shard => shard.Location.Database.Contains(companyName));


            return database is null;
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
                        userNames = SqlDatabaseUtils.GetAllIdentityByField(IdentityField.UserName.ToString());

                    SqlDatabaseUtils.DeleteTenant(tenantName);
                    AzureStorageUtils.DeleteTenantStorageContainer(tenantName);
                }
                else
                    Console.WriteLine("Database DELETE cancelled.");
            }
            else
                Console.WriteLine("Database DELETE cancelled.");
        }

        private static bool DeleteTenantDatabase(string tenantName)
        {
            string serverName = Configuration.IsDevelopment
                ? Configuration.AppServerNameDevelopment
                : Configuration.AppServerNameProduction;

            ConsoleUtils.WriteColor(DangerColor, "WARNING: DATABASE WILL BE DELETED AND NOT RECOVERABLE.");
            Console.WriteLine($"Please enter 'YES' to confirm deletion of '{tenantName}' database");
            string confirm = Console.ReadLine();

            if (!string.Equals(confirm, "YES", StringComparison.CurrentCulture))
                return false;

            ListShardMap<int> shardMap = TryGetListShardMap();
            ShardLocation shardLocation = new ShardLocation(serverName, tenantName);
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
    }
}
