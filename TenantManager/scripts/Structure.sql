CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](255) NULL,
	[FirstName] [nvarchar](255) NULL,
	[MiddleName] [nvarchar](255) NULL,
	[Gender] [int] NOT NULL,
	[Birthday] [datetime2](7) NULL,
	[DriversLicenseNumber] [nvarchar](50) NULL,
	[DriversLicenseIssued] [datetime2](7) NULL,
	[DriversLicenseExpiry] [datetime2](7) NULL,
	[DriversLicenseState] [nvarchar](2) NULL,
	[AddressLine] [nvarchar](255) NULL,
	[AddressCity] [nvarchar](255) NULL,
	[AddressState] [nvarchar](255) NULL,
	[AddressPostalCode] [nvarchar](15) NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

CREATE TABLE [dbo].[Organization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[ContactId] [int] NULL,
	[AddressLine] [nvarchar](255) NULL,
	[AddressCity] [nvarchar](255) NULL,
	[AddressState] [nvarchar](255) NULL,
	[AddressPostalCode] [nvarchar](15) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Organization_Person_ContactId] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Person] ([Id])
GO

ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Organization_Person_ContactId]
GO

CREATE NONCLUSTERED INDEX [IX_Organization_ContactId] ON [dbo].[Organization] ([ContactId] ASC)

CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerType] [int] NOT NULL,
	[AllowMail] [bit] NULL,
	[AllowEmail] [bit] NULL,
	[AllowSms] [bit] NULL,
	[Created] [datetime2](7) NOT NULL,
	[OrganizationId] [int] NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Organization_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([Id])
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Organization_OrganizationId]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Person_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Person_PersonId]
GO

CREATE NONCLUSTERED INDEX [IX_Customer_OrganizationId] ON [dbo].[Customer] ([OrganizationId] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_Customer_PersonId] ON [dbo].[Customer] ([PersonId] ASC)
GO

CREATE TABLE [dbo].[Email](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](254) NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[OrganizationId] [int] NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

ALTER TABLE [dbo].[Email] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsPrimary]
GO

ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_Organization_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([Id])
GO

ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_Organization_OrganizationId]
GO

ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_Person_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO

ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_Person_PersonId]
GO

CREATE NONCLUSTERED INDEX [IX_Email_OrganizationId] ON [dbo].[Email] ([OrganizationId] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_Email_PersonId] ON [dbo].[Email] ([PersonId] ASC)
GO

CREATE TABLE [dbo].[Phone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[PhoneType] [int] NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[OrganizationId] [int] NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Organization_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([Id])
GO

ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Organization_OrganizationId]
GO

ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Person_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO

ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Person_PersonId]
GO

CREATE NONCLUSTERED INDEX [IX_Phone_OrganizationId] ON [dbo].[Phone] ([OrganizationId] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_Phone_PersonId] ON [dbo].[Phone] ([PersonId] ASC)
GO

CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VIN] [nvarchar](max) NULL,
	[Year] [int] NOT NULL,
	[Make] [nvarchar](max) NULL,
	[Model] [nvarchar](max) NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO

ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Customer_CustomerId]
GO

CREATE NONCLUSTERED INDEX [IX_Vehicle_CustomerId] ON [dbo].[Vehicle] ([CustomerId] ASC)
GO

