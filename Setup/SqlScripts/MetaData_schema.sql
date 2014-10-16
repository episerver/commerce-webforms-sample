IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_MetaDataSystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_MetaDataSystem]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaField_MetaDataType]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaField]'))
ALTER TABLE [dbo].[MetaField] DROP CONSTRAINT [FK_MetaField_MetaDataType]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaClassMetaFieldRelation_MetaClass]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaClassMetaFieldRelation]'))
ALTER TABLE [dbo].[MetaClassMetaFieldRelation] DROP CONSTRAINT [FK_MetaClassMetaFieldRelation_MetaClass]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaClassMetaFieldRelation_MetaField]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaClassMetaFieldRelation]'))
ALTER TABLE [dbo].[MetaClassMetaFieldRelation] DROP CONSTRAINT [FK_MetaClassMetaFieldRelation_MetaField]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaDictionary_MetaField]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaDictionary]'))
ALTER TABLE [dbo].[MetaDictionary] DROP CONSTRAINT [FK_MetaDictionary_MetaField]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaDictionaryLocalization_MetaDictionary]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaDictionaryLocalization]'))
ALTER TABLE [dbo].[MetaDictionaryLocalization] DROP CONSTRAINT [FK_MetaDictionaryLocalization_MetaDictionary]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaFileValue_MetaKey]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaFileValue]'))
ALTER TABLE [dbo].[MetaFileValue] DROP CONSTRAINT [FK_MetaFileValue_MetaKey]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaMultiValueDictionary_MetaKey]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaMultiValueDictionary]'))
ALTER TABLE [dbo].[MetaMultiValueDictionary] DROP CONSTRAINT [FK_MetaMultiValueDictionary_MetaKey]
GO

if exists ( select 1
            from sys.schemas s
            join sys.objects tabs on tabs.schema_id = s.schema_id
            join sys.triggers tr on tr.parent_id = tabs.object_id
            where s.name = 'dbo' and tabs.name = 'MetaClass' and tr.name = 'mdptr_sys_MetaClass_PrimaryKeyName')
drop trigger dbo.mdptr_sys_MetaClass_PrimaryKeyName
go

if exists ( select 1
            from sys.schemas s
            join sys.objects tabs on tabs.schema_id = s.schema_id
            join sys.triggers tr on tr.parent_id = tabs.object_id
            where s.name = 'dbo' and tabs.name = 'MetaField' and tr.name = 'mdptr_sys_MetaField_IsKeyField')
drop trigger dbo.mdptr_sys_MetaField_IsKeyField
go

