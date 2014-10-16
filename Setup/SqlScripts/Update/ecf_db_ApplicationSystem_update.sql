/********************************************************************
             Pre Release Upgrade Script
*********************************************************************/

--------------- August 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetApplicationSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_ApplicationSystem]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_ApplicationSystem])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- November 01, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 2;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE TABLE [CommonSettings]
	(
	SettingId int NOT NULL IDENTITY (1, 1),
	ApplicationId uniqueidentifier NOT NULL,
	Name nvarchar(100) NOT NULL,
	Value nvarchar(50) NULL
	)  ON [PRIMARY]'

exec dbo.sp_executesql @statement = N'ALTER TABLE [CommonSettings] ADD CONSTRAINT
	PK_CommonSettings PRIMARY KEY CLUSTERED 
	(
	SettingId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Settings]
	@ApplicationId uniqueidentifier
AS
BEGIN
	select * from [CommonSettings] 
		where [ApplicationId] = @ApplicationId
END'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- November 05, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 3;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Setting_SettingId]
	@ApplicationId uniqueidentifier,
	@SettingId int
AS
BEGIN
	select * from [CommonSettings] 
		where [ApplicationId] = @ApplicationId and [SettingId] = @SettingId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Setting_Name]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(100)
AS
BEGIN
	select * from [CommonSettings] 
		where [ApplicationId] = @ApplicationId and [Name] = @Name
END'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


--------------- December 19, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 4;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

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

ALTER TABLE [dbo].[ApplicationLog]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationLog_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Application] ([ApplicationId])
ON UPDATE CASCADE
ON DELETE CASCADE

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- December 22, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 5;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ApplicationLog]
	@ApplicationId uniqueidentifier,
	@Source nvarchar(100) = null,
	@Created datetime = null,
	@Operation nvarchar(50) = null,
	@ObjectType nvarchar(50) = null,
    @StartingRec int,
	@NumRecords int
AS
BEGIN
	SET NOCOUNT ON;
	WITH OrderedLogs AS 
	(
		select *, row_number() over(order by LogId) as RowNumber from ApplicationLog where COALESCE(@Source, Source) = Source AND COALESCE(@Operation, Operation) = Operation and COALESCE(@ObjectType, ObjectType) = ObjectType and COALESCE(@Created, Created) <= Created
	),
	OrderedLogsCount(TotalCount) as
	(
		select count(LogId) from OrderedLogs
	)
	select LogId, Source, Operation, ObjectKey, ObjectType, Username, Created, Succeeded, IPAddress, Notes, ApplicationId, TotalCount from OrderedLogs, OrderedLogsCount
	where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
	SET NOCOUNT OFF;
END'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- January 21, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 6;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ApplicationLog]
	@ApplicationId uniqueidentifier,
	@IsSystemLog bit = 0,
	@Source nvarchar(100) = null,
	@Created datetime = null,
	@Operation nvarchar(50) = null,
	@ObjectType nvarchar(50) = null,
    @StartingRec int,
	@NumRecords int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SystemLogKey nvarchar(100)
	SET @SystemLogKey = ''system''; 

	WITH OrderedLogs AS 
	(
		select *, row_number() over(order by LogId desc) as RowNumber from ApplicationLog 
			where ((@IsSystemLog = 1 AND Source = @SystemLogKey) OR (@IsSystemLog = 0 AND NOT Source = @SystemLogKey))
				AND COALESCE(@Source, Source) = Source 
				AND COALESCE(@Operation, Operation) = Operation 
				AND COALESCE(@ObjectType, ObjectType) = ObjectType 
				AND COALESCE(@Created, Created) <= Created
	),
	OrderedLogsCount(TotalCount) as
	(
		select count(LogId) from OrderedLogs
	)
	select LogId, Source, Operation, ObjectKey, ObjectType, Username, Created, Succeeded, IPAddress, Notes, ApplicationId, TotalCount from OrderedLogs, OrderedLogsCount
	where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
	SET NOCOUNT OFF;
END'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- January 22, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 7;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ApplicationLog_LogId]
	@LogId int
AS
BEGIN
	SELECT AL.* FROM ApplicationLog AL WHERE LogId = @LogId
END'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 03, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 8;

Select @Installed = InstallDate  from SchemaVersion_ApplicationSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ApplicationLog]
	@ApplicationId uniqueidentifier,
	@IsSystemLog bit = 0,
	@Source nvarchar(100) = null,
	@Created datetime = null,
	@Operation nvarchar(50) = null,
	@ObjectType nvarchar(50) = null,
  @StartingRec int,
	@NumRecords int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SystemLogKey nvarchar(100)
	SET @SystemLogKey = ''system''; 

	WITH OrderedLogs AS 
	(
		select *, row_number() over(order by LogId desc) as RowNumber from ApplicationLog 
			where ((@IsSystemLog = 1 AND Source = @SystemLogKey) OR (@IsSystemLog = 0 AND NOT Source = @SystemLogKey))
				AND COALESCE(@Source, Source) = Source 
				AND COALESCE(@Operation, Operation) = Operation 
				AND COALESCE(@ObjectType, ObjectType) = ObjectType 
				AND COALESCE(@Created, Created) <= Created
	),
	OrderedLogsCount(TotalCount) as
	(
		select count(LogId) from OrderedLogs
	)
	select LogId, Source, Operation, ObjectKey, ObjectType, Username, Created, Succeeded, IPAddress, Notes, ApplicationId, TotalCount from OrderedLogs, OrderedLogsCount
	where RowNumber between @StartingRec and @StartingRec + @NumRecords
	SET NOCOUNT OFF;
END'

--## END Schema Patch ##
Insert into SchemaVersion_ApplicationSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


declare @major int = 5
declare @minor int = 0
declare @patch int = 9
if not exists (select 1 from SchemaVersion_ApplicationSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    if OBJECT_ID('dbo.ecf_Application', 'P') is not null drop procedure dbo.ecf_Application
    if OBJECT_ID('dbo.ecf_ApplicationByName', 'P') is not null drop procedure dbo.ecf_ApplicationByName

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[ecf_Application]
    @ApplicationId uniqueidentifier = null,
    @ApplicationName nvarchar(200) = null,
    @IsActive bit = null
AS
begin
    select ApplicationId, Name, IsActive
    from [Application]
    where isnull(@ApplicationId, ApplicationId) = ApplicationId
      and isnull(@ApplicationName, Name) = Name
      and isnull(@IsActive, IsActive) = IsActive
end'

    if not exists (
        select 1
        from sys.key_constraints kc
        join sys.indexes i on kc.parent_object_id = i.object_id and kc.unique_index_id = i.index_id
        join sys.columns c on kc.parent_object_id = c.object_id and c.name = 'Name'
        where kc.parent_object_id = OBJECT_ID('dbo.Application', 'U')
          and exists (select 1 from sys.index_columns ic where ic.object_id = i.object_id and ic.index_id = i.index_id and ic.column_id = c.column_id)
          and not exists (select 1 from sys.index_columns ic where ic.object_id = i.object_id and ic.index_id = i.index_id and ic.column_id != c.column_id))
    begin
        exec dbo.sp_executesql N'alter table [dbo].[Application] add constraint [AX_Application_Name] unique (Name)'
    end

    insert into SchemaVersion_ApplicationSystem (Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(varchar(2),@major) + '.' + CONVERT(varchar(2),@minor) + '.' +  CONVERT(varchar(3),@patch) + ' was applied successfully '
end
go