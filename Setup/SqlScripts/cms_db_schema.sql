IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_Control_dps_Node]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_Control]'))
ALTER TABLE [dbo].[dps_Control] DROP CONSTRAINT [FK_dps_Control_dps_Node]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_ControlStorage_dps_Control]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage]'))
ALTER TABLE [dbo].[dps_ControlStorage] DROP CONSTRAINT [FK_dps_ControlStorage_dps_Control]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_Node_dps_NodeType]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_Node]'))
ALTER TABLE [dbo].[dps_Node] DROP CONSTRAINT [FK_dps_Node_dps_NodeType]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_Node_dps_PageDocument]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_Node]'))
ALTER TABLE [dbo].[dps_Node] DROP CONSTRAINT [FK_dps_Node_dps_PageDocument]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_MenuItem_main_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_MenuItem]'))
ALTER TABLE [dbo].[main_MenuItem] DROP CONSTRAINT [FK_main_MenuItem_main_Menu]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_MenuItem_Resources_main_MenuItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_MenuItem_Resources]'))
ALTER TABLE [dbo].[main_MenuItem_Resources] DROP CONSTRAINT [FK_main_MenuItem_Resources_main_MenuItem]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_PageVersion_main_LanguageInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_PageVersion]'))
ALTER TABLE [dbo].[main_PageVersion] DROP CONSTRAINT [FK_main_PageVersion_main_LanguageInfo]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_PageVersion_main_PageTree]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_PageVersion]'))
ALTER TABLE [dbo].[main_PageVersion] DROP CONSTRAINT [FK_main_PageVersion_main_PageTree]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_PageVersion_main_Templates]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_PageVersion]'))
ALTER TABLE [dbo].[main_PageVersion] DROP CONSTRAINT [FK_main_PageVersion_main_Templates]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NavigationCommand_NavigationItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[NavigationCommand]'))
ALTER TABLE [dbo].[NavigationCommand] DROP CONSTRAINT [FK_NavigationCommand_NavigationItems]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NavigationParams_NavigationItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[NavigationParams]'))
ALTER TABLE [dbo].[NavigationParams] DROP CONSTRAINT [FK_NavigationParams_NavigationItems]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteLanguage_Site]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteLanguage]'))
ALTER TABLE [dbo].[SiteLanguage] DROP CONSTRAINT [FK_SiteLanguage_Site]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_WorkflowStatus_main_Workflow]') AND parent_object_id = OBJECT_ID(N'[dbo].[WorkflowStatus]'))
ALTER TABLE [dbo].[WorkflowStatus] DROP CONSTRAINT [FK_main_WorkflowStatus_main_Workflow]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_WorkflowStatusAccess_main_WorkflowStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[WorkflowStatusAccess]'))
ALTER TABLE [dbo].[WorkflowStatusAccess] DROP CONSTRAINT [FK_main_WorkflowStatusAccess_main_WorkflowStatus]
GO

