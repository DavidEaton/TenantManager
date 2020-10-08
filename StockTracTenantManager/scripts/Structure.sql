CREATE TABLE [Person] (
    [Id] int NOT NULL IDENTITY,
    [LastName] nvarchar(255) NOT NULL,
    [FirstName] nvarchar(255) NOT NULL,
    [MiddleName] nvarchar(255) NULL,
    [Gender] nvarchar(1) NULL,
    [Birthday] datetime2 NULL,
    [PhonePrimary] nvarchar(15) NULL,
    [PhoneSecondary] nvarchar(15) NULL,
    [EMailPrimary] nvarchar(255) NULL,
    [EMailSecondary] nvarchar(255) NULL,
    [CustomerType] int NOT NULL,
    [DriversLicence] nvarchar(max) NULL,
    [DlExpires] datetime2 NULL,
    [DlState] nvarchar(2) NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Address] (
    [Id] int NOT NULL IDENTITY,
    [Street1] nvarchar(max) NOT NULL,
    [Street2] nvarchar(max) NULL,
    [Apartment] nvarchar(max) NULL,
    [City] nvarchar(max) NOT NULL,
    [State] nvarchar(max) NOT NULL,
    [PostalCode] nvarchar(max) NOT NULL,
    [CountryCode] nvarchar(2) NULL,
    [PersonId] int NOT NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Address_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([Id]) ON DELETE CASCADE
);
GO

CREATE UNIQUE INDEX [IX_Address_PersonId] ON [Address] ([PersonId]);
GO