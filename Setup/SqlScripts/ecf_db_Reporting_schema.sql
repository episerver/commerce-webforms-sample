/****** Object:  Table [dbo].[ReportingDates]    Script Date: 07/21/2009 17:25:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportingDates]') AND type in (N'U'))
DROP TABLE [dbo].[ReportingDates]
GO

/****** Object:  Table [dbo].[SchemaVersion_ReportingSystem]    Script Date: 07/21/2009 17:25:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_ReportingSystem]') AND type in (N'U'))
DROP TABLE [dbo].[SchemaVersion_ReportingSystem]
GO

/****** Object:  Table [dbo].[ReportingDates]    Script Date: 07/21/2009 17:25:58 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportingDates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportingDates](
	[DateKey] [int] NOT NULL,
	[DateFull] [datetime] NULL,
	[CharacterDate] [varchar](10) NULL,
	[FullYear] [char](4) NULL,
	[QuarterNumber] [tinyint] NULL,
	[WeekNumber] [tinyint] NULL,
	[WeekDayName] [varchar](10) NULL,
	[MonthDay] [tinyint] NULL,
	[MonthName] [varchar](12) NULL,
	[YearDay] [smallint] NULL,
	[DateDefinition] [varchar](50) NULL,
	[WeekDay] [tinyint] NULL,
	[MonthNumber] [tinyint] NULL,
 CONSTRAINT [PK__ReportingDates__7B712C3B] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_ReportingDates] UNIQUE NONCLUSTERED 
(
	[DateFull] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[SchemaVersion_ReportingSystem]    Script Date: 07/21/2009 17:25:58 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_ReportingSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SchemaVersion_ReportingSystem](
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Patch] [int] NOT NULL,
	[InstallDate] [datetime] NOT NULL
) ON [PRIMARY]
END
GO