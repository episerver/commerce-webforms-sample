/****** Object:  Table [dbo].[RolePermission]    Script Date: 07/21/2009 17:25:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolePermission]') AND type in (N'U'))
DROP TABLE [dbo].[RolePermission]
GO

/****** Object:  Table [dbo].[SchemaVersion_SecuritySystem]    Script Date: 07/21/2009 17:25:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_SecuritySystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_SecuritySystem]
GO


/****** Object:  Table [dbo].[RolePermission]    Script Date: 07/21/2009 17:25:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolePermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RolePermission](
	[RolePermissionId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[Permission] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SchemaVersion_SecuritySystem]    Script Date: 07/21/2009 17:25:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_SecuritySystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_SecuritySystem](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[Security_RoleAssignment]    Script Date: 08/04/2009 16:00:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Security_RoleAssignment]') AND type in (N'U'))
DROP TABLE [dbo].[Security_RoleAssignment]
GO

/****** Object:  Table [dbo].[Security_RoleAssignment]    Script Date: 08/04/2009 15:57:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Security_RoleAssignment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Security_RoleAssignment](
	[SecurityRoleAssignmentId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Security_RoleAssignment_SecurityRoleAssignmentId]  DEFAULT (newid()),
	[RoleParticipant] [uniqueidentifier] NOT NULL,
	[Role] [nvarchar](255) NOT NULL,
	[Scope] [nvarchar](max) NULL,
	[CheckMode] [int] NULL,
	[IsOnlyForOwner] [bit] NOT NULL CONSTRAINT [DF_Security_RoleAssignment_IsOnlyForOwner]  DEFAULT ((0)),
 CONSTRAINT [PK_Security_RoleAssignment] PRIMARY KEY CLUSTERED 
(
	[SecurityRoleAssignmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


/****** Object:  Table [dbo].[Security_SsoTickets]    Script Date: 05/20/2011 10:32:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Security_SsoTickets]') AND type in (N'U'))
DROP TABLE [dbo].[Security_RoleAssignment]
GO

/****** Object:  Table [dbo].[Security_SsoTickets]    Script Date: 05/20/2011 10:32:56 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Security_SsoTickets]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Security_SsoTickets](
	[SsoTicket] nvarchar(64) NOT NULL,
	[UserName] nvarchar(256) NOT NULL,
	[ApplicationName] nvarchar(200) NULL,
	[ExpirationUtc] datetime NOT NULL,
	[Valid] bit NOT NULL,
	CONSTRAINT [PK_Security_SsoTickets] PRIMARY KEY ([SsoTicket] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
		ON [PRIMARY]
) ON [PRIMARY]
END
GO

