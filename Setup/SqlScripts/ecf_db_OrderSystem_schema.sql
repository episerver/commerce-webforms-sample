IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LineItem_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItem]'))
ALTER TABLE [dbo].[LineItem] DROP CONSTRAINT [FK_LineItem_OrderForm]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LineItemDiscount_LineItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]'))
ALTER TABLE [dbo].[LineItemDiscount] DROP CONSTRAINT [FK_LineItemDiscount_LineItem]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderForm_OrderGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderForm]'))
ALTER TABLE [dbo].[OrderForm] DROP CONSTRAINT [FK_OrderForm_OrderGroup]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderFormDiscount_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderFormDiscount]'))
ALTER TABLE [dbo].[OrderFormDiscount] DROP CONSTRAINT [FK_OrderFormDiscount_OrderForm]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderFormPayment_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderFormPayment]'))
ALTER TABLE [dbo].[OrderFormPayment] DROP CONSTRAINT [FK_OrderFormPayment_OrderForm]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderGroupAddress_OrderGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderGroupAddress]'))
ALTER TABLE [dbo].[OrderGroupAddress] DROP CONSTRAINT [FK_OrderGroupAddress_OrderGroup]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderSearchResults_OrderGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderSearchResults]'))
ALTER TABLE [dbo].[OrderSearchResults] DROP CONSTRAINT [FK_OrderSearchResults_OrderGroup]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethod_PaymentMethodParameter_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[PaymentMethodParameter]'))
ALTER TABLE [dbo].[PaymentMethodParameter] DROP CONSTRAINT [PaymentMethod_PaymentMethodParameter_FK1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketPaymentMethods_PaymentMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketPaymentMethods]'))
ALTER TABLE [dbo].[MarketPaymentMethods] DROP CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketPaymentMethods_Market]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketPaymentMethods]'))
ALTER TABLE [dbo].[MarketPaymentMethods] DROP CONSTRAINT [FK_MarketPaymentMethods_Market]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Shipment_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[Shipment]'))
ALTER TABLE [dbo].[Shipment] DROP CONSTRAINT [FK_Shipment_OrderForm]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingCountry_Country]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingCountry]'))
ALTER TABLE [dbo].[ShippingCountry] DROP CONSTRAINT [FK_ShippingCountry_Country]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingCountry_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingCountry]'))
ALTER TABLE [dbo].[ShippingCountry] DROP CONSTRAINT [FK_ShippingCountry_ShippingMethod]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShipmentDiscount_Shipment]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShipmentDiscount]'))
ALTER TABLE [dbo].[ShipmentDiscount] DROP CONSTRAINT [FK_ShipmentDiscount_Shipment]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingOptionParameter_ShippingOption]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingOptionParameter]'))
ALTER TABLE [dbo].[ShippingOptionParameter] DROP CONSTRAINT [FK_ShippingOptionParameter_ShippingOption]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingMethod_ShippingOption]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethod]'))
ALTER TABLE [dbo].[ShippingMethod] DROP CONSTRAINT [FK_ShippingMethod_ShippingOption]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingMethodCase_JurisdictionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethodCase]'))
ALTER TABLE [dbo].[ShippingMethodCase] DROP CONSTRAINT [FK_ShippingMethodCase_JurisdictionGroup]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethod_ShippingMethodCase_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethodCase]'))
ALTER TABLE [dbo].[ShippingMethodCase] DROP CONSTRAINT [ShippingMethod_ShippingMethodCase_FK1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingMethodParameter_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethodParameter]'))
ALTER TABLE [dbo].[ShippingMethodParameter] DROP CONSTRAINT [FK_ShippingMethodParameter_ShippingMethod]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPackage_Package]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPackage]'))
ALTER TABLE [dbo].[ShippingPackage] DROP CONSTRAINT [FK_ShippingPackage_Package]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPackage_ShippingOption]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPackage]'))
ALTER TABLE [dbo].[ShippingPackage] DROP CONSTRAINT [FK_ShippingPackage_ShippingOption]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPaymentRestriction_PaymentMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]'))
ALTER TABLE [dbo].[ShippingPaymentRestriction] DROP CONSTRAINT [FK_ShippingPaymentRestriction_PaymentMethod]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPaymentRestriction_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]'))
ALTER TABLE [dbo].[ShippingPaymentRestriction] DROP CONSTRAINT [FK_ShippingPaymentRestriction_ShippingMethod]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingRegion_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingRegion]'))
ALTER TABLE [dbo].[ShippingRegion] DROP CONSTRAINT [FK_ShippingRegion_ShippingMethod]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[StateProvince_ShippingRegion_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingRegion]'))
ALTER TABLE [dbo].[ShippingRegion] DROP CONSTRAINT [StateProvince_ShippingRegion_FK1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_StateProvince_Country]') AND parent_object_id = OBJECT_ID(N'[dbo].[StateProvince]'))
ALTER TABLE [dbo].[StateProvince] DROP CONSTRAINT [FK_StateProvince_Country]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaxValue_JurisdictionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxValue]'))
ALTER TABLE [dbo].[TaxValue] DROP CONSTRAINT [FK_TaxValue_JurisdictionGroup]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Tax_TaxValue_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxValue]'))
ALTER TABLE [dbo].[TaxValue] DROP CONSTRAINT [Tax_TaxValue_FK1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaxLanguage_Tax]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxLanguage]'))
ALTER TABLE [dbo].[TaxLanguage] DROP CONSTRAINT [FK_TaxLanguage_Tax]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_JurisdictionRelation_Jurisdiction]') AND parent_object_id = OBJECT_ID(N'[dbo].[JurisdictionRelation]'))
ALTER TABLE [dbo].[JurisdictionRelation] DROP CONSTRAINT [FK_JurisdictionRelation_Jurisdiction]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_JurisdictionRelation_JurisdictionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[JurisdictionRelation]'))
ALTER TABLE [dbo].[JurisdictionRelation] DROP CONSTRAINT [FK_JurisdictionRelation_JurisdictionGroup]
GO

