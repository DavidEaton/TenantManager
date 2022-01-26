BEGIN TRANSACTION;
GO

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
GO

CREATE TABLE [VendorInvoicePaymentMethods] (
    [Id] bigint NOT NULL IDENTITY,
    [PaymentName] nvarchar(max) NULL,
    [TrackingState] int NOT NULL,
    CONSTRAINT [PK_VendorInvoicePaymentMethods] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Vendors] (
    [Id] bigint NOT NULL IDENTITY,
    [VendorCode] nvarchar(max) NULL,
    [Name] nvarchar(max) NULL,
    [IsActive] bit NULL,
    [TrackingState] int NOT NULL,
    CONSTRAINT [PK_Vendors] PRIMARY KEY ([Id])
);
GO

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
GO

CREATE TABLE [dbo].[VendorInvoice] (
    [Id] bigint NOT NULL IDENTITY,
    [VendorId] bigint NULL,
    [Date] datetime2 NULL,
    [DatePosted] datetime2 NULL,
    [Status] int NOT NULL DEFAULT 1,
    [InvoiceNumber] nvarchar(max) NULL,
    [Total] float NOT NULL,
    CONSTRAINT [PK_VendorInvoice] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_VendorInvoice_Vendors_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [Vendors] ([Id]) ON DELETE NO ACTION
);
GO

CREATE TABLE [dbo].[Customer] (
    [Id] bigint NOT NULL IDENTITY,
    [PersonId] bigint NULL,
    [OrganizationId] bigint NULL,
    [CustomerType] int NOT NULL,
    [AllowMail] bit NULL,
    [AllowEmail] bit NULL,
    [AllowSms] bit NULL,
    [Created] datetime2 NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Customer_Organization_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Customer_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]) ON DELETE NO ACTION
);
GO

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
GO

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
GO

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
GO

CREATE TABLE [dbo].[VendorInvoicePayment] (
    [Id] bigint NOT NULL IDENTITY,
    [InvoiceId] bigint NOT NULL,
    [PaymentMethod] int NOT NULL,
    [Amount] float NOT NULL,
    [VendorInvoiceId] bigint NULL,
    CONSTRAINT [PK_VendorInvoicePayment] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId] FOREIGN KEY ([VendorInvoiceId]) REFERENCES [dbo].[VendorInvoice] ([Id]) ON DELETE NO ACTION
);
GO

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
GO

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
GO

CREATE INDEX [IX_Customer_OrganizationId] ON [dbo].[Customer] ([OrganizationId]);
GO

CREATE INDEX [IX_Customer_PersonId] ON [dbo].[Customer] ([PersonId]);
GO

CREATE INDEX [IX_Email_OrganizationId] ON [dbo].[Email] ([OrganizationId]);
GO

CREATE INDEX [IX_Email_PersonId] ON [dbo].[Email] ([PersonId]);
GO

CREATE INDEX [IX_Organization_ContactId] ON [dbo].[Organization] ([ContactId]);
GO

CREATE INDEX [IX_Phone_OrganizationId] ON [dbo].[Phone] ([OrganizationId]);
GO

CREATE INDEX [IX_Phone_PersonId] ON [dbo].[Phone] ([PersonId]);
GO

CREATE INDEX [IX_Vehicle_CustomerId] ON [dbo].[Vehicle] ([CustomerId]);
GO

CREATE INDEX [IX_VendorInvoice_VendorId] ON [dbo].[VendorInvoice] ([VendorId]);
GO

CREATE INDEX [IX_VendorInvoiceItem_InvoiceId] ON [dbo].[VendorInvoiceItem] ([InvoiceId]);
GO

CREATE INDEX [IX_VendorInvoicePayment_VendorInvoiceId] ON [dbo].[VendorInvoicePayment] ([VendorInvoiceId]);
GO

CREATE INDEX [IX_VendorInvoiceTax_VendorInvoiceId] ON [dbo].[VendorInvoiceTax] ([VendorInvoiceId]);
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [dbo].[VendorInvoice] DROP CONSTRAINT [FK_VendorInvoice_Vendors_VendorId];
GO

ALTER TABLE [Vendors] DROP CONSTRAINT [PK_Vendors];
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Vendors]') AND [c].[name] = N'TrackingState');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Vendors] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Vendors] DROP COLUMN [TrackingState];
GO

EXEC sp_rename N'[Vendors]', N'Vendor';
ALTER SCHEMA [dbo] TRANSFER [Vendor];
GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[Vendor]') AND [c].[name] = N'VendorCode');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[Vendor] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [dbo].[Vendor] ALTER COLUMN [VendorCode] nvarchar(10) NOT NULL;
ALTER TABLE [dbo].[Vendor] ADD DEFAULT N'' FOR [VendorCode];
GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[Vendor]') AND [c].[name] = N'Name');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[Vendor] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [dbo].[Vendor] ALTER COLUMN [Name] nvarchar(255) NOT NULL;
ALTER TABLE [dbo].[Vendor] ADD DEFAULT N'' FOR [Name];
GO

ALTER TABLE [dbo].[Vendor] ADD CONSTRAINT [PK_Vendor] PRIMARY KEY ([Id]);
GO

ALTER TABLE [dbo].[VendorInvoice] ADD CONSTRAINT [FK_VendorInvoice_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [dbo].[Vendor] ([Id]) ON DELETE NO ACTION;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [VendorInvoicePaymentMethods] DROP CONSTRAINT [PK_VendorInvoicePaymentMethods];
GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[VendorInvoicePaymentMethods]') AND [c].[name] = N'TrackingState');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [VendorInvoicePaymentMethods] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [VendorInvoicePaymentMethods] DROP COLUMN [TrackingState];
GO

EXEC sp_rename N'[VendorInvoicePaymentMethods]', N'VendorInvoicePaymentMethod';
ALTER SCHEMA [dbo] TRANSFER [VendorInvoicePaymentMethod];
GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[dbo].[VendorInvoicePaymentMethod]') AND [c].[name] = N'PaymentName');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [dbo].[VendorInvoicePaymentMethod] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ALTER COLUMN [PaymentName] nvarchar(max) NOT NULL;
ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD DEFAULT N'' FOR [PaymentName];
GO

ALTER TABLE [dbo].[VendorInvoicePaymentMethod] ADD CONSTRAINT [PK_VendorInvoicePaymentMethod] PRIMARY KEY ([Id]);
GO

COMMIT;
GO

