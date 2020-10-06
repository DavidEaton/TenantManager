using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using System;

namespace StockTracTenantManager
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

			// Create the container and return a container client object
			BlobContainerClient containerClient = blobServiceClient.CreateBlobContainer(containerName, PublicAccessType.Blob);
			ConsoleUtils.WriteInfo($"Image container '{containerName}' created for {containerName}.");
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
