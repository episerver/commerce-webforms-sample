/****** Object:  Table [dbo].[SchemaVersion_BusinessFoundation]    Script Date: 07/21/2009 17:22:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_BusinessFoundation]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_BusinessFoundation]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaClassDataSource_mcmd_MetaClass]    Script Date: 05/13/2009 09:53:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_mcmd_MetaClassDataSource_mcmd_MetaClass]') AND parent_object_id = OBJECT_ID(N'[dbo].[mcmd_MetaClassDataSource]'))
ALTER TABLE [dbo].[mcmd_MetaClassDataSource] DROP CONSTRAINT [FK_mcmd_MetaClassDataSource_mcmd_MetaClass]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaField_mcmd_MetaClass]    Script Date: 05/13/2009 09:53:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_mcmd_MetaField_mcmd_MetaClass]') AND parent_object_id = OBJECT_ID(N'[dbo].[mcmd_MetaField]'))
ALTER TABLE [dbo].[mcmd_MetaField] DROP CONSTRAINT [FK_mcmd_MetaField_mcmd_MetaClass]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaFieldMap_mcmd_MetaClass]    Script Date: 05/13/2009 09:53:33 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_mcmd_MetaFieldMap_mcmd_MetaClass]') AND parent_object_id = OBJECT_ID(N'[dbo].[mcmd_MetaFieldMap]'))
ALTER TABLE [dbo].[mcmd_MetaFieldMap] DROP CONSTRAINT [FK_mcmd_MetaFieldMap_mcmd_MetaClass]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaFieldMap_mcmd_MetaClass1]    Script Date: 05/13/2009 09:53:34 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_mcmd_MetaFieldMap_mcmd_MetaClass1]') AND parent_object_id = OBJECT_ID(N'[dbo].[mcmd_MetaFieldMap]'))
ALTER TABLE [dbo].[mcmd_MetaFieldMap] DROP CONSTRAINT [FK_mcmd_MetaFieldMap_mcmd_MetaClass1]
GO
/****** Object:  ForeignKey [FK_mcmd_SelectedEnumValue_mcmd_MetaEnum]    Script Date: 05/13/2009 09:54:01 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_mcmd_SelectedEnumValue_mcmd_MetaEnum]') AND parent_object_id = OBJECT_ID(N'[dbo].[mcmd_SelectedEnumValue]'))
ALTER TABLE [dbo].[mcmd_SelectedEnumValue] DROP CONSTRAINT [FK_mcmd_SelectedEnumValue_mcmd_MetaEnum]
GO
/****** Object:  Table [dbo].[mcmd_MetaFileContentType]    Script Date: 05/13/2009 09:53:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaFileContentType]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaFileContentType]
GO
/****** Object:  Table [dbo].[mcmd_MetaEnum]    Script Date: 05/13/2009 09:53:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaEnum]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaEnum]
GO
/****** Object:  Table [dbo].[mcmd_MetaClass]    Script Date: 05/13/2009 09:53:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaClass]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaClass]
GO
/****** Object:  Table [dbo].[mcmd_MetaClassDataSource]    Script Date: 05/13/2009 09:53:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaClassDataSource]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaClassDataSource]
GO
/****** Object:  Table [dbo].[mcmd_Module]    Script Date: 05/13/2009 09:53:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_Module]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_Module]
GO
/****** Object:  Table [dbo].[mcmd_MetaFieldMap]    Script Date: 05/13/2009 09:53:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaFieldMap]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaFieldMap]
GO
/****** Object:  Table [dbo].[mcmd_MetaField]    Script Date: 05/13/2009 09:53:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaField]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaField]
GO
/****** Object:  Table [dbo].[mcmd_MetaFieldType]    Script Date: 05/13/2009 09:53:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaFieldType]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaFieldType]
GO
/****** Object:  Table [dbo].[mcmd_MetaView]    Script Date: 05/13/2009 09:53:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaView]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaView]
GO
/****** Object:  Table [dbo].[mcmd_MetaFile]    Script Date: 05/13/2009 09:53:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaFile]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaFile]
GO
/****** Object:  Table [dbo].[mcmd_MetaIdentifier]    Script Date: 05/13/2009 09:53:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaIdentifier]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaIdentifier]
GO
/****** Object:  Table [dbo].[mcmd_MetaLink]    Script Date: 05/13/2009 09:53:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaLink]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaLink]
GO
/****** Object:  Table [dbo].[mcmd_MetaModelVersionId]    Script Date: 05/13/2009 09:53:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_MetaModelVersionId]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_MetaModelVersionId]
GO
/****** Object:  Table [dbo].[mcmd_SelectedEnumValue]    Script Date: 05/13/2009 09:54:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_SelectedEnumValue]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_SelectedEnumValue]
GO
/****** Object:  Table [dbo].[mcmd_TmpMetaFile]    Script Date: 05/13/2009 09:54:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcmd_TmpMetaFile]') AND type in (N'U'))
DROP TABLE [dbo].[mcmd_TmpMetaFile]
GO
/****** Object:  Table [dbo].[mcweb_ListViewProfile]    Script Date: 05/13/2009 09:54:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcweb_ListViewProfile]') AND type in (N'U'))
DROP TABLE [dbo].[mcweb_ListViewProfile]
GO
/****** Object:  Table [dbo].[McBlobStorage]    Script Date: 05/13/2009 09:54:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[McBlobStorage]') AND type in (N'U'))
DROP TABLE [dbo].[McBlobStorage]
GO
/****** Object:  Table [dbo].[mcweb_FormDocument]    Script Date: 05/13/2009 09:54:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mcweb_FormDocument]') AND type in (N'U'))
DROP TABLE [dbo].[mcweb_FormDocument]
GO

/****** Object:  Table [dbo].[SchemaVersion_BusinessFoundation]    Script Date: 07/21/2009 17:22:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_BusinessFoundation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_BusinessFoundation](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[mcmd_MetaFile]    Script Date: 05/13/2009 09:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaFile](
	[FileId] [int] IDENTITY(1,1) NOT NULL,
	[FileUID] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[Body] [image] NULL,
	[Length]  AS (datalength([Body])),
 CONSTRAINT [PK_mcmd_MetaFile] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_mcmd_MetaFile] ON [dbo].[mcmd_MetaFile] 
(
	[FileUID] ASC
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaFileContentType]    Script Date: 05/13/2009 09:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaFileContentType](
	[ContentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Extension] [nvarchar](10) NULL,
	[ContentTypeString] [nvarchar](255) NOT NULL,
	[FriendlyName] [nvarchar](50) NULL CONSTRAINT [DF_mcmd_MetaFileContentType_FriendlyName]  DEFAULT (''),
 CONSTRAINT [PK_mcmd_MetaFileContentType] PRIMARY KEY CLUSTERED 
(
	[ContentTypeId] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaIdentifier]    Script Date: 05/13/2009 09:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mcmd_MetaIdentifier](
	[IdentifierId] [int] IDENTITY(1,1) NOT NULL,
	[PeriodKey] [varchar](10) NOT NULL CONSTRAINT [DF_mcmd_MetaIdentifier_PeriodKey]  DEFAULT (''),
	[TypeName] [nvarchar](50) NOT NULL,
	[MetaClassName] [nvarchar](50) NOT NULL,
	[MetaFieldName] [nvarchar](50) NOT NULL,
	[Id] [int] NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_mcmd_MetaIdentifier] PRIMARY KEY CLUSTERED 
(
	[IdentifierId] ASC
) ON [PRIMARY],
 CONSTRAINT [IX_mcmd_MetaIdentifier] UNIQUE NONCLUSTERED 
(
	[PeriodKey] ASC,
	[TypeName] ASC,
	[MetaClassName] ASC,
	[MetaFieldName] ASC,
	[Value] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mcmd_MetaLink]    Script Date: 05/13/2009 09:53:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaLink](
	[LinkId] [int] IDENTITY(1,1) NOT NULL,
	[MetaClassName] [nvarchar](50) NULL,
	[MetaObjectId] [int] NULL,
	[UID] [ntext] NULL,
 CONSTRAINT [PK_mcmd_MetaLink] PRIMARY KEY CLUSTERED 
(
	[LinkId] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaModelVersionId]    Script Date: 05/13/2009 09:53:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaModelVersionId](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_mcmd_MetaModelVersionId_VersionId]  DEFAULT (newid()),
 CONSTRAINT [PK_mcmd_MetaModelVersionId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_TmpMetaFile]    Script Date: 05/13/2009 09:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_TmpMetaFile](
	[TmpFileId] [int] IDENTITY(1,1) NOT NULL,
	[Created] [datetime] NOT NULL CONSTRAINT [DF_mcmd_TmpMetaFile_Created] DEFAULT (GETUTCDATE()),
	[FileUID] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[Body] [image] NULL,
 CONSTRAINT [PK_mcmd_TmpMetaFile] PRIMARY KEY CLUSTERED 
(
	[TmpFileId] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaClass]    Script Date: 05/13/2009 09:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaClass](
	[MetaClassId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](255) NOT NULL,
	[PluralName] [nvarchar](255) NOT NULL,
	[TitleFieldName] [nvarchar](50) NOT NULL,
	[XSValidators] [ntext] NULL,
	[XSAttributes] [ntext] NULL,
	[XSExtensions] [ntext] NULL,
	[Owner] [nvarchar](255) NOT NULL,
	[AccessLevel] [int] NOT NULL,
	[XSModules] [ntext] NULL,
 CONSTRAINT [PK_mcmd_MetaClass] PRIMARY KEY CLUSTERED 
(
	[MetaClassId] ASC
) ON [PRIMARY],
 CONSTRAINT [IX_mcmd_MetaClass] UNIQUE NONCLUSTERED 
(
	[Name] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaEnum]    Script Date: 05/13/2009 09:53:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaEnum](
	[MetaEnumId] [int] IDENTITY(1,1) NOT NULL,
	[Id] [int] NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](255) NOT NULL,
	[OrderId] [int] NOT NULL CONSTRAINT [DF_mcmd_MetaEnum_OrderId]  DEFAULT ((0)),
	[Owner] [nvarchar](255) NOT NULL,
	[AccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_mcmd_MetaEnum] PRIMARY KEY CLUSTERED 
(
	[MetaEnumId] ASC
) ON [PRIMARY],
 CONSTRAINT [IX_mcmd_MetaEnum] UNIQUE NONCLUSTERED 
(
	[Id] ASC,
	[TypeName] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaView]    Script Date: 05/13/2009 09:53:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaView](
	[MetaViewId] [int] IDENTITY(1,1) NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[Card] [nvarchar](50) NOT NULL CONSTRAINT [DF_mcmd_MetaView_Card]  DEFAULT (N''),
	[Name] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](255) NOT NULL,
	[XSAttributes] [ntext] NULL,
	[XSFilters] [ntext] NULL,
	[XSSorts] [ntext] NULL,
	[XSGroups] [ntext] NULL,
	[XSAvailableFields] [ntext] NULL,
	[Owner] [nvarchar](255) NOT NULL,
	[AccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_mcmd_MetaView] PRIMARY KEY CLUSTERED 
(
	[MetaViewId] ASC
) ON [PRIMARY],
 CONSTRAINT [IX_mcmd_MetaView] UNIQUE NONCLUSTERED 
(
	[Name] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_Module]    Script Date: 05/13/2009 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_Module](
	[ModuleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[XSAttributes] [ntext] NULL,
 CONSTRAINT [PK_mcmd_Module] PRIMARY KEY CLUSTERED 
(
	[ModuleId] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaFieldType]    Script Date: 05/13/2009 09:53:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaFieldType](
	[MetaFieldTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](255) NOT NULL,
	[McDataType] [int] NOT NULL,
	[XSViews] [ntext] NULL,
	[XSAttributes] [ntext] NULL,
	[Owner] [nvarchar](255) NOT NULL CONSTRAINT [DF_mcmd_MetaFieldType_Owner]  DEFAULT (N'System'),
	[AccessLevel] [int] NOT NULL CONSTRAINT [DF_mcmd_MetaFieldType_AccessLevel]  DEFAULT ((1)),
 CONSTRAINT [PK_mcmd_MetaFieldType] PRIMARY KEY CLUSTERED 
(
	[MetaFieldTypeId] ASC
) ON [PRIMARY],
 CONSTRAINT [IX_mcmd_MetaFieldType] UNIQUE NONCLUSTERED 
(
	[Name] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaClassDataSource]    Script Date: 05/13/2009 09:53:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaClassDataSource](
	[MetaClassDataSourceId] [int] IDENTITY(1,1) NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[PrimaryTable] [nvarchar](50) NOT NULL,
	[XSExtendedTables] [ntext] NULL,
	[XSConditions] [ntext] NULL,
 CONSTRAINT [PK_mcmd_MetaClassDataSource] PRIMARY KEY CLUSTERED 
(
	[MetaClassDataSourceId] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaFieldMap]    Script Date: 05/13/2009 09:53:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaFieldMap](
	[MetaFieldMapId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SrcMetaClassId] [int] NOT NULL,
	[DestMetaClassId] [int] NOT NULL,
	[XSReferences] [ntext] NULL,
	[XSElements] [ntext] NULL,
 CONSTRAINT [PK_mcmd_MetaFieldMap] PRIMARY KEY CLUSTERED 
(
	[MetaFieldMapId] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_MetaField]    Script Date: 05/13/2009 09:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_MetaField](
	[MetaFieldId] [int] IDENTITY(1,1) NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](255) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[Nullable] [bit] NOT NULL,
	[DefaultValue] [ntext] NOT NULL,
	[ReadOnly] [bit] NOT NULL,
	[XSDataSource] [ntext] NULL,
	[XSAttributes] [ntext] NULL,
	[Owner] [nvarchar](255) NOT NULL,
	[AccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_mcmd_MetaField] PRIMARY KEY CLUSTERED 
(
	[MetaFieldId] ASC
) ON [PRIMARY],
 CONSTRAINT [IX_mcmd_MetaField] UNIQUE NONCLUSTERED 
(
	[MetaClassId] ASC,
	[Name] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mcmd_SelectedEnumValue]    Script Date: 05/13/2009 09:54:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mcmd_SelectedEnumValue](
	[SelectedEnumValueId] [int] IDENTITY(1,1) NOT NULL,
	[Key] [uniqueidentifier] NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[Id] [int] NOT NULL,
 CONSTRAINT [PK_mcmd_SelectedEnumValue] PRIMARY KEY CLUSTERED 
(
	[SelectedEnumValueId] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaClassDataSource_mcmd_MetaClass]    Script Date: 05/13/2009 09:53:20 ******/