/****** Object:  Table [dbo].[Country]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Country]') AND type in (N'U'))
DROP TABLE [dbo].[Country]
GO

/****** Object:  Table [dbo].[LineItem]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND type in (N'U'))
DROP TABLE [dbo].[LineItem]
GO

/****** Object:  Table [dbo].[LineItemDiscount]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]') AND type in (N'U'))
DROP TABLE [dbo].[LineItemDiscount]
GO

/****** Object:  Table [dbo].[OrderForm]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderForm]') AND type in (N'U'))
DROP TABLE [dbo].[OrderForm]
GO

/****** Object:  Table [dbo].[OrderFormDiscount]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormDiscount]') AND type in (N'U'))
DROP TABLE [dbo].[OrderFormDiscount]
GO

/****** Object:  Table [dbo].[OrderFormPayment]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormPayment]') AND type in (N'U'))
DROP TABLE [dbo].[OrderFormPayment]
GO

/****** Object:  Table [dbo].[OrderGroup]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroup]') AND type in (N'U'))
DROP TABLE [dbo].[OrderGroup]
GO

/****** Object:  Table [dbo].[OrderGroupAddress]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroupAddress]') AND type in (N'U'))
DROP TABLE [dbo].[OrderGroupAddress]
GO

/****** Object:  Table [dbo].[OrderSearchResults]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderSearchResults]') AND type in (N'U'))
DROP TABLE [dbo].[OrderSearchResults]
GO

/****** Object:  Table [dbo].[OrderStatus]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderStatus]') AND type in (N'U'))
DROP TABLE [dbo].[OrderStatus]
GO

/****** Object:  Table [dbo].[Package]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Package]') AND type in (N'U'))
DROP TABLE [dbo].[Package]
GO

/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 07/21/2009 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethod]') AND type in (N'U'))
DROP TABLE [dbo].[PaymentMethod]
GO

/****** Object:  Table [dbo].[MarketPaymentMethods]    Script Date: 03/01/2013 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarketPaymentMethods]') AND type in (N'U'))
DROP TABLE [dbo].[MarketPaymentMethods]
GO

/****** Object:  Table [dbo].[PaymentMethodParameter]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethodParameter]') AND type in (N'U'))
DROP TABLE [dbo].[PaymentMethodParameter]
GO

/****** Object:  Table [dbo].[SchemaVersion_OrderSystem]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_OrderSystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_OrderSystem]
GO

/****** Object:  Table [dbo].[Shipment]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Shipment]') AND type in (N'U'))
DROP TABLE [dbo].[Shipment]
GO

/****** Object:  Table [dbo].[ShippingCountry]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingCountry]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingCountry]
GO

/****** Object:  Table [dbo].[ShipmentDiscount]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShipmentDiscount]') AND type in (N'U'))
DROP TABLE [dbo].[ShipmentDiscount]
GO

/****** Object:  Table [dbo].[ShippingOption]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOption]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingOption]
GO

/****** Object:  Table [dbo].[ShippingOptionParameter]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOptionParameter]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingOptionParameter]
GO

/****** Object:  Table [dbo].[ShippingMethod]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethod]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingMethod]
GO

/****** Object:  Table [dbo].[ShippingMethodCase]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethodCase]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingMethodCase]
GO

/****** Object:  Table [dbo].[ShippingMethodParameter]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethodParameter]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingMethodParameter]
GO

/****** Object:  Table [dbo].[ShippingPackage]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingPackage]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingPackage]
GO

/****** Object:  Table [dbo].[ShippingPaymentRestriction]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingPaymentRestriction]
GO

/****** Object:  Table [dbo].[ShippingRegion]    Script Date: 07/21/2009 17:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingRegion]') AND type in (N'U'))
DROP TABLE [dbo].[ShippingRegion]
GO

/****** Object:  Table [dbo].[StateProvince]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StateProvince]') AND type in (N'U'))
DROP TABLE [dbo].[StateProvince]
GO

/****** Object:  Table [dbo].[TaxCategory]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxCategory]') AND type in (N'U'))
DROP TABLE [dbo].[TaxCategory]
GO

/****** Object:  Table [dbo].[TaxValue]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxValue]') AND type in (N'U'))
DROP TABLE [dbo].[TaxValue]
GO

/****** Object:  Table [dbo].[Tax]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tax]') AND type in (N'U'))
DROP TABLE [dbo].[Tax]
GO

/****** Object:  Table [dbo].[TaxLanguage]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxLanguage]') AND type in (N'U'))
DROP TABLE [dbo].[TaxLanguage]
GO

/****** Object:  Table [dbo].[Jurisdiction]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Jurisdiction]') AND type in (N'U'))
DROP TABLE [dbo].[Jurisdiction]
GO

/****** Object:  Table [dbo].[JurisdictionGroup]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JurisdictionGroup]') AND type in (N'U'))
DROP TABLE [dbo].[JurisdictionGroup]
GO

/****** Object:  Table [dbo].[JurisdictionRelation]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JurisdictionRelation]') AND type in (N'U'))
DROP TABLE [dbo].[JurisdictionRelation]
GO

/****** Object:  Table [dbo].[OrderGroupLock]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroupLock]') AND type in (N'U'))
DROP TABLE [dbo].[OrderGroupLock]
GO

/****** Object:  Table [dbo].[OrderGroupNote]    Script Date: 07/21/2009 17:25:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroupNote]') AND type in (N'U'))
DROP TABLE [dbo].[OrderGroupNote]
GO

/****** Object:  Table [dbo].[PickList]    Script Date: 10/20/2010 12:48:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PickList]') AND type in (N'U'))
DROP TABLE [dbo].[PickList]
GO

/****** Object:  Table [dbo].[ReturnReasonDictionary]    Script Date: 05/13/2011 23:29:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReturnReasonDictionary]') AND type in (N'U'))
DROP TABLE [dbo].[ReturnReasonDictionary]
GO

/****** Object:  Table [dbo].[[OrderGroupNote]]    Script Date: 07/21/2009 17:25:06 ******/
CREATE TABLE [dbo].[OrderGroupNote](
	[OrderNoteId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Type] [nvarchar](50) NULL,
	[Detail] [ntext] NULL,
	[Created] [datetime] NOT NULL,
	[LineItemId] [int] NULL,
 CONSTRAINT [PK_OrderGroupNote] PRIMARY KEY CLUSTERED 
(
	[OrderNoteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/****** Object:  Table [dbo].[[OrderGroupLock]]    Script Date: 07/21/2009 17:25:06 ******/
CREATE TABLE [dbo].[OrderGroupLock](
	[OrderLockId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[Created] [datetime] NOT NULL,
	[OrderGroupId] [int] NOT NULL,
 CONSTRAINT [PK_OrderGroupLock] PRIMARY KEY CLUSTERED 
(
	[OrderLockId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Country]    Script Date: 07/21/2009 17:25:06 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Country]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Ordering] [int] NULL,
	[Visible] [bit] NULL,
	[Code] [nvarchar](3) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Country_PK] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[LineItem]    Script Date: 07/21/2009 17:25:06 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LineItem](
	[LineItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderFormId] [int] NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[Catalog] [nvarchar](255) NOT NULL,
	[CatalogNode] [nvarchar](255) NOT NULL,
	[ParentCatalogEntryId] [nvarchar](255) NULL,
	[CatalogEntryId] [nvarchar](255) NOT NULL,
	[Quantity] [money] NOT NULL,
	[PlacedPrice] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[LineItemDiscountAmount] [money] NOT NULL,
	[OrderLevelDiscountAmount] [money] NOT NULL,
	[ShippingAddressId] [nvarchar](50) NOT NULL,
	[ShippingMethodName] [nvarchar](128) NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[ExtendedPrice] [money] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Status] [nvarchar](64) NULL,
	[DisplayName] [nvarchar](255) NULL,
	[AllowBackordersAndPreorders] [bit] NOT NULL,
	[InStockQuantity] [money] NOT NULL,
	[PreorderQuantity] [money] NOT NULL,
	[BackorderQuantity] [money] NOT NULL,
	[InventoryStatus] int NOT NULL,
	[LineItemOrdering] [datetime] NULL,
	[ConfigurationId] [nvarchar](255) NULL,
	[MinQuantity] [money] NOT NULL,
	[MaxQuantity] [money] NOT NULL,
	[ProviderId] [nvarchar](255) NULL,
	[ReturnReason] [nvarchar](255) NULL,
	[OrigLineItemId] [int] NULL,
	[ReturnQuantity] [money] NOT NULL default 0,
	[WarehouseCode] [nvarchar](50) NULL,
    [IsInventoryAllocated] [bit] not null constraint DF_LineItem_IsInventoryAllocated default 0
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[LineItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_LineItem_OrderFormId]    Script Date: 07/21/2009 17:25:06 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND name = N'IX_LineItem_OrderFormId')
CREATE NONCLUSTERED INDEX [IX_LineItem_OrderFormId] ON [dbo].[LineItem] 
(
	[OrderFormId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]

/****** Object:  Index [IX_LineItem_OrderGroupId]    Script Date: 07/21/2009 17:25:06 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND name = N'IX_LineItem_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_LineItem_OrderGroupId] ON [dbo].[LineItem] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[LineItemDiscount]    Script Date: 07/21/2009 17:25:06 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LineItemDiscount](
	[LineItemDiscountId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[LineItemId] [int] NOT NULL,
	[DiscountId] [int] NOT NULL,
	[DiscountAmount] [money] NOT NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[DiscountName] [nvarchar](50) NULL,
	[DisplayMessage] [nvarchar](100) NULL,
	[DiscountValue] [money] NOT NULL,
 CONSTRAINT [PK_LineItemDiscount] PRIMARY KEY CLUSTERED 
(
	[LineItemDiscountId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_LineItemDiscount] UNIQUE NONCLUSTERED 
(
	[DiscountId] ASC,
	[LineItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_LineItem_OrderGroupId]    Script Date: 07/21/2009 17:25:06 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]') AND name = N'IX_LineItem_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_LineItem_OrderGroupId] ON [dbo].[LineItemDiscount] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]

/****** Object:  Index [IX_LineItemDiscount_LineItem]    Script Date: 07/21/2009 17:25:06 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]') AND name = N'IX_LineItemDiscount_LineItem')
CREATE NONCLUSTERED INDEX [IX_LineItemDiscount_LineItem] ON [dbo].[LineItemDiscount] 
(
	[LineItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderForm]    Script Date: 07/21/2009 17:25:06 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderForm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderForm](
	[OrderFormId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[Name] [nvarchar](64) NULL,
	[BillingAddressId] [nvarchar](50) NULL,
	[DiscountAmount] [money] NOT NULL,
	[SubTotal] [money] NOT NULL,
	[ShippingTotal] [money] NOT NULL,
	[HandlingTotal] [money] NOT NULL,
	[TaxTotal] [money] NOT NULL,
	[Total] [money] NOT NULL,
	[Status] [nvarchar](64) NULL,
	[ProviderId] [nvarchar](255) NULL,
	[ReturnComment] [nvarchar] (1024) NULL,
	[ReturnType] [nvarchar](50) NULL,
	[ReturnAuthCode] [nvarchar](255) NULL,
	[OrigOrderFormId] [int] NULL,
	[ExchangeOrderGroupId] [int] NULL,
	[AuthorizedPaymentTotal] [money] NOT NULL,
	[CapturedPaymentTotal] [money] NOT NULL
 CONSTRAINT [PK_OrderInfo] PRIMARY KEY CLUSTERED 
(
	[OrderFormId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_OrderForm_OrderGroupId]    Script Date: 07/21/2009 17:25:06 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderForm]') AND name = N'IX_OrderForm_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_OrderForm_OrderGroupId] ON [dbo].[OrderForm] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderFormDiscount]    Script Date: 07/21/2009 17:25:06 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormDiscount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderFormDiscount](
	[OrderFormDiscountId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[OrderFormId] [int] NOT NULL,
	[DiscountId] [int] NOT NULL,
	[DiscountAmount] [money] NOT NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[DiscountName] [nvarchar](50) NULL,
	[DisplayMessage] [nvarchar](100) NULL,
	[DiscountValue] [money] NOT NULL,
 CONSTRAINT [PK_OrderFormDiscount] PRIMARY KEY CLUSTERED 
(
	[OrderFormDiscountId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_OrderFormDiscount] UNIQUE NONCLUSTERED 
(
	[DiscountId] ASC,
	[OrderFormId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_OrderFormDiscount_OrderGroupId]    Script Date: 07/21/2009 17:25:06 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormDiscount]') AND name = N'IX_OrderFormDiscount_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_OrderFormDiscount_OrderGroupId] ON [dbo].[OrderFormDiscount] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderFormPayment]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormPayment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderFormPayment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[OrderFormId] [int] NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[BillingAddressId] [nvarchar](50) NULL,
	[PaymentMethodId] [uniqueidentifier] NOT NULL,
	[PaymentMethodName] [nvarchar](128) NULL,
	[CustomerName] [nvarchar](64) NULL,
	[Amount] [money] NOT NULL,
	[PaymentType] [int] NOT NULL,
	[ValidationCode] [nvarchar](64) NULL,
	[AuthorizationCode] [nvarchar](255) NULL,
	[TransactionType] nvarchar(255) NULL,
	[TransactionID] nvarchar(255) NULL,
	[Status] [nvarchar](64) NULL,
	[ImplementationClass] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_OrderFormPayment] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_OrderFormPayment_OrderFormId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormPayment]') AND name = N'IX_OrderFormPayment_OrderFormId')
CREATE NONCLUSTERED INDEX [IX_OrderFormPayment_OrderFormId] ON [dbo].[OrderFormPayment] 
(
	[OrderFormId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]

/****** Object:  Index [IX_OrderFormPayment_OrderGroupId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderFormPayment]') AND name = N'IX_OrderFormPayment_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_OrderFormPayment_OrderGroupId] ON [dbo].[OrderFormPayment] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderGroup]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderGroup](
	[OrderGroupId] [int] IDENTITY(1,1) NOT NULL,
	[InstanceId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[AffiliateId] [uniqueidentifier] NULL,
	[Name] [nvarchar](64) NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[CustomerName] [nvarchar](64) NULL,
	[AddressId] [nvarchar](50) NULL,
	[ShippingTotal] [money] NOT NULL,
	[HandlingTotal] [money] NOT NULL,
	[TaxTotal] [money] NOT NULL,
	[SubTotal] [money] NOT NULL,
	[Total] [money] NOT NULL,
	[BillingCurrency] [nvarchar](64) NULL,
	[Status] [nvarchar](64) NULL,
	[ProviderId] [nvarchar](255) NULL,
	[SiteId] [nvarchar](255) NULL,
	[OwnerOrg] [nvarchar](255) NULL,
	[Owner] [nvarchar](255) NULL,
	MarketId nvarchar(8) not null constraint DF_OrderGroup_MarketId default 'DEFAULT'
 CONSTRAINT [PK_PurchaseOrders] PRIMARY KEY CLUSTERED 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_OrderGroup]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroup]') AND name = N'IX_OrderGroup')
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderGroup] ON [dbo].[OrderGroup] 
(
	[InstanceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]

/****** Object:  Index [IX_OrderGroup_CustomerIdName]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroup]') AND name = N'IX_OrderGroup_CustomerIdName')
CREATE NONCLUSTERED INDEX [IX_OrderGroup_CustomerIdName] ON [dbo].[OrderGroup] 
(
	[CustomerId] ASC,
	[Name] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderGroupAddress]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroupAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderGroupAddress](
	[OrderGroupAddressId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[Name] [nvarchar](64) NULL,
	[FirstName] [nvarchar](64) NULL,
	[LastName] [nvarchar](64) NULL,
	[Organization] [nvarchar](64) NULL,
	[Line1] [nvarchar](80) NULL,
	[Line2] [nvarchar](80) NULL,
	[City] [nvarchar](64) NULL,
	[State] [nvarchar](64) NULL,
	[CountryCode] [nvarchar](50) NULL,
	[CountryName] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](20) NULL,
	[RegionCode] [nvarchar](50) NULL,
	[RegionName] [nvarchar](64) NULL,
	[DaytimePhoneNumber] [nvarchar](32) NULL,
	[EveningPhoneNumber] [nvarchar](32) NULL,
	[FaxNumber] [nvarchar](32) NULL,
	[Email] [nvarchar](64) NULL,
 CONSTRAINT [PK_OrderGroupAddress] PRIMARY KEY CLUSTERED 
(
	[OrderGroupAddressId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_OrderGroupAddress_OrderGroupId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderGroupAddress]') AND name = N'IX_OrderGroupAddress_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_OrderGroupAddress_OrderGroupId] ON [dbo].[OrderGroupAddress] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderSearchResults]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderSearchResults]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderSearchResults](
	[SearchSetId] [uniqueidentifier] NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[Created] [datetime] NULL DEFAULT (getutcdate())
) ON [PRIMARY]
END

/****** Object:  Index [IX_OrderSearchResults_SearchSetId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderSearchResults]') AND name = N'IX_OrderSearchResults_SearchSetId')
CREATE CLUSTERED INDEX [IX_OrderSearchResults_SearchSetId] ON [dbo].[OrderSearchResults] 
(
	[SearchSetId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderStatus]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Package]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Package]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Package](
	[PackageId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](600) NULL,
	[Width] [float] NULL,
	[Height] [float] NULL,
	[Length] [float] NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Package_PK] PRIMARY KEY CLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethod]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PaymentMethod](
	[PaymentMethodId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[LanguageId] [nvarchar](128) NOT NULL,
	[SystemKeyword] [nvarchar](30) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[ClassName] [nvarchar](500) NOT NULL,
	[PaymentImplementationClassName] [nvarchar] (255) NULL,
	[SupportsRecurring] [bit] NOT NULL,
	[Ordering] [int] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
 CONSTRAINT [PK_PaymentOption] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_PaymentMethod] UNIQUE NONCLUSTERED 
(
	[ApplicationId] ASC,
	[LanguageId] ASC,
	[SystemKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MarketPaymentMethods]    Script Date: 03/01/2013  ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarketPaymentMethods]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MarketPaymentMethods](
	[MarketId] [nvarchar](8) NOT NULL,
	[PaymentMethodId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_MarketPaymentMethods] PRIMARY KEY CLUSTERED (MarketId, PaymentMethodId)
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PaymentMethodParameter]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethodParameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PaymentMethodParameter](
	[ParameterId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMethodId] [uniqueidentifier] NOT NULL,
	[Parameter] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](4000) NULL,
 CONSTRAINT [PaymentMethodParameter_PK] PRIMARY KEY CLUSTERED 
(
	[ParameterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_PaymentMethodParameter] UNIQUE NONCLUSTERED 
(
	[PaymentMethodId] ASC,
	[Parameter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SchemaVersion_OrderSystem]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_OrderSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_OrderSystem](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Shipment]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Shipment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Shipment](
	[ShipmentId] [int] IDENTITY(1,1) NOT NULL,
	[OrderFormId] [int] NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[ShippingAddressId] [nvarchar](50) NULL,
	[ShipmentTrackingNumber] [nvarchar](128) NULL,
	[ShipmentTotal] [money] NOT NULL,
	[ShippingDiscountAmount] [money] NOT NULL,
	[ShippingMethodName] [nvarchar](128) NULL,
	[Status] [nvarchar](64) NULL,
	[LineItemIds] [nvarchar](max) NULL,
	[WarehouseCode] [nvarchar](50) NULL,
	[PickListId] [int] NULL,
	[SubTotal] [money] NOT NULL
 CONSTRAINT [PK_Shipment] PRIMARY KEY CLUSTERED 
(
	[ShipmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_Shipment_OrderFormId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Shipment]') AND name = N'IX_Shipment_OrderFormId')
CREATE NONCLUSTERED INDEX [IX_Shipment_OrderFormId] ON [dbo].[Shipment] 
(
	[OrderFormId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]

/****** Object:  Index [IX_Shipment_OrderGroupId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Shipment]') AND name = N'IX_Shipment_OrderGroupId')
CREATE NONCLUSTERED INDEX [IX_Shipment_OrderGroupId] ON [dbo].[Shipment] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ShippingCountry]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingCountry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingCountry](
	[ShippingCountryId] [int] IDENTITY(1,1) NOT NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_ShippingCountry] PRIMARY KEY CLUSTERED 
(
	[ShippingCountryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShipmentDiscount]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShipmentDiscount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShipmentDiscount](
	[ShipmentDiscountId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[ShipmentId] [int] NOT NULL,
	[DiscountId] [int] NOT NULL,
	[DiscountAmount] [money] NOT NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[DiscountName] [nvarchar](50) NULL,
	[DisplayMessage] [nvarchar](100) NULL,
	[DiscountValue] [money] NOT NULL,
 CONSTRAINT [PK_ShipmentDiscount] PRIMARY KEY CLUSTERED 
(
	[ShipmentDiscountId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_ShipmentDiscount] UNIQUE NONCLUSTERED 
(
	[DiscountId] ASC,
	[ShipmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_ShipmentDiscountOrderGroupId]    Script Date: 07/21/2009 17:25:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ShipmentDiscount]') AND name = N'IX_ShipmentDiscountOrderGroupId')
CREATE NONCLUSTERED INDEX [IX_ShipmentDiscountOrderGroupId] ON [dbo].[ShipmentDiscount] 
(
	[OrderGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ShippingOption]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOption]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingOption](
	[ShippingOptionId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](600) NULL,
	[SystemKeyword] [nvarchar](30) NOT NULL,
	[ClassName] [nvarchar](500) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [ShippingOption_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingOptionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_ShippingOption] UNIQUE NONCLUSTERED 
(
	[ApplicationId] ASC,
	[SystemKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingOptionParameter]    Script Date: 07/21/2009 17:25:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOptionParameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingOptionParameter](
	[ShippingOptionParameterId] [int] IDENTITY(1,1) NOT NULL,
	[ShippingOptionId] [uniqueidentifier] NOT NULL,
	[Parameter] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](255) NULL,
 CONSTRAINT [ShippingOptionParameter_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingOptionParameterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingMethod]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethod]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingMethod](
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[ShippingOptionId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[LanguageId] [nvarchar](10) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[BasePrice] [money] NOT NULL,
	[Currency] [nvarchar](50) NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[Ordering] [int] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
 CONSTRAINT [ShippingMethod_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingMethodId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_ShippingMethod] UNIQUE NONCLUSTERED 
(
	[ApplicationId] ASC,
	[LanguageId] ASC,
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingMethodCase]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethodCase]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingMethodCase](
	[ShippingMethodCaseId] [int] IDENTITY(1,1) NOT NULL,
	[Total] [float] NOT NULL,
	[Charge] [money] NOT NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[JurisdictionGroupId] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [ShippingMethodCase_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingMethodCaseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingMethodParameter]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethodParameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingMethodParameter](
	[ShippingMethodParamterId] [int] IDENTITY(1,1) NOT NULL,
	[Parameter] [nvarchar](50) NULL,
	[Value] [nvarchar](100) NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ShippingMethodParameter] PRIMARY KEY CLUSTERED 
(
	[ShippingMethodParamterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingPackage]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingPackage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingPackage](
	[ShippingPackageId] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [int] NOT NULL,
	[ShippingOptionId] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](100) NOT NULL,
 CONSTRAINT [ShippingPackage_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingPackageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingPaymentRestriction]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingPaymentRestriction](
	[ShippingPaymentRestrictionId] [int] IDENTITY(1,1) NOT NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[PaymentMethodId] [uniqueidentifier] NOT NULL,
	[RestrictShippingMethods] [bit] NOT NULL CONSTRAINT [DF_ShippingPaymentRestriction_RestrictShippingMethods]  DEFAULT ((0)),
 CONSTRAINT [PK_ShippingPaymentRestriction] PRIMARY KEY CLUSTERED 
(
	[ShippingPaymentRestrictionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ShippingRegion]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingRegion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingRegion](
	[ShippingRegionId] [int] IDENTITY(1,1) NOT NULL,
	[ShippingMethodId] [uniqueidentifier] NOT NULL,
	[StateProvinceId] [int] NULL,
 CONSTRAINT [ShippingRegion_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingRegionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[StateProvince]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StateProvince]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StateProvince](
	[StateProvinceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Ordering] [int] NULL,
	[Visible] [bit] NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [StateProvince_PK] PRIMARY KEY CLUSTERED 
(
	[StateProvinceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[TaxCategory]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaxCategory](
	[TaxCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [TaxCategory_PK] PRIMARY KEY CLUSTERED 
(
	[TaxCategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[TaxValue]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxValue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaxValue](
	[TaxValueId] [int] IDENTITY(1,1) NOT NULL,
	[Percentage] [float] NOT NULL,
	[TaxId] [int] NOT NULL,
	[TaxCategory] [nvarchar](50) NOT NULL,
	[JurisdictionGroupId] [int] NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
	[AffectiveDate] [datetime] NOT NULL,
 CONSTRAINT [TaxValue_PK] PRIMARY KEY CLUSTERED 
(
	[TaxValueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Tax]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tax]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tax](
	[TaxId] [int] IDENTITY(1,1) NOT NULL,
	[TaxType] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Tax_PK] PRIMARY KEY CLUSTERED 
(
	[TaxId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Tax] UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[TaxLanguage]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxLanguage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaxLanguage](
	[TaxLanguageId] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
	[TaxId] [int] NOT NULL,
 CONSTRAINT [PK_TaxLanguage] PRIMARY KEY CLUSTERED 
(
	[TaxLanguageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Jurisdiction]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Jurisdiction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Jurisdiction](
	[JurisdictionId] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[StateProvinceCode] [nvarchar](50) NULL,
	[CountryCode] [nvarchar](50) NOT NULL,
	[JurisdictionType] [int] NOT NULL,
	[ZipPostalCodeStart] [nvarchar](50) NULL,
	[ZipPostalCodeEnd] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[County] [nvarchar](50) NULL,
	[GeoCode] [nvarchar](255) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TaxRegion] PRIMARY KEY CLUSTERED 
(
	[JurisdictionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[JurisdictionGroup]    Script Date: 07/21/2009 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JurisdictionGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[JurisdictionGroup](
	[JurisdictionGroupId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[JurisdictionType] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JurisdictionGroup] PRIMARY KEY CLUSTERED 
(
	[JurisdictionGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[OrderNoteType]    Script Date: 06/11/2010 17:25:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderNoteType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderNoteType](
	[OrderNoteTypeId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderNoteType] PRIMARY KEY CLUSTERED 
(
	[OrderNoteTypeId] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ReturnFormStatus]    Script Date: 06/11/2010 15:15:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReturnFormStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReturnFormStatus](
	[ReturnFormStatusId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ReturnFormStatus] PRIMARY KEY CLUSTERED 
(
	[ReturnFormStatusId] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[OrderShipmentStatus]    Script Date: 06/11/2010 15:16:29 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderShipmentStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderShipmentStatus](
	[OrderShipmentStatusId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderShipmentStatus] PRIMARY KEY CLUSTERED 
(
	[OrderShipmentStatusId] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PickList]    Script Date: 10/20/2010 12:48:25 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PickList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PickList](
	[PickListId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[WarehouseCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_PickList] PRIMARY KEY CLUSTERED 
(
	[PickListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_PickList_WarehouseCode]    Script Date: 10/20/2010 12:48:25 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PickList]') AND name = N'IX_PickList_WarehouseCode')
CREATE NONCLUSTERED INDEX [IX_PickList_WarehouseCode] ON [dbo].[PickList]
(
	[WarehouseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[JurisdictionRelation]    Script Date: 07/21/2009 17:25:09 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JurisdictionRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[JurisdictionRelation](
	[JurisdictionId] [int] NOT NULL,
	[JurisdictionGroupId] [int] NOT NULL,
 CONSTRAINT [PK_JurisdictionRelation] PRIMARY KEY CLUSTERED 
(
	[JurisdictionId] ASC,
	[JurisdictionGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ReturnReasonDictionary]    Script Date: 05/13/2011 23:29:14 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReturnReasonDictionary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReturnReasonDictionary](
	[ReturnReasonId] [int] IDENTITY(1,1) NOT NULL,
	[ReturnReasonText] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Ordering] [int] NOT NULL,
	[Visible] [bit] NULL,
 CONSTRAINT [PK_ReturnReasonDictionary] PRIMARY KEY CLUSTERED 
(
	[ReturnReasonText],[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LineItem_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItem]'))
ALTER TABLE [dbo].[LineItem]  WITH CHECK ADD  CONSTRAINT [FK_LineItem_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [OrderForm] ([OrderFormId])
ALTER TABLE [dbo].[LineItem] CHECK CONSTRAINT [FK_LineItem_OrderForm]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LineItemDiscount_LineItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]'))
ALTER TABLE [dbo].[LineItemDiscount]  WITH CHECK ADD  CONSTRAINT [FK_LineItemDiscount_LineItem] FOREIGN KEY([LineItemId])
REFERENCES [LineItem] ([LineItemId])
ALTER TABLE [dbo].[LineItemDiscount] CHECK CONSTRAINT [FK_LineItemDiscount_LineItem]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderForm_OrderGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderForm]'))
ALTER TABLE [dbo].[OrderForm]  WITH CHECK ADD  CONSTRAINT [FK_OrderForm_OrderGroup] FOREIGN KEY([OrderGroupId])
REFERENCES [OrderGroup] ([OrderGroupId])
ALTER TABLE [dbo].[OrderForm] CHECK CONSTRAINT [FK_OrderForm_OrderGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderFormDiscount_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderFormDiscount]'))
ALTER TABLE [dbo].[OrderFormDiscount]  WITH CHECK ADD  CONSTRAINT [FK_OrderFormDiscount_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [OrderForm] ([OrderFormId])
ALTER TABLE [dbo].[OrderFormDiscount] CHECK CONSTRAINT [FK_OrderFormDiscount_OrderForm]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderFormPayment_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderFormPayment]'))
ALTER TABLE [dbo].[OrderFormPayment]  WITH CHECK ADD  CONSTRAINT [FK_OrderFormPayment_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [OrderForm] ([OrderFormId])
ALTER TABLE [dbo].[OrderFormPayment] CHECK CONSTRAINT [FK_OrderFormPayment_OrderForm]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderGroupAddress_OrderGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderGroupAddress]'))
ALTER TABLE [dbo].[OrderGroupAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrderGroupAddress_OrderGroup] FOREIGN KEY([OrderGroupId])
REFERENCES [OrderGroup] ([OrderGroupId])
ALTER TABLE [dbo].[OrderGroupAddress] CHECK CONSTRAINT [FK_OrderGroupAddress_OrderGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderSearchResults_OrderGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderSearchResults]'))
ALTER TABLE [dbo].[OrderSearchResults]  WITH CHECK ADD  CONSTRAINT [FK_OrderSearchResults_OrderGroup] FOREIGN KEY([OrderGroupId])
REFERENCES [OrderGroup] ([OrderGroupId]) ON DELETE CASCADE
ALTER TABLE [dbo].[OrderSearchResults] CHECK CONSTRAINT [FK_OrderSearchResults_OrderGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketPaymentMethods_PaymentMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketPaymentMethods]'))
ALTER TABLE [dbo].[MarketPaymentMethods]  WITH CHECK ADD  CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod] FOREIGN KEY([PaymentMethodId])
REFERENCES [PaymentMethod] ([PaymentMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketPaymentMethods] CHECK CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketPaymentMethods_Market]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketPaymentMethods]'))
ALTER TABLE [dbo].[MarketPaymentMethods]  WITH CHECK ADD  CONSTRAINT [FK_MarketPaymentMethods_Market] FOREIGN KEY([MarketId])
REFERENCES [Market] ([MarketId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketPaymentMethods] CHECK CONSTRAINT [FK_MarketPaymentMethods_Market]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethod_PaymentMethodParameter_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[PaymentMethodParameter]'))
ALTER TABLE [dbo].[PaymentMethodParameter]  WITH CHECK ADD  CONSTRAINT [PaymentMethod_PaymentMethodParameter_FK1] FOREIGN KEY([PaymentMethodId])
REFERENCES [PaymentMethod] ([PaymentMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PaymentMethodParameter] CHECK CONSTRAINT [PaymentMethod_PaymentMethodParameter_FK1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Shipment_OrderForm]') AND parent_object_id = OBJECT_ID(N'[dbo].[Shipment]'))
ALTER TABLE [dbo].[Shipment]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipment_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [OrderForm] ([OrderFormId])
ALTER TABLE [dbo].[Shipment] CHECK CONSTRAINT [FK_Shipment_OrderForm]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingCountry_Country]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingCountry]'))
ALTER TABLE [dbo].[ShippingCountry]  WITH CHECK ADD  CONSTRAINT [FK_ShippingCountry_Country] FOREIGN KEY([CountryId])
REFERENCES [Country] ([CountryId])
ALTER TABLE [dbo].[ShippingCountry] CHECK CONSTRAINT [FK_ShippingCountry_Country]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingCountry_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingCountry]'))
ALTER TABLE [dbo].[ShippingCountry]  WITH CHECK ADD  CONSTRAINT [FK_ShippingCountry_ShippingMethod] FOREIGN KEY([ShippingMethodId])
REFERENCES [ShippingMethod] ([ShippingMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingCountry] CHECK CONSTRAINT [FK_ShippingCountry_ShippingMethod]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShipmentDiscount_Shipment]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShipmentDiscount]'))
ALTER TABLE [dbo].[ShipmentDiscount]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentDiscount_Shipment] FOREIGN KEY([ShipmentId])
REFERENCES [Shipment] ([ShipmentId])
ALTER TABLE [dbo].[ShipmentDiscount] CHECK CONSTRAINT [FK_ShipmentDiscount_Shipment]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingOptionParameter_ShippingOption]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingOptionParameter]'))
ALTER TABLE [dbo].[ShippingOptionParameter]  WITH CHECK ADD  CONSTRAINT [FK_ShippingOptionParameter_ShippingOption] FOREIGN KEY([ShippingOptionId])
REFERENCES [ShippingOption] ([ShippingOptionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingOptionParameter] CHECK CONSTRAINT [FK_ShippingOptionParameter_ShippingOption]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingMethod_ShippingOption]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethod]'))
ALTER TABLE [dbo].[ShippingMethod]  WITH CHECK ADD  CONSTRAINT [FK_ShippingMethod_ShippingOption] FOREIGN KEY([ShippingOptionId])
REFERENCES [ShippingOption] ([ShippingOptionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingMethod] CHECK CONSTRAINT [FK_ShippingMethod_ShippingOption]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingMethodCase_JurisdictionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethodCase]'))
ALTER TABLE [dbo].[ShippingMethodCase]  WITH CHECK ADD  CONSTRAINT [FK_ShippingMethodCase_JurisdictionGroup] FOREIGN KEY([JurisdictionGroupId])
REFERENCES [JurisdictionGroup] ([JurisdictionGroupId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingMethodCase] CHECK CONSTRAINT [FK_ShippingMethodCase_JurisdictionGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[ShippingMethod_ShippingMethodCase_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethodCase]'))
ALTER TABLE [dbo].[ShippingMethodCase]  WITH NOCHECK ADD  CONSTRAINT [ShippingMethod_ShippingMethodCase_FK1] FOREIGN KEY([ShippingMethodId])
REFERENCES [ShippingMethod] ([ShippingMethodId])
ALTER TABLE [dbo].[ShippingMethodCase] CHECK CONSTRAINT [ShippingMethod_ShippingMethodCase_FK1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingMethodParameter_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingMethodParameter]'))
ALTER TABLE [dbo].[ShippingMethodParameter]  WITH CHECK ADD  CONSTRAINT [FK_ShippingMethodParameter_ShippingMethod] FOREIGN KEY([ShippingMethodId])
REFERENCES [ShippingMethod] ([ShippingMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingMethodParameter] CHECK CONSTRAINT [FK_ShippingMethodParameter_ShippingMethod]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPackage_Package]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPackage]'))
ALTER TABLE [dbo].[ShippingPackage]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPackage_Package] FOREIGN KEY([PackageId])
REFERENCES [Package] ([PackageId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingPackage] CHECK CONSTRAINT [FK_ShippingPackage_Package]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPackage_ShippingOption]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPackage]'))
ALTER TABLE [dbo].[ShippingPackage]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPackage_ShippingOption] FOREIGN KEY([ShippingOptionId])
REFERENCES [ShippingOption] ([ShippingOptionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingPackage] CHECK CONSTRAINT [FK_ShippingPackage_ShippingOption]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPaymentRestriction_PaymentMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]'))
ALTER TABLE [dbo].[ShippingPaymentRestriction]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPaymentRestriction_PaymentMethod] FOREIGN KEY([PaymentMethodId])
REFERENCES [PaymentMethod] ([PaymentMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingPaymentRestriction] CHECK CONSTRAINT [FK_ShippingPaymentRestriction_PaymentMethod]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingPaymentRestriction_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]'))
ALTER TABLE [dbo].[ShippingPaymentRestriction]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPaymentRestriction_ShippingMethod] FOREIGN KEY([ShippingMethodId])
REFERENCES [ShippingMethod] ([ShippingMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingPaymentRestriction] CHECK CONSTRAINT [FK_ShippingPaymentRestriction_ShippingMethod]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingRegion_ShippingMethod]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingRegion]'))
ALTER TABLE [dbo].[ShippingRegion]  WITH CHECK ADD  CONSTRAINT [FK_ShippingRegion_ShippingMethod] FOREIGN KEY([ShippingMethodId])
REFERENCES [ShippingMethod] ([ShippingMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ShippingRegion] CHECK CONSTRAINT [FK_ShippingRegion_ShippingMethod]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[StateProvince_ShippingRegion_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ShippingRegion]'))
ALTER TABLE [dbo].[ShippingRegion]  WITH CHECK ADD  CONSTRAINT [StateProvince_ShippingRegion_FK1] FOREIGN KEY([StateProvinceId])
REFERENCES [StateProvince] ([StateProvinceId])
ALTER TABLE [dbo].[ShippingRegion] CHECK CONSTRAINT [StateProvince_ShippingRegion_FK1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_StateProvince_Country]') AND parent_object_id = OBJECT_ID(N'[dbo].[StateProvince]'))
ALTER TABLE [dbo].[StateProvince]  WITH CHECK ADD  CONSTRAINT [FK_StateProvince_Country] FOREIGN KEY([CountryId])
REFERENCES [Country] ([CountryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[StateProvince] CHECK CONSTRAINT [FK_StateProvince_Country]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaxValue_JurisdictionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxValue]'))
ALTER TABLE [dbo].[TaxValue]  WITH CHECK ADD  CONSTRAINT [FK_TaxValue_JurisdictionGroup] FOREIGN KEY([JurisdictionGroupId])
REFERENCES [JurisdictionGroup] ([JurisdictionGroupId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[TaxValue] CHECK CONSTRAINT [FK_TaxValue_JurisdictionGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Tax_TaxValue_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxValue]'))
ALTER TABLE [dbo].[TaxValue]  WITH CHECK ADD  CONSTRAINT [Tax_TaxValue_FK1] FOREIGN KEY([TaxId])
REFERENCES [Tax] ([TaxId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[TaxValue] CHECK CONSTRAINT [Tax_TaxValue_FK1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaxLanguage_Tax]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxLanguage]'))
ALTER TABLE [dbo].[TaxLanguage]  WITH CHECK ADD  CONSTRAINT [FK_TaxLanguage_Tax] FOREIGN KEY([TaxId])
REFERENCES [Tax] ([TaxId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[TaxLanguage] CHECK CONSTRAINT [FK_TaxLanguage_Tax]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_JurisdictionRelation_Jurisdiction]') AND parent_object_id = OBJECT_ID(N'[dbo].[JurisdictionRelation]'))
ALTER TABLE [dbo].[JurisdictionRelation]  WITH CHECK ADD  CONSTRAINT [FK_JurisdictionRelation_Jurisdiction] FOREIGN KEY([JurisdictionId])
REFERENCES [Jurisdiction] ([JurisdictionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[JurisdictionRelation] CHECK CONSTRAINT [FK_JurisdictionRelation_Jurisdiction]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_JurisdictionRelation_JurisdictionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[JurisdictionRelation]'))
ALTER TABLE [dbo].[JurisdictionRelation]  WITH CHECK ADD  CONSTRAINT [FK_JurisdictionRelation_JurisdictionGroup] FOREIGN KEY([JurisdictionGroupId])
REFERENCES [JurisdictionGroup] ([JurisdictionGroupId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[JurisdictionRelation] CHECK CONSTRAINT [FK_JurisdictionRelation_JurisdictionGroup]
GO

