SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCard](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[FeeType] [int] NOT NULL,
	[Fee] [float] NOT NULL,
	[IsAddedToDeposit] [bit] NOT NULL,
 CONSTRAINT [PK_CreditCard] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/5/2022 12:23:02 PM ******/
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
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[ExciseFee]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExciseFee](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[FeeType] [int] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_ExciseFee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryItem]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryItem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ManufacturerId] [bigint] NOT NULL,
	[ItemNumber] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ProductCodeId] [bigint] NOT NULL,
	[ItemType] [int] NOT NULL,
	[DetailId] [bigint] NOT NULL,
	[PartId] [bigint] NULL,
	[LaborId] [bigint] NULL,
	[TireId] [bigint] NULL,
 CONSTRAINT [PK_InventoryItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryItemLabor]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryItemLabor](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[LaborType] [int] NOT NULL,
	[LaborAmount] [float] NOT NULL,
	[TechPayType] [int] NOT NULL,
	[TechPayAmount] [float] NOT NULL,
	[SkillLevel] [int] NOT NULL,
 CONSTRAINT [PK_InventoryItemLabor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryItemPart]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryItemPart](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[List] [float] NOT NULL,
	[Cost] [float] NOT NULL,
	[Core] [float] NOT NULL,
	[Retail] [float] NOT NULL,
	[TechPayType] [int] NOT NULL,
	[TechPayAmount] [float] NOT NULL,
	[LineCode] [nvarchar](max) NULL,
	[SubLineCode] [nvarchar](max) NULL,
	[Fractional] [bit] NOT NULL,
	[SkillLevel] [int] NOT NULL,
 CONSTRAINT [PK_InventoryItemPart] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryItemTire]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryItemTire](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](max) NULL,
	[Width] [float] NOT NULL,
	[AspectRatio] [float] NOT NULL,
	[Diameter] [float] NOT NULL,
	[LoadIndex] [int] NOT NULL,
	[SpeedRating] [nvarchar](max) NULL,
	[List] [float] NOT NULL,
	[Cost] [float] NOT NULL,
	[Core] [float] NOT NULL,
	[Retail] [float] NOT NULL,
	[TechPayType] [int] NOT NULL,
	[TechPayAmount] [float] NOT NULL,
	[LineCode] [nvarchar](max) NULL,
	[SubLineCode] [nvarchar](max) NULL,
	[Fractional] [bit] NOT NULL,
	[SkillLevel] [int] NOT NULL,
 CONSTRAINT [PK_InventoryItemTire] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[Organization]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[Phone]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[ProductCode]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[RepairOrder]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrder](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderNumber] [bigint] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[CustomerName] [nvarchar](max) NULL,
	[Vehicle] [nvarchar](max) NULL,
	[PartsTotal] [float] NOT NULL,
	[LaborTotal] [float] NOT NULL,
	[DiscountTotal] [float] NOT NULL,
	[TaxTotal] [float] NOT NULL,
	[HazMatTotal] [float] NOT NULL,
	[ShopSuppliesTotal] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateInvoiced] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RepairOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderItem]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderItem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderServiceId] [bigint] NOT NULL,
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
 CONSTRAINT [PK_RepairOrderItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderItemTax]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderItemTax](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[TaxId] [bigint] NOT NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
	[PartTax] [float] NOT NULL,
	[LaborTax] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderItemTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderPayment]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderPayment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderId] [bigint] NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderPurchase]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderPurchase](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[VendorId] [bigint] NOT NULL,
	[PurchaseDate] [datetime2](7) NOT NULL,
	[PONumber] [nvarchar](max) NULL,
	[VendorInvoiceNumber] [nvarchar](max) NULL,
	[VendorPartNumber] [nvarchar](max) NULL,
 CONSTRAINT [PK_RepairOrderPurchase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderSerialNumber]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderSerialNumber](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[SerialNumber] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RepairOrderSerialNumber] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderService]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderService](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderId] [bigint] NOT NULL,
	[ServiceName] [nvarchar](max) NULL,
	[SaleCode] [nvarchar](max) NULL,
	[IsCounterSale] [bit] NOT NULL,
	[IsDeclined] [bit] NOT NULL,
	[PartsTotal] [float] NOT NULL,
	[LaborTotal] [float] NOT NULL,
	[DiscountTotal] [float] NOT NULL,
	[TaxTotal] [float] NOT NULL,
	[ShopSuppliesTotal] [float] NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderService] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderServiceTax]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderServiceTax](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderServiceId] [bigint] NOT NULL,
	[TaxId] [bigint] NOT NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
	[PartTax] [float] NOT NULL,
	[LaborTax] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderServiceTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderTax]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderTax](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderId] [bigint] NOT NULL,
	[TaxId] [bigint] NOT NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
	[PartTax] [float] NOT NULL,
	[LaborTax] [float] NOT NULL,
 CONSTRAINT [PK_RepairOrderTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderTech]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderTech](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderServiceId] [bigint] NOT NULL,
	[TechnicianId] [bigint] NOT NULL,
 CONSTRAINT [PK_RepairOrderTech] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepairOrderWarranty]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairOrderWarranty](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RepairOrderItemId] [bigint] NOT NULL,
	[Quantity] [float] NOT NULL,
	[Type] [int] NOT NULL,
	[NewWarranty] [nvarchar](max) NULL,
	[OriginalWarranty] [nvarchar](max) NULL,
	[OriginalInvoiceId] [bigint] NOT NULL,
 CONSTRAINT [PK_RepairOrderWarranty] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleCode]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleCode](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[DesiredMargin] [float] NOT NULL,
	[LaborRate] [float] NOT NULL,
	[IncludeLabor] [bit] NULL,
	[IncludeParts] [bit] NULL,
	[MaximumCharge] [float] NULL,
	[MinimumCharge] [float] NULL,
	[MinimumJobAmount] [float] NULL,
	[Percentage] [float] NULL,
 CONSTRAINT [PK_SaleCode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesTax]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesTax](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[TaxType] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[IsAppliedByDefault] [bit] NOT NULL,
	[IsTaxable] [bit] NOT NULL,
	[TaxIdNumber] [nvarchar](max) NULL,
	[PartTaxRate] [float] NOT NULL,
	[LaborTaxRate] [float] NOT NULL,
 CONSTRAINT [PK_SalesTax] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesTaxTaxableExciseFee]    Script Date: 5/5/2022 12:23:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesTaxTaxableExciseFee](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SalesTaxId] [bigint] NULL,
	[ExciseFeeId] [bigint] NULL,
 CONSTRAINT [PK_SalesTaxTaxableExciseFee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[VendorInvoice]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[VendorInvoiceItem]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[VendorInvoicePayment]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[VendorInvoicePaymentMethods]    Script Date: 5/5/2022 12:23:02 PM ******/
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
/****** Object:  Table [dbo].[VendorInvoiceTax]    Script Date: 5/5/2022 12:23:02 PM ******/
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
ALTER TABLE [dbo].[RepairOrderItem] ADD  DEFAULT ((0)) FOR [SaleType]
GO
ALTER TABLE [dbo].[RepairOrderItem] ADD  DEFAULT ((0)) FOR [PartType]
GO
ALTER TABLE [dbo].[RepairOrderPayment] ADD  DEFAULT ((0)) FOR [PaymentMethod]
GO
ALTER TABLE [dbo].[RepairOrderWarranty] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [DesiredMargin]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [LaborRate]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IncludeLabor]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IncludeParts]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [MaximumCharge]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [MinimumCharge]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [MinimumJobAmount]
GO
ALTER TABLE [dbo].[SaleCode] ADD  DEFAULT ((0.0000000000000000e+000)) FOR [Percentage]
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
ALTER TABLE [dbo].[InventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_InventoryItem_InventoryItemLabor_LaborId] FOREIGN KEY([LaborId])
REFERENCES [dbo].[InventoryItemLabor] ([Id])
GO
ALTER TABLE [dbo].[InventoryItem] CHECK CONSTRAINT [FK_InventoryItem_InventoryItemLabor_LaborId]
GO
ALTER TABLE [dbo].[InventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_InventoryItem_InventoryItemPart_PartId] FOREIGN KEY([PartId])
REFERENCES [dbo].[InventoryItemPart] ([Id])
GO
ALTER TABLE [dbo].[InventoryItem] CHECK CONSTRAINT [FK_InventoryItem_InventoryItemPart_PartId]
GO
ALTER TABLE [dbo].[InventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_InventoryItem_InventoryItemTire_TireId] FOREIGN KEY([TireId])
REFERENCES [dbo].[InventoryItemTire] ([Id])
GO
ALTER TABLE [dbo].[InventoryItem] CHECK CONSTRAINT [FK_InventoryItem_InventoryItemTire_TireId]
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
ALTER TABLE [dbo].[RepairOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItem_Manufacturer_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItem] CHECK CONSTRAINT [FK_RepairOrderItem_Manufacturer_ManufacturerId]
GO
ALTER TABLE [dbo].[RepairOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItem_ProductCode_ProductCodeId] FOREIGN KEY([ProductCodeId])
REFERENCES [dbo].[ProductCode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItem] CHECK CONSTRAINT [FK_RepairOrderItem_ProductCode_ProductCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItem_RepairOrderService_RepairOrderServiceId] FOREIGN KEY([RepairOrderServiceId])
REFERENCES [dbo].[RepairOrderService] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItem] CHECK CONSTRAINT [FK_RepairOrderItem_RepairOrderService_RepairOrderServiceId]
GO
ALTER TABLE [dbo].[RepairOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItem_SaleCode_SaleCodeId] FOREIGN KEY([SaleCodeId])
REFERENCES [dbo].[SaleCode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItem] CHECK CONSTRAINT [FK_RepairOrderItem_SaleCode_SaleCodeId]
GO
ALTER TABLE [dbo].[RepairOrderItemTax]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderItemTax_RepairOrderItem_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderItemTax] CHECK CONSTRAINT [FK_RepairOrderItemTax_RepairOrderItem_RepairOrderItemId]
GO
ALTER TABLE [dbo].[RepairOrderPayment]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderPayment_RepairOrder_RepairOrderId] FOREIGN KEY([RepairOrderId])
REFERENCES [dbo].[RepairOrder] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderPayment] CHECK CONSTRAINT [FK_RepairOrderPayment_RepairOrder_RepairOrderId]
GO
ALTER TABLE [dbo].[RepairOrderPurchase]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderPurchase_RepairOrderItem_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderPurchase] CHECK CONSTRAINT [FK_RepairOrderPurchase_RepairOrderItem_RepairOrderItemId]
GO
ALTER TABLE [dbo].[RepairOrderSerialNumber]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderSerialNumber_RepairOrderItem_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderSerialNumber] CHECK CONSTRAINT [FK_RepairOrderSerialNumber_RepairOrderItem_RepairOrderItemId]
GO
ALTER TABLE [dbo].[RepairOrderService]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderService_RepairOrder_RepairOrderId] FOREIGN KEY([RepairOrderId])
REFERENCES [dbo].[RepairOrder] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderService] CHECK CONSTRAINT [FK_RepairOrderService_RepairOrder_RepairOrderId]
GO
ALTER TABLE [dbo].[RepairOrderServiceTax]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderServiceTax_RepairOrderService_RepairOrderServiceId] FOREIGN KEY([RepairOrderServiceId])
REFERENCES [dbo].[RepairOrderService] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderServiceTax] CHECK CONSTRAINT [FK_RepairOrderServiceTax_RepairOrderService_RepairOrderServiceId]
GO
ALTER TABLE [dbo].[RepairOrderTax]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderTax_RepairOrder_RepairOrderId] FOREIGN KEY([RepairOrderId])
REFERENCES [dbo].[RepairOrder] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderTax] CHECK CONSTRAINT [FK_RepairOrderTax_RepairOrder_RepairOrderId]
GO
ALTER TABLE [dbo].[RepairOrderTech]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderTech_RepairOrderService_RepairOrderServiceId] FOREIGN KEY([RepairOrderServiceId])
REFERENCES [dbo].[RepairOrderService] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderTech] CHECK CONSTRAINT [FK_RepairOrderTech_RepairOrderService_RepairOrderServiceId]
GO
ALTER TABLE [dbo].[RepairOrderWarranty]  WITH CHECK ADD  CONSTRAINT [FK_RepairOrderWarranty_RepairOrderItem_RepairOrderItemId] FOREIGN KEY([RepairOrderItemId])
REFERENCES [dbo].[RepairOrderItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RepairOrderWarranty] CHECK CONSTRAINT [FK_RepairOrderWarranty_RepairOrderItem_RepairOrderItemId]
GO
ALTER TABLE [dbo].[SalesTaxTaxableExciseFee]  WITH CHECK ADD  CONSTRAINT [FK_SalesTaxTaxableExciseFee_ExciseFee_ExciseFeeId] FOREIGN KEY([ExciseFeeId])
REFERENCES [dbo].[ExciseFee] ([Id])
GO
ALTER TABLE [dbo].[SalesTaxTaxableExciseFee] CHECK CONSTRAINT [FK_SalesTaxTaxableExciseFee_ExciseFee_ExciseFeeId]
GO
ALTER TABLE [dbo].[SalesTaxTaxableExciseFee]  WITH CHECK ADD  CONSTRAINT [FK_SalesTaxTaxableExciseFee_SalesTax_SalesTaxId] FOREIGN KEY([SalesTaxId])
REFERENCES [dbo].[SalesTax] ([Id])
GO
ALTER TABLE [dbo].[SalesTaxTaxableExciseFee] CHECK CONSTRAINT [FK_SalesTaxTaxableExciseFee_SalesTax_SalesTaxId]
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
