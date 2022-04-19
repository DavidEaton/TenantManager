IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Manufacturer] (
        [Id] bigint NOT NULL IDENTITY,
        [Code] nvarchar(max) NOT NULL,
        [Prefix] nvarchar(max) NULL,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Manufacturer] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Person] (
        [Id] bigint NOT NULL IDENTITY,
        [LastName] nvarchar(255) NULL,
        [FirstName] nvarchar(255) NULL,
        [MiddleName] nvarchar(255) NULL,
        [Gender] int NOT NULL,
        [Birthday] datetime2 NULL,
        [DriversLicenseNumber] nvarchar(50) NULL,
        [DriversLicenseIssued] datetime2 NULL,
        [DriversLicenseExpiry] datetime2 NULL,
        [DriversLicenseState] nvarchar(2) NULL,
        [AddressLine] nvarchar(255) NULL,
        [AddressCity] nvarchar(255) NULL,
        [AddressState] nvarchar(2) NULL,
        [AddressPostalCode] nvarchar(15) NULL,
        CONSTRAINT [PK_Person] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrder] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderNumber] bigint NOT NULL,
        [InvoiceNumber] bigint NOT NULL,
        [CustomerName] nvarchar(max) NULL,
        [Vehicle] nvarchar(max) NULL,
        [PartsTotal] float NOT NULL,
        [LaborTotal] float NOT NULL,
        [DiscountTotal] float NOT NULL,
        [TaxTotal] float NOT NULL,
        [HazMatTotal] float NOT NULL,
        [ShopSuppliesTotal] float NOT NULL,
        [Total] float NOT NULL,
        [DateCreated] datetime2 NOT NULL,
        [DateModified] datetime2 NOT NULL,
        [DateInvoiced] datetime2 NOT NULL,
        CONSTRAINT [PK_RepairOrder] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderPurchase] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderItemId] bigint NOT NULL,
        [VendorId] bigint NOT NULL,
        [PurchaseDate] datetime2 NOT NULL,
        [PONumber] nvarchar(max) NULL,
        [VendorInvoiceNumber] nvarchar(max) NULL,
        [VendorPartNumber] nvarchar(max) NULL,
        CONSTRAINT [PK_RepairOrderPurchase] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[SaleCode] (
        [Id] bigint NOT NULL IDENTITY,
        [Code] nvarchar(max) NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_SaleCode] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Vendor] (
        [Id] bigint NOT NULL IDENTITY,
        [VendorCode] nvarchar(10) NOT NULL,
        [Name] nvarchar(255) NOT NULL,
        [IsActive] bit NULL,
        CONSTRAINT [PK_Vendor] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [VendorInvoicePaymentMethods] (
        [Id] bigint NOT NULL IDENTITY,
        [PaymentName] nvarchar(max) NULL,
        [TrackingState] int NOT NULL,
        CONSTRAINT [PK_VendorInvoicePaymentMethods] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Organization] (
        [Id] bigint NOT NULL IDENTITY,
        [Name] nvarchar(255) NULL,
        [ContactId] bigint NULL,
        [Note] nvarchar(max) NULL,
        [AddressLine] nvarchar(255) NULL,
        [AddressCity] nvarchar(255) NULL,
        [AddressState] nvarchar(2) NULL,
        [AddressPostalCode] nvarchar(15) NULL,
        CONSTRAINT [PK_Organization] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Organization_Person_ContactId] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Person] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderPayment] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderId] bigint NOT NULL,
        [PaymentMethod] int NOT NULL DEFAULT 0,
        [Amount] float NOT NULL,
        CONSTRAINT [PK_RepairOrderPayment] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderPayment_RepairOrder_RepairOrderId] FOREIGN KEY ([RepairOrderId]) REFERENCES [dbo].[RepairOrder] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderService] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderId] bigint NOT NULL,
        [ServiceName] nvarchar(max) NULL,
        [SaleCode] nvarchar(max) NULL,
        [IsCounterSale] bit NOT NULL,
        [IsDeclined] bit NOT NULL,
        [PartsTotal] float NOT NULL,
        [LaborTotal] float NOT NULL,
        [DiscountTotal] float NOT NULL,
        [TaxTotal] float NOT NULL,
        [ShopSuppliesTotal] float NOT NULL,
        [Total] float NOT NULL,
        CONSTRAINT [PK_RepairOrderService] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderService_RepairOrder_RepairOrderId] FOREIGN KEY ([RepairOrderId]) REFERENCES [dbo].[RepairOrder] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderTax] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderId] bigint NOT NULL,
        [TaxId] bigint NOT NULL,
        [PartTaxRate] float NOT NULL,
        [LaborTaxRate] float NOT NULL,
        [PartTax] float NOT NULL,
        [LaborTax] float NOT NULL,
        CONSTRAINT [PK_RepairOrderTax] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderTax_RepairOrder_RepairOrderId] FOREIGN KEY ([RepairOrderId]) REFERENCES [dbo].[RepairOrder] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[ProductCode] (
        [Id] bigint NOT NULL IDENTITY,
        [ManufacturerId] bigint NULL,
        [Code] nvarchar(max) NOT NULL,
        [SaleCodeId] bigint NULL,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ProductCode] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductCode_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_ProductCode_SaleCode_SaleCodeId] FOREIGN KEY ([SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[VendorInvoice] (
        [Id] bigint NOT NULL IDENTITY,
        [VendorId] bigint NULL,
        [Date] datetime2 NULL,
        [DatePosted] datetime2 NULL,
        [Status] int NOT NULL DEFAULT 1,
        [InvoiceNumber] nvarchar(max) NULL,
        [Total] float NOT NULL,
        CONSTRAINT [PK_VendorInvoice] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorInvoice_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Customer] (
        [Id] bigint NOT NULL IDENTITY,
        [PersonId] bigint NULL,
        [OrganizationId] bigint NULL,
        [CustomerType] int NOT NULL,
        [AllowMail] bit NULL,
        [AllowEmail] bit NULL,
        [AllowSms] bit NULL,
        CONSTRAINT [PK_Customer] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Customer_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Customer_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Email] (
        [Id] bigint NOT NULL IDENTITY,
        [Address] nvarchar(254) NOT NULL,
        [IsPrimary] bit NOT NULL DEFAULT CAST(0 AS bit),
        [OrganizationId] bigint NULL,
        [PersonId] bigint NULL,
        CONSTRAINT [PK_Email] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Email_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Email_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Phone] (
        [Id] bigint NOT NULL IDENTITY,
        [Number] nvarchar(50) NOT NULL,
        [PhoneType] int NOT NULL,
        [IsPrimary] bit NOT NULL,
        [OrganizationId] bigint NULL,
        [PersonId] bigint NULL,
        CONSTRAINT [PK_Phone] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Phone_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Phone_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderServiceTax] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderServiceId] bigint NOT NULL,
        [TaxId] bigint NOT NULL,
        [PartTaxRate] float NOT NULL,
        [LaborTaxRate] float NOT NULL,
        [PartTax] float NOT NULL,
        [LaborTax] float NOT NULL,
        CONSTRAINT [PK_RepairOrderServiceTax] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderServiceTax_RepairOrderService_RepairOrderServiceId] FOREIGN KEY ([RepairOrderServiceId]) REFERENCES [dbo].[RepairOrderService] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderTech] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderServiceId] bigint NOT NULL,
        [TechnicianId] bigint NOT NULL,
        CONSTRAINT [PK_RepairOrderTech] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderTech_RepairOrderService_RepairOrderServiceId] FOREIGN KEY ([RepairOrderServiceId]) REFERENCES [dbo].[RepairOrderService] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItem] (
        [Id] bigint NOT NULL IDENTITY,
        [ManufacturerId] bigint NOT NULL,
        [PartNumber] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [ProductCodeId] bigint NOT NULL,
        [PartType] int NOT NULL,
        [QuantityOnHand] int NOT NULL,
        [Cost] float NOT NULL,
        [SuggestedPrice] float NOT NULL,
        [Labor] float NOT NULL,
        CONSTRAINT [PK_InventoryItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItem_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_InventoryItem_ProductCode_ProductCodeId] FOREIGN KEY ([ProductCodeId]) REFERENCES [dbo].[ProductCode] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderItem] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderServiceId] bigint NOT NULL,
        [ManufacturerId] bigint NOT NULL,
        [PartNumber] nvarchar(max) NULL,
        [Description] nvarchar(max) NULL,
        [SaleCodeId] bigint NOT NULL,
        [ProductCodeId] bigint NOT NULL,
        [SaleType] int NOT NULL DEFAULT 0,
        [PartType] int NOT NULL DEFAULT 0,
        [IsDeclined] bit NOT NULL,
        [IsCounterSale] bit NOT NULL,
        [QuantitySold] float NOT NULL,
        [SellingPrice] float NOT NULL,
        [LaborType] int NOT NULL,
        [LaborEach] float NOT NULL,
        [Cost] float NOT NULL,
        [Core] float NOT NULL,
        [DiscountType] int NOT NULL,
        [DiscountEach] float NOT NULL,
        [Total] float NOT NULL,
        CONSTRAINT [PK_RepairOrderItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderItem_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_RepairOrderItem_ProductCode_ProductCodeId] FOREIGN KEY ([ProductCodeId]) REFERENCES [dbo].[ProductCode] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_RepairOrderItem_RepairOrderService_RepairOrderServiceId] FOREIGN KEY ([RepairOrderServiceId]) REFERENCES [dbo].[RepairOrderService] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_RepairOrderItem_SaleCode_SaleCodeId] FOREIGN KEY ([SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[VendorInvoiceItem] (
        [Id] bigint NOT NULL IDENTITY,
        [InvoiceId] bigint NOT NULL,
        [Type] int NOT NULL DEFAULT 0,
        [PartNumber] nvarchar(255) NOT NULL,
        [MfrId] nvarchar(10) NOT NULL,
        [Description] nvarchar(255) NOT NULL,
        [Quantity] float NOT NULL,
        [Cost] float NOT NULL,
        [Core] float NOT NULL,
        [PONumber] nvarchar(max) NULL,
        [InvoiceNumber] nvarchar(max) NULL,
        [TransactionDate] datetime2 NULL,
        CONSTRAINT [PK_VendorInvoiceItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_InvoiceId] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[VendorInvoicePayment] (
        [Id] bigint NOT NULL IDENTITY,
        [InvoiceId] bigint NOT NULL,
        [PaymentMethod] int NOT NULL,
        [Amount] float NOT NULL,
        [VendorInvoiceId] bigint NULL,
        CONSTRAINT [PK_VendorInvoicePayment] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[VendorInvoiceTax] (
        [Id] bigint NOT NULL IDENTITY,
        [InvoiceId] bigint NOT NULL,
        [Order] int NOT NULL,
        [TaxId] int NOT NULL,
        [Amount] float NOT NULL,
        [VendorInvoiceId] bigint NULL,
        CONSTRAINT [PK_VendorInvoiceTax] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[Vehicle] (
        [Id] bigint NOT NULL IDENTITY,
        [VIN] nvarchar(max) NULL,
        [Year] int NOT NULL,
        [Make] nvarchar(max) NULL,
        [Model] nvarchar(max) NULL,
        [CustomerId] bigint NULL,
        CONSTRAINT [PK_Vehicle] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Vehicle_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id]) ON DELETE NO ACTION
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderItemTax] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderItemId] bigint NOT NULL,
        [TaxId] bigint NOT NULL,
        [PartTaxRate] float NOT NULL,
        [LaborTaxRate] float NOT NULL,
        [PartTax] float NOT NULL,
        [LaborTax] float NOT NULL,
        CONSTRAINT [PK_RepairOrderItemTax] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderItemTax_RepairOrderItem_RepairOrderItemId] FOREIGN KEY ([RepairOrderItemId]) REFERENCES [dbo].[RepairOrderItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderSerialNumber] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderItemId] bigint NOT NULL,
        [SerialNumber] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_RepairOrderSerialNumber] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderSerialNumber_RepairOrderItem_RepairOrderItemId] FOREIGN KEY ([RepairOrderItemId]) REFERENCES [dbo].[RepairOrderItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderWarranty] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderItemId] bigint NOT NULL,
        [Quantity] float NOT NULL,
        [Type] int NOT NULL DEFAULT 0,
        [NewWarranty] nvarchar(max) NULL,
        [OriginalWarranty] nvarchar(max) NULL,
        [OriginalInvoiceId] bigint NOT NULL,
        CONSTRAINT [PK_RepairOrderWarranty] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderWarranty_RepairOrderItem_RepairOrderItemId] FOREIGN KEY ([RepairOrderItemId]) REFERENCES [dbo].[RepairOrderItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Customer_OrganizationId] ON [dbo].[Customer] ([OrganizationId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Customer_PersonId] ON [dbo].[Customer] ([PersonId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Email_OrganizationId] ON [dbo].[Email] ([OrganizationId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Email_PersonId] ON [dbo].[Email] ([PersonId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItem_ManufacturerId] ON [dbo].[InventoryItem] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItem_ProductCodeId] ON [dbo].[InventoryItem] ([ProductCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Organization_ContactId] ON [dbo].[Organization] ([ContactId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Phone_OrganizationId] ON [dbo].[Phone] ([OrganizationId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Phone_PersonId] ON [dbo].[Phone] ([PersonId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_ProductCode_ManufacturerId] ON [dbo].[ProductCode] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_ProductCode_SaleCodeId] ON [dbo].[ProductCode] ([SaleCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_ManufacturerId] ON [dbo].[RepairOrderItem] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_ProductCodeId] ON [dbo].[RepairOrderItem] ([ProductCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_RepairOrderServiceId] ON [dbo].[RepairOrderItem] ([RepairOrderServiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_SaleCodeId] ON [dbo].[RepairOrderItem] ([SaleCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItemTax_RepairOrderItemId] ON [dbo].[RepairOrderItemTax] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderPayment_RepairOrderId] ON [dbo].[RepairOrderPayment] ([RepairOrderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderSerialNumber_RepairOrderItemId] ON [dbo].[RepairOrderSerialNumber] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderService_RepairOrderId] ON [dbo].[RepairOrderService] ([RepairOrderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderServiceTax_RepairOrderServiceId] ON [dbo].[RepairOrderServiceTax] ([RepairOrderServiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderTax_RepairOrderId] ON [dbo].[RepairOrderTax] ([RepairOrderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderTech_RepairOrderServiceId] ON [dbo].[RepairOrderTech] ([RepairOrderServiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderWarranty_RepairOrderItemId] ON [dbo].[RepairOrderWarranty] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_Vehicle_CustomerId] ON [dbo].[Vehicle] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoice_VendorId] ON [dbo].[VendorInvoice] ([VendorId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoiceItem_InvoiceId] ON [dbo].[VendorInvoiceItem] ([InvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoicePayment_VendorInvoiceId] ON [dbo].[VendorInvoicePayment] ([VendorInvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoiceTax_VendorInvoiceId] ON [dbo].[VendorInvoiceTax] ([VendorInvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220322190640_Initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220322190640_Initial', N'6.0.0');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220412163704_AddRepairOrderItemPurchases')
BEGIN
    CREATE INDEX [IX_RepairOrderPurchase_RepairOrderItemId] ON [dbo].[RepairOrderPurchase] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220412163704_AddRepairOrderItemPurchases')
BEGIN
    ALTER TABLE [dbo].[RepairOrderPurchase] ADD CONSTRAINT [FK_RepairOrderPurchase_RepairOrderItem_RepairOrderItemId] FOREIGN KEY ([RepairOrderItemId]) REFERENCES [dbo].[RepairOrderItem] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220412163704_AddRepairOrderItemPurchases')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220412163704_AddRepairOrderItemPurchases', N'6.0.0');
END;
GO

COMMIT;
GO

