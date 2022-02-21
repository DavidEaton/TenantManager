/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PersonId] [bigint] NULL,
	[OrganizationId] [bigint] NULL,
	[CustomerType] [int] NOT NULL,
	[AllowMail] [bit] NULL,
	[AllowEmail] [bit] NULL,
	[AllowSms] [bit] NULL,
	[Created] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](254) NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[OrganizationId] [bigint] NULL,
	[PersonId] [bigint] NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryItem]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryItem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ManufacturerId] [bigint] NOT NULL,
	[PartNumber] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ProductCodeId] [bigint] NOT NULL,
	[PartType] [int] NOT NULL,
	[QuantityOnHand] [int] NOT NULL,
	[Cost] [float] NOT NULL,
	[SuggestedPrice] [float] NOT NULL,
	[Labor] [float] NOT NULL,
 CONSTRAINT [PK_InventoryItem] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](max) NOT NULL,
	[Prefix] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Manufacturer] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[ContactId] [bigint] NULL,
	[Note] [nvarchar](max) NULL,
	[AddressLine] [nvarchar](255) NULL,
	[AddressCity] [nvarchar](255) NULL,
	[AddressState] [nvarchar](2) NULL,
	[AddressPostalCode] [nvarchar](15) NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
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
	[AddressState] [nvarchar](2) NULL,
	[AddressPostalCode] [nvarchar](15) NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[PhoneType] [int] NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[OrganizationId] [bigint] NULL,
	[PersonId] [bigint] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCode]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCode](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ManufacturerId] [bigint] NULL,
	[Code] [nvarchar](max) NOT NULL,
	[SaleCodeId] [bigint] NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ProductCode] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderItems]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderItems](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderServiceId] [bigint] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[ManufacturerId] [bigint] NOT NULL,
	[PartNumber] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[SaleCodeId] [bigint] NOT NULL,
	[ProductCodeId] [bigint] NOT NULL,
	[SaleType] [int] NOT NULL,
	[PartType] [int] NOT NULL,
	[IsDeclined] [bit] NOT NULL,
	[IsCounterSale] [bit] NOT NULL,
	[QuantitySold] [float] NOT NULL,
	[SellingPrice] [float] NOT NULL,
	[LaborType] [int] NOT NULL,
	[LaborEach] [float] NOT NULL,
	[Cost] [float] NOT NULL,
	[Core] [float] NOT NULL,
	[DiscountType] [int] NOT NULL,
	[DiscountEach] [float] NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderItems] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderItemTaxes]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderItemTaxes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[TaxId] [bigint] NOT NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
	[PartTax] [float] NOT NULL,
	[LaborTax] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderItemTaxes] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderPayments]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderPayments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderId] [bigint] NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderPayments] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderPurchases]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderPurchases](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[VendorId] [bigint] NOT NULL,
	[PurchaseDate] [datetime2](7) NOT NULL,
	[PONumber] [nvarchar](max) NULL,
	[VendorInvoiceNumber] [nvarchar](max) NULL,
	[VendorPartNumber] [nvarchar](max) NULL,
 CONSTRAINT [PK_RepairOrderPurchases] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrders]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrders](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderNumber] [bigint] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[CustomerName] [nvarchar](max) NULL,
	[Vehicle] [nvarchar](max) NULL,
	[Total] [float] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateInvoiced] [datetime2](7) NOT NULL,
	[DiscountTotal] [float] NOT NULL,
	[HazMatTotal] [float] NOT NULL,
	[LaborTotal] [float] NOT NULL,
	[PartsTotal] [float] NOT NULL,
	[ShopSuppliesTotal] [float] NOT NULL,
	[TaxTotal] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrders] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderSerialNumbers]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderSerialNumbers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[SerialNumber] [nvarchar](max) NULL,
 CONSTRAINT [PK_RepairOrderSerialNumbers] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderServices]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderServices](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderId] [bigint] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[ServiceName] [nvarchar](max) NULL,
	[SaleCode] [nvarchar](max) NULL,
	[IsCounterSale] [bit] NOT NULL,
	[IsDeclined] [bit] NOT NULL,
	[PartsTotal] [float] NOT NULL,
	[LaborTotal] [float] NOT NULL,
	[TaxTotal] [float] NOT NULL,
	[ShopSuppliesTotal] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[DiscountTotal] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderServices] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderServiceTaxes]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderServiceTaxes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderServiceId] [bigint] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[TaxId] [bigint] NOT NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
	[PartTax] [float] NOT NULL,
	[LaborTax] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderServiceTaxes] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderTaxes]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderTaxes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderId] [bigint] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[TaxId] [bigint] NOT NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
	[PartTax] [float] NOT NULL,
	[LaborTax] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderTaxes] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderTechs]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderTechs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderServiceId] [bigint] NOT NULL,
	[TechnicianId] [bigint] NOT NULL,
 CONSTRAINT [PK_RepairOrderTechs] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderWarranties]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderWarranties](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	[Type] [int] NOT NULL,
	[NewWarranty] [nvarchar](max) NULL,
	[OriginalWarranty] [nvarchar](max) NULL,
	[OriginalInvoiceId] [bigint] NOT NULL,
 CONSTRAINT [PK_RepairOrderWarranties] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCode]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleCode](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SaleCode] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VIN] [nvarchar](max) NULL,
	[Year] [int] NOT NULL,
	[Make] [nvarchar](max) NULL,
	[Model] [nvarchar](max) NULL,
	[CustomerId] [bigint] NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VendorCode] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorInvoice]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorInvoice](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VendorId] [bigint] NULL,
	[Date] [datetime2](7) NULL,
	[DatePosted] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[InvoiceNumber] [nvarchar](max) NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PK_VendorInvoice] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorInvoiceItem]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorInvoiceItem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [bigint] NOT NULL,
	[Type] [int] NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[MfrId] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Quantity] [float] NOT NULL,
	[Cost] [float] NOT NULL,
	[Core] [float] NOT NULL,
	[PONumber] [nvarchar](max) NULL,
	[InvoiceNumber] [nvarchar](max) NULL,
	[TransactionDate] [datetime2](7) NULL,
 CONSTRAINT [PK_VendorInvoiceItem] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorInvoicePayment]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorInvoicePayment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [bigint] NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[VendorInvoiceId] [bigint] NULL,
 CONSTRAINT [PK_VendorInvoicePayment] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorInvoicePaymentMethods]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorInvoicePaymentMethods](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PaymentName] [nvarchar](max) NULL,
	[TrackingState] [int] NOT NULL,
 CONSTRAINT [PK_VendorInvoicePaymentMethods] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorInvoiceTax]    Script Date: 2/21/2022 1:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorInvoiceTax](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [bigint] NOT NULL,
	[Order] [int] NOT NULL,
	[TaxId] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[VendorInvoiceId] [bigint] NULL,
 CONSTRAINT [PK_VendorInvoiceTax] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsPrimary]
