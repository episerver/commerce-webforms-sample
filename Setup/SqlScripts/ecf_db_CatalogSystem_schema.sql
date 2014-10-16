IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogAssociation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogAssociation]'))
ALTER TABLE [dbo].[CatalogAssociation] DROP CONSTRAINT [FK_CatalogAssociation_CatalogEntry]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntity_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntry]'))
ALTER TABLE [dbo].[CatalogEntry] DROP CONSTRAINT [FK_CatalogEntity_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryAssociation_AssociationType]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]'))
ALTER TABLE [dbo].[CatalogEntryAssociation] DROP CONSTRAINT [FK_CatalogEntryAssociation_AssociationType]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryAssociation_CatalogAssociation]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]'))
ALTER TABLE [dbo].[CatalogEntryAssociation] DROP CONSTRAINT [FK_CatalogEntryAssociation_CatalogAssociation]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryAssociation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]'))
ALTER TABLE [dbo].[CatalogEntryAssociation] DROP CONSTRAINT [FK_CatalogEntryAssociation_CatalogEntry]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryRelation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryRelation]'))
ALTER TABLE [dbo].[CatalogEntryRelation] DROP CONSTRAINT [FK_CatalogEntryRelation_CatalogEntry]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryRelation_CatalogEntry1]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryRelation]'))
ALTER TABLE [dbo].[CatalogEntryRelation] DROP CONSTRAINT [FK_CatalogEntryRelation_CatalogEntry1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntrySearchResults_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntrySearchResults]'))
ALTER TABLE [dbo].[CatalogEntrySearchResults] DROP CONSTRAINT [FK_CatalogEntrySearchResults_CatalogEntry]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogLanguage_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogLanguage]'))
ALTER TABLE [dbo].[CatalogLanguage] DROP CONSTRAINT [FK_CatalogLanguage_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItem_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNode]'))
ALTER TABLE [dbo].[CatalogNode] DROP CONSTRAINT [FK_CatalogItem_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemCategory_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]'))
ALTER TABLE [dbo].[CatalogNodeRelation] DROP CONSTRAINT [FK_CatalogItemCategory_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemCategory_CatalogItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]'))
ALTER TABLE [dbo].[CatalogNodeRelation] DROP CONSTRAINT [FK_CatalogItemCategory_CatalogItem]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogNodeSearchResults_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNodeSearchResults]'))
ALTER TABLE [dbo].[CatalogNodeSearchResults] DROP CONSTRAINT [FK_CatalogNodeSearchResults_CatalogNode]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogSecurity_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogSecurity]'))
ALTER TABLE [dbo].[CatalogSecurity] DROP CONSTRAINT [FK_CatalogSecurity_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NodeEntryRelation_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]'))
ALTER TABLE [dbo].[NodeEntryRelation] DROP CONSTRAINT [FK_NodeEntryRelation_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NodeEntryRelation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]'))
ALTER TABLE [dbo].[NodeEntryRelation] DROP CONSTRAINT [FK_NodeEntryRelation_CatalogEntry]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NodeEntryRelation_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]'))
ALTER TABLE [dbo].[NodeEntryRelation] DROP CONSTRAINT [FK_NodeEntryRelation_CatalogNode]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteCatalog_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteCatalog]'))
ALTER TABLE [dbo].[SiteCatalog] DROP CONSTRAINT [FK_SiteCatalog_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Variation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[Variation]'))
ALTER TABLE [dbo].[Variation] DROP CONSTRAINT [FK_Variation_CatalogEntry]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Variation_Merchant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Variation]'))
ALTER TABLE [dbo].[Variation] DROP CONSTRAINT [FK_Variation_Merchant]
GO

