﻿using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;

namespace TenantManager
{
    internal static class ShardManagementUtils
    {
        static bool isIdentity = false;
        /// <summary>
        /// Tries to get the ShardMapManager that is stored in the specified database.
        /// </summary>
        public static ShardMapManager TryGetShardMapManager()
        {
            string shardMapManagerServerName = Configuration.IsDevelopment ? Configuration.IdentityTenantsServerNameDevelopment : Configuration.IdentityTenantsServerNameProduction;

            string shardMapManagerConnectionString =
                    Configuration.GetConnectionString(
                        shardMapManagerServerName,
                        Configuration.ShardMapManagerDatabaseName,
                        isIdentity);

            if (!SqlDatabaseUtils.DatabaseExists(shardMapManagerServerName, Configuration.ShardMapManagerDatabaseName))
            {
                // Shard Map Manager database has not yet been created
                return null;
            }

            bool shardMapManagerExists = ShardMapManagerFactory.TryGetSqlShardMapManager(
                shardMapManagerConnectionString,
                ShardMapManagerLoadPolicy.Lazy,
                out ShardMapManager shardMapManager);

            if (!shardMapManagerExists)
            {
                // Shard Map Manager database exists, but Shard Map Manager has not been created
                return null;
            }

            return shardMapManager;
        }

        /// <summary>
        /// Creates a shard map manager in the database specified by the given connection string.
        /// </summary>
        public static ShardMapManager CreateOrGetShardMapManager(string shardMapManagerConnectionString)
        {
            // Get shard map manager database connection string
            // Try to get a reference to the Shard Map Manager in the Shard Map Manager database. If it doesn't already exist, then create it.
            ShardMapManager shardMapManager;
            bool shardMapManagerExists = ShardMapManagerFactory.TryGetSqlShardMapManager(
                shardMapManagerConnectionString,
                ShardMapManagerLoadPolicy.Lazy,
                out shardMapManager);

            if (shardMapManagerExists)
            {
                ConsoleUtils.WriteInfo("Shard Map Manager already exists");
            }
            else
            {
                // The Shard Map Manager does not exist, so create it
                shardMapManager = ShardMapManagerFactory.CreateSqlShardMapManager(shardMapManagerConnectionString);
                ConsoleUtils.WriteInfo("Created Shard Map Manager");
            }

            return shardMapManager;
        }

        /// <summary>
        /// Creates a new List Shard Map with the specified name, or gets the List Shard Map if it already exists.
        /// </summary>
        public static ListShardMap<T> CreateOrGetListShardMap<T>(ShardMapManager shardMapManager, string shardMapName)
        {
            // Try to get a reference to the Shard Map.
            ListShardMap<T> shardMap;
            bool shardMapExists = shardMapManager.TryGetListShardMap(shardMapName, out shardMap);

            if (shardMapExists)
            {
                ConsoleUtils.WriteInfo("Shard Map {0} already exists", shardMap.Name);
            }
            else
            {
                // The Shard Map does not exist, so create it
                shardMap = shardMapManager.CreateListShardMap<T>(shardMapName);
                ConsoleUtils.WriteInfo("Created Shard Map {0}", shardMap.Name);
            }

            return shardMap;
        }

        /// <summary>
        /// Adds Shards to the Shard Map, or returns them if they have already been added.
        /// </summary>
        public static Shard CreateOrGetShard(ShardMap shardMap, ShardLocation shardLocation)
        {
            // Try to get a reference to the Shard
            Shard shard;
            bool shardExists = shardMap.TryGetShard(shardLocation, out shard);

            if (shardExists)
            {
                ConsoleUtils.WriteInfo("Shard {0} has already been added to the Shard Map", shardLocation.Database);
            }
            else
            {
                // The Shard Map does not exist, so create it
                shard = shardMap.CreateShard(shardLocation);
                ConsoleUtils.WriteInfo("Added shard {0} to the Shard Map", shardLocation.Database);
            }

            return shard;
        }
    }

}