/****** Object:  Table [dbo].[SchemaVersion]    Script Date: 07/21/2009 17:20:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion]
GO

/****** Object:  Table [dbo].[dps_Control]    Script Date: 07/21/2009 17:20:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control]') AND type in (N'U'))
DROP TABLE [dbo].[dps_Control]
GO

/****** Object:  Table [dbo].[dps_ControlStorage]    Script Date: 07/21/2009 17:20:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage]') AND type in (N'U'))
DROP TABLE [dbo].[dps_ControlStorage]
GO

/****** Object:  Table [dbo].[dps_NodeType]    Script Date: 07/21/2009 17:20:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType]') AND type in (N'U'))
DROP TABLE [dbo].[dps_NodeType]
GO

/****** Object:  Table [dbo].[dps_Node]    Script Date: 07/21/2009 17:20:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node]') AND type in (N'U'))
DROP TABLE [dbo].[dps_Node]
GO

/****** Object:  Table [dbo].[dps_PageDocument]    Script Date: 07/21/2009 17:20:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument]') AND type in (N'U'))
DROP TABLE [dbo].[dps_PageDocument]
GO

/****** Object:  Table [dbo].[dps_TemporaryStorage]    Script Date: 07/21/2009 17:20:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage]') AND type in (N'U'))
DROP TABLE [dbo].[dps_TemporaryStorage]
GO

/****** Object:  Table [dbo].[main_GlobalVariables]    Script Date: 07/21/2009 17:20:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_GlobalVariables]') AND type in (N'U'))
DROP TABLE [dbo].[main_GlobalVariables]
GO

/****** Object:  Table [dbo].[main_LanguageInfo]    Script Date: 07/21/2009 17:20:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_LanguageInfo]') AND type in (N'U'))
DROP TABLE [dbo].[main_LanguageInfo]
GO

/****** Object:  Table [dbo].[main_Menu]    Script Date: 07/21/2009 17:20:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_Menu]') AND type in (N'U'))
DROP TABLE [dbo].[main_Menu]
GO

/****** Object:  Table [dbo].[main_MenuItem]    Script Date: 07/21/2009 17:20:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem]') AND type in (N'U'))
DROP TABLE [dbo].[main_MenuItem]
GO

/****** Object:  Table [dbo].[main_MenuItem_Resources]    Script Date: 07/21/2009 17:20:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_Resources]') AND type in (N'U'))
DROP TABLE [dbo].[main_MenuItem_Resources]
GO

/****** Object:  Table [dbo].[main_PageAttributes]    Script Date: 07/21/2009 17:20:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributes]') AND type in (N'U'))
DROP TABLE [dbo].[main_PageAttributes]
GO

/****** Object:  Table [dbo].[main_PageState]    Script Date: 07/21/2009 17:20:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageState]') AND type in (N'U'))
DROP TABLE [dbo].[main_PageState]
GO

/****** Object:  Table [dbo].[main_PageTree]    Script Date: 07/21/2009 17:20:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTree]') AND type in (N'U'))
DROP TABLE [dbo].[main_PageTree]
GO

/****** Object:  Table [dbo].[main_PageTreeAccess]    Script Date: 07/21/2009 17:20:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess]') AND type in (N'U'))
DROP TABLE [dbo].[main_PageTreeAccess]
GO

/****** Object:  Table [dbo].[main_Templates]    Script Date: 07/21/2009 17:20:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_Templates]') AND type in (N'U'))
DROP TABLE [dbo].[main_Templates]
GO

/****** Object:  Table [dbo].[main_PageVersion]    Script Date: 07/21/2009 17:20:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersion]') AND type in (N'U'))
DROP TABLE [dbo].[main_PageVersion]
GO

/****** Object:  Table [dbo].[NavigationItems]    Script Date: 07/21/2009 17:20:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NavigationItems]') AND type in (N'U'))
DROP TABLE [dbo].[NavigationItems]
GO

/****** Object:  Table [dbo].[NavigationCommand]    Script Date: 07/21/2009 17:20:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NavigationCommand]') AND type in (N'U'))
DROP TABLE [dbo].[NavigationCommand]
GO

/****** Object:  Table [dbo].[NavigationParams]    Script Date: 07/21/2009 17:20:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NavigationParams]') AND type in (N'U'))
DROP TABLE [dbo].[NavigationParams]
GO

/****** Object:  Table [dbo].[SiteLanguage]    Script Date: 07/21/2009 17:20:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteLanguage]') AND type in (N'U'))
DROP TABLE [dbo].[SiteLanguage]
GO

/****** Object:  Table [dbo].[Workflow]    Script Date: 07/21/2009 17:20:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Workflow]') AND type in (N'U'))
DROP TABLE [dbo].[Workflow]
GO

/****** Object:  Table [dbo].[WorkflowStatus]    Script Date: 07/21/2009 17:20:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowStatus]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowStatus]
GO

/****** Object:  Table [dbo].[WorkflowStatusAccess]    Script Date: 07/21/2009 17:20:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowStatusAccess]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowStatusAccess]
GO

/****** Object:  Table [dbo].[SchemaVersion]    Script Date: 07/21/2009 17:20:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[dps_Control]    Script Date: 07/21/2009 17:20:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dps_Control](
	[ControlId] [int] IDENTITY(1,1) NOT NULL,
	[NodeId] [int] NOT NULL,
	[ControlUID] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_dps_Control] PRIMARY KEY CLUSTERED 
(
	[ControlId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[dps_ControlStorage]    Script Date: 07/21/2009 17:20:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dps_ControlStorage](
	[ControlStorageId] [int] IDENTITY(1,1) NOT NULL,
	[ControlId] [int] NOT NULL,
	[Key] [nvarchar](255) NOT NULL,
	[Value] [image] NULL,
 CONSTRAINT [PK_dps_ControlStorage] PRIMARY KEY CLUSTERED 
(
	[ControlStorageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[dps_NodeType]    Script Date: 07/21/2009 17:20:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dps_NodeType](
	[NodeTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_dps_NodeType] PRIMARY KEY CLUSTERED 
(
	[NodeTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[dps_Node]    Script Date: 07/21/2009 17:20:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dps_Node](
	[NodeId] [int] IDENTITY(1,1) NOT NULL,
	[PageId] [int] NOT NULL,
	[NodeTypeId] [int] NOT NULL CONSTRAINT [DF_dps_Node_NodeTypeId]  DEFAULT ((0)),
	[NodeUID] [nvarchar](255) NOT NULL CONSTRAINT [DF_dps_Node_NodeUID]  DEFAULT (N''),
	[FactoryUID] [nvarchar](255) NOT NULL CONSTRAINT [DF_dps_Node_FactoryUID]  DEFAULT (N''),
	[FactoryControlUID] [nvarchar](255) NOT NULL CONSTRAINT [DF_dps_Node_FactoryControlUID]  DEFAULT (N''),
	[ControlPlaceId] [nvarchar](255) NOT NULL CONSTRAINT [DF_dps_Node_ControlPlaceId]  DEFAULT (N''),
	[ControlPlaceIndex] [int] NOT NULL,
 CONSTRAINT [PK_dps_Node] PRIMARY KEY CLUSTERED 
(
	[NodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[dps_PageDocument]    Script Date: 07/21/2009 17:20:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dps_PageDocument](
	[PageId] [int] IDENTITY(1,1) NOT NULL,
	[PageVersionId] [int] NOT NULL CONSTRAINT [DF_dps_PageDocument_PageVersionId]  DEFAULT ((0)),
 CONSTRAINT [PK_dps_PageDocument] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[dps_TemporaryStorage]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dps_TemporaryStorage](
	[StorageId] [int] IDENTITY(1,1) NOT NULL,
	[PageVersionId] [int] NOT NULL CONSTRAINT [DF_dps_TemporaryStorage_PageVersionId]  DEFAULT ((0)),
	[Created] [datetime] NOT NULL,
	[Expire] [int] NULL,
	[PageDocument] [image] NOT NULL,
	[CreatorUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dps_TemporaryStorage] PRIMARY KEY CLUSTERED 
(
	[StorageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_GlobalVariables]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_GlobalVariables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_GlobalVariables](
	[GlobalVariableId] [int] IDENTITY(1,1) NOT NULL,
	[KEY] [nvarchar](250) NOT NULL,
	[VALUE] [nvarchar](1024) NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_main_GlobalVariables] PRIMARY KEY CLUSTERED 
(
	[GlobalVariableId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_LanguageInfo]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_LanguageInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_LanguageInfo](
	[LangId] [int] IDENTITY(1,1) NOT NULL,
	[LangName] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](50) NULL,
	[IsDefault] [bit] NULL CONSTRAINT [DF_main_LanguageInfo_IsDefault]  DEFAULT ((0)),
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_main_LanguageInfo] PRIMARY KEY CLUSTERED 
(
	[LangId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_Menu]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_Menu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_Menu](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[FriendlyName] [nvarchar](250) NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_main_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_MenuItem]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_MenuItem](
	[MenuItemId] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[CommandText] [nvarchar](1024) NULL,
	[CommandType] [int] NULL,
	[Text] [nvarchar](250) NULL,
	[LeftImageUrl] [nvarchar](1024) NULL,
	[RightImageUrl] [nvarchar](1024) NULL,
	[OutlineLevel] [int] NULL,
	[Outline] [nvarchar](2048) NULL,
	[IsVisible] [bit] NOT NULL,
	[IsInherits] [bit] NULL,
	[IsRoot] [bit] NOT NULL,
	[Order] [int] NOT NULL,
 CONSTRAINT [PK_main_MenuItem] PRIMARY KEY CLUSTERED 
(
	[MenuItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_MenuItem_Resources]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_Resources]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_MenuItem_Resources](
	[MenuItemResourceId] [int] IDENTITY(1,1) NOT NULL,
	[MenuItemId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Text] [nvarchar](250) NOT NULL,
	[ToolTip] [nvarchar](250) NULL,
 CONSTRAINT [PK_main_MenuItem_Resources] PRIMARY KEY CLUSTERED 
(
	[MenuItemResourceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_PageAttributes]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_PageAttributes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PageId] [int] NOT NULL,
	[Title] [nvarchar](256) NULL,
	[MetaKeys] [nvarchar](4000) NULL,
	[MetaDescriptions] [nvarchar](4000) NULL,
 CONSTRAINT [PK_main_PageAttributes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_PageState]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageState]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_PageState](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[FriendlyName] [nvarchar](250) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_main_PageState] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_PageTree]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTree]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_PageTree](
	[PageId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Outline] [nvarchar](2048) NOT NULL,
	[OutlineLevel] [int] NOT NULL,
	[IsFolder] [bit] NOT NULL CONSTRAINT [DF_main_FileTree_IsFolder]  DEFAULT ((0)),
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_main_FileTree_IsDefault]  DEFAULT ((0)),
	[Order] [int] NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[MasterPage] [nvarchar](256) NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_main_FileTree] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_PageTreeAccess]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_PageTreeAccess](
	[PageAccessId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](256) NOT NULL,
	[PageId] [int] NOT NULL,
 CONSTRAINT [PK_main_PageTreeAccess] PRIMARY KEY CLUSTERED 
(
	[PageAccessId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[main_Templates]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_Templates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_Templates](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](250) NOT NULL,
	[Path] [nvarchar](2048) NOT NULL,
	[Preview] [image] NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[TemplateType] [nvarchar](50) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_main_Templates] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

/****** Object:  Index [IX_main_Templates]    Script Date: 07/21/2009 17:20:54 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[main_Templates]') AND name = N'IX_main_Templates')
CREATE UNIQUE NONCLUSTERED INDEX [IX_main_Templates] ON [dbo].[main_Templates] 
(
	[Name] ASC,
	[LanguageCode] ASC,
	[TemplateType] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[main_PageVersion]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[main_PageVersion](
	[VersionId] [int] IDENTITY(1,1) NOT NULL,
	[PageId] [int] NOT NULL,
	[TemplateId] [int] NOT NULL,
	[VersionNum] [int] NOT NULL,
	[LangId] [int] NOT NULL,
	[StatusId] [int] NULL,
	[Created] [datetime] NULL,
	[CreatorUID] [uniqueidentifier] NULL,
	[Edited] [datetime] NULL,
	[EditorUID] [uniqueidentifier] NULL,
	[StateId] [int] NULL,
	[Comment] [nvarchar](1024) NULL,
 CONSTRAINT [PK_page_PageVersion] PRIMARY KEY CLUSTERED 
(
	[VersionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Trigger [dbo].[main_PageVersion_DeleteTrigger]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersion_DeleteTrigger]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [main_PageVersion_DeleteTrigger]
   ON [main_PageVersion]
   FOR DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    delete from [dps_TemporaryStorage] where [PageVersionId] IN (SELECT [VersionId] FROM deleted)
	delete from [dps_PageDocument] where [PageVersionId] IN (SELECT [VersionId] FROM deleted)
END' 
GO

/****** Object:  Table [dbo].[NavigationItems]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NavigationItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NavigationItems](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](256) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_NavigationItems] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[NavigationCommand]    Script Date: 07/21/2009 17:20:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NavigationCommand]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NavigationCommand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UrlUID] [nvarchar](256) NOT NULL,
	[ItemId] [int] NULL,
	[Params] [nvarchar](1024) NULL,
	[TrigerParam] [nvarchar](256) NULL,
 CONSTRAINT [PK_NavigationCommand] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[NavigationParams]    Script Date: 07/21/2009 17:20:55 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NavigationParams]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NavigationParams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[Value] [nvarchar](256) NULL,
	[IsRequired] [bit] NULL,
 CONSTRAINT [PK_NavigationParams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SiteLanguage]    Script Date: 07/21/2009 17:20:55 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteLanguage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SiteLanguage](
	[SiteId] [uniqueidentifier] NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Workflow]    Script Date: 07/21/2009 17:20:55 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Workflow]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Workflow](
	[WorkflowId] [int] IDENTITY(1,1) NOT NULL,
	[FriendlyName] [nvarchar](250) NOT NULL,
	[IsDefault] [bit] NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_main_Workflow] PRIMARY KEY CLUSTERED 
(
	[WorkflowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[WorkflowStatus]    Script Date: 07/21/2009 17:20:55 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WorkflowStatus](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowId] [int] NOT NULL,
	[Weight] [int] NOT NULL,
	[FriendlyName] [nvarchar](250) NULL,
 CONSTRAINT [PK_main_WorkflowStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[WorkflowStatusAccess]    Script Date: 07/21/2009 17:20:55 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowStatusAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WorkflowStatusAccess](
	[StatusAccessId] [int] IDENTITY(1,1) NOT NULL,
	[StatusId] [int] NOT NULL,
	[RoleId] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_main_WorkflowStatusAccess] PRIMARY KEY CLUSTERED 
(
	[StatusAccessId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_Control_dps_Node]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_Control]'))
ALTER TABLE [dbo].[dps_Control]  WITH NOCHECK ADD  CONSTRAINT [FK_dps_Control_dps_Node] FOREIGN KEY([NodeId])
REFERENCES [dps_Node] ([NodeId])
ON DELETE CASCADE
ALTER TABLE [dbo].[dps_Control] CHECK CONSTRAINT [FK_dps_Control_dps_Node]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_ControlStorage_dps_Control]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage]'))
ALTER TABLE [dbo].[dps_ControlStorage]  WITH NOCHECK ADD  CONSTRAINT [FK_dps_ControlStorage_dps_Control] FOREIGN KEY([ControlId])
REFERENCES [dps_Control] ([ControlId])
ON DELETE CASCADE
ALTER TABLE [dbo].[dps_ControlStorage] CHECK CONSTRAINT [FK_dps_ControlStorage_dps_Control]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_Node_dps_NodeType]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_Node]'))
ALTER TABLE [dbo].[dps_Node]  WITH NOCHECK ADD  CONSTRAINT [FK_dps_Node_dps_NodeType] FOREIGN KEY([NodeTypeId])
REFERENCES [dps_NodeType] ([NodeTypeId])
ON DELETE CASCADE
ALTER TABLE [dbo].[dps_Node] CHECK CONSTRAINT [FK_dps_Node_dps_NodeType]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dps_Node_dps_PageDocument]') AND parent_object_id = OBJECT_ID(N'[dbo].[dps_Node]'))
ALTER TABLE [dbo].[dps_Node]  WITH NOCHECK ADD  CONSTRAINT [FK_dps_Node_dps_PageDocument] FOREIGN KEY([PageId])
REFERENCES [dps_PageDocument] ([PageId])
ON DELETE CASCADE
ALTER TABLE [dbo].[dps_Node] CHECK CONSTRAINT [FK_dps_Node_dps_PageDocument]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_MenuItem_main_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_MenuItem]'))
ALTER TABLE [dbo].[main_MenuItem]  WITH CHECK ADD  CONSTRAINT [FK_main_MenuItem_main_Menu] FOREIGN KEY([MenuId])
REFERENCES [main_Menu] ([MenuId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[main_MenuItem] CHECK CONSTRAINT [FK_main_MenuItem_main_Menu]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_MenuItem_Resources_main_MenuItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_MenuItem_Resources]'))
ALTER TABLE [dbo].[main_MenuItem_Resources]  WITH CHECK ADD  CONSTRAINT [FK_main_MenuItem_Resources_main_MenuItem] FOREIGN KEY([MenuItemId])
REFERENCES [main_MenuItem] ([MenuItemId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[main_MenuItem_Resources] CHECK CONSTRAINT [FK_main_MenuItem_Resources_main_MenuItem]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_PageVersion_main_LanguageInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_PageVersion]'))
ALTER TABLE [dbo].[main_PageVersion]  WITH NOCHECK ADD  CONSTRAINT [FK_main_PageVersion_main_LanguageInfo] FOREIGN KEY([LangId])
REFERENCES [main_LanguageInfo] ([LangId])
ON DELETE CASCADE
ALTER TABLE [dbo].[main_PageVersion] CHECK CONSTRAINT [FK_main_PageVersion_main_LanguageInfo]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_PageVersion_main_PageTree]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_PageVersion]'))
ALTER TABLE [dbo].[main_PageVersion]  WITH NOCHECK ADD  CONSTRAINT [FK_main_PageVersion_main_PageTree] FOREIGN KEY([PageId])
REFERENCES [main_PageTree] ([PageId])
ALTER TABLE [dbo].[main_PageVersion] CHECK CONSTRAINT [FK_main_PageVersion_main_PageTree]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_PageVersion_main_Templates]') AND parent_object_id = OBJECT_ID(N'[dbo].[main_PageVersion]'))
ALTER TABLE [dbo].[main_PageVersion]  WITH NOCHECK ADD  CONSTRAINT [FK_main_PageVersion_main_Templates] FOREIGN KEY([TemplateId])
REFERENCES [main_Templates] ([TemplateId])
ALTER TABLE [dbo].[main_PageVersion] CHECK CONSTRAINT [FK_main_PageVersion_main_Templates]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NavigationCommand_NavigationItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[NavigationCommand]'))
ALTER TABLE [dbo].[NavigationCommand]  WITH NOCHECK ADD  CONSTRAINT [FK_NavigationCommand_NavigationItems] FOREIGN KEY([ItemId])
REFERENCES [NavigationItems] ([ItemId])
ALTER TABLE [dbo].[NavigationCommand] CHECK CONSTRAINT [FK_NavigationCommand_NavigationItems]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NavigationParams_NavigationItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[NavigationParams]'))
ALTER TABLE [dbo].[NavigationParams]  WITH CHECK ADD  CONSTRAINT [FK_NavigationParams_NavigationItems] FOREIGN KEY([ItemId])
REFERENCES [NavigationItems] ([ItemId])
ALTER TABLE [dbo].[NavigationParams] CHECK CONSTRAINT [FK_NavigationParams_NavigationItems]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteLanguage_Site]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteLanguage]'))
ALTER TABLE [dbo].[SiteLanguage]  WITH CHECK ADD  CONSTRAINT [FK_SiteLanguage_Site] FOREIGN KEY([SiteId])
REFERENCES [Site] ([SiteId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[SiteLanguage] CHECK CONSTRAINT [FK_SiteLanguage_Site]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_WorkflowStatus_main_Workflow]') AND parent_object_id = OBJECT_ID(N'[dbo].[WorkflowStatus]'))
ALTER TABLE [dbo].[WorkflowStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_main_WorkflowStatus_main_Workflow] FOREIGN KEY([WorkflowId])
REFERENCES [Workflow] ([WorkflowId])
ON DELETE CASCADE
ALTER TABLE [dbo].[WorkflowStatus] CHECK CONSTRAINT [FK_main_WorkflowStatus_main_Workflow]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_main_WorkflowStatusAccess_main_WorkflowStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[WorkflowStatusAccess]'))
ALTER TABLE [dbo].[WorkflowStatusAccess]  WITH NOCHECK ADD  CONSTRAINT [FK_main_WorkflowStatusAccess_main_WorkflowStatus] FOREIGN KEY([StatusId])
REFERENCES [WorkflowStatus] ([StatusId])
ON DELETE CASCADE
ALTER TABLE [dbo].[WorkflowStatusAccess] CHECK CONSTRAINT [FK_main_WorkflowStatusAccess_main_WorkflowStatus]
GO