/****** Object:  Table [dbo].[Affiliate]    Script Date: 07/21/2009 17:23:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Affiliate]') AND type in (N'U'))
DROP TABLE [dbo].[Affiliate]
GO

/****** Object:  Table [dbo].[AssociationType]    Script Date: 07/21/2009 17:23:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationType]') AND type in (N'U'))
DROP TABLE [dbo].[AssociationType]
GO

/****** Object:  Table [dbo].[Catalog]    Script Date: 07/21/2009 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Catalog]') AND type in (N'U'))
DROP TABLE [dbo].[Catalog]
GO

/****** Object:  Table [dbo].[CatalogAssociation]    Script Date: 07/21/2009 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogAssociation]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogAssociation]
GO

/****** Object:  Table [dbo].[CatalogEntry]    Script Date: 07/21/2009 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntry]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogEntry]
GO

/****** Object:  Table [dbo].[CatalogEntryAssociation]    Script Date: 07/21/2009 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogEntryAssociation]
GO

/****** Object:  Table [dbo].[CatalogEntryRelation]    Script Date: 07/21/2009 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntryRelation]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogEntryRelation]
GO

/****** Object:  Table [dbo].[CatalogEntrySearchResults]    Script Date: 07/21/2009 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntrySearchResults]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogEntrySearchResults]
GO

/****** Object:  Table [dbo].[CatalogEntrySearchResults_SingleSort] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntrySearchResults_SingleSort]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogEntrySearchResults_SingleSort]
GO

/****** Object:  Table [dbo].[CatalogItemAsset]    Script Date: 07/21/2009 17:24:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogItemAsset]
GO

/****** Object:  Table [dbo].[CatalogItemSeo]    Script Date: 07/21/2009 17:24:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemSeo]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogItemSeo]
GO

/****** Object:  Table [dbo].[CatalogLanguage]    Script Date: 07/21/2009 17:24:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogLanguage]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogLanguage]
GO

/****** Object:  Table [dbo].[CatalogLanguageMap]    Script Date: 07/21/2009 17:24:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogLanguageMap]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogLanguageMap]
GO

/****** Object:  Table [dbo].[CatalogNode]    Script Date: 07/21/2009 17:24:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNode]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogNode]
GO

/****** Object:  Table [dbo].[CatalogNodeRelation]    Script Date: 07/21/2009 17:24:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogNodeRelation]
GO

/****** Object:  Table [dbo].[CatalogNodeSearchResults]    Script Date: 07/21/2009 17:24:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNodeSearchResults]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogNodeSearchResults]
GO

/****** Object:  Table [dbo].[CatalogSecurity]    Script Date: 07/21/2009 17:24:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogSecurity]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogSecurity]
GO

/****** Object:  Table [dbo].[CurrencyRate]    Script Date: 07/21/2009 17:24:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CurrencyRate]') AND type in (N'U'))
DROP TABLE [dbo].[CurrencyRate]
GO

/****** Object:  Table [dbo].[Inventory]    Script Date: 07/21/2009 17:24:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inventory]') AND type in (N'U'))
DROP TABLE [dbo].[Inventory]
GO

/****** Object:  Table [dbo].[Merchant]    Script Date: 07/21/2009 17:24:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Merchant]') AND type in (N'U'))
DROP TABLE [dbo].[Merchant]
GO

/****** Object:  Table [dbo].[NodeEntryRelation]    Script Date: 07/21/2009 17:24:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]') AND type in (N'U'))
DROP TABLE [dbo].[NodeEntryRelation]
GO

/****** Object:  Table [dbo].[SalePrice]    Script Date: 07/21/2009 17:24:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalePrice]') AND type in (N'U'))
DROP TABLE [dbo].[SalePrice]
GO

/****** Object:  Table [dbo].[SchemaVersion_CatalogSystem]    Script Date: 07/21/2009 17:24:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_CatalogSystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_CatalogSystem]
GO

/****** Object:  Table [dbo].[SiteCatalog]    Script Date: 07/21/2009 17:24:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteCatalog]') AND type in (N'U'))
DROP TABLE [dbo].[SiteCatalog]
GO

/****** Object:  Table [dbo].[Variation]    Script Date: 07/21/2009 17:24:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Variation]') AND type in (N'U'))
DROP TABLE [dbo].[Variation]
GO

/****** Object:  Table [dbo].[Warehouse]    Script Date: 07/21/2009 17:24:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Warehouse]') AND type in (N'U'))
DROP TABLE [dbo].[Warehouse]
GO

/****** Object:  Table [dbo].[CatalogLog]    Script Date: 07/21/2009 17:24:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogLog]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogLog]
GO

/****** Object:  Table [dbo].[Affiliate]    Script Date: 07/21/2009 17:24:18 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Affiliate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Affiliate](
	[AffiliateId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[AssociationType]    Script Date: 07/21/2009 17:24:18 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssociationType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssociationType](
	[AssociationTypeId] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_AssociationType] PRIMARY KEY CLUSTERED 
(
	[AssociationTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Catalog]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Catalog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Catalog](
	[CatalogId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DefaultCurrency] [nvarchar](128) NULL,
	[WeightBase] [nvarchar](128) NULL,
	[DefaultLanguage] [nvarchar](10) NULL,
	[IsPrimary] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[CreatorId] [nvarchar](50) NULL,
	[ModifierId] [nvarchar](50) NULL,
	[SortOrder] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Owner] [nvarchar](255) NULL,
 CONSTRAINT [PK_Catalog_1] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogAssociation]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogAssociation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogAssociation](
	[CatalogAssociationId] [int] IDENTITY(1,1) NOT NULL,
	[CatalogEntryId] [int] NOT NULL,
	[AssociationName] [nvarchar](150) NOT NULL,
	[AssociationDescription] [nvarchar](255) NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_CatalogRelation] PRIMARY KEY CLUSTERED 
(
	[CatalogAssociationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_CatalogAssociation] UNIQUE NONCLUSTERED 
(
	[AssociationName] ASC,
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogEntry]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogEntry](
	[CatalogEntryId] [int] IDENTITY(1,1) NOT NULL,
	[CatalogId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[TemplateName] [nvarchar](50) NULL,
	[Code] [nvarchar](100) NOT NULL,
	[ClassTypeId] [nvarchar](50) NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[SerializedData] [image] NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[ContentAssetsID] [uniqueidentifier]
	CONSTRAINT [PK_CatalogEntity] PRIMARY KEY CLUSTERED 
(
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_CatalogEntity] UNIQUE NONCLUSTERED 
(
	[Code] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogEntryAssociation]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogEntryAssociation](
	[CatalogAssociationId] [int] NOT NULL,
	[CatalogEntryId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[AssociationTypeId] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CatalogEntryAssociation] PRIMARY KEY CLUSTERED 
(
	[CatalogAssociationId] ASC,
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_CatalogEntryAssociation] UNIQUE NONCLUSTERED 
(
	[CatalogAssociationId] ASC,
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogEntryRelation]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntryRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogEntryRelation](
	[ParentEntryId] [int] NOT NULL,
	[ChildEntryId] [int] NOT NULL,
	[RelationTypeId] [nvarchar](50) NOT NULL,
	[Quantity] [money] NULL,
	[GroupName] [nvarchar](100) NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_CatalogEntryRelation] PRIMARY KEY CLUSTERED 
(
	[ParentEntryId] ASC,
	[ChildEntryId] ASC,
	[RelationTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_CatalogEntryRelation] UNIQUE NONCLUSTERED 
(
	[RelationTypeId] ASC,
	[ChildEntryId] ASC,
	[ParentEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogEntrySearchResults]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogEntrySearchResults]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogEntrySearchResults](
	[SearchSetId] [uniqueidentifier] NOT NULL,
	[CatalogEntryId] [int] NOT NULL,
	[Created] [datetime] NULL CONSTRAINT [DF__CatalogEn__Creat__0EF836A4]  DEFAULT (getutcdate()),
	[SortOrder] [int] NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogEntrySearchResults_SingleSort]    Script Date: 06/13/2011 18:25:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CatalogEntrySearchResults_SingleSort](
	[SearchSetId] [uniqueidentifier] NOT NULL,
	[ResultIndex] [int] NOT NULL,
	[Created] [datetime] NOT NULL CONSTRAINT DF_CatalogEntrySearchResults_SingleSort_Created DEFAULT GETUTCDATE(),
	[CatalogEntryId] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CatalogEntrySearchResults_SingleSort] PRIMARY KEY
(
	[SearchSetId] ASC,
	[ResultIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE INDEX [IX_CatalogEntrySearchResults_SingleSort_Created] on [dbo].[CatalogEntrySearchResults_SingleSort] ([Created])
GO

/****** Object:  Table [dbo].[CatalogItemAsset]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogItemAsset](
	[CatalogNodeId] [int] NOT NULL CONSTRAINT [DF_CatalogItemAsset_CatalogNodeId]  DEFAULT ((0)),
	[CatalogEntryId] [int] NOT NULL CONSTRAINT [DF_CatalogItemAsset_CatalogEntryId]  DEFAULT ((0)),
	[AssetType] [nvarchar](50) NOT NULL,
	[AssetKey] [nvarchar](254) NOT NULL,
	[GroupName] [nvarchar](100) NULL,
	[SortOrder] [int] NOT NULL	
 CONSTRAINT [PK_CatalogItemAsset] PRIMARY KEY CLUSTERED 
(
	[CatalogNodeId] ASC,
	[CatalogEntryId] ASC,
	[AssetType] ASC,
	[AssetKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_CatalogItemAsset_EntryId]    Script Date: 07/21/2009 17:24:19 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]') AND name = N'IX_CatalogItemAsset_EntryId')
CREATE NONCLUSTERED INDEX [IX_CatalogItemAsset_EntryId] ON [dbo].[CatalogItemAsset] 
(
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

/****** Object:  Index [IX_CatalogItemAsset_NodeId]    Script Date: 07/21/2009 17:24:19 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]') AND name = N'IX_CatalogItemAsset_NodeId')
CREATE NONCLUSTERED INDEX [IX_CatalogItemAsset_NodeId] ON [dbo].[CatalogItemAsset] 
(
	[CatalogNodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CatalogItemSeo]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemSeo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogItemSeo](
	[LanguageCode] [nvarchar](50) NOT NULL,
	[CatalogNodeId] [int] NULL,
	[CatalogEntryId] [int] NULL,
	[Uri] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](150) NULL,
	[Description] [nvarchar](355) NULL,
	[Keywords] [nvarchar](355) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UriSegment] [nvarchar] (255) NULL,
 CONSTRAINT [PK_CatalogItemSeo] PRIMARY KEY CLUSTERED 
(
	[LanguageCode] ASC,
	[Uri] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemSeo]') AND name = N'IX_CatalogItemSeo_CatalogEntryId')
CREATE NONCLUSTERED INDEX [IX_CatalogItemSeo_CatalogEntryId] ON [dbo].[CatalogItemSeo] 
(
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemSeo]') AND name = N'IX_CatalogItemSeo_CatalogNodeId')
CREATE NONCLUSTERED INDEX [IX_CatalogItemSeo_CatalogNodeId] ON [dbo].[CatalogItemSeo] 
(
	[CatalogNodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalogLanguage]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogLanguage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogLanguage](
	[CatalogId] [int] NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
	[UriSegment] [nvarchar] (255) NULL,
 CONSTRAINT [PK_CatalogLanguage] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC,
	[LanguageCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogLanguageMap]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogLanguageMap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogLanguageMap](
	[Language] [nvarchar](10) NOT NULL,
	[LCID] [int] NULL,
	[Collation] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogNode]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogNode](
	[CatalogNodeId] [int] IDENTITY(1,1) NOT NULL,
	[CatalogId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[TemplateName] [nvarchar](50) NULL,
	[Code] [nvarchar](100) NOT NULL,
	[ParentNodeId] [int] NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[ContentAssetsID] [uniqueidentifier],
 CONSTRAINT [PK_CatalogItem] PRIMARY KEY CLUSTERED 
(
	[CatalogNodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_CatalogItem] UNIQUE NONCLUSTERED 
(
	[Code] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Trigger [dbo].[CategoryDeleteTrigger]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CategoryDeleteTrigger]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [CategoryDeleteTrigger] ON [dbo].[CatalogNode] 
FOR DELETE 
AS
BEGIN
	DELETE [CatalogNodeRelation] WHERE ParentNodeId IN (SELECT CatalogNodeId FROM [deleted])
END' 
GO

/****** Object:  Table [dbo].[CatalogNodeRelation]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogNodeRelation](
	[CatalogId] [int] NOT NULL,
	[ParentNodeId] [int] NOT NULL,
	[ChildNodeId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_CatalogNodeRelation] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC,
	[ParentNodeId] ASC,
	[ChildNodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogNodeSearchResults]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNodeSearchResults]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogNodeSearchResults](
	[SearchSetId] [uniqueidentifier] NOT NULL,
	[CatalogNodeId] [int] NOT NULL,
	[Created] [datetime] NULL DEFAULT (getutcdate())
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CatalogSecurity]    Script Date: 07/21/2009 17:24:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogSecurity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogSecurity](
	[CatalogId] [int] NOT NULL,
	[SID] [nvarchar](250) NOT NULL,
	[Scope] [nvarchar](50) NOT NULL,
	[AllowMask] [binary](8) NOT NULL,
	[DenyMask] [binary](8) NOT NULL
) ON [PRIMARY]
END

/****** Object:  Index [IX_CatalogSecurity]    Script Date: 07/21/2009 17:24:19 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CatalogSecurity]') AND name = N'IX_CatalogSecurity')
CREATE UNIQUE NONCLUSTERED INDEX [IX_CatalogSecurity] ON [dbo].[CatalogSecurity] 
(
	[CatalogId] ASC,
	[SID] ASC,
	[Scope] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CurrencyRate]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CurrencyRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CurrencyRate](
	[CurrencyRateId] [int] IDENTITY(1,1) NOT NULL,
	[AverageRate] [float] NULL,
	[EndOfDayRate] [float] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[FromCurrencyId] [int] NOT NULL,
	[ToCurrencyId] [int] NOT NULL,
	[CurrencyRateDate] [datetime] NOT NULL,
 CONSTRAINT [CurrencyRate_PK] PRIMARY KEY CLUSTERED 
(
	[CurrencyRateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Inventory]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inventory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inventory](
	[SkuId] [nvarchar](100) NOT NULL,
	[InStockQuantity] [decimal](18, 0) NOT NULL,
	[ReservedQuantity] [decimal](18, 0) NOT NULL,
	[ReorderMinQuantity] [decimal](18, 0) NOT NULL,
	[PreorderQuantity] [decimal](18, 0) NOT NULL,
	[BackorderQuantity] [decimal](18, 0) NOT NULL,
	[AllowBackorder] [bit] NOT NULL,
	[AllowPreorder] [bit] NOT NULL,
	[InventoryStatus] [int] NOT NULL,
	[PreorderAvailabilityDate] [datetime] NOT NULL,
	[BackorderAvailabilityDate] [datetime] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[SkuId] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_VariationInventory] UNIQUE NONCLUSTERED 
(
	[SkuId] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Merchant]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Merchant]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Merchant](
	[MerchantId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Merchant] PRIMARY KEY CLUSTERED 
(
	[MerchantId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[NodeEntryRelation]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NodeEntryRelation](
	[CatalogId] [int] NOT NULL,
	[CatalogEntryId] [int] NOT NULL,
	[CatalogNodeId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Modified] [datetime] NOT NULL default (getutcdate())
 CONSTRAINT [PK_NodeEntryRelation] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC,
	[CatalogEntryId] ASC,
	[CatalogNodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[NodeEntryRelation_UpsertTrigger]    Script Date: 12/21/2011 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation_UpsertTrigger]') AND type = N'TR')
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE trigger [dbo].[NodeEntryRelation_UpsertTrigger]
	on [dbo].[NodeEntryRelation]
	after update, insert
	as
	begin
		set nocount on
    
		update [dbo].[NodeEntryRelation]
		set [Modified] = GETUTCDATE()
		from [dbo].[NodeEntryRelation] ner
		join inserted
			on ner.[CatalogId] = inserted.[CatalogId]
			and ner.[CatalogEntryId] = inserted.[CatalogEntryId]
			and ner.[CatalogNodeId] = inserted.[CatalogNodeId]
	end'
END
GO

/****** Object:  Table [dbo].[NodeEntryRelation_DeleteTrigger]    Script Date: 12/21/2011 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation_DeleteTrigger]') AND type = N'TR')
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE trigger [dbo].[NodeEntryRelation_DeleteTrigger]
	on [dbo].[NodeEntryRelation]
	after delete
	as
	begin
		set nocount on
    
		insert into ApplicationLog ([Source], [Operation], [ObjectKey], [ObjectType], [Username], [Created], [Succeeded], [ApplicationId])
		select ''catalog'', ''Modified'', deleted.CatalogEntryId, ''relation'', ''database-trigger'', GETUTCDATE(), 1, ISNULL(app.ApplicationId, fallback_app.ApplicationId)
		from deleted
		left outer join Catalog app on deleted.CatalogEntryId = app.CatalogId
		cross join (select top 1 ApplicationId from Application) fallback_app
	end'
END
GO

/****** Object:  Table [dbo].[SalePrice]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalePrice]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SalePrice](
	[SalePriceId] [int] IDENTITY(1,1) NOT NULL,
	[ItemCode] [nvarchar](100) NULL,
	[SaleType] [int] NOT NULL,
	[SaleCode] [nvarchar](100) NULL,
	[StartDate] [datetime] NOT NULL,
	[Currency] [varchar](128) NOT NULL,
	[MinQuantity] [money] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_SalePrice] PRIMARY KEY CLUSTERED 
(
	[SalePriceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SalePrice]') AND name = N'IX_SalePrice_ItemCode')
CREATE NONCLUSTERED INDEX [IX_SalePrice_ItemCode] ON [dbo].[SalePrice] 
(
	[ItemCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SchemaVersion_CatalogSystem]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_CatalogSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_CatalogSystem](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SiteCatalog]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteCatalog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SiteCatalog](
	[CatalogId] [int] NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END

/****** Object:  Index [IX_SiteCatalog]    Script Date: 07/21/2009 17:24:20 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SiteCatalog]') AND name = N'IX_SiteCatalog')
CREATE UNIQUE NONCLUSTERED INDEX [IX_SiteCatalog] ON [dbo].[SiteCatalog] 
(
	[CatalogId] ASC,
	[SiteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Variation]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Variation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Variation](
	[CatalogEntryId] [int] NOT NULL,
	[ListPrice] [money] NULL,
	[TaxCategoryId] [int] NOT NULL,
	[TrackInventory] [bit] NOT NULL,
	[MerchantId] [uniqueidentifier] NULL,
	[WarehouseId] [int] NOT NULL,
	[Weight] [float] NOT NULL,
	[PackageId] [int] NOT NULL,
	[MinQuantity] [money] NULL,
	[MaxQuantity] [money] NULL,
 CONSTRAINT [PK_ProductVariation] PRIMARY KEY CLUSTERED 
(
	[CatalogEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Warehouse]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Warehouse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Warehouse](
	[WarehouseId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CreatorId] [nvarchar](100) NULL,
	[Created] [datetime] NOT NULL CONSTRAINT DF_Warehouse_Created DEFAULT (GETUTCDATE()),
	[ModifierId] [nvarchar](100) NULL,
	[Modified] [datetime] NOT NULL CONSTRAINT DF_Warehouse_Modified DEFAULT (GETUTCDATE()),
	[IsActive] [bit] NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[IsFulfillmentCenter] [bit] NOT NULL,
	[IsPickupLocation] [bit] NOT NULL,
	[IsDeliveryLocation] [bit] NOT NULL,
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
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],

CONSTRAINT [IX_Warehouse] UNIQUE NONCLUSTERED 
(
	[ApplicationId] ASC,
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]


END
GO

/****** Object:  Table [dbo].[CatalogLog]    Script Date: 07/21/2009 17:24:20 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Operation] [nvarchar](50) NOT NULL,
	[ObjectKey] [nvarchar](100) NOT NULL,
	[ObjectType] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Succeeded] [bit] NOT NULL,
	[Notes] [nvarchar](255) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CatalogLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogAssociation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogAssociation]'))
ALTER TABLE [dbo].[CatalogAssociation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogAssociation_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogAssociation] CHECK CONSTRAINT [FK_CatalogAssociation_CatalogEntry]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntity_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntry]'))
ALTER TABLE [dbo].[CatalogEntry]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntity_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogEntry] CHECK CONSTRAINT [FK_CatalogEntity_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryAssociation_AssociationType]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]'))
ALTER TABLE [dbo].[CatalogEntryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntryAssociation_AssociationType] FOREIGN KEY([AssociationTypeId])
REFERENCES [AssociationType] ([AssociationTypeId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogEntryAssociation] CHECK CONSTRAINT [FK_CatalogEntryAssociation_AssociationType]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryAssociation_CatalogAssociation]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]'))
ALTER TABLE [dbo].[CatalogEntryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntryAssociation_CatalogAssociation] FOREIGN KEY([CatalogAssociationId])
REFERENCES [CatalogAssociation] ([CatalogAssociationId])
ALTER TABLE [dbo].[CatalogEntryAssociation] CHECK CONSTRAINT [FK_CatalogEntryAssociation_CatalogAssociation]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryAssociation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryAssociation]'))
ALTER TABLE [dbo].[CatalogEntryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntryAssociation_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogEntryAssociation] CHECK CONSTRAINT [FK_CatalogEntryAssociation_CatalogEntry]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryRelation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryRelation]'))
ALTER TABLE [dbo].[CatalogEntryRelation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntryRelation_CatalogEntry] FOREIGN KEY([ChildEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogEntryRelation] CHECK CONSTRAINT [FK_CatalogEntryRelation_CatalogEntry]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntryRelation_CatalogEntry1]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntryRelation]'))
ALTER TABLE [dbo].[CatalogEntryRelation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntryRelation_CatalogEntry1] FOREIGN KEY([ParentEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ALTER TABLE [dbo].[CatalogEntryRelation] CHECK CONSTRAINT [FK_CatalogEntryRelation_CatalogEntry1]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogEntrySearchResults_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogEntrySearchResults]'))
ALTER TABLE [dbo].[CatalogEntrySearchResults]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntrySearchResults_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogEntrySearchResults] CHECK CONSTRAINT [FK_CatalogEntrySearchResults_CatalogEntry]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogLanguage_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogLanguage]'))
ALTER TABLE [dbo].[CatalogLanguage]  WITH CHECK ADD  CONSTRAINT [FK_CatalogLanguage_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogLanguage] CHECK CONSTRAINT [FK_CatalogLanguage_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItem_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNode]'))
ALTER TABLE [dbo].[CatalogNode]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItem_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogNode] CHECK CONSTRAINT [FK_CatalogItem_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemCategory_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]'))
ALTER TABLE [dbo].[CatalogNodeRelation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItemCategory_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ALTER TABLE [dbo].[CatalogNodeRelation] CHECK CONSTRAINT [FK_CatalogItemCategory_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemCategory_CatalogItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]'))
ALTER TABLE [dbo].[CatalogNodeRelation]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItemCategory_CatalogItem] FOREIGN KEY([ChildNodeId])
REFERENCES [CatalogNode] ([CatalogNodeId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogNodeRelation] CHECK CONSTRAINT [FK_CatalogItemCategory_CatalogItem]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogNodeSearchResults_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogNodeSearchResults]'))
ALTER TABLE [dbo].[CatalogNodeSearchResults]  WITH CHECK ADD  CONSTRAINT [FK_CatalogNodeSearchResults_CatalogNode] FOREIGN KEY([CatalogNodeId])
REFERENCES [CatalogNode] ([CatalogNodeId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogNodeSearchResults] CHECK CONSTRAINT [FK_CatalogNodeSearchResults_CatalogNode]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogSecurity_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogSecurity]'))
ALTER TABLE [dbo].[CatalogSecurity]  WITH CHECK ADD  CONSTRAINT [FK_CatalogSecurity_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogSecurity] CHECK CONSTRAINT [FK_CatalogSecurity_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NodeEntryRelation_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]'))
ALTER TABLE [dbo].[NodeEntryRelation]  WITH CHECK ADD  CONSTRAINT [FK_NodeEntryRelation_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ALTER TABLE [dbo].[NodeEntryRelation] CHECK CONSTRAINT [FK_NodeEntryRelation_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NodeEntryRelation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]'))
ALTER TABLE [dbo].[NodeEntryRelation]  WITH CHECK ADD  CONSTRAINT [FK_NodeEntryRelation_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[NodeEntryRelation] CHECK CONSTRAINT [FK_NodeEntryRelation_CatalogEntry]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NodeEntryRelation_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[NodeEntryRelation]'))
ALTER TABLE [dbo].[NodeEntryRelation]  WITH CHECK ADD  CONSTRAINT [FK_NodeEntryRelation_CatalogNode] FOREIGN KEY([CatalogNodeId])
REFERENCES [CatalogNode] ([CatalogNodeId])
ALTER TABLE [dbo].[NodeEntryRelation] CHECK CONSTRAINT [FK_NodeEntryRelation_CatalogNode]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteCatalog_Catalog]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteCatalog]'))
ALTER TABLE [dbo].[SiteCatalog]  WITH CHECK ADD  CONSTRAINT [FK_SiteCatalog_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [Catalog] ([CatalogId])
ALTER TABLE [dbo].[SiteCatalog] CHECK CONSTRAINT [FK_SiteCatalog_Catalog]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Variation_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[Variation]'))
ALTER TABLE [dbo].[Variation]  WITH CHECK ADD  CONSTRAINT [FK_Variation_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[Variation] CHECK CONSTRAINT [FK_Variation_CatalogEntry]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Variation_Merchant]') AND parent_object_id = OBJECT_ID(N'[dbo].[Variation]'))
ALTER TABLE [dbo].[Variation]  WITH CHECK ADD  CONSTRAINT [FK_Variation_Merchant] FOREIGN KEY([MerchantId])
REFERENCES [Merchant] ([MerchantId])
ON UPDATE SET NULL
ON DELETE SET NULL
ALTER TABLE [dbo].[Variation] CHECK CONSTRAINT [FK_Variation_Merchant]
GO

