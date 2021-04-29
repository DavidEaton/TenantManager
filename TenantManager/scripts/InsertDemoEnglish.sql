IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Birthday', N'CustomerType', N'DlExpires', N'DlState', N'DriversLicence', N'EMailPrimary', N'EMailSecondary', N'FirstName', N'Gender', N'LastName', N'MiddleName', N'PhonePrimary', N'PhoneSecondary') AND [object_id] = OBJECT_ID(N'[Person]'))
    SET IDENTITY_INSERT [Person] ON;
INSERT INTO [Person] ([Id], [Birthday], [CustomerType], [DlExpires], [DlState], [DriversLicence], [EMailPrimary], [EMailSecondary], [FirstName], [Gender], [LastName], [MiddleName], [PhonePrimary], [PhoneSecondary])
VALUES (1, '1985-09-28T00:00:00.0000000-04:00', 0, '2021-09-28T00:00:00.0000000-04:00', N'MI', N'E350 844 25414', N'jb@moops.com', NULL, N'Jerry', N'M', N'Berry', N'Cherry', NULL, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Birthday', N'CustomerType', N'DlExpires', N'DlState', N'DriversLicence', N'EMailPrimary', N'EMailSecondary', N'FirstName', N'Gender', N'LastName', N'MiddleName', N'PhonePrimary', N'PhoneSecondary') AND [object_id] = OBJECT_ID(N'[Person]'))
    SET IDENTITY_INSERT [Person] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Birthday', N'CustomerType', N'DlExpires', N'DlState', N'DriversLicence', N'EMailPrimary', N'EMailSecondary', N'FirstName', N'Gender', N'LastName', N'MiddleName', N'PhonePrimary', N'PhoneSecondary') AND [object_id] = OBJECT_ID(N'[Person]'))
    SET IDENTITY_INSERT [Person] ON;
INSERT INTO [Person] ([Id], [Birthday], [CustomerType], [DlExpires], [DlState], [DriversLicence], [EMailPrimary], [EMailSecondary], [FirstName], [Gender], [LastName], [MiddleName], [PhonePrimary], [PhoneSecondary])
VALUES (2, '1988-08-05T00:00:00.0000000-04:00', 0, '2022-09-28T00:00:00.0000000-04:00', N'MI', N'Z340 233 26648', N'mm@moops.com', NULL, N'Molly', N'F', N'Moops', N'Marie', NULL, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Birthday', N'CustomerType', N'DlExpires', N'DlState', N'DriversLicence', N'EMailPrimary', N'EMailSecondary', N'FirstName', N'Gender', N'LastName', N'MiddleName', N'PhonePrimary', N'PhoneSecondary') AND [object_id] = OBJECT_ID(N'[Person]'))
    SET IDENTITY_INSERT [Person] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Apartment', N'City', N'CountryCode', N'PersonId', N'PostalCode', N'State', N'Street1', N'Street2') AND [object_id] = OBJECT_ID(N'[Address]'))
    SET IDENTITY_INSERT [Address] ON;
INSERT INTO [Address] ([Id], [Apartment], [City], [CountryCode], [PersonId], [PostalCode], [State], [Street1], [Street2])
VALUES (1, N'C3', N'Gaylord', N'US', 1, N'49735', N'MI', N'1234 Five Ave.', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Apartment', N'City', N'CountryCode', N'PersonId', N'PostalCode', N'State', N'Street1', N'Street2') AND [object_id] = OBJECT_ID(N'[Address]'))
    SET IDENTITY_INSERT [Address] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Apartment', N'City', N'CountryCode', N'PersonId', N'PostalCode', N'State', N'Street1', N'Street2') AND [object_id] = OBJECT_ID(N'[Address]'))
    SET IDENTITY_INSERT [Address] ON;
INSERT INTO [Address] ([Id], [Apartment], [City], [CountryCode], [PersonId], [PostalCode], [State], [Street1], [Street2])
VALUES (2, N'P0', N'Gaylord', N'US', 2, N'49735', N'MI', N'5431 One Street', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Apartment', N'City', N'CountryCode', N'PersonId', N'PostalCode', N'State', N'Street1', N'Street2') AND [object_id] = OBJECT_ID(N'[Address]'))
    SET IDENTITY_INSERT [Address] OFF;

GO


UPDATE [Person] SET [Birthday] = '1985-09-29T00:00:00.0000000-04:00', [DlExpires] = '2021-09-29T00:00:00.0000000-04:00', [PhonePrimary] = N'9893501234'
WHERE [Id] = 1;
SELECT @@ROWCOUNT;


GO

UPDATE [Person] SET [Birthday] = '1988-08-06T00:00:00.0000000-04:00', [DlExpires] = '2022-09-29T00:00:00.0000000-04:00', [PhonePrimary] = N'2316453210'
WHERE [Id] = 2;
SELECT @@ROWCOUNT;


GO
