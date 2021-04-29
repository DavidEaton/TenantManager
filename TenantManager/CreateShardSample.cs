using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using System;
using System.Collections.Generic;
using System.Linq;

namespace TenantManager
{
    internal class CreateShardSample
    {
        /// <summary>
        /// Creates a new shard (or uses an existing empty shard), adds it to the shard map,
        /// and assigns it the specified point if possible.
        /// </summary>
        public static void CreateShard(ListShardMap<int> shardMap,
                                        string databaseName,
                                        int dataOption,
                                        int systemOfMeasurement)
        {
            // Create a new shard, or get an existing empty shard (if a previous create partially succeeded).
            Shard shard = CreateOrGetEmptyShard(shardMap, databaseName, dataOption, systemOfMeasurement);
            int currentMaxHighKey;
            int defaultNewHighKey;
            // Here we assume that the points start at 0, are contiguous, 
            // and are bounded (i.e. there is no point where HighIsMax == true)
            try
            {
                currentMaxHighKey = shardMap.GetMappings().Max(m => m.Value);
                defaultNewHighKey = currentMaxHighKey + 1;
            }
            catch (Exception)
            {
                // No maps yet exist so shardMap.GetMappings() throws exception.
                defaultNewHighKey = 0;
            }

            // Create a mapping to that shard.
            PointMapping<int> mappingForNewShard = shardMap.CreatePointMapping(defaultNewHighKey, shard);
            ConsoleUtils.WriteInfo("Mapped point {0} to shard {1}", mappingForNewShard.Value, shard.Location.Database);
        }

        /// <summary>
        /// Script file that will be executed to initialize a shard.
        /// </summary>
        private const string InitializeShardScriptFile = "scripts/Structure.sql";
        private const string InsertRequiredDatabaseRowsScriptFileEnglish = "scripts/InsertRequiredEnglish.sql";
        private const string InsertRequiredDatabaseRowsScriptFileMetric = "scripts/InsertRequiredMetric.sql";
        private const string InsertDemoDatabaseRowsScriptFileEnglish = "scripts/InsertDemoEnglish.sql";
        private const string InsertDemoDatabaseRowsScriptFileMetric = "scripts/InsertDemoMetric.sql";

        /// <summary>
        /// Creates a new shard, or gets an existing empty shard (i.e. a shard that has no mappings).
        /// The reason why an empty shard might exist is that it was created and initialized but we 
        /// failed to create a mapping to it.
        /// </summary>
        private static Shard CreateOrGetEmptyShard(ListShardMap<int> shardMap,
                                                    string databaseName,
                                                    int dataOption,
                                                    int systemOfMeasurement)
        {
            // Get an empty shard if one already exists, otherwise create a new one
            Shard shard = FindEmptyShard(shardMap);
            if (shard == null)
            {
                // No empty shard exists, so create one
                // Only create the database if it doesn't already exist. It might already exist if
                // we tried to create it previously but hit a transient fault.
                if (!SqlDatabaseUtils.DatabaseExists(Configuration.ServerName, databaseName))
                {
                    SqlDatabaseUtils.CreateDatabase(Configuration.ServerName, databaseName);
                }

                // Create schema and populate reference data on that database
                // The initialize script must be idempotent, in case it was already run on this database
                // and we failed to add it to the shard map previously
                SqlDatabaseUtils.ExecuteSqlScript(Configuration.ServerName, databaseName, InitializeShardScriptFile);
                SqlDatabaseUtils.ExecuteSqlScript(Configuration.ServerName, databaseName,
                    systemOfMeasurement == 1 ? InsertRequiredDatabaseRowsScriptFileEnglish : InsertRequiredDatabaseRowsScriptFileMetric);

                if (dataOption == 2)
                {
                    // User elected to populate database with demo rows
                    string demoFile = systemOfMeasurement == 1 ? InsertDemoDatabaseRowsScriptFileEnglish : InsertDemoDatabaseRowsScriptFileMetric;
                    SqlDatabaseUtils.ExecuteSqlScript(Configuration.ServerName, databaseName, demoFile);
                }
                // Add it to the shard map
                ShardLocation shardLocation = new ShardLocation(Configuration.ServerName, databaseName);
                shard = ShardManagementUtils.CreateOrGetShard(shardMap, shardLocation);
            }

            return shard;
        }

        /// <summary>
        /// Finds an existing empty shard, or returns null if none exist.
        /// </summary>
        private static Shard FindEmptyShard(ListShardMap<int> shardMap)
        {
            // Get all shards in the shard map
            IEnumerable<Shard> allShards = shardMap.GetShards();

            // Get all mappings in the shard map
            IEnumerable<PointMapping<int>> allMappings = shardMap.GetMappings();

            // Determine which shards have mappings
            HashSet<Shard> shardsWithMappings = new HashSet<Shard>(allMappings.Select(m => m.Shard));

            // Get the first shard (ordered by name) that has no mappings, if it exists
            return allShards.OrderBy(s => s.Location.Database).FirstOrDefault(s => !shardsWithMappings.Contains(s));
        }
    }
}
