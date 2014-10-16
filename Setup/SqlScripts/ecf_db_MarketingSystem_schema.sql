IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-CampaignSegment_ecf_mktg-Campaign]') AND parent_object_id = OBJECT_ID(N'[dbo].[CampaignSegment]'))
ALTER TABLE [dbo].[CampaignSegment] DROP CONSTRAINT [FK_ecf_mktg-CampaignSegment_ecf_mktg-Campaign]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-CampaignSegment_ecf_mktg-Segment]') AND parent_object_id = OBJECT_ID(N'[dbo].[CampaignSegment]'))
ALTER TABLE [dbo].[CampaignSegment] DROP CONSTRAINT [FK_ecf_mktg-CampaignSegment_ecf_mktg-Segment]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-Policy_ecf_mktg-Expression]') AND parent_object_id = OBJECT_ID(N'[dbo].[Policy]'))
ALTER TABLE [dbo].[Policy] DROP CONSTRAINT [FK_ecf_mktg-Policy_ecf_mktg-Expression]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-GroupPolicy_ecf_mktg-Policy]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupPolicy]'))
ALTER TABLE [dbo].[GroupPolicy] DROP CONSTRAINT [FK_ecf_mktg-GroupPolicy_ecf_mktg-Policy]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-Promotion_ecf_mktg-Campaign]') AND parent_object_id = OBJECT_ID(N'[dbo].[Promotion]'))
ALTER TABLE [dbo].[Promotion] DROP CONSTRAINT [FK_ecf_mktg-Promotion_ecf_mktg-Campaign]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionCondition_ecf_mktg-Expression]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionCondition]'))
ALTER TABLE [dbo].[PromotionCondition] DROP CONSTRAINT [FK_ecf_mktg-PromotionCondition_ecf_mktg-Expression]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionCondition_ecf_mktg-Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionCondition]'))
ALTER TABLE [dbo].[PromotionCondition] DROP CONSTRAINT [FK_ecf_mktg-PromotionCondition_ecf_mktg-Promotion]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionLanguage]'))
ALTER TABLE [dbo].[PromotionLanguage] DROP CONSTRAINT [FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionPolicy_ecf_mktg-Policy]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionPolicy]'))
ALTER TABLE [dbo].[PromotionPolicy] DROP CONSTRAINT [FK_ecf_mktg-PromotionPolicy_ecf_mktg-Policy]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionPolicy_ecf_mktg-Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionPolicy]'))
ALTER TABLE [dbo].[PromotionPolicy] DROP CONSTRAINT [FK_ecf_mktg-PromotionPolicy_ecf_mktg-Promotion]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression]') AND parent_object_id = OBJECT_ID(N'[dbo].[SegmentCondition]'))
ALTER TABLE [dbo].[SegmentCondition] DROP CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment]') AND parent_object_id = OBJECT_ID(N'[dbo].[SegmentCondition]'))
ALTER TABLE [dbo].[SegmentCondition] DROP CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-SegmentMember_ecf_mktg-Segment]') AND parent_object_id = OBJECT_ID(N'[dbo].[SegmentMember]'))
ALTER TABLE [dbo].[SegmentMember] DROP CONSTRAINT [FK_ecf_mktg-SegmentMember_ecf_mktg-Segment]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PromotionUsage_Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionUsage]'))
ALTER TABLE [dbo].[PromotionUsage] DROP CONSTRAINT [FK_PromotionUsage_Promotion]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketCampaigns_Campaign]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketCampaigns]'))
ALTER TABLE [dbo].[MarketCampaigns] DROP CONSTRAINT [FK_MarketCampaigns_Campaign]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketCampaigns_Market]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketCampaigns]'))
ALTER TABLE [dbo].[MarketCampaigns] DROP CONSTRAINT [FK_MarketCampaigns_Market]
GO