/****** Object:  Table [dbo].[MetaAttribute]    Script Date: 07/21/2009 17:26:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaAttribute]') AND type in (N'U'))
DROP TABLE [dbo].[MetaAttribute]
GO

/****** Object:  Table [dbo].[MetaDataType]    Script Date: 07/21/2009 17:26:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaDataType]') AND type in (N'U'))
DROP TABLE [dbo].[MetaDataType]
GO

/****** Object:  Table [dbo].[MetaClass]    Script Date: 07/21/2009 17:26:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaClass]') AND type in (N'U'))
DROP TABLE [dbo].[MetaClass]
GO

/****** Object:  Table [dbo].[MetaField]    Script Date: 07/21/2009 17:26:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaField]') AND type in (N'U'))
DROP TABLE [dbo].[MetaField]
GO

/****** Object:  Table [dbo].[MetaClassMetaFieldRelation]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaClassMetaFieldRelation]') AND type in (N'U'))
DROP TABLE [dbo].[MetaClassMetaFieldRelation]
GO

/****** Object:  Table [dbo].[MetaDictionary]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaDictionary]') AND type in (N'U'))
DROP TABLE [dbo].[MetaDictionary]
GO

/****** Object:  Table [dbo].[MetaDictionaryLocalization]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaDictionaryLocalization]') AND type in (N'U'))
DROP TABLE [dbo].[MetaDictionaryLocalization]
GO

/****** Object:  Table [dbo].[MetaFileValue]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaFileValue]') AND type in (N'U'))
DROP TABLE [dbo].[MetaFileValue]
GO

/****** Object:  Table [dbo].[MetaKey]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaKey]') AND type in (N'U'))
DROP TABLE [dbo].[MetaKey]
GO

/****** Object:  Table [dbo].[MetaMultiValueDictionary]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaMultiValueDictionary]') AND type in (N'U'))
DROP TABLE [dbo].[MetaMultiValueDictionary]
GO

/****** Object:  Table [dbo].[MetaObjectValue]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaObjectValue]') AND type in (N'U'))
DROP TABLE [dbo].[MetaObjectValue]
GO

/****** Object:  Table [dbo].[MetaRule]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaRule]') AND type in (N'U'))
DROP TABLE [dbo].[MetaRule]
GO

/****** Object:  Table [dbo].[MetaStringDictionaryValue]    Script Date: 07/21/2009 17:26:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaStringDictionaryValue]') AND type in (N'U'))
DROP TABLE [dbo].[MetaStringDictionaryValue]
GO

/****** Object:  Table [dbo].[SchemaVersion_MetaDataSystem] ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_MetaDataSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_MetaDataSystem] (
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaAttribute]    Script Date: 07/21/2009 17:26:03 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaAttribute]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaAttribute](
	[AttrOwnerId] [int] NOT NULL,
	[AttrOwnerType] [int] NOT NULL,
	[Key] [nvarchar](256) NOT NULL,
	[Value] [ntext] NOT NULL,
 CONSTRAINT [PK_MetaAttribute] PRIMARY KEY CLUSTERED 
(
	[AttrOwnerId] ASC,
	[AttrOwnerType] ASC,
	[Key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaDataType]    Script Date: 07/21/2009 17:26:03 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaDataType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaDataType](
	[DataTypeId] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[FriendlyName] [nvarchar](256) NOT NULL,
	[Description] [ntext] NULL,
	[Length] [int] NOT NULL CONSTRAINT [DF_MetaDataType_Length]  DEFAULT ((0)),
	[SqlName] [nvarchar](256) NOT NULL,
	[AllowNulls] [bit] NOT NULL CONSTRAINT [DF_MetaDataType_AllowNulls]  DEFAULT ((1)),
	[Variable] [bit] NOT NULL CONSTRAINT [DF_MetaDataType_Variable]  DEFAULT ((0)),
	[IsSQLCommonType] [bit] NOT NULL CONSTRAINT [DF_MetaDataType_IsSQLCommonType]  DEFAULT ((1)),
	[DefaultValue] [nvarchar](256) NOT NULL CONSTRAINT [DF_MetaDataType_DefaultValue]  DEFAULT (N''),
 CONSTRAINT [PK_MetaDataType] PRIMARY KEY CLUSTERED 
(
	[DataTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaClass]    Script Date: 07/21/2009 17:26:03 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaClass]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaClass](
	[MetaClassId] [int] IDENTITY(1,1) NOT NULL,
	[Namespace] [nvarchar](1024) NOT NULL CONSTRAINT [DF_MetaClass_Namespace]  DEFAULT (N''),
	[Name] [nvarchar](256) NOT NULL,
	[FriendlyName] [nvarchar](256) NOT NULL CONSTRAINT [DF_MetaClass_FriendlyName]  DEFAULT (N''),
	[IsSystem] [bit] NOT NULL CONSTRAINT [DF_MetaClass_IsSystem]  DEFAULT ((0)),
	[IsAbstract] [bit] NOT NULL CONSTRAINT [DF_MetaClass_IsAbstract]  DEFAULT ((0)),
	[ParentClassId] [int] NOT NULL CONSTRAINT [DF_MetaClass_ParentClassId]  DEFAULT ((0)),
	[TableName] [nvarchar](256) NOT NULL,
	[PrimaryKeyName] [nvarchar](256) NOT NULL CONSTRAINT [DF_MetaClass_PrimaryKeyName]  DEFAULT (N''),
	[Description] [ntext] NULL,
	[FieldListChangedSqlScript] [ntext] NULL,
	[Tag] [image] NULL,
 CONSTRAINT [PK_MetaClass] PRIMARY KEY CLUSTERED 
(
	[MetaClassId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_MetaClass] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaField]    Script Date: 07/21/2009 17:26:03 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaField]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaField](
	[MetaFieldId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Namespace] [nvarchar](1024) NOT NULL CONSTRAINT [DF_MetaField_Namespace]  DEFAULT (''),
	[SystemMetaClassId] [int] NOT NULL CONSTRAINT [DF_MetaField_SystemMetaClassId]  DEFAULT ((0)),
	[FriendlyName] [nvarchar](256) NOT NULL,
	[Description] [ntext] NULL,
	[DataTypeId] [int] NOT NULL,
	[Length] [int] NOT NULL CONSTRAINT [DF_MetaField_Length]  DEFAULT ((0)),
	[AllowNulls] [bit] NOT NULL CONSTRAINT [DF_MetaField_AllowNulls]  DEFAULT ((1)),
	[MultiLanguageValue] [bit] NOT NULL CONSTRAINT [DF_MetaField_MultiLanguageValue]  DEFAULT ((0)),
	[AllowSearch] [bit] NOT NULL,
	[Tag] [image] NULL,
	[IsEncrypted] [bit] NOT NULL CONSTRAINT [DF_MetaField_Encrypt]  DEFAULT ((0)),
	IsKeyField bit not null default (0),
 CONSTRAINT [PK_MetaField] PRIMARY KEY CLUSTERED 
(
	[MetaFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_MetaField] UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[SystemMetaClassId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaClassMetaFieldRelation]    Script Date: 07/21/2009 17:26:03 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaClassMetaFieldRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaClassMetaFieldRelation](
	[MetaClassId] [int] NOT NULL,
	[MetaFieldId] [int] NOT NULL,
	[Weight] [int] NOT NULL CONSTRAINT [DF_MetaClassMetaFieldRelation_Weight]  DEFAULT ((0)),
	[Enabled] [bit] NOT NULL CONSTRAINT [DF_MetaClassMetaFieldRelation_Enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_MetaClassMetaFieldRelation] PRIMARY KEY CLUSTERED 
(
	[MetaClassId] ASC,
	[MetaFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaDictionary]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaDictionary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaDictionary](
	[MetaDictionaryId] [int] IDENTITY(1,1) NOT NULL,
	[MetaFieldId] [int] NOT NULL,
	[Value] [nvarchar](2048) NOT NULL CONSTRAINT [DF_MetaDictionary_Value]  DEFAULT (N''),
	[Tag] [image] NULL,
 CONSTRAINT [PK_MetaDictionary] PRIMARY KEY CLUSTERED 
(
	[MetaDictionaryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaDictionaryLocalization]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaDictionaryLocalization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaDictionaryLocalization](
	[MetaDictionaryLocalizationId] [int] IDENTITY(1,1) NOT NULL,
	[MetaDictionaryId] [int] NOT NULL,
	[Language] [nvarchar](20) NOT NULL,
	[Value] [nvarchar](2048) NOT NULL,
	[Tag] [image] NULL,
 CONSTRAINT [PK_MetaDictionaryLocalization] PRIMARY KEY CLUSTERED 
(
	[MetaDictionaryLocalizationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [IX_MetaDictionaryLocalization] UNIQUE NONCLUSTERED 
(
	[MetaDictionaryId] ASC,
	[Language] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaFileValue]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaFileValue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaFileValue](
	[MetaKey] [int] NOT NULL,
	[FileName] [nvarchar](256) NULL,
	[ContentType] [nvarchar](256) NULL,
	[Data] [image] NULL,
	[Size] [int] NOT NULL CONSTRAINT [DF_MetaFileValue_Size]  DEFAULT ((0)),
	[CreationTime] [datetime] NOT NULL CONSTRAINT [DF_MetaFileValue_CreationTime]  DEFAULT (GETUTCDATE()),
	[LastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_MetaFileValue_LastWriteTime]  DEFAULT (GETUTCDATE()),
	[LastReadTime] [datetime] NOT NULL CONSTRAINT [DF_MetaFileValue_LastReadTime]  DEFAULT (GETUTCDATE()),
 CONSTRAINT [PK_MetaFileValue] PRIMARY KEY CLUSTERED 
(
	[MetaKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaKey]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaKey]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaKey](
	[MetaKey] [int] IDENTITY(1,1) NOT NULL,
	[MetaObjectId] [int] NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[MetaFieldId] [int] NOT NULL,
	[Language] [nvarchar](20) NULL,
 CONSTRAINT [PK_MetaKey] PRIMARY KEY CLUSTERED 
(
	[MetaKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_MetaKey_MetaObjectIdMetaClassId]    Script Date: 07/21/2009 17:26:04 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MetaKey]') AND name = N'IX_MetaKey_MetaObjectIdMetaClassId')
CREATE NONCLUSTERED INDEX [IX_MetaKey_MetaObjectIdMetaClassId] ON [dbo].[MetaKey] 
(
	[MetaObjectId] ASC,
	[MetaClassId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]

/****** Object:  Index [IX_MetaKey2]    Script Date: 07/21/2009 17:26:04 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MetaKey]') AND name = N'IX_MetaKey2')
CREATE NONCLUSTERED INDEX [IX_MetaKey2] ON [dbo].[MetaKey] 
(
	[MetaObjectId] ASC,
	[MetaClassId] ASC,
	[MetaFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[MetaMultiValueDictionary]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaMultiValueDictionary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaMultiValueDictionary](
	[MetaKey] [int] NOT NULL,
	[MetaDictionaryId] [int] NOT NULL,
 CONSTRAINT [PK_MetaMultiValueDictionary] PRIMARY KEY CLUSTERED 
(
	[MetaKey] ASC,
	[MetaDictionaryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaObjectValue]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaObjectValue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaObjectValue](
	[MetaKey] [int] NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[MetaObjectId] [int] NOT NULL,
 CONSTRAINT [PK_MetaObjectValue] PRIMARY KEY CLUSTERED 
(
	[MetaKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaRule]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaRule](
	[RuleId] [int] IDENTITY(1,1) NOT NULL,
	[MetaClassId] [int] NOT NULL,
	[Data] [image] NULL,
 CONSTRAINT [PK_MetaRule] PRIMARY KEY CLUSTERED 
(
	[RuleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[MetaStringDictionaryValue]    Script Date: 07/21/2009 17:26:04 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetaStringDictionaryValue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MetaStringDictionaryValue](
	[MetaKey] [int] NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [ntext] NOT NULL,
 CONSTRAINT [PK_MetaStringDictionaryValue] PRIMARY KEY CLUSTERED 
(
	[MetaKey] ASC,
	[Key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

/****** Object:  Index [IX_MetaStringDictionaryMetaKey]    Script Date: 07/21/2009 17:26:04 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MetaStringDictionaryValue]') AND name = N'IX_MetaStringDictionaryMetaKey')
CREATE NONCLUSTERED INDEX [IX_MetaStringDictionaryMetaKey] ON [dbo].[MetaStringDictionaryValue] 
(
	[MetaKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaField_MetaDataType]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaField]'))
ALTER TABLE [dbo].[MetaField]  WITH CHECK ADD  CONSTRAINT [FK_MetaField_MetaDataType] FOREIGN KEY([DataTypeId])
REFERENCES [MetaDataType] ([DataTypeId])
ALTER TABLE [dbo].[MetaField] CHECK CONSTRAINT [FK_MetaField_MetaDataType]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaClassMetaFieldRelation_MetaClass]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaClassMetaFieldRelation]'))
ALTER TABLE [dbo].[MetaClassMetaFieldRelation]  WITH CHECK ADD  CONSTRAINT [FK_MetaClassMetaFieldRelation_MetaClass] FOREIGN KEY([MetaClassId])
REFERENCES [MetaClass] ([MetaClassId])
ALTER TABLE [dbo].[MetaClassMetaFieldRelation] CHECK CONSTRAINT [FK_MetaClassMetaFieldRelation_MetaClass]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaClassMetaFieldRelation_MetaField]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaClassMetaFieldRelation]'))
ALTER TABLE [dbo].[MetaClassMetaFieldRelation]  WITH CHECK ADD  CONSTRAINT [FK_MetaClassMetaFieldRelation_MetaField] FOREIGN KEY([MetaFieldId])
REFERENCES [MetaField] ([MetaFieldId])
ALTER TABLE [dbo].[MetaClassMetaFieldRelation] CHECK CONSTRAINT [FK_MetaClassMetaFieldRelation_MetaField]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaDictionary_MetaField]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaDictionary]'))
ALTER TABLE [dbo].[MetaDictionary]  WITH CHECK ADD  CONSTRAINT [FK_MetaDictionary_MetaField] FOREIGN KEY([MetaFieldId])
REFERENCES [MetaField] ([MetaFieldId])
ALTER TABLE [dbo].[MetaDictionary] CHECK CONSTRAINT [FK_MetaDictionary_MetaField]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaDictionaryLocalization_MetaDictionary]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaDictionaryLocalization]'))
ALTER TABLE [dbo].[MetaDictionaryLocalization]  WITH CHECK ADD  CONSTRAINT [FK_MetaDictionaryLocalization_MetaDictionary] FOREIGN KEY([MetaDictionaryId])
REFERENCES [MetaDictionary] ([MetaDictionaryId])
ON DELETE CASCADE
ALTER TABLE [dbo].[MetaDictionaryLocalization] CHECK CONSTRAINT [FK_MetaDictionaryLocalization_MetaDictionary]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaFileValue_MetaKey]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaFileValue]'))
ALTER TABLE [dbo].[MetaFileValue]  WITH CHECK ADD  CONSTRAINT [FK_MetaFileValue_MetaKey] FOREIGN KEY([MetaKey])
REFERENCES [MetaKey] ([MetaKey])
ALTER TABLE [dbo].[MetaFileValue] CHECK CONSTRAINT [FK_MetaFileValue_MetaKey]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MetaMultiValueDictionary_MetaKey]') AND parent_object_id = OBJECT_ID(N'[dbo].[MetaMultiValueDictionary]'))
ALTER TABLE [dbo].[MetaMultiValueDictionary]  WITH CHECK ADD  CONSTRAINT [FK_MetaMultiValueDictionary_MetaKey] FOREIGN KEY([MetaKey])
REFERENCES [MetaKey] ([MetaKey])
ALTER TABLE [dbo].[MetaMultiValueDictionary] CHECK CONSTRAINT [FK_MetaMultiValueDictionary_MetaKey]
GO