GO
ALTER TABLE [dbo].[RepairOrderItems] ADD  DEFAULT (CONVERT([bigint],(0))) FOR [ManufacturerId]
GO
ALTER TABLE [dbo].[RepairOrderItems] ADD  DEFAULT (CONVERT([bigint],(0))) FOR [SaleCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItems] ADD  DEFAULT (CONVERT([bigint],(0))) FOR [ProductCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItems] ADD  DEFAULT ((0)) FOR [SaleType]
GO
ALTER TABLE [dbo].[RepairOrderItems] ADD  DEFAULT ((0)) FOR [PartType]
GO
ALTER TABLE [dbo].[RepairOrderPayments] ADD  DEFAULT ((0)) FOR [PaymentMethod]
GO
ALTER TABLE [dbo].[RepairOrders] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [DiscountTotal]
GO
ALTER TABLE [dbo].[RepairOrders] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [HazMatTotal]
GO
ALTER TABLE [dbo].[RepairOrders] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [LaborTotal]
GO
ALTER TABLE [dbo].[RepairOrders] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [PartsTotal]
GO
ALTER TABLE [dbo].[RepairOrders] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [ShopSuppliesTotal]
GO
ALTER TABLE [dbo].[RepairOrders] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [TaxTotal]
GO
ALTER TABLE [dbo].[RepairOrderServices] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [DiscountTotal]
GO
ALTER TABLE [dbo].[RepairOrderWarranties] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[VendorInvoice] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[VendorInvoiceItem] ADD  DEFAULT ((0)) FOR [Type]
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
ALTER TABLE [dbo].[InventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_InventoryItem_Manufacturer_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InventoryItem] CHECK CONSTRAINT [FK_InventoryItem_Manufacturer_ManufacturerId]
GO
ALTER TABLE [dbo].[InventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_InventoryItem_ProductCode_ProductCodeId] FOREIGN KEY([ProductCodeId])
REFERENCES [dbo].[ProductCode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InventoryItem] CHECK CONSTRAINT [FK_InventoryItem_ProductCode_ProductCodeId]
GO
ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Organization_Person_ContactId] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Organization_Person_ContactId]
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
ALTER TABLE [dbo].[ProductCode]  WITH CHECK ADD  CONSTRAINT [FK_ProductCode_Manufacturer_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
GO
ALTER TABLE [dbo].[ProductCode] CHECK CONSTRAINT [FK_ProductCode_Manufacturer_ManufacturerId]
GO
ALTER TABLE [dbo].[ProductCode]  WITH CHECK ADD  CONSTRAINT [FK_ProductCode_SaleCode_SaleCodeId] FOREIGN KEY([SaleCodeId])
REFERENCES [dbo].[SaleCode] ([Id])
GO
ALTER TABLE [dbo].[ProductCode] CHECK CONSTRAINT [FK_ProductCode_SaleCode_SaleCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItems_Manufacturer_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItems] CHECK CONSTRAINT [FK_RepairOrderItems_Manufacturer_ManufacturerId]
GO
ALTER TABLE [dbo].[RepairOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItems_ProductCode_ProductCodeId] FOREIGN KEY([ProductCodeId])
REFERENCES [dbo].[ProductCode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItems] CHECK CONSTRAINT [FK_RepairOrderItems_ProductCode_ProductCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItems_RepairOrderServices_RepairOrderServiceId] FOREIGN KEY([RepairOrderServiceId])
REFERENCES [dbo].[RepairOrderServices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItems] CHECK CONSTRAINT [FK_RepairOrderItems_RepairOrderServices_RepairOrderServiceId]
GO
ALTER TABLE [dbo].[RepairOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItems_SaleCode_SaleCodeId] FOREIGN KEY([SaleCodeId])
REFERENCES [dbo].[SaleCode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItems] CHECK CONSTRAINT [FK_RepairOrderItems_SaleCode_SaleCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItemTaxes]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItemTaxes_RepairOrderItems_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItemTaxes] CHECK CONSTRAINT [FK_RepairOrderItemTaxes_RepairOrderItems_RepairOrderItemId]
GO
ALTER TABLE [dbo].[RepairOrderPayments]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderPayments_RepairOrders_RepairOrderId] FOREIGN KEY([RepairOrderId])
REFERENCES [dbo].[RepairOrders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderPayments] CHECK CONSTRAINT [FK_RepairOrderPayments_RepairOrders_RepairOrderId]
GO
ALTER TABLE [dbo].[RepairOrderSerialNumbers]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderSerialNumbers_RepairOrderItems_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderSerialNumbers] CHECK CONSTRAINT [FK_RepairOrderSerialNumbers_RepairOrderItems_RepairOrderItemId]
GO
ALTER TABLE [dbo].[RepairOrderServices]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderServices_RepairOrders_RepairOrderId] FOREIGN KEY([RepairOrderId])
REFERENCES [dbo].[RepairOrders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderServices] CHECK CONSTRAINT [FK_RepairOrderServices_RepairOrders_RepairOrderId]
GO
ALTER TABLE [dbo].[RepairOrderServiceTaxes]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderServiceTaxes_RepairOrderServices_RepairOrderServiceId] FOREIGN KEY([RepairOrderServiceId])
REFERENCES [dbo].[RepairOrderServices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderServiceTaxes] CHECK CONSTRAINT [FK_RepairOrderServiceTaxes_RepairOrderServices_RepairOrderServiceId]
GO
ALTER TABLE [dbo].[RepairOrderTaxes]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderTaxes_RepairOrders_RepairOrderId] FOREIGN KEY([RepairOrderId])
REFERENCES [dbo].[RepairOrders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderTaxes] CHECK CONSTRAINT [FK_RepairOrderTaxes_RepairOrders_RepairOrderId]
GO
ALTER TABLE [dbo].[RepairOrderTechs]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderTechs_RepairOrderServices_RepairOrderServiceId] FOREIGN KEY([RepairOrderServiceId])
REFERENCES [dbo].[RepairOrderServices] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderTechs] CHECK CONSTRAINT [FK_RepairOrderTechs_RepairOrderServices_RepairOrderServiceId]
GO
ALTER TABLE [dbo].[RepairOrderWarranties]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderWarranties_RepairOrderItems_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItems] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderWarranties] CHECK CONSTRAINT [FK_RepairOrderWarranties_RepairOrderItems_RepairOrderItemId]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Customer_CustomerId]
GO
ALTER TABLE [dbo].[VendorInvoice]  WITH CHECK ADD  CONSTRAINT [FK_VendorInvoice_Vendor_VendorId] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[VendorInvoice] CHECK CONSTRAINT [FK_VendorInvoice_Vendor_VendorId]
GO
ALTER TABLE [dbo].[VendorInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_InvoiceId] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[VendorInvoice] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorInvoiceItem] CHECK CONSTRAINT [FK_VendorInvoiceItem_VendorInvoice_InvoiceId]
GO
ALTER TABLE [dbo].[VendorInvoicePayment]  WITH CHECK ADD  CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId] FOREIGN KEY([VendorInvoiceId])
REFERENCES [dbo].[VendorInvoice] ([Id])
GO
ALTER TABLE [dbo].[VendorInvoicePayment] CHECK CONSTRAINT [FK_VendorInvoicePayment_VendorInvoice_VendorInvoiceId]
GO
ALTER TABLE [dbo].[VendorInvoiceTax]  WITH CHECK ADD  CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId] FOREIGN KEY([VendorInvoiceId])
REFERENCES [dbo].[VendorInvoice] ([Id])
GO
ALTER TABLE [dbo].[VendorInvoiceTax] CHECK CONSTRAINT [FK_VendorInvoiceTax_VendorInvoice_VendorInvoiceId]
GO