ALTER TABLE [dbo].[mcmd_MetaClassDataSource]  WITH CHECK ADD  CONSTRAINT [FK_mcmd_MetaClassDataSource_mcmd_MetaClass] FOREIGN KEY([MetaClassId])
REFERENCES [dbo].[mcmd_MetaClass] ([MetaClassId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[mcmd_MetaClassDataSource] CHECK CONSTRAINT [FK_mcmd_MetaClassDataSource_mcmd_MetaClass]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaField_mcmd_MetaClass]    Script Date: 05/13/2009 09:53:30 ******/
ALTER TABLE [dbo].[mcmd_MetaField]  WITH CHECK ADD  CONSTRAINT [FK_mcmd_MetaField_mcmd_MetaClass] FOREIGN KEY([MetaClassId])
REFERENCES [dbo].[mcmd_MetaClass] ([MetaClassId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[mcmd_MetaField] CHECK CONSTRAINT [FK_mcmd_MetaField_mcmd_MetaClass]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaFieldMap_mcmd_MetaClass]    Script Date: 05/13/2009 09:53:33 ******/
ALTER TABLE [dbo].[mcmd_MetaFieldMap]  WITH CHECK ADD  CONSTRAINT [FK_mcmd_MetaFieldMap_mcmd_MetaClass] FOREIGN KEY([SrcMetaClassId])
REFERENCES [dbo].[mcmd_MetaClass] ([MetaClassId])
GO
ALTER TABLE [dbo].[mcmd_MetaFieldMap] CHECK CONSTRAINT [FK_mcmd_MetaFieldMap_mcmd_MetaClass]
GO
/****** Object:  ForeignKey [FK_mcmd_MetaFieldMap_mcmd_MetaClass1]    Script Date: 05/13/2009 09:53:34 ******/
ALTER TABLE [dbo].[mcmd_MetaFieldMap]  WITH CHECK ADD  CONSTRAINT [FK_mcmd_MetaFieldMap_mcmd_MetaClass1] FOREIGN KEY([DestMetaClassId])
REFERENCES [dbo].[mcmd_MetaClass] ([MetaClassId])
GO
ALTER TABLE [dbo].[mcmd_MetaFieldMap] CHECK CONSTRAINT [FK_mcmd_MetaFieldMap_mcmd_MetaClass1]
GO
/****** Object:  ForeignKey [FK_mcmd_SelectedEnumValue_mcmd_MetaEnum]    Script Date: 05/13/2009 09:54:01 ******/
ALTER TABLE [dbo].[mcmd_SelectedEnumValue]  WITH CHECK ADD  CONSTRAINT [FK_mcmd_SelectedEnumValue_mcmd_MetaEnum] FOREIGN KEY([Id], [TypeName])
REFERENCES [dbo].[mcmd_MetaEnum] ([Id], [TypeName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[mcmd_SelectedEnumValue] CHECK CONSTRAINT [FK_mcmd_SelectedEnumValue_mcmd_MetaEnum]
GO

/****** Object:  Table [dbo].[mcweb_ListViewProfile]    Script Date: 06/22/2009 13:44:32 ******/
CREATE TABLE [dbo].[mcweb_ListViewProfile](
	[ListViewProfileId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[MetaClassName] [nvarchar](50) NOT NULL,
	[ViewName] [nvarchar](50) NOT NULL,
	[PlaceName] [nvarchar](50) NOT NULL CONSTRAINT [DF_mcweb_ListViewProfile_PlaceName]  DEFAULT (N''),
	[IsSystem] [bit] NOT NULL CONSTRAINT [DF_mcweb_ListViewProfile_IsSystem]  DEFAULT ((0)),
	[IsPublic] [bit] NOT NULL,
	[XSListViewProfile] [ntext] NOT NULL,
	[UserUid] [uniqueidentifier] NULL,
CONSTRAINT [PK_mcweb_ListViewProfile] PRIMARY KEY CLUSTERED 
(
	[ListViewProfileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, 		ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[McBlobStorage]    Script Date: 06/22/2009 13:44:32 ******/
CREATE TABLE [dbo].[McBlobStorage](
	[uid] [uniqueidentifier] NOT NULL,
	[contentType] [nvarchar](255) NULL,
	[ownerType] [nvarchar](254) NULL,
	[ownerKey] [nvarchar](254) NULL,
	[provider] [nvarchar](50) NULL,
	[BlobData] [image] NULL,
	[fileName] [nvarchar](1024) NULL,
	[fileExtension] [nvarchar](8) NULL,
	[allowSearch] [bit] NULL,
	[created] [datetime] NOT NULL CONSTRAINT [DF_McBlobStorage_created] DEFAULT (getutcdate()),
	[isTemporary] [bit] NOT NULL CONSTRAINT [DF_McBlobStorage_isTemporary] DEFAULT ((1))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[mcweb_FormDocument]    Script Date: 06/22/2009 13:44:32 ******/
CREATE TABLE [dbo].[mcweb_FormDocument]
(
	[FormDocumentId] [int] IDENTITY(1,1) NOT NULL,
	[MetaClassName] [nvarchar](50) NOT NULL,
	[FormDocumentName] [nvarchar](50) NOT NULL,
	[FormDocumentXml] [ntext] NOT NULL,
	[MetaUITypeId] [nvarchar](50) NOT NULL CONSTRAINT [DF_mcweb_FormDocument_MetaUITypeId] DEFAULT (N''),
	CONSTRAINT [PK_mcweb_FormDocuments] PRIMARY KEY CLUSTERED ([FormDocumentId])
)
GO

