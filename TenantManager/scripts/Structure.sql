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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[CreditCard] (
        [Id] bigint NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [FeeType] int NOT NULL,
        [Fee] float NOT NULL,
        [IsAddedToDeposit] bit NOT NULL,
        CONSTRAINT [PK_CreditCard] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[ExciseFee] (
        [Id] bigint NOT NULL IDENTITY,
        [Description] nvarchar(max) NOT NULL,
        [FeeType] int NOT NULL DEFAULT 0,
        [Amount] float NOT NULL DEFAULT 0.0E0,
        CONSTRAINT [PK_ExciseFee] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[SaleCode] (
        [Id] bigint NOT NULL IDENTITY,
        [Code] nvarchar(max) NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [LaborRate] float NOT NULL DEFAULT 0.0E0,
        [DesiredMargin] float NOT NULL DEFAULT 0.0E0,
        [Percentage] float NULL DEFAULT 0.0E0,
        [MinimumJobAmount] float NULL DEFAULT 0.0E0,
        [MinimumCharge] float NULL DEFAULT 0.0E0,
        [MaximumCharge] float NULL DEFAULT 0.0E0,
        [IncludeParts] bit NULL DEFAULT CAST(0 AS bit),
        [IncludeLabor] bit NULL DEFAULT CAST(0 AS bit),
        CONSTRAINT [PK_SaleCode] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[SalesTax] (
        [Id] bigint NOT NULL IDENTITY,
        [Description] nvarchar(max) NOT NULL,
        [TaxType] int NOT NULL DEFAULT 0,
        [Order] int NOT NULL,
        [IsAppliedByDefault] bit NOT NULL DEFAULT CAST(1 AS bit),
        [IsTaxable] bit NOT NULL DEFAULT CAST(0 AS bit),
        [TaxIdNumber] nvarchar(255) NULL,
        [PartTaxRate] float NOT NULL DEFAULT 0.0E0,
        [LaborTaxRate] float NOT NULL DEFAULT 0.0E0,
        CONSTRAINT [PK_SalesTax] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [VendorInvoicePaymentMethods] (
        [Id] bigint NOT NULL IDENTITY,
        [PaymentName] nvarchar(max) NULL,
        [TrackingState] int NOT NULL,
        CONSTRAINT [PK_VendorInvoicePaymentMethods] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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
        CONSTRAINT [FK_Organization_Person_ContactId] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Person] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[ProductCode] (
        [Id] bigint NOT NULL IDENTITY,
        [ManufacturerId] bigint NULL,
        [Code] nvarchar(max) NOT NULL,
        [SaleCodeId] bigint NULL,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ProductCode] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductCode_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]),
        CONSTRAINT [FK_ProductCode_SaleCode_SaleCodeId] FOREIGN KEY ([SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[SalesTaxTaxableExciseFee] (
        [Id] bigint NOT NULL IDENTITY,
        [SalesTaxId] bigint NULL,
        [ExciseFeeId] bigint NULL,
        CONSTRAINT [PK_SalesTaxTaxableExciseFee] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SalesTaxTaxableExciseFee_ExciseFee_ExciseFeeId] FOREIGN KEY ([ExciseFeeId]) REFERENCES [dbo].[ExciseFee] ([Id]),
        CONSTRAINT [FK_SalesTaxTaxableExciseFee_SalesTax_SalesTaxId] FOREIGN KEY ([SalesTaxId]) REFERENCES [dbo].[SalesTax] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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
        CONSTRAINT [FK_VendorInvoice_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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
        CONSTRAINT [FK_Customer_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]),
        CONSTRAINT [FK_Customer_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[Email] (
        [Id] bigint NOT NULL IDENTITY,
        [Address] nvarchar(254) NOT NULL,
        [IsPrimary] bit NOT NULL DEFAULT CAST(0 AS bit),
        [OrganizationId] bigint NULL,
        [PersonId] bigint NULL,
        CONSTRAINT [PK_Email] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Email_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]),
        CONSTRAINT [FK_Email_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[Phone] (
        [Id] bigint NOT NULL IDENTITY,
        [Number] nvarchar(50) NOT NULL,
        [PhoneType] int NOT NULL,
        [IsPrimary] bit NOT NULL,
        [OrganizationId] bigint NULL,
        [PersonId] bigint NULL,
        CONSTRAINT [PK_Phone] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Phone_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]),
        CONSTRAINT [FK_Phone_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItem] (
        [Id] bigint NOT NULL IDENTITY,
        [ManufacturerId] bigint NOT NULL,
        [ItemNumber] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [ProductCodeId] bigint NOT NULL,
        [ItemType] int NOT NULL,
        CONSTRAINT [PK_InventoryItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItem_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_InventoryItem_ProductCode_ProductCodeId] FOREIGN KEY ([ProductCodeId]) REFERENCES [dbo].[ProductCode] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[VendorInvoicePayment] (
        [Id] bigint NOT NULL IDENTITY,
        [InvoiceId] bigint NOT NULL,
        [PaymentMethod] int NOT NULL,
        [Amount] float NOT NULL,
        [VendorInvoiceId] bigint NULL,
        CONSTRAINT [PK_VendorInvoicePayment] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[VendorInvoiceTax] (
        [Id] bigint NOT NULL IDENTITY,
        [InvoiceId] bigint NOT NULL,
        [Order] int NOT NULL,
        [TaxId] int NOT NULL,
        [Amount] float NOT NULL,
        [VendorInvoiceId] bigint NULL,
        CONSTRAINT [PK_VendorInvoiceTax] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[Vehicle] (
        [Id] bigint NOT NULL IDENTITY,
        [VIN] nvarchar(max) NULL,
        [Year] int NOT NULL,
        [Make] nvarchar(max) NULL,
        [Model] nvarchar(max) NULL,
        [CustomerId] bigint NULL,
        CONSTRAINT [PK_Vehicle] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Vehicle_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItemLabor] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [LaborType] int NOT NULL,
        [LaborAmount] float NOT NULL,
        [TechPayType] int NOT NULL,
        [TechPayAmount] float NOT NULL,
        [SkillLevel] int NOT NULL,
        CONSTRAINT [PK_InventoryItemLabor] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemLabor_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItemPackage] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [BasePartsAmount] float NOT NULL,
        [BaseLaborAmount] float NOT NULL,
        [Script] nvarchar(max) NULL,
        [IsDiscountable] bit NOT NULL,
        CONSTRAINT [PK_InventoryItemPackage] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemPackage_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItemPart] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [List] float NOT NULL,
        [Cost] float NOT NULL,
        [Core] float NOT NULL,
        [Retail] float NOT NULL,
        [TechPayType] int NOT NULL,
        [TechPayAmount] float NOT NULL,
        [LineCode] nvarchar(max) NULL,
        [SubLineCode] nvarchar(max) NULL,
        [Fractional] bit NOT NULL,
        [SkillLevel] int NOT NULL,
        CONSTRAINT [PK_InventoryItemPart] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemPart_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItemTire] (
        [Id] bigint NOT NULL IDENTITY,
        [Type] nvarchar(max) NULL,
        [Width] float NOT NULL,
        [AspectRatio] float NOT NULL,
        [Diameter] float NOT NULL,
        [LoadIndex] int NOT NULL,
        [SpeedRating] nvarchar(max) NULL,
        [InventoryItemId] bigint NOT NULL,
        [List] float NOT NULL,
        [Cost] float NOT NULL,
        [Core] float NOT NULL,
        [Retail] float NOT NULL,
        [TechPayType] int NOT NULL,
        [TechPayAmount] float NOT NULL,
        [LineCode] nvarchar(max) NULL,
        [SubLineCode] nvarchar(max) NULL,
        [Fractional] bit NOT NULL,
        [SkillLevel] int NOT NULL,
        CONSTRAINT [PK_InventoryItemTire] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemTire_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[RepairOrderPurchase] (
        [Id] bigint NOT NULL IDENTITY,
        [RepairOrderItemId] bigint NOT NULL,
        [VendorId] bigint NOT NULL,
        [PurchaseDate] datetime2 NOT NULL,
        [PONumber] nvarchar(max) NULL,
        [VendorInvoiceNumber] nvarchar(max) NULL,
        [VendorPartNumber] nvarchar(max) NULL,
        CONSTRAINT [PK_RepairOrderPurchase] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RepairOrderPurchase_RepairOrderItem_RepairOrderItemId] FOREIGN KEY ([RepairOrderItemId]) REFERENCES [dbo].[RepairOrderItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItemPackageItem] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemPackageId] bigint NOT NULL,
        [Order] int NOT NULL,
        [ItemId] bigint NULL,
        [Quantity] float NOT NULL,
        [PartAmountIsAdditional] bit NOT NULL,
        [LaborAmountIsAdditional] bit NOT NULL,
        [ExciseFeeIsAdditional] bit NOT NULL,
        CONSTRAINT [PK_InventoryItemPackageItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemPackageItem_InventoryItem_ItemId] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[InventoryItem] ([Id]),
        CONSTRAINT [FK_InventoryItemPackageItem_InventoryItemPackage_InventoryItemPackageId] FOREIGN KEY ([InventoryItemPackageId]) REFERENCES [dbo].[InventoryItemPackage] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE TABLE [dbo].[InventoryItemPackagePlaceholder] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemPackageId] bigint NOT NULL,
        [Order] int NOT NULL,
        [ItemType] int NOT NULL,
        [Description] nvarchar(max) NULL,
        [Quantity] float NOT NULL,
        [PartAmountIsAdditional] bit NOT NULL,
        [LaborAmountIsAdditional] bit NOT NULL,
        [ExciseFeeIsAdditional] bit NOT NULL,
        CONSTRAINT [PK_InventoryItemPackagePlaceholder] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemPackagePlaceholder_InventoryItemPackage_InventoryItemPackageId] FOREIGN KEY ([InventoryItemPackageId]) REFERENCES [dbo].[InventoryItemPackage] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Customer_OrganizationId] ON [dbo].[Customer] ([OrganizationId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Customer_PersonId] ON [dbo].[Customer] ([PersonId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Email_OrganizationId] ON [dbo].[Email] ([OrganizationId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Email_PersonId] ON [dbo].[Email] ([PersonId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItem_ManufacturerId] ON [dbo].[InventoryItem] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItem_ProductCodeId] ON [dbo].[InventoryItem] ([ProductCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemLabor_InventoryItemId] ON [dbo].[InventoryItemLabor] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemPackage_InventoryItemId] ON [dbo].[InventoryItemPackage] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItemPackageItem_InventoryItemPackageId] ON [dbo].[InventoryItemPackageItem] ([InventoryItemPackageId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItemPackageItem_ItemId] ON [dbo].[InventoryItemPackageItem] ([ItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_InventoryItemPackagePlaceholder_InventoryItemPackageId] ON [dbo].[InventoryItemPackagePlaceholder] ([InventoryItemPackageId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemPart_InventoryItemId] ON [dbo].[InventoryItemPart] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemTire_InventoryItemId] ON [dbo].[InventoryItemTire] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Organization_ContactId] ON [dbo].[Organization] ([ContactId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Phone_OrganizationId] ON [dbo].[Phone] ([OrganizationId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Phone_PersonId] ON [dbo].[Phone] ([PersonId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_ProductCode_ManufacturerId] ON [dbo].[ProductCode] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_ProductCode_SaleCodeId] ON [dbo].[ProductCode] ([SaleCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_ManufacturerId] ON [dbo].[RepairOrderItem] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_ProductCodeId] ON [dbo].[RepairOrderItem] ([ProductCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_RepairOrderServiceId] ON [dbo].[RepairOrderItem] ([RepairOrderServiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItem_SaleCodeId] ON [dbo].[RepairOrderItem] ([SaleCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderItemTax_RepairOrderItemId] ON [dbo].[RepairOrderItemTax] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderPayment_RepairOrderId] ON [dbo].[RepairOrderPayment] ([RepairOrderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderPurchase_RepairOrderItemId] ON [dbo].[RepairOrderPurchase] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderSerialNumber_RepairOrderItemId] ON [dbo].[RepairOrderSerialNumber] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderService_RepairOrderId] ON [dbo].[RepairOrderService] ([RepairOrderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderServiceTax_RepairOrderServiceId] ON [dbo].[RepairOrderServiceTax] ([RepairOrderServiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderTax_RepairOrderId] ON [dbo].[RepairOrderTax] ([RepairOrderId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderTech_RepairOrderServiceId] ON [dbo].[RepairOrderTech] ([RepairOrderServiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_RepairOrderWarranty_RepairOrderItemId] ON [dbo].[RepairOrderWarranty] ([RepairOrderItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_SalesTaxTaxableExciseFee_ExciseFeeId] ON [dbo].[SalesTaxTaxableExciseFee] ([ExciseFeeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_SalesTaxTaxableExciseFee_SalesTaxId] ON [dbo].[SalesTaxTaxableExciseFee] ([SalesTaxId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_Vehicle_CustomerId] ON [dbo].[Vehicle] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoice_VendorId] ON [dbo].[VendorInvoice] ([VendorId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoiceItem_InvoiceId] ON [dbo].[VendorInvoiceItem] ([InvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoicePayment_VendorInvoiceId] ON [dbo].[VendorInvoicePayment] ([VendorInvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    CREATE INDEX [IX_VendorInvoiceTax_VendorInvoiceId] ON [dbo].[VendorInvoiceTax] ([VendorInvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220527143251_Initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220527143251_Initial', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[InventoryItemPackageItem] DROP CONSTRAINT [FK_InventoryItemPackageItem_InventoryItem_ItemId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[ProductCode] DROP CONSTRAINT [FK_ProductCode_Manufacturer_ManufacturerId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[ProductCode] DROP CONSTRAINT [FK_ProductCode_SaleCode_SaleCodeId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    DROP INDEX [IX_InventoryItemPackageItem_ItemId] ON [dbo].[InventoryItemPackageItem];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[InventoryItemPackageItem]') AND [c].[name] = N'ItemId');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[InventoryItemPackageItem] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [dbo].[InventoryItemPackageItem] DROP COLUMN [ItemId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    DROP INDEX [IX_ProductCode_SaleCodeId] ON [dbo].[ProductCode];
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[ProductCode]') AND [c].[name] = N'SaleCodeId');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[ProductCode] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [dbo].[ProductCode] ALTER COLUMN [SaleCodeId] bigint NOT NULL;
    ALTER TABLE [dbo].[ProductCode] ADD DEFAULT CAST(0 AS bigint) FOR [SaleCodeId];
    CREATE INDEX [IX_ProductCode_SaleCodeId] ON [dbo].[ProductCode] ([SaleCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    DROP INDEX [IX_ProductCode_ManufacturerId] ON [dbo].[ProductCode];
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[ProductCode]') AND [c].[name] = N'ManufacturerId');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[ProductCode] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [dbo].[ProductCode] ALTER COLUMN [ManufacturerId] bigint NOT NULL;
    ALTER TABLE [dbo].[ProductCode] ADD DEFAULT CAST(0 AS bigint) FOR [ManufacturerId];
    CREATE INDEX [IX_ProductCode_ManufacturerId] ON [dbo].[ProductCode] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[InventoryItemPackageItem] ADD [InventoryItemId] bigint NOT NULL DEFAULT CAST(0 AS bigint);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    CREATE INDEX [IX_InventoryItemPackageItem_InventoryItemId] ON [dbo].[InventoryItemPackageItem] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[InventoryItemPackageItem] ADD CONSTRAINT [FK_InventoryItemPackageItem_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE NO ACTION;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[ProductCode] ADD CONSTRAINT [FK_ProductCode_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]) ON DELETE NO ACTION;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    ALTER TABLE [dbo].[ProductCode] ADD CONSTRAINT [FK_ProductCode_SaleCode_SaleCodeId] FOREIGN KEY ([SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id]) ON DELETE NO ACTION;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220602152328_PkgItemInventoryItemId')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220602152328_PkgItemInventoryItemId', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220709180858_giftcertificates')
BEGIN
    CREATE TABLE [dbo].[InventoryItemCourtesyCheck] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [LaborType] int NOT NULL,
        [LaborAmount] float NOT NULL,
        [TechPayType] int NOT NULL,
        [TechPayAmount] float NOT NULL,
        [SkillLevel] int NOT NULL,
        CONSTRAINT [PK_InventoryItemCourtesyCheck] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemCourtesyCheck_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220709180858_giftcertificates')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemCourtesyCheck_InventoryItemId] ON [dbo].[InventoryItemCourtesyCheck] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220709180858_giftcertificates')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220709180858_giftcertificates', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    DROP TABLE [dbo].[InventoryItemCourtesyCheck];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE TABLE [InventoryItemDonation] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [TrackingState] int NOT NULL,
        CONSTRAINT [PK_InventoryItemDonation] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemDonation_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE TABLE [InventoryItemGiftCertificate] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [TrackingState] int NOT NULL,
        CONSTRAINT [PK_InventoryItemGiftCertificate] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemGiftCertificate_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE TABLE [dbo].[InventoryItemInspection] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [LaborType] int NOT NULL,
        [LaborAmount] float NOT NULL,
        [TechPayType] int NOT NULL,
        [TechPayAmount] float NOT NULL,
        [SkillLevel] int NOT NULL,
        [Type] int NOT NULL,
        CONSTRAINT [PK_InventoryItemInspection] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemInspection_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE TABLE [InventoryItemWarranties] (
        [Id] bigint NOT NULL IDENTITY,
        [InventoryItemId] bigint NOT NULL,
        [PeriodType] int NOT NULL,
        [Duration] int NOT NULL,
        CONSTRAINT [PK_InventoryItemWarranties] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryItemWarranties_InventoryItem_InventoryItemId] FOREIGN KEY ([InventoryItemId]) REFERENCES [dbo].[InventoryItem] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemDonation_InventoryItemId] ON [InventoryItemDonation] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemGiftCertificate_InventoryItemId] ON [InventoryItemGiftCertificate] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemInspection_InventoryItemId] ON [dbo].[InventoryItemInspection] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    CREATE UNIQUE INDEX [IX_InventoryItemWarranties_InventoryItemId] ON [InventoryItemWarranties] ([InventoryItemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220711150622_AddInventoryWarranty')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220711150622_AddInventoryWarranty', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_InvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [VendorInvoicePaymentMethods] DROP CONSTRAINT [PK_VendorInvoicePaymentMethods];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePayment]') AND [c].[name] = N'InvoiceId');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP COLUMN [InvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'MfrId');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP COLUMN [MfrId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[VendorInvoicePaymentMethods]') AND [c].[name] = N'PaymentName');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [VendorInvoicePaymentMethods] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [VendorInvoicePaymentMethods] DROP COLUMN [PaymentName];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[VendorInvoicePaymentMethods]') AND [c].[name] = N'TrackingState');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [VendorInvoicePaymentMethods] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [VendorInvoicePaymentMethods] DROP COLUMN [TrackingState];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    EXEC sp_rename N'[VendorInvoicePaymentMethods]', N'VendorInvoicePaymentMethod';
    ALTER SCHEMA [dbo] TRANSFER [VendorInvoicePaymentMethod];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceItem].[InvoiceId]', N'VendorInvoiceId', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceItem].[IX_VendorInvoiceItem_InvoiceId]', N'IX_VendorInvoiceItem_VendorInvoiceId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    DROP INDEX [IX_VendorInvoiceTax_VendorInvoiceId] ON [dbo].[VendorInvoiceTax];
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceTax]') AND [c].[name] = N'VendorInvoiceId');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [' + @var7 + '];');
    ALTER TABLE [dbo].[VendorInvoiceTax] ALTER COLUMN [VendorInvoiceId] bigint NOT NULL;
    ALTER TABLE [dbo].[VendorInvoiceTax] ADD DEFAULT CAST(0 AS bigint) FOR [VendorInvoiceId];
    CREATE INDEX [IX_VendorInvoiceTax_VendorInvoiceId] ON [dbo].[VendorInvoiceTax] ([VendorInvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] ADD [SalesTaxId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] ADD [TaxName] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    DROP INDEX [IX_VendorInvoicePayment_VendorInvoiceId] ON [dbo].[VendorInvoicePayment];
    DECLARE @var8 sysname;
    SELECT @var8 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePayment]') AND [c].[name] = N'VendorInvoiceId');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [' + @var8 + '];');
    ALTER TABLE [dbo].[VendorInvoicePayment] ALTER COLUMN [VendorInvoiceId] bigint NOT NULL;
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD DEFAULT CAST(0 AS bigint) FOR [VendorInvoiceId];
    CREATE INDEX [IX_VendorInvoicePayment_VendorInvoiceId] ON [dbo].[VendorInvoicePayment] ([VendorInvoiceId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD [MyPropertyId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD [ManufacturerId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD [SaleCode] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD [Name] nvarchar(255) NOT NULL DEFAULT N'';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD CONSTRAINT [PK_VendorInvoicePaymentMethod] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    CREATE INDEX [IX_VendorInvoiceTax_SalesTaxId] ON [dbo].[VendorInvoiceTax] ([SalesTaxId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    CREATE INDEX [IX_VendorInvoicePayment_MyPropertyId] ON [dbo].[VendorInvoicePayment] ([MyPropertyId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    CREATE INDEX [IX_VendorInvoiceItem_ManufacturerId] ON [dbo].[VendorInvoiceItem] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_MyPropertyId] FOREIGN KEY ([MyPropertyId]) REFERENCES [dbo].[VendorInvoicePaymentMethod] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] ADD CONSTRAINT [FK_VendorInvoiceTax_SalesTax_SalesTaxId] FOREIGN KEY ([SalesTaxId]) REFERENCES [dbo].[SalesTax] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] ADD CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220723140316_VendorInvoiceNavProperties')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220723140316_VendorInvoiceNavProperties', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220724134737_VendorPaymentMethod')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_MyPropertyId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220724134737_VendorPaymentMethod')
BEGIN
    DECLARE @var9 sysname;
    SELECT @var9 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePayment]') AND [c].[name] = N'PaymentMethod');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [' + @var9 + '];');
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP COLUMN [PaymentMethod];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220724134737_VendorPaymentMethod')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoicePayment].[MyPropertyId]', N'PaymentMethodId', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220724134737_VendorPaymentMethod')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoicePayment].[IX_VendorInvoicePayment_MyPropertyId]', N'IX_VendorInvoicePayment_PaymentMethodId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220724134737_VendorPaymentMethod')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_PaymentMethodId] FOREIGN KEY ([PaymentMethodId]) REFERENCES [dbo].[VendorInvoicePaymentMethod] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220724134737_VendorPaymentMethod')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220724134737_VendorPaymentMethod', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725132321_NullableBools')
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[SalesTax]') AND [c].[name] = N'IsTaxable');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[SalesTax] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [dbo].[SalesTax] ALTER COLUMN [IsTaxable] bit NULL;
    ALTER TABLE [dbo].[SalesTax] ADD DEFAULT CAST(0 AS bit) FOR [IsTaxable];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725132321_NullableBools')
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[SalesTax]') AND [c].[name] = N'IsAppliedByDefault');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[SalesTax] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [dbo].[SalesTax] ALTER COLUMN [IsAppliedByDefault] bit NULL;
    ALTER TABLE [dbo].[SalesTax] ADD DEFAULT CAST(1 AS bit) FOR [IsAppliedByDefault];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725132321_NullableBools')
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[CreditCard]') AND [c].[name] = N'IsAddedToDeposit');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[CreditCard] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [dbo].[CreditCard] ALTER COLUMN [IsAddedToDeposit] bit NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725132321_NullableBools')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220725132321_NullableBools', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725163745_VendorInvoiceVendorId')
BEGIN
    ALTER TABLE [dbo].[VendorInvoice] DROP CONSTRAINT [FK_VendorInvoice_Vendor_VendorId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725163745_VendorInvoiceVendorId')
BEGIN
    DROP INDEX [IX_VendorInvoice_VendorId] ON [dbo].[VendorInvoice];
    DECLARE @var13 sysname;
    SELECT @var13 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoice]') AND [c].[name] = N'VendorId');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoice] DROP CONSTRAINT [' + @var13 + '];');
    ALTER TABLE [dbo].[VendorInvoice] ALTER COLUMN [VendorId] bigint NOT NULL;
    ALTER TABLE [dbo].[VendorInvoice] ADD DEFAULT CAST(0 AS bigint) FOR [VendorId];
    CREATE INDEX [IX_VendorInvoice_VendorId] ON [dbo].[VendorInvoice] ([VendorId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725163745_VendorInvoiceVendorId')
BEGIN
    ALTER TABLE [dbo].[VendorInvoice] ADD CONSTRAINT [FK_VendorInvoice_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725163745_VendorInvoiceVendorId')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220725163745_VendorInvoiceVendorId', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725175343_VendInvItemMfrId')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_Manufacturer_ManufacturerId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725175343_VendInvItemMfrId')
BEGIN
    DROP INDEX [IX_VendorInvoiceItem_ManufacturerId] ON [dbo].[VendorInvoiceItem];
    DECLARE @var14 sysname;
    SELECT @var14 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'ManufacturerId');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var14 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] ALTER COLUMN [ManufacturerId] bigint NOT NULL;
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD DEFAULT CAST(0 AS bigint) FOR [ManufacturerId];
    CREATE INDEX [IX_VendorInvoiceItem_ManufacturerId] ON [dbo].[VendorInvoiceItem] ([ManufacturerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725175343_VendInvItemMfrId')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220725175343_VendInvItemMfrId')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220725175343_VendInvItemMfrId', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726162900_VendInvItemSaleCode')
BEGIN
    DECLARE @var15 sysname;
    SELECT @var15 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'SaleCode');
    IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var15 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP COLUMN [SaleCode];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726162900_VendInvItemSaleCode')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD [SaleCodeId] bigint NOT NULL DEFAULT CAST(0 AS bigint);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726162900_VendInvItemSaleCode')
BEGIN
    CREATE INDEX [IX_VendorInvoiceItem_SaleCodeId] ON [dbo].[VendorInvoiceItem] ([SaleCodeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726162900_VendInvItemSaleCode')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_SaleCode_SaleCodeId] FOREIGN KEY ([SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726162900_VendInvItemSaleCode')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220726162900_VendInvItemSaleCode', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_SaleCode_SaleCodeId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_VendorInvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    DECLARE @var16 sysname;
    SELECT @var16 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'VendorInvoiceId');
    IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var16 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] ALTER COLUMN [VendorInvoiceId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    DECLARE @var17 sysname;
    SELECT @var17 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'SaleCodeId');
    IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var17 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] ALTER COLUMN [SaleCodeId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_SaleCode_SaleCodeId] FOREIGN KEY ([SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726180630_VendInvItemNullableIds')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220726180630_VendInvItemNullableIds', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726193340_VendInvItemNullableIds2')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_Manufacturer_ManufacturerId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726193340_VendInvItemNullableIds2')
BEGIN
    DECLARE @var18 sysname;
    SELECT @var18 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'ManufacturerId');
    IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var18 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] ALTER COLUMN [ManufacturerId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726193340_VendInvItemNullableIds2')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] ADD CONSTRAINT [FK_VendorInvoiceItem_Manufacturer_ManufacturerId] FOREIGN KEY ([ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220726193340_VendInvItemNullableIds2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220726193340_VendInvItemNullableIds2', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_PaymentMethodId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    DROP INDEX [IX_VendorInvoicePayment_PaymentMethodId] ON [dbo].[VendorInvoicePayment];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    DECLARE @var19 sysname;
    SELECT @var19 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePayment]') AND [c].[name] = N'PaymentMethodId');
    IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [' + @var19 + '];');
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP COLUMN [PaymentMethodId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD [IsOnAccountPaymentType] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD [IsReconciledByAnotherVendor] bit NOT NULL DEFAULT CAST(0 AS bit);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD [VendorId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD [VendorInvoicePaymentMethodId] bigint NOT NULL DEFAULT CAST(0 AS bigint);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    CREATE INDEX [IX_VendorInvoicePaymentMethod_VendorId] ON [dbo].[VendorInvoicePaymentMethod] ([VendorId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    CREATE INDEX [IX_VendorInvoicePayment_VendorInvoicePaymentMethodId] ON [dbo].[VendorInvoicePayment] ([VendorInvoicePaymentMethodId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_VendorInvoicePaymentMethodId] FOREIGN KEY ([VendorInvoicePaymentMethodId]) REFERENCES [dbo].[VendorInvoicePaymentMethod] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD CONSTRAINT [FK_VendorInvoicePaymentMethod_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220729171921_VendorInvoicePaymentType')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220729171921_VendorInvoicePaymentType', N'6.0.5');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoice] DROP CONSTRAINT [FK_VendorInvoice_Vendor_VendorId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_Manufacturer_ManufacturerId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_SaleCode_SaleCodeId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_VendorInvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_VendorInvoicePaymentMethodId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] DROP CONSTRAINT [FK_VendorInvoicePaymentMethod_Vendor_VendorId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DROP TABLE [dbo].[SalesTaxTaxableExciseFee];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DROP INDEX [IX_VendorInvoicePayment_VendorInvoicePaymentMethodId] ON [dbo].[VendorInvoicePayment];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [PK_VendorInvoiceItem];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var20 sysname;
    SELECT @var20 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceTax]') AND [c].[name] = N'Amount');
    IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [' + @var20 + '];');
    ALTER TABLE [dbo].[VendorInvoiceTax] DROP COLUMN [Amount];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var21 sysname;
    SELECT @var21 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceTax]') AND [c].[name] = N'InvoiceId');
    IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [' + @var21 + '];');
    ALTER TABLE [dbo].[VendorInvoiceTax] DROP COLUMN [InvoiceId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var22 sysname;
    SELECT @var22 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceTax]') AND [c].[name] = N'Order');
    IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [' + @var22 + '];');
    ALTER TABLE [dbo].[VendorInvoiceTax] DROP COLUMN [Order];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var23 sysname;
    SELECT @var23 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceTax]') AND [c].[name] = N'TaxName');
    IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [' + @var23 + '];');
    ALTER TABLE [dbo].[VendorInvoiceTax] DROP COLUMN [TaxName];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var24 sysname;
    SELECT @var24 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePaymentMethod]') AND [c].[name] = N'IsReconciledByAnotherVendor');
    IF @var24 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePaymentMethod] DROP CONSTRAINT [' + @var24 + '];');
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] DROP COLUMN [IsReconciledByAnotherVendor];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var25 sysname;
    SELECT @var25 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePayment]') AND [c].[name] = N'VendorInvoicePaymentMethodId');
    IF @var25 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [' + @var25 + '];');
    ALTER TABLE [dbo].[VendorInvoicePayment] DROP COLUMN [VendorInvoicePaymentMethodId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var26 sysname;
    SELECT @var26 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceItem]') AND [c].[name] = N'InvoiceNumber');
    IF @var26 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceItem] DROP CONSTRAINT [' + @var26 + '];');
    ALTER TABLE [dbo].[VendorInvoiceItem] DROP COLUMN [InvoiceNumber];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceItem]', N'VendorInvoiceLineItem';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoicePaymentMethod].[VendorId]', N'ReconcilingVendorId', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoicePaymentMethod].[IX_VendorInvoicePaymentMethod_VendorId]', N'IX_VendorInvoicePaymentMethod_ReconcilingVendorId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[SaleCodeId]', N'Item_SaleCodeId', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[PartNumber]', N'ItemPartNumber', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[ManufacturerId]', N'Item_ManufacturerId', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[Description]', N'ItemDescription', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[IX_VendorInvoiceItem_VendorInvoiceId]', N'IX_VendorInvoiceLineItem_VendorInvoiceId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[IX_VendorInvoiceItem_SaleCodeId]', N'IX_VendorInvoiceLineItem_Item_SaleCodeId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    EXEC sp_rename N'[dbo].[VendorInvoiceLineItem].[IX_VendorInvoiceItem_ManufacturerId]', N'IX_VendorInvoiceLineItem_Item_ManufacturerId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var27 sysname;
    SELECT @var27 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceTax]') AND [c].[name] = N'VendorInvoiceId');
    IF @var27 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceTax] DROP CONSTRAINT [' + @var27 + '];');
    ALTER TABLE [dbo].[VendorInvoiceTax] ALTER COLUMN [VendorInvoiceId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var28 sysname;
    SELECT @var28 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePayment]') AND [c].[name] = N'VendorInvoiceId');
    IF @var28 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePayment] DROP CONSTRAINT [' + @var28 + '];');
    ALTER TABLE [dbo].[VendorInvoicePayment] ALTER COLUMN [VendorInvoiceId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD [PaymentMethodId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var29 sysname;
    SELECT @var29 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoice]') AND [c].[name] = N'VendorId');
    IF @var29 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoice] DROP CONSTRAINT [' + @var29 + '];');
    ALTER TABLE [dbo].[VendorInvoice] ALTER COLUMN [VendorId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var30 sysname;
    SELECT @var30 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoice]') AND [c].[name] = N'InvoiceNumber');
    IF @var30 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoice] DROP CONSTRAINT [' + @var30 + '];');
    ALTER TABLE [dbo].[VendorInvoice] ALTER COLUMN [InvoiceNumber] nvarchar(255) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[ExciseFee] ADD [SalesTaxId] bigint NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var31 sysname;
    SELECT @var31 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceLineItem]') AND [c].[name] = N'Type');
    IF @var31 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceLineItem] DROP CONSTRAINT [' + @var31 + '];');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var32 sysname;
    SELECT @var32 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceLineItem]') AND [c].[name] = N'ItemPartNumber');
    IF @var32 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceLineItem] DROP CONSTRAINT [' + @var32 + '];');
    ALTER TABLE [dbo].[VendorInvoiceLineItem] ALTER COLUMN [ItemPartNumber] nvarchar(255) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    DECLARE @var33 sysname;
    SELECT @var33 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoiceLineItem]') AND [c].[name] = N'ItemDescription');
    IF @var33 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoiceLineItem] DROP CONSTRAINT [' + @var33 + '];');
    ALTER TABLE [dbo].[VendorInvoiceLineItem] ALTER COLUMN [ItemDescription] nvarchar(255) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceLineItem] ADD CONSTRAINT [PK_VendorInvoiceLineItem] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    CREATE INDEX [IX_VendorInvoicePayment_PaymentMethodId] ON [dbo].[VendorInvoicePayment] ([PaymentMethodId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    CREATE INDEX [IX_ExciseFee_SalesTaxId] ON [dbo].[ExciseFee] ([SalesTaxId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[ExciseFee] ADD CONSTRAINT [FK_ExciseFee_SalesTax_SalesTaxId] FOREIGN KEY ([SalesTaxId]) REFERENCES [dbo].[SalesTax] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoice] ADD CONSTRAINT [FK_VendorInvoice_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceLineItem] ADD CONSTRAINT [FK_VendorInvoiceLineItem_Manufacturer_Item_ManufacturerId] FOREIGN KEY ([Item_ManufacturerId]) REFERENCES [dbo].[Manufacturer] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceLineItem] ADD CONSTRAINT [FK_VendorInvoiceLineItem_SaleCode_Item_SaleCodeId] FOREIGN KEY ([Item_SaleCodeId]) REFERENCES [dbo].[SaleCode] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceLineItem] ADD CONSTRAINT [FK_VendorInvoiceLineItem_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePayment] ADD CONSTRAINT [FK_VendorInvoicePayment_VendorInvoicePaymentMethod_PaymentMethodId] FOREIGN KEY ([PaymentMethodId]) REFERENCES [dbo].[VendorInvoicePaymentMethod] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD CONSTRAINT [FK_VendorInvoicePaymentMethod_Vendor_ReconcilingVendorId] FOREIGN KEY ([ReconcilingVendorId]) REFERENCES [dbo].[Vendor] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    ALTER TABLE [dbo].[VendorInvoiceTax] ADD CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220828181727_VendorInvoiceLineItemsItem')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220828181727_VendorInvoiceLineItemsItem', N'6.0.5');
END;
GO

COMMIT;
GO

