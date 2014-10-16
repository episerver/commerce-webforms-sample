IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteSecurity_Site]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteSecurity]'))
ALTER TABLE [dbo].[SiteSecurity] DROP CONSTRAINT [FK_SiteSecurity_Site]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ApplicationLog_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[ApplicationLog]'))
ALTER TABLE [dbo].[ApplicationLog] DROP CONSTRAINT [FK_ApplicationLog_Application]
GO

/****** Object:  Table [dbo].[SchemaVersion_ApplicationSystem]    Script Date: 07/21/2009 17:22:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_ApplicationSystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_ApplicationSystem]
GO

/****** Object:  Table [dbo].[Application]    Script Date: 07/21/2009 17:22:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Application]') AND type in (N'U'))
DROP TABLE [dbo].[Application]
GO

/****** Object:  Table [dbo].[Site]    Script Date: 07/21/2009 17:22:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Site]') AND type in (N'U'))
DROP TABLE [dbo].[Site]
GO

/****** Object:  Table [dbo].[SiteSecurity]    Script Date: 07/21/2009 17:22:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteSecurity]') AND type in (N'U'))
DROP TABLE [dbo].[SiteSecurity]
GO

/****** Object:  Table [dbo].[CommonSettings]    Script Date: 07/21/2009 17:22:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CommonSettings]') AND type in (N'U'))
DROP TABLE [dbo].[CommonSettings]
GO

/****** Object:  Table [dbo].[ApplicationLog]    Script Date: 07/21/2009 17:22:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ApplicationLog]') AND type in (N'U'))
DROP TABLE [dbo].[ApplicationLog]
GO

/****** Object:  Table [dbo].[SchemaVersion_ApplicationSystem]    Script Date: 07/21/2009 17:22:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_ApplicationSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_ApplicationSystem](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Application]    Script Date: 07/21/2009 17:22:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Application]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Application](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Aplication] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY],
    constraint [AX_Application_Name] unique (Name)
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Site]    Script Date: 07/21/2009 17:22:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Site]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Site](
	[SiteId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Domain] [nvarchar](1000) NULL,
	[Folder] [nvarchar](255) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SiteSecurity]    Script Date: 07/21/2009 17:22:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteSecurity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SiteSecurity](
	[SiteId] [uniqueidentifier] NOT NULL,
	[SID] [nvarchar](250) NOT NULL,
	[Scope] [nvarchar](50) NOT NULL,
	[AllowMask] [binary](8) NOT NULL,
	[DenyMask] [binary](8) NOT NULL
) ON [PRIMARY]
END

/****** Object:  Index [IX_SiteSecurity]    Script Date: 07/21/2009 17:22:33 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SiteSecurity]') AND name = N'IX_SiteSecurity')
CREATE UNIQUE NONCLUSTERED INDEX [IX_SiteSecurity] ON [dbo].[SiteSecurity] 
(
	[SiteId] ASC,
	[Scope] ASC,
	[SID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CommonSettings]    Script Date: 07/21/2009 17:22:34 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CommonSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CommonSettings](
	[SettingId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](50) NULL,
 CONSTRAINT [PK_CommonSettings] PRIMARY KEY CLUSTERED 
(
	[SettingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[ApplicationLog]    Script Date: 07/21/2009 17:22:34 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ApplicationLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ApplicationLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Source] [nvarchar](100) NOT NULL,
	[Operation] [nvarchar](50) NOT NULL,
	[ObjectKey] [nvarchar](100) NOT NULL,
	[ObjectType] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Succeeded] [bit] NOT NULL,
	[IPAddress] [nvarchar](50) NULL,
	[Notes] [nvarchar](255) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ApplicationLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteSecurity_Site]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteSecurity]'))
ALTER TABLE [dbo].[SiteSecurity]  WITH CHECK ADD  CONSTRAINT [FK_SiteSecurity_Site] FOREIGN KEY([SiteId])
REFERENCES [Site] ([SiteId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[SiteSecurity] CHECK CONSTRAINT [FK_SiteSecurity_Site]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ApplicationLog_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[ApplicationLog]'))
ALTER TABLE [dbo].[ApplicationLog]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationLog_Application] FOREIGN KEY([ApplicationId])
REFERENCES [Application] ([ApplicationId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[ApplicationLog] CHECK CONSTRAINT [FK_ApplicationLog_Application]
GO

