using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using System;
using System.Net;

namespace TenantManager
{
    /// <summary>
    /// Helper methods for interacting with Azure Storage.
    /// </summary>
    internal static class AzureStorageUtils
    {
        static readonly string storageConnection = Configuration.AzureStorageConnectionString;

        public static void CreateTenantStorageContainer(string containerName)
        {
            // Create a BlobServiceClient object which will be used to create a container client
            BlobServiceClient blobServiceClient = new BlobServiceClient(storageConnection);

            try
            {
                // Create the container and return a container client object
                BlobContainerClient containerClient = blobServiceClient.CreateBlobContainer(containerName, PublicAccessType.Blob);
                ConsoleUtils.WriteInfo($"Image container '{containerName}' created for {containerName}.");
            }
            catch (WebException ex)
            {
                if (ex.Status == WebExceptionStatus.ProtocolError)
                {
                    var response = ex.Response as HttpWebResponse;
                    if (response != null)
                        if (response.StatusCode == HttpStatusCode.Conflict)
                            ConsoleUtils.WriteInfo($"Image container '{containerName}' was already present for {containerName}.");
                    else
                    {
                        // log it
                    }
                }
                else
                {
                    // log it
                }
            }
        }

        internal static bool DeleteTenantStorageContainer(string containerName)
        {
            BlobServiceClient blobServiceClient = new BlobServiceClient(storageConnection);
            Azure.Response result;
            try
            {
                result = blobServiceClient.DeleteBlobContainer(containerName, null);
            }
            catch (Exception)
            {
                ConsoleUtils.WriteInfo($"Failed to delete container '{containerName}'.");
                return false;
            }

            if (result.Status == 202)
            {
                ConsoleUtils.WriteInfo($"Deleted image container for '{containerName}'.");
                return true;
            }

            ConsoleUtils.WriteInfo($"Failed to delete container '{containerName}'.");
            return false;
        }
    }

}