/****** Object:  Table [dbo].[Campaign]    Script Date: 07/21/2009 17:56:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Campaign]') AND type in (N'U'))
DROP TABLE [dbo].[Campaign]
GO

/****** Object:  Table [dbo].[CampaignSegment]    Script Date: 07/21/2009 17:56:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CampaignSegment]') AND type in (N'U'))
DROP TABLE [dbo].[CampaignSegment]
GO

/****** Object:  Table [dbo].[Expression]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Expression]') AND type in (N'U'))
DROP TABLE [dbo].[Expression]
GO

/****** Object:  Table [dbo].[Policy]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Policy]') AND type in (N'U'))
DROP TABLE [dbo].[Policy]
GO

/****** Object:  Table [dbo].[GroupPolicy]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupPolicy]') AND type in (N'U'))
DROP TABLE [dbo].[GroupPolicy]
GO

/****** Object:  Table [dbo].[Promotion]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Promotion]') AND type in (N'U'))
DROP TABLE [dbo].[Promotion]
GO

/****** Object:  Table [dbo].[PromotionCondition]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionCondition]') AND type in (N'U'))
DROP TABLE [dbo].[PromotionCondition]
GO

/****** Object:  Table [dbo].[PromotionLanguage]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionLanguage]') AND type in (N'U'))
DROP TABLE [dbo].[PromotionLanguage]
GO

/****** Object:  Table [dbo].[PromotionPolicy]    Script Date: 07/21/2009 17:56:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionPolicy]') AND type in (N'U'))
DROP TABLE [dbo].[PromotionPolicy]
GO

/****** Object:  Table [dbo].[SchemaVersion_MarketingSystem]    Script Date: 07/21/2009 17:56:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_MarketingSystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_MarketingSystem]
GO

/****** Object:  Table [dbo].[Segment]    Script Date: 07/21/2009 17:56:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Segment]') AND type in (N'U'))
DROP TABLE [dbo].[Segment]
GO

/****** Object:  Table [dbo].[SegmentCondition]    Script Date: 07/21/2009 17:56:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SegmentCondition]') AND type in (N'U'))
DROP TABLE [dbo].[SegmentCondition]
GO

/****** Object:  Table [dbo].[SegmentMember]    Script Date: 07/21/2009 17:56:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SegmentMember]') AND type in (N'U'))
DROP TABLE [dbo].[SegmentMember]
GO

/****** Object:  Table [dbo].[PromotionUsage]    Script Date: 07/21/2009 17:56:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionUsage]') AND type in (N'U'))
DROP TABLE [dbo].[PromotionUsage]
GO

/****** Object:  Table [dbo].[MarketCampaigns]    Script Date: 08/21/2013 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarketCampaigns]') AND type in (N'U'))
DROP TABLE [dbo].[MarketCampaigns]
GO

/****** Object:  Table [dbo].[Campaign]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Campaign]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Campaign](
	[CampaignId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Exported] [datetime] NULL,
	[Modified] [datetime] NULL CONSTRAINT [DF__ecf_mktg-__Modif__3716A457]  DEFAULT (getutcdate()),
	[ModifiedBy] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[IsArchived] [bit] NOT NULL,
	[Comments] [nvarchar](1024) NULL,
 CONSTRAINT [PK_ecf_mktg-Campaign] PRIMARY KEY CLUSTERED 
(
	[CampaignId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[CampaignSegment]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CampaignSegment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CampaignSegment](
	[CampaignSegmentId] [int] IDENTITY(1,1) NOT NULL,
	[SegmentId] [int] NOT NULL,
	[CampaignId] [int] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-CampaignSegment] PRIMARY KEY CLUSTERED 
(
	[CampaignSegmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Expression]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Expression]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Expression](
	[ExpressionId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Category] [nvarchar](50) NOT NULL,
	[ExpressionXml] [ntext] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_ecf_mktg-Expression] PRIMARY KEY CLUSTERED 
(
	[ExpressionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Policy]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Policy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Policy](
	[PolicyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[ExpressionId] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[IsLocal] [bit] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-Policy] PRIMARY KEY CLUSTERED 
(
	[PolicyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[GroupPolicy]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupPolicy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GroupPolicy](
	[GroupPolicyId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](50) NOT NULL,
	[PolicyId] [int] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-GroupPolicy] PRIMARY KEY CLUSTERED 
(
	[GroupPolicyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Promotion]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Promotion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Promotion](
	[PromotionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[CouponCode] [nvarchar](50) NULL,
	[OfferAmount] [money] NOT NULL,
	[OfferType] [int] NOT NULL,
	[PromotionGroup] [nvarchar](50) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[ExclusivityType] [nvarchar](50) NOT NULL,
	[Priority] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NOT NULL,
	[PromotionType] [nvarchar](50) NOT NULL,
	[PerOrderLimit] [int] NOT NULL,
	[ApplicationLimit] [int] NOT NULL,
	[Params] [varbinary](max) NULL,
	[CustomerLimit] [int] NOT NULL,
	[MaxEntryDiscountQuantity] [decimal] NULL,
 CONSTRAINT [PK_ecf_mktg-Promotion] PRIMARY KEY CLUSTERED 
(
	[PromotionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PromotionCondition]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionCondition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PromotionCondition](
	[PromotionConditionId] [int] IDENTITY(1,1) NOT NULL,
	[PromotionId] [int] NOT NULL,
	[ExpressionId] [int] NOT NULL,
	[CatalogName] [nvarchar](250) NULL,
	[CatalogNodeId] [nvarchar](50) NULL,
	[CatalogEntryId] [nvarchar](250) NULL,
 CONSTRAINT [PK_ecf_mktg-PromotionCondition] PRIMARY KEY CLUSTERED 
(
	[PromotionConditionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PromotionLanguage]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionLanguage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PromotionLanguage](
	[PromotionLanguageId] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
	[PromotionId] [int] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-PromotionLanguage] PRIMARY KEY CLUSTERED 
(
	[PromotionLanguageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PromotionPolicy]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionPolicy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PromotionPolicy](
	[PromotionPolicyId] [int] IDENTITY(1,1) NOT NULL,
	[PromotionId] [int] NOT NULL,
	[PolicyId] [int] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-PromotionPolicy] PRIMARY KEY CLUSTERED 
(
	[PromotionPolicyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SchemaVersion_MarketingSystem]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_MarketingSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_MarketingSystem](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Segment]    Script Date: 07/21/2009 17:56:07 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Segment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Segment](
	[SegmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[ExpressionFilter] [varbinary](max) NULL,
 CONSTRAINT [PK_ecf_mktg-Segment] PRIMARY KEY CLUSTERED 
(
	[SegmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_ecf_mktg-Segment]    Script Date: 07/21/2009 17:56:07 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Segment]') AND name = N'IX_ecf_mktg-Segment')
CREATE UNIQUE NONCLUSTERED INDEX [IX_ecf_mktg-Segment] ON [dbo].[Segment] 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SegmentCondition]    Script Date: 07/21/2009 17:56:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SegmentCondition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SegmentCondition](
	[PrincipalGroupConditionId] [int] IDENTITY(1,1) NOT NULL,
	[SegmentId] [int] NOT NULL,
	[ExpressionId] [int] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-SegmentCondition] PRIMARY KEY CLUSTERED 
(
	[PrincipalGroupConditionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SegmentMember]    Script Date: 07/21/2009 17:56:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SegmentMember]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SegmentMember](
	[SegmentMemberId] [int] IDENTITY(1,1) NOT NULL,
	[SegmentId] [int] NOT NULL,
	[PrincipalId] [uniqueidentifier] NOT NULL,
	[Exclude] [bit] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-SegmentMember] PRIMARY KEY CLUSTERED 
(
	[SegmentMemberId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[PromotionUsage]    Script Date: 07/21/2009 17:56:08 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromotionUsage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PromotionUsage](
	[PromotionUsageId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[PromotionId] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_PromotionUsage] PRIMARY KEY CLUSTERED 
(
	[PromotionUsageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MarketCampaigns]    Script Date: 08/21/2013  ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarketCampaigns]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MarketCampaigns](
	[MarketId] [nvarchar](8) NOT NULL,
	[CampaignId] [int] NOT NULL,
 CONSTRAINT [PK_MarketCampaigns] PRIMARY KEY CLUSTERED (MarketId, CampaignId)
) ON [PRIMARY]
END
GO


IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-CampaignSegment_ecf_mktg-Campaign]') AND parent_object_id = OBJECT_ID(N'[dbo].[CampaignSegment]'))
ALTER TABLE [dbo].[CampaignSegment]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-CampaignSegment_ecf_mktg-Campaign] FOREIGN KEY([CampaignId])
REFERENCES [Campaign] ([CampaignId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CampaignSegment] CHECK CONSTRAINT [FK_ecf_mktg-CampaignSegment_ecf_mktg-Campaign]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-CampaignSegment_ecf_mktg-Segment]') AND parent_object_id = OBJECT_ID(N'[dbo].[CampaignSegment]'))
ALTER TABLE [dbo].[CampaignSegment]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-CampaignSegment_ecf_mktg-Segment] FOREIGN KEY([SegmentId])
REFERENCES [Segment] ([SegmentId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CampaignSegment] CHECK CONSTRAINT [FK_ecf_mktg-CampaignSegment_ecf_mktg-Segment]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-Policy_ecf_mktg-Expression]') AND parent_object_id = OBJECT_ID(N'[dbo].[Policy]'))
ALTER TABLE [dbo].[Policy]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-Policy_ecf_mktg-Expression] FOREIGN KEY([ExpressionId])
REFERENCES [Expression] ([ExpressionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[Policy] CHECK CONSTRAINT [FK_ecf_mktg-Policy_ecf_mktg-Expression]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-GroupPolicy_ecf_mktg-Policy]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupPolicy]'))
ALTER TABLE [dbo].[GroupPolicy]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-GroupPolicy_ecf_mktg-Policy] FOREIGN KEY([PolicyId])
REFERENCES [Policy] ([PolicyId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[GroupPolicy] CHECK CONSTRAINT [FK_ecf_mktg-GroupPolicy_ecf_mktg-Policy]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-Promotion_ecf_mktg-Campaign]') AND parent_object_id = OBJECT_ID(N'[dbo].[Promotion]'))
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-Promotion_ecf_mktg-Campaign] FOREIGN KEY([CampaignId])
REFERENCES [Campaign] ([CampaignId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK_ecf_mktg-Promotion_ecf_mktg-Campaign]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionCondition_ecf_mktg-Expression]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionCondition]'))
ALTER TABLE [dbo].[PromotionCondition]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-PromotionCondition_ecf_mktg-Expression] FOREIGN KEY([ExpressionId])
REFERENCES [Expression] ([ExpressionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PromotionCondition] CHECK CONSTRAINT [FK_ecf_mktg-PromotionCondition_ecf_mktg-Expression]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionCondition_ecf_mktg-Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionCondition]'))
ALTER TABLE [dbo].[PromotionCondition]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-PromotionCondition_ecf_mktg-Promotion] FOREIGN KEY([PromotionId])
REFERENCES [Promotion] ([PromotionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PromotionCondition] CHECK CONSTRAINT [FK_ecf_mktg-PromotionCondition_ecf_mktg-Promotion]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionLanguage]'))
ALTER TABLE [dbo].[PromotionLanguage]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion] FOREIGN KEY([PromotionId])
REFERENCES [Promotion] ([PromotionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PromotionLanguage] CHECK CONSTRAINT [FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionPolicy_ecf_mktg-Policy]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionPolicy]'))
ALTER TABLE [dbo].[PromotionPolicy]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-PromotionPolicy_ecf_mktg-Policy] FOREIGN KEY([PolicyId])
REFERENCES [Policy] ([PolicyId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PromotionPolicy] CHECK CONSTRAINT [FK_ecf_mktg-PromotionPolicy_ecf_mktg-Policy]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-PromotionPolicy_ecf_mktg-Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionPolicy]'))
ALTER TABLE [dbo].[PromotionPolicy]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-PromotionPolicy_ecf_mktg-Promotion] FOREIGN KEY([PromotionId])
REFERENCES [Promotion] ([PromotionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PromotionPolicy] CHECK CONSTRAINT [FK_ecf_mktg-PromotionPolicy_ecf_mktg-Promotion]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression]') AND parent_object_id = OBJECT_ID(N'[dbo].[SegmentCondition]'))
ALTER TABLE [dbo].[SegmentCondition]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression] FOREIGN KEY([ExpressionId])
REFERENCES [Expression] ([ExpressionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[SegmentCondition] CHECK CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment]') AND parent_object_id = OBJECT_ID(N'[dbo].[SegmentCondition]'))
ALTER TABLE [dbo].[SegmentCondition]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment] FOREIGN KEY([SegmentId])
REFERENCES [Segment] ([SegmentId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[SegmentCondition] CHECK CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ecf_mktg-SegmentMember_ecf_mktg-Segment]') AND parent_object_id = OBJECT_ID(N'[dbo].[SegmentMember]'))
ALTER TABLE [dbo].[SegmentMember]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-SegmentMember_ecf_mktg-Segment] FOREIGN KEY([SegmentId])
REFERENCES [Segment] ([SegmentId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[SegmentMember] CHECK CONSTRAINT [FK_ecf_mktg-SegmentMember_ecf_mktg-Segment]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PromotionUsage_Promotion]') AND parent_object_id = OBJECT_ID(N'[dbo].[PromotionUsage]'))
ALTER TABLE [dbo].[PromotionUsage]  WITH CHECK ADD  CONSTRAINT [FK_PromotionUsage_Promotion] FOREIGN KEY([PromotionId])
REFERENCES [Promotion] ([PromotionId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[PromotionUsage] CHECK CONSTRAINT [FK_PromotionUsage_Promotion]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketCampaigns_Campaign]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketCampaigns]'))
ALTER TABLE [dbo].[MarketCampaigns]  WITH CHECK ADD  CONSTRAINT [FK_MarketCampaigns_Campaign] FOREIGN KEY([CampaignId])
REFERENCES [Campaign] ([CampaignId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketCampaigns] CHECK CONSTRAINT [FK_MarketCampaigns_Campaign]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MarketCampaigns_Market]') AND parent_object_id = OBJECT_ID(N'[dbo].[MarketCampaigns]'))
ALTER TABLE [dbo].[MarketCampaigns]  WITH CHECK ADD  CONSTRAINT [FK_MarketCampaigns_Market] FOREIGN KEY([MarketId])
REFERENCES [Market] ([MarketId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketCampaigns] CHECK CONSTRAINT [FK_MarketCampaigns_Market]
GO

