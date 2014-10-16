/********************************************************************
             ECF5.0_CMS_upgrade.sql
    Mediachase ECF 5.0 CMS Upgrade Script
*********************************************************************/

----2007/11/06 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec sp_ExecuteSQL N'CREATE PROCEDURE [dbo].[main_MenuItemGetBySiteIdLanguageId]
	@SiteId uniqueidentifier,
	@LanguageId int
AS
SELECT t1.MenuItemId, t1.MenuId, t1.CommandText, t1.CommandType, t1.LeftImageUrl, t1.RightImageUrl, t1.IsVisible, t1.IsRoot, t1.[Order], t2.[Text], t2.ToolTip, t2.LanguageId, t1.Outline, t1.OutlineLevel, t1.IsInherits
	FROM main_MenuItem t1 LEFT JOIN main_MenuItem_Resources t2 ON(t1.MenuItemId = t2.MenuItemId  AND (@LanguageId = t2.LanguageId OR @LanguageId = 0))
	INNER JOIN main_Menu M ON M.MenuId = t1.MenuId
	WHERE M.SiteId = @SiteId
	ORDER BY [Order]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---- Dec 3, 2007 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 2;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
execute dbo.sp_executesql @statement = N'ALTER FUNCTION [dbo].[ecf_splitlist]
(
	@List nvarchar(max)
)
RETURNS 
@ParsedList table
(
	Item nvarchar(100)
)
AS
BEGIN
	DECLARE @Item nvarchar(100), @Pos int

	SET @List = LTRIM(RTRIM(@List))+ '',''
	SET @Pos = CHARINDEX('','', @List, 1)

	IF REPLACE(@List, '','', '''') <> ''''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @Item = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
			IF @Item <> ''''
			BEGIN
				INSERT INTO @ParsedList (Item) 
				VALUES (CAST(@Item AS nvarchar(100))) --Use Appropriate conversion
			END
			SET @List = RIGHT(@List, LEN(@List) - @Pos)
			SET @Pos = CHARINDEX('','', @List, 1)

		END
	END	
	RETURN
END' 

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 3;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec sp_ExecuteSQL N'CREATE PROCEDURE [dbo].[cms_Site]
    @ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier = null
AS
BEGIN
	if(LEN(@SiteId) = 0)
		set @SiteId = null

	SELECT S.* from [Site] S
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT G.* from [main_GlobalVariables] G
		INNER JOIN [Site] S ON G.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.SiteId = COALESCE(@SiteId, S.SiteId)
END'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 4;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec sp_ExecuteSQL N'CREATE PROCEDURE [dbo].[cms_menu_LoadBySiteId]
	@SiteId uniqueidentifier
 AS

SELECT M.* FROM main_Menu M WHERE M.[SiteId] = @SiteId

SELECT I.* FROM main_MenuItem I INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[SiteId] = @SiteId

SELECT R.* FROM main_MenuItem_Resources R INNER JOIN main_MenuItem I ON R.MenuItemId = I.MenuItemId INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[SiteId] = @SiteId'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 5;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteLanguage_Site]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteLanguage]'))
begin
 CREATE TABLE [dbo].[SiteLanguage](
 	[SiteId] [uniqueidentifier] NOT NULL,
 	[LanguageCode] [nvarchar](50) NOT NULL
 ) ON [PRIMARY]

 ALTER TABLE [dbo].[SiteLanguage]  WITH CHECK ADD  CONSTRAINT [FK_SiteLanguage_Site] FOREIGN KEY([SiteId])
 REFERENCES [dbo].[Site] ([SiteId])
 ON UPDATE CASCADE
 ON DELETE CASCADE
end

EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[cms_Site]
    @ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier = null
AS
BEGIN
	if(LEN(@SiteId) = 0)
		set @SiteId = null

	SELECT S.* from [Site] S
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT G.* from [main_GlobalVariables] G
		INNER JOIN [Site] S ON G.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT L.* from [SiteLanguage] L
		INNER JOIN [Site] S ON L.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.SiteId = COALESCE(@SiteId, S.SiteId)
END' 

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 6;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
if not exists (select * from syscolumns
  where id=object_id('main_LanguageInfo') and name='ApplicationId')
  ALTER TABLE dbo.main_LanguageInfo ADD ApplicationId uniqueidentifier NULL
  
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 7;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
update dbo.main_LanguageInfo set ApplicationId = (select top 1 ApplicationId from [Application])
ALTER TABLE dbo.main_LanguageInfo ALTER COLUMN ApplicationId uniqueidentifier NOT NULL
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_LoadById] 
	@LangId int
AS
 BEGIN
	SELECT [LangId] as LangId, [LangName] as LangName, [FriendlyName] as FriendlyName, [IsDefault] as IsDefault, ApplicationId
		FROM dbo.main_LanguageInfo
		WHERE @LangId = LangId
 END' 
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_Update] 
	@LangId as int,
	@LangName as varchar(50),
	@FriendlyName as varchar(50),
	@IsDefault as bit,
	@ApplicationId uniqueidentifier
AS
UPDATE dbo.main_LanguageInfo
	SET LangName = @LangName, FriendlyName = @FriendlyName, IsDefault = @IsDefault, ApplicationId = @ApplicationId
	WHERE LangId = @LangId' 
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_GetByLangName] 
	@langName varchar(50),
	@ApplicationId uniqueidentifier
AS
 BEGIN
	SELECT [langId], [langName], [FriendlyName], [IsDefault], ApplicationId
	FROM main_LanguageInfo
	WHERE langName = @langName and ApplicationId = @ApplicationId
 END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_Add]
	@LangName varchar(50),
	@FriendlyName varchar(50),
	@IsDefault bit,
	@ApplicationId uniqueidentifier,
	@retval int output
 AS
INSERT INTO dbo.main_LanguageInfo
	([LangName], [FriendlyName], [IsDefault], ApplicationId) VALUES (@LangName, @FriendlyName, @IsDefault, @ApplicationId)
SET @retval = @@IDENTITY' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfoLoadAll]
	@ApplicationId uniqueidentifier	
 AS
SELECT [LangId],[LangName], [FriendlyName], [IsDefault], ApplicationId
	FROM dbo.main_LanguageInfo
	where ApplicationId = @ApplicationId' 
 
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 8;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.main_GlobalVariables ADD CONSTRAINT
	PK_main_GlobalVariables PRIMARY KEY CLUSTERED 
	(
	GlobalVariableId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- July 19, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 9;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
execute dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_GetDraftStatus] 
	@ApplicationId uniqueidentifier,
	@retval INT OUTPUT
AS
 BEGIN
	DECLARE @WorkFlowId INT

	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE [IsDefault] = 1 AND ApplicationId = @ApplicationId
	SELECT @retval = MIN(StatusId) FROM [WorkFlowStatus]
			WHERE [Weight] > -1 and [WorkFlowId] = @WorkFlowId	

	IF @retval IS NULL
		SET @retval = -1
 END' 

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- July 25, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 10;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
execute dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionAdd2] 
	@PageId int,
	@TemplateId int,
	@VersionNum int,
	@LangId int,
	@StatusId int,
	@Created datetime,
	@CreatorUID uniqueidentifier,
	@Edited datetime,
	@EditorUID uniqueidentifier,
	@StateId int,
	@Comment nvarchar(1024),
	@retval int output
AS
 BEGIN
	declare @statusToInsert int

	set @statusToInsert = @StatusId

	DECLARE @WorkFlowId INT
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE IsDefault = 1

	if(not exists(select null from [WorkflowStatus] where [StatusId]=@StatusId and [WorkflowId]=@WorkflowId)) 
	begin
		-- if status doesn''t exist, insert status with weight 0
		SELECT @statusToInsert = [Weight] FROM [WorkFlowStatus] WHERE ([Weight] = 0) AND ([WorkFlowId] = @WorkFlowId)
	end
	
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, @VersionNum, @LangId, @statusToInsert, @Created, @CreatorUID, @Edited, @EditorUID, @StateId, @Comment)
	set @retval = SCOPE_IDENTITY()
 END' 
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ August 05, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 11;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_FileTreeDelete]
	@PageId int
 AS
--get element order
DECLARE @Order int 
SELECT @Order = [Order] 
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
DECLARE @Count int
--delete element
IF (SELECT [IsFolder] FROM [main_PageTree] WHERE [PageId]  = @PageId) = 1
BEGIN
--FOLDER
--get folder outline
	DECLARE @Outline nvarchar(2048)

	SELECT @Outline = [Outline] 
		FROM [main_PageTree]
		WHERE [PageId] = @PageId

--count files in this folder
	SELECT @Count = COUNT(*) 
		FROM [main_PageTree]
		WHERE ([Outline] = @Outline) OR ([Outline] LIKE @Outline + ''%'')

--delete all child versions
	DELETE FROM [main_PageVersion] 
		WHERE [PageId] in (SELECT [PageId] FROM [main_PageTree] 
				WHERE [Outline] LIKE @Outline + ''%'')

--delete all children
	DELETE FROM [main_PageTree]
		WHERE [Outline] LIKE @Outline + ''%''

-- delete navigation
	DELETE FROM [NavigationCommand]
		WHERE [UrlUID] = @PageId

-- delete page access records
	DELETE FROM [main_PageTreeAccess]
		WHERE [PageId] = @PageId

-- delete page attributes
	DELETE FROM [main_PageAttributes]
		WHERE [PageId] = @PageId

--delete folder
	DELETE FROM [main_PageTree]
		WHERE [PageId] = @PageId
END
ELSE
BEGIN
--SINGLE FILE

-- delete navigation
	DELETE FROM [NavigationCommand]
		WHERE [UrlUID] = @PageId

-- delete page access records
	DELETE FROM [main_PageTreeAccess]
		WHERE [PageId] = @PageId

-- delete page attributes
	DELETE FROM [main_PageAttributes]
		WHERE [PageId] = @PageId

-- Delete all versions of the file
	DELETE FROM [main_PageVersion]
		WHERE [PageId] = @PageId

--delete file
	DELETE FROM [main_PageTree]
		WHERE [PageId] = @PageId

--TODO add settings delete
	SET @Count = 1
END
--UPDATE ORDER
UPDATE [main_PageTree]
	SET [Order] = [Order] -  @Count
	WHERE [Order] > @Order' 

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeGetRoot]
	@SiteId uniqueidentifier,
	@retval int output 
 AS
SELECT @retval = [PageId] FROM [main_PageTree] WHERE [OutlineLevel] = 0 and [SiteId] = @SiteId
IF @retval IS NULL
BEGIN
INSERT INTO [main_PageTree]
	([Name],[IsPublic], [IsFolder], [IsDefault], [Outline], [OutlineLevel], [Order], [SiteId]) 
	VALUES
	(''Root'',1,1,0, ''/'', 0, 0, @SiteId)
SET @retval = SCOPE_IDENTITY()
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_LoadById]
	@MenuId int
 AS
SELECT M.* FROM main_Menu M WHERE M.[MenuId] = @MenuId

SELECT I.* FROM main_MenuItem I INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[MenuId] = @MenuId

SELECT R.* FROM main_MenuItem_Resources R INNER JOIN main_MenuItem I ON R.MenuItemId = I.MenuItemId INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[MenuId] = @MenuId'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_LoadByMenuItemId]
	@MenuItemId int
AS
SELECT M.* FROM main_Menu M 
INNER JOIN main_MenuItem I ON M.[MenuId]=I.[MenuId]
WHERE I.[MenuItemId] = @MenuItemId

SELECT I.* FROM main_MenuItem I WHERE I.[MenuItemId] = @MenuItemId

SELECT R.* FROM main_MenuItem_Resources R 
INNER JOIN main_MenuItem I ON R.MenuItemId = I.MenuItemId 
WHERE I.[MenuItemId] = @MenuItemId'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ August 06, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 12;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_PageVersionDelete] 
	@PageVersionId int
AS
 BEGIN
	DELETE FROM [main_PageVersion] WHERE [VersionId] = @PageVersionId
 END'

exec dbo.sp_executesql @statement = N'CREATE TRIGGER [main_PageVersion_DeleteTrigger]
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

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_FileTreeDelete]
	@PageId int
 AS
-- get siteId
declare @SiteId uniqueidentifier
set @SiteId=(SELECT [SiteId] FROM [main_PageTree] WHERE [PageId] = @PageId)
--get element order
DECLARE @Order int 
SELECT @Order = [Order] 
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
--print ''pageid=''+cast(@PageId as nvarchar(10))+''  order=''+cast(@order as nvarchar(10))
DECLARE @Count int
--delete element
IF (SELECT [IsFolder] FROM [main_PageTree] WHERE [PageId]  = @PageId) = 1
BEGIN
--FOLDER
--get folder outline
	DECLARE @Outline nvarchar(2048)

	SELECT @Outline = [Outline] 
		FROM [main_PageTree]
		WHERE [PageId] = @PageId

	--print ''outline=''+cast(@outline as nvarchar(10))

--count files in this folder
	SELECT @Count = COUNT(*) 
		FROM [main_PageTree]
		WHERE ([Outline] = @Outline) OR ([Outline] LIKE @Outline + ''%'') AND [SiteId]=@SiteId

--delete all child versions
	DELETE FROM [main_PageVersion] 
		WHERE [PageId] in (SELECT [PageId] FROM [main_PageTree] 
				WHERE ([Outline] LIKE @Outline + ''%'') AND [SiteId]=@SiteId)

--delete all children
	DECLARE @ChildPageId int
	DECLARE @CurrentOutlineLevel int
	SET @CurrentOutlineLevel = (SELECT [OutlineLevel] FROM [main_PageTree] WHERE [PageId]=@PageId)
	--print ''@CurrentOutlineLevel=''+cast(@CurrentOutlineLevel as nvarchar(10))
	WHILE EXISTS(SELECT null FROM [main_PageTree] WHERE ([Outline] LIKE @Outline + ''%'') AND ([OutlineLevel]=@CurrentOutlineLevel+1) AND [SiteId]=@SiteId)
	BEGIN
		SET @ChildPageId = (SELECT TOP 1 [PageId] FROM [main_PageTree] WHERE ([Outline] LIKE @Outline + ''%'') AND ([OutlineLevel]=@CurrentOutlineLevel+1) AND [SiteId]=@SiteId)
		--print ''@ChildPageId=''+cast(@ChildPageId as nvarchar(10))
		exec [main_FileTreeDelete] @ChildPageId
	END

-- delete navigation
	DELETE FROM [NavigationCommand]
		WHERE [UrlUID] = @PageId

-- delete page access records
	DELETE FROM [main_PageTreeAccess]
		WHERE [PageId] = @PageId

-- delete page attributes
	DELETE FROM [main_PageAttributes]
		WHERE [PageId] = @PageId

--delete folder
	DELETE FROM [main_PageTree]
		WHERE [PageId] = @PageId
END
ELSE
BEGIN
--SINGLE FILE

	--DECLARE @PageOutline nvarchar(200)
	--SELECT @PageOutline = [Outline] FROM [main_PageTree] WHERE [PageId] = @PageId
	--print ''deleting page ''+@PageOutline
	
-- delete navigation
	DELETE FROM [NavigationCommand]
		WHERE [UrlUID] = @PageId

-- delete page access records
	DELETE FROM [main_PageTreeAccess]
		WHERE [PageId] = @PageId

-- delete page attributes
	DELETE FROM [main_PageAttributes]
		WHERE [PageId] = @PageId

-- Delete all versions of the file
	DELETE FROM [main_PageVersion]
		WHERE [PageId] = @PageId

--delete file
	DELETE FROM [main_PageTree]
		WHERE [PageId] = @PageId

--TODO add settings delete
	SET @Count = 1
END
--UPDATE ORDER
UPDATE [main_PageTree]
	SET [Order] = [Order] -  @Count
	WHERE [Order] > @Order AND [SiteId]=@SiteId'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeAdd]
	@Name nvarchar(250),
	@IsPublic bit,
	@IsFolder bit,
	@IsDefault bit,
	@MasterPage nvarchar(256),
--	@TemplateId int,
--	@CreatorUID uniqueidentifier,
--	@LangId int,
--	@IsSecurityInherits bit,
	@SiteId uniqueidentifier,
	@retval int output 
 AS
--add new element to root
DECLARE @MaxOrder int
SELECT @MaxOrder = MAX([Order]) 
	FROM dbo.main_PageTree 
--
IF @MaxOrder IS NULL
	SET @MaxOrder = -1
IF @IsFolder = 1
BEGIN
INSERT INTO dbo.main_PageTree
	([Name],[IsPublic], [IsFolder], [IsDefault], [Outline], [OutlineLevel], [Order], [MasterPage], [SiteId]) VALUES
	(@Name, @IsPublic, @IsFolder, @IsDefault, CAST(''/''+@Name+''/''  AS NVARCHAR(2048)), 1, @MaxOrder + 1, @MasterPage, @SiteId)
	SET @retval = SCOPE_IDENTITY()
END
ELSE
BEGIN
INSERT INTO dbo.main_PageTree
	([Name],[IsPublic], [IsFolder], [IsDefault], [Outline], [OutlineLevel], [Order], [MasterPage], [SiteId]) VALUES
	(@Name, @IsPublic, @IsFolder, @IsDefault, CAST(''/''+@Name  AS NVARCHAR(2048)), 1, @MaxOrder + 1, @MasterPage, @SiteId)
	SET @retval = SCOPE_IDENTITY()
-- Create new version (1st version) of the page
--INSERT INTO dbo.main_PageVersion
--	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID]) VALUES
--	(@retval, @TemplateId, 0, @LangId, 0, GETDATE(), @CreatorUID)
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeUpdate]
	@PageId int,
	@Name nvarchar(250),
	@IsPublic bit,
	@IsFolder bit,
	@IsDefault bit,
	@MasterPage nvarchar(256),
	@SiteId uniqueidentifier
 AS
DECLARE @OutlineOld nvarchar(2048)
DECLARE @OutlineNew nvarchar(2048)
DECLARE @NameOld nvarchar(250)
--get old Outline
SELECT @OutlineOld = [Outline], @NameOld = [Name]
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
IF @NameOld <> @Name
BEGIN
--exclude old file name 
SET @OutlineNew = REVERSE(@OutlineOld)
PRINT @OutlineNew
SET @OutlineNew = SUBSTRING(@OutlineNew,2,LEN(@OutlineNew) )
PRINT @OutlineNew
SET @OutlineNew = SUBSTRING(@OutlineNew,CHARINDEX(''/'',@OutlineNew) ,LEN(@OutlineNew) - LEN(@NameOld) + 1)
SET @OutlineNew = REVERSE(@OutlineNew)
--finish new outline
SET @OutlineNew = @OutlineNew + @Name
IF (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @PageId) = 1
	SET @OutlineNew = @OutlineNew + ''/''
--replace old outline and update
UPDATE dbo.main_PageTree 
	SET 
	[Name] = @Name,
	[Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew),
	[IsPublic] = @IsPublic,
	[IsDefault] = @IsDefault,
	[MasterPage] = @MasterPage,
	[SiteId] = @SiteId
	WHERE ([PageId] = @PageId) 
--replace old outline in child outline
UPDATE dbo.main_PageTree 
	SET [Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew)
	WHERE ([Outline] LIKE @OutlineOld + ''%'') AND [SiteId]=@SiteId
END
ELSE
BEGIN
UPDATE dbo.main_PageTree 
	SET 
	[IsPublic] = @IsPublic,
	[IsDefault] = @IsDefault,
	[MasterPage] = @MasterPage,
	[SiteId] = @SiteId
	WHERE ([PageId] = @PageId)
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_FileTreeMoveTo] 
	@PageId int,
	@NewParentId int
AS

-- get siteId
DECLARE @SiteId uniqueidentifier
SET @SiteId = (SELECT [SiteId] FROM dbo.main_PageTree WHERE [PageId] = @NewParentId)

DECLARE @Count int 
DECLARE @MaxOrder int
DECLARE @OutlineOld nvarchar(2048)
--if parent IsFolder = 1 - all well
IF (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @NewParentId) = 1 
BEGIN
--get main element outline
SELECT @OutlineOld = [Outline]
	FROM dbo.main_PageTree
	WHERE ([PageId] = @PageId) 
--get element count
SELECT @Count = COUNT(*)
	FROM dbo.main_PageTree
	WHERE ([PageId] = @PageId) OR ([Outline] LIKE @outlineOld + ''%'' AND [SiteId]=@SiteId)
--get max order
SELECT @MaxOrder =MAX([Order])
	FROM dbo.main_PageTree
	WHERE ([PageId] = @PageId) OR ([Outline] LIKE @outlineOld + ''%'' AND [SiteId]=@SiteId)
--update lowest element order
UPDATE dbo.main_PageTree
	SET [Order] = [Order] - @Count
	WHERE [Order] > @MaxOrder AND [SiteId]=@SiteId
--get parent order
DECLARE @OrderPar int 
SELECT @OrderPar = [Order]
	FROM dbo.main_PageTree
	WHERE [PageId] = @NewParentId
--update lowest element order
UPDATE dbo.main_PageTree
	SET [Order] = [Order] + @Count
	WHERE [Order] > @OrderPar AND [SiteId]=@SiteId
--update outline
DECLARE @OutlineNew nvarchar(2048)
SELECT @OutlineNew = [Outline] 
	FROM dbo.main_PageTree
	WHERE [PageId] = @NewParentId
SELECT @OutlineNew = @OutlineNew + [Name]
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
IF  (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @PageId) = 1 
	SET @OutlineNew = @OutlineNew + ''/''
UPDATE dbo.main_PageTree
	SET [Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew)
	WHERE ([PageId] = @PageId) OR ([Outline] LIKE @OutlineOld + ''%'' AND [SiteId]=@SiteId)
--update order
DECLARE @FirstOrder int
SELECT @FirstOrder = [Order] - 1
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
UPDATE dbo.main_PageTree
	SET [Order] = [Order] - @FirstOrder + @OrderPar
	WHERE ([PageId] = @PageId) OR ([Outline] LIKE @OutlineNew + ''%'' AND [SiteId]=@SiteId)
--update outline level
DECLARE @ParLevel int
SELECT @ParLevel = [OutlineLevel]
	FROM dbo.main_PageTree
	WHERE [PageId] = @NewParentId
DECLARE @FirstLevel int
SELECT @FirstLevel = [OutlineLevel] - 1
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
UPDATE dbo.main_PageTree
	SET [OutlineLevel] = [OutlineLevel] - @FirstLevel + @ParLevel
	WHERE ([PageId] = @PageId) OR ([Outline] LIKE @OutlineNew + ''%'' AND [SiteId]=@SiteId)
END'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ August 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 13;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetContentSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ November 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 14;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_MenuItemAdd]
	@MenuId int,
	@CommandText nvarchar(1024) = '''',
	@CommandType int = 0,
	@Text nvarchar(250) = ''Mediachase CMS'',
	@LeftImageUrl nvarchar(1024) = NULL,
	@RightImageUrl nvarchar(1024) = NULL,
	@IsVisible bit = 1,
	@IsInherits bit = 0,
	@Order int = 0,
	@retval int output
AS
BEGIN
--get menu item [Outline]
DECLARE @Outline  nvarchar(1024)
SELECT @Outline = [Outline]  + CAST([MenuItemId] AS NVARCHAR(2048)) + ''.''
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId AND [IsRoot] = 1
--append item to bottom
INSERT INTO dbo.main_MenuItem
	([MenuId],[CommandText],[CommandType],[Text],[LeftImageUrl],[RightImageUrl],[IsVisible],[IsInherits],[Order],[Outline],[OutlineLevel], [IsRoot])
	VALUES
	(@MenuId, @CommandText, @CommandType, @Text, @LeftImageUrl, @RightImageUrl, @IsVisible, @IsInherits, @Order, @Outline, 1, 0 )
SET @retval = SCOPE_IDENTITY()
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_MenuItemUpdate]
	@MenuItemId int,
	@CommandText nvarchar(1024) = '''',
	@CommandType int = 0,
	@Text nvarchar(250) = ''Mediachase CMS'',
	@LeftImageUrl nvarchar(1024) = NULL,
	@RightImageUrl nvarchar(1024) = NULL,
	@IsVisible bit = 1,
	@IsInherits bit = 0,
	@Order int = 0
AS
	UPDATE dbo.main_MenuItem
	SET
		[CommandText] = @CommandText,
		[CommandType] = @CommandType,
		[Text] = @Text,
		[LeftImageUrl] = @LeftImageUrl,
		[RightImageUrl] = @RightImageUrl,
		[IsVisible] = @IsVisible,
		[IsInherits] = @IsInherits,
		[Order] = @Order
	WHERE [MenuItemId] = @MenuItemId'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemUpdateSortOrder]
	@MenuItemId int,
	@Order int = 0
AS
	UPDATE dbo.main_MenuItem
	SET 
		[Order] = @Order
	WHERE [MenuItemId] = @MenuItemId'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_MenuItemMoveTo]
	@MenuItemId int,
	@TargetMenuItemId int,
	@MoveToMode int
AS
--  1 moved item will be the first among the siblings
--  2 moved item will be the last among the siblings
--  3 sort order will not be changed

if (@MenuItemId = @TargetMenuItemId)
	return

--get start item outline
declare @Outline nvarchar(2048)
select @Outline = [Outline] + cast([MenuItemId] as nvarchar(2048)) + ''.''
	from dbo.main_MenuItem
	where [MenuItemId] = @MenuItemId

--get start item order
declare @CurrentOrder int
select @CurrentOrder = [Order] from dbo.main_MenuItem where [MenuItemId]  = @MenuItemId

--get target outline
declare @TargetOutline nvarchar(2048)
select @TargetOutline = [Outline] + cast([MenuItemId] as nvarchar(2048)) + ''.''
	from dbo.main_MenuItem
	where [MenuItemId] = @TargetMenuItemId

-- if target is child of a source, generate error
if left(@TargetOutline, len(@Outline)) = @Outline
begin
	RAISERROR(''Cannot move parent to a child.'', 1, 1)
	return
end

-- move item
if @Outline != @TargetOutline
begin
	-- get outline level
	declare @OutlineLevel int
	select @OutlineLevel = [OutlineLevel] from dbo.main_MenuItem
		where [MenuItemId] = @MenuItemId
	
	declare @TargetOutlineLevel int
	select @TargetOutlineLevel = [OutlineLevel] from dbo.main_MenuItem
		where [MenuItemId] = @TargetMenuItemId
	
	--update outline level
	update dbo.main_MenuItem
		set [OutlineLevel] = [OutlineLevel] - @OutlineLevel + @TargetOutlineLevel + 1
		where [Outline] LIKE @Outline + ''%'' OR [MenuItemId] = @MenuItemId 

	-- update outline
	-- item''s outline
	update [main_MenuItem] set [Outline] = @TargetOutline
		where [MenuItemId] = @MenuItemId

	-- children''s outline
	update [main_MenuItem]
		set [Outline] = replace([Outline], @Outline, @TargetOutline + cast(@MenuItemId AS NVARCHAR(2048)) + ''.'')
		where [Outline] like @Outline + ''%''
end

-------------- Update traget order ------------------
declare @TargetOrder int

------------- insert first ----------------
if @MoveToMode = 1
begin
	select @TargetOrder = coalesce(min([Order]), 0) from dbo.main_MenuItem 
		where ([Outline] = @TargetOutline and [MenuItemId] != @MenuItemId and [MenuItemId] != @TargetMenuItemId )

	if (@TargetOrder > 0)
		set @TargetOrder = @TargetOrder - 1

	--update item order
	update [main_MenuItem] set [Order] = @TargetOrder
		where [MenuItemId] = @MenuItemId
END

------------ insert last ----------------
IF @MoveToMode = 2
BEGIN

	select @TargetOrder = coalesce(max([Order]), 0) from dbo.main_MenuItem 
		where ([Outline] = @TargetOutline and [MenuItemId] != @MenuItemId and [MenuItemId] != @TargetMenuItemId )

	if (@TargetOrder < 0)
		set @TargetOrder = 0 
	else
		set @TargetOrder = @TargetOrder + 1

	--update item order
	update [main_MenuItem] set [Order] = @TargetOrder
		where [MenuItemId] = @MenuItemId
END'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ February 10, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 15;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_PageVersionAdd] 
	@PageId int,
	@TemplateId int,
	@LangId int,
--	@StatusId int,
	@CreatorUID uniqueidentifier,
	@StateId int,
	@Comment nvarchar(1024),
	@retval int output
AS
 BEGIN
	DECLARE @WorkFlowId INT 
	DECLARE @WorkFlowStatus INT 
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE IsDefault = 1
	SELECT @WorkFlowStatus = [StatusId] FROM [WorkFlowStatus] WHERE ([Weight] = 0) AND ([WorkFlowId] = @WorkFlowId)
	

	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, 0, @LangId, @WorkFlowStatus, GETUTCDATE(), @CreatorUID, GETUTCDATE(), @CreatorUID, @StateId, @Comment)
	set @retval = SCOPE_IDENTITY()

 END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_PageVersionAddDraft] 
	@PageId int,
	@TemplateId int,
	@LangId int,
	@CreatorUID uniqueidentifier,
	@retval int output
AS
 BEGIN
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, 0, @LangId, -1, GETUTCDATE(), @CreatorUID, GETUTCDATE(), @CreatorUID, 1, N'''')
	set @retval = SCOPE_IDENTITY()
 END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_PageVersionUpdate] 
	@VersionId INT,
	@TemplateId INT,
	@LangId INT,
	@OldStatusId INT,
	@NewStatusId INT,
	@EditorUID UNIQUEIDENTIFIER,
	@StateId INT,
	@Comment NVARCHAR(1024),
	@retval INT OUTPUT
AS
 BEGIN
	DECLARE @PageId INT
	DECLARE @VersionNum INT
	DECLARE @Created DATETIME
	DECLARE @CreatorUID uniqueidentifier

	SELECT @PageId = [PageId], @VersionNum = [VersionNum], @Created = [Created], @CreatorUID = [CreatorUID]
		FROM [dbo].[main_PageVersion]
	WHERE [VersionId] = @VersionId

	-- update old page status
	UPDATE [dbo].[main_PageVersion] SET
		[VersionNum] = @VersionNum + 1,
		[TemplateId] = @TemplateId,
		[StatusId] = @NewStatusId,
		[LangId] = @LangId,
		[Edited] = GETUTCDATE(),
		[EditorUID] = @EditorUID,
		[StateId] = @StateId,
		[Comment] = @Comment
	WHERE [VersionId] = @VersionId

	--create new version of the document
	--INSERT INTO [dbo].[main_PageVersion]
	--([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID]) VALUES
	--(@PageId, @TemplateId, @VersionNum + 1, @LangId, @NewStatusId, @Created, @CreatorUID, GETDATE(), @EditorUID)
	--set @retval = @@identity
	
 END'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ February 27, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 16;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeLoadById] 
	@PageId int
AS
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, [SiteId]
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeLoadByFolderId] 
	@FolderId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @SiteId uniqueidentifier
DECLARE @OutlineLevel int
--get folder outline
SELECT @SiteId = SiteId, @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel]
	FROM dbo.main_PageTree
	WHERE [PageId] = @FolderId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, [SiteId]
	FROM dbo.main_PageTree
	WHERE ([Outline] LIKE @FolderOutline + ''%'') AND ([PageId] != @FolderId)  AND ([OutlineLevel] = @OutlineLevel + 1) AND SiteId = @SiteId
	ORDER BY [Name]'
	
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeLoadByOutline] 
	@Outline nvarchar(2048),
	@SiteId uniqueidentifier
AS
--Get page OR default folder page
IF (SELECT  [IsFolder] FROM dbo.main_PageTree WHERE [Outline] LIKE @Outline and SiteId = @SiteId) = 1 
BEGIN
	DECLARE @FolderOutlineLevel int
	SELECT @FolderOutlineLevel = [OutlineLevel]
		FROM dbo.main_PageTree
		WHERE  [Outline] LIKE @Outline and SiteId = @SiteId
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage 
		FROM dbo.main_PageTree
		WHERE ([Outline] LIKE @Outline+''%'' AND [IsDefault] = 1)  AND ([OutlineLevel] = @FolderOutlineLevel + 1) and SiteId = @SiteId
END
ELSE
BEGIN
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic]
		FROM dbo.main_PageTree
		WHERE ([Outline] LIKE @Outline) and SiteId = @SiteId
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeLoadByOutlineAll] 
	@outline nvarchar(2048),
	@SiteId uniqueidentifier
AS
 begin
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic] , isnull([MasterPage], '''') as MasterPage 
		FROM dbo.main_PageTree
		WHERE ([Outline] LIKE @Outline) and SiteId = @SiteId
 end'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeLoadParent] 
	@PageId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @OutlineLevel int
DECLARE @SiteId uniqueidentifier
--get folder outline
SELECT @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel], @SiteId = SiteId
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, SiteId
	FROM dbo.main_PageTree
	WHERE (@FolderOutline LIKE [Outline] + ''%'')   AND ([OutlineLevel] = @OutlineLevel - 1) and SiteId = @SiteId'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeLoadParentAll] 
	@PageId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @OutlineLevel int
DECLARE @SiteId uniqueidentifier
--get folder outline
SELECT @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel], @SiteId = SiteId
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, SiteId
	FROM dbo.main_PageTree
	WHERE (@FolderOutline LIKE [Outline] + ''%'') AND SiteId = @SiteId
	ORDER BY [OutlineLevel]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ March 02, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 17;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuGetByName]
	@FriendlyName nvarchar(250),
	@SiteId uniqueidentifier
 AS
SELECT [MenuId],[FriendlyName]
	FROM dbo.main_Menu
	WHERE ([FriendlyName] = @FriendlyName) AND ([SiteId] = @SiteId)'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ March 06, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 18;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##

/*  [main_PageState]  */
exec dbo.sp_executesql @statement = N'ALTER TABLE [main_PageState] ADD [ApplicationId] uniqueidentifier NULL'
exec dbo.sp_executesql @statement = N'update [main_PageState] set [ApplicationId] = (select top 1 [ApplicationId] from [Application])'
exec dbo.sp_executesql @statement = N'ALTER TABLE [main_PageState] ALTER COLUMN [ApplicationId] uniqueidentifier NOT NULL'

/*  [main_NavigationItems]  */
exec dbo.sp_executesql @statement = N'ALTER TABLE [NavigationItems] ADD [ApplicationId] uniqueidentifier NULL'
exec dbo.sp_executesql @statement = N'update [NavigationItems] set [ApplicationId] = (select top 1 [ApplicationId] from [Application])'
exec dbo.sp_executesql @statement = N'ALTER TABLE [NavigationItems] ALTER COLUMN [ApplicationId] uniqueidentifier NOT NULL'

/*  [main_Templates] index */
exec dbo.sp_executesql @statement = N'DROP INDEX IX_main_Templates ON [main_Templates]'
exec dbo.sp_executesql @statement = N'CREATE UNIQUE NONCLUSTERED INDEX IX_main_Templates ON [main_Templates]
	(
	Name,
	LanguageCode,
	TemplateType,
	ApplicationId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

/* ---------- Stored Procedures (updating/creating) ------------ */	
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_GlobalVariablesAdd]
	@Key nvarchar(250),
	@Value nvarchar(1024),
	@SiteId uniqueidentifier,
	@retval int output
 AS
INSERT INTO [main_GlobalVariables]
	([KEY],[VALUE], SiteId) VALUES (@Key,@Value, @SiteId)
SET @retval = SCOPE_IDENTITY()'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_LanguageInfo_Add]
	@LangName varchar(50),
	@FriendlyName varchar(50),
	@IsDefault bit,
	@ApplicationId uniqueidentifier,
	@retval int output
 AS
INSERT INTO [main_LanguageInfo]
	([LangName], [FriendlyName], [IsDefault], [ApplicationId]) VALUES (@LangName, @FriendlyName, @IsDefault, @ApplicationId)
SET @retval = SCOPE_IDENTITY()'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_menu_MenuAdd]
	@FriendlyName nvarchar(250),
	@SiteId uniqueidentifier,
	@retval int output
 AS
	INSERT INTO [main_Menu]
		([FriendlyName], [SiteId]) VALUES (@FriendlyName, @SiteId)
	SET @retval = SCOPE_IDENTITY()
	--add new virtual root to main_MenuItem
	INSERT INTO [main_MenuItem]
		([MenuId], [Text], [Order], [Outline], [OutlineLevel], [IsRoot], [IsVisible])
	VALUES 
		(@retval, @FriendlyName, 0, ''.'', 0, 1, 0)'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_NavigationCommandAll]
	@ApplicationId uniqueidentifier
AS
	SELECT NC.[Id], NC.[UrlUID], NC.[ItemId], NC.[Params], NC.[TrigerParam] FROM [NavigationCommand] NC
	INNER JOIN [NavigationItems] NI ON NC.[ItemId]=NI.[ItemId]	
	WHERE NI.[ApplicationId] = @ApplicationId'
	
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_NavigationItemsInsert]
(
	@ItemName nvarchar(256) = NULL,
	@ApplicationId uniqueidentifier,
	@retval int = NULL output
)
AS
	SET NOCOUNT ON

	INSERT INTO [NavigationItems]
	(
		[ItemName],
		[ApplicationId]
	)
	VALUES
	(
		@ItemName,
		@ApplicationId
	)

	SELECT @retval = SCOPE_IDENTITY()

	SET NOCOUNT OFF

	RETURN @@Error'
	
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_NavigationItemsSelectAll]
	@ApplicationId uniqueidentifier
AS	
	SELECT [ItemId], [ItemName], [ApplicationId]
	FROM [NavigationItems]
	WHERE [ApplicationId] = @ApplicationId'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_NavigationItemsSelectByName]
(
	@ApplicationId uniqueidentifier,
	@ItemName nvarchar(256)
)
AS	
	SELECT [ItemId], [ItemName], [ApplicationId] FROM [NavigationItems]
	WHERE 
		[ApplicationId] = @ApplicationId AND 
		[ItemName] = @ItemName'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_NavigationParamsSelectAll]
	@ApplicationId uniqueidentifier
AS
	SELECT NP.[Id], NP.[ItemId], NP.[Name], NP.[Value], NP.[IsRequired] FROM [NavigationParams] NP
	INNER JOIN [NavigationItems] NI ON NP.[ItemId]=NI.[ItemId]	
	WHERE NI.[ApplicationId] = @ApplicationId'
	
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_PageStateGetAll]
	@ApplicationId uniqueidentifier
AS
	SELECT [StateId], [FriendlyName] FROM [main_PageState] 
	WHERE [ApplicationId] = @ApplicationId'
	
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_Workflow_Add] 
	@FriendlyName nvarchar(250),
	@IsDefault bit,
	@ApplicationId uniqueidentifier,
	@retval int output
AS
BEGIN
	INSERT INTO [Workflow] (FriendlyName, IsDefault, ApplicationId)
	VALUES (@FriendlyName, @IsDefault, @ApplicationId)
	SET @retval = SCOPE_IDENTITY()
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_WorkflowStatus_Add]
	@WorkflowId int,
	@Weight int,
	@FriendlyName nvarchar(250),
	@retval int output
AS
BEGIN
	INSERT INTO [WorkflowStatus] ([WorkflowId], [Weight], [FriendlyName])
	VALUES (@WorkflowId, @Weight, @FriendlyName)
	SET @retval = SCOPE_IDENTITY()
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [main_PageTreeAccess_GetAll]
	@SiteId uniqueidentifier
AS
BEGIN
	SELECT PTA.[PageAccessId], PTA.[RoleId], PTA.[PageId] FROM [main_PageTreeAccess] PTA
	INNER JOIN [main_PageTree] PT ON PT.[PageId] = PTA.[PageId]
	WHERE PT.[SiteId] = @SiteId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetAll] 
	@ApplicationId uniqueidentifier
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByRoleId]
	@ApplicationId uniqueidentifier, 
	@RoleId nvarchar(256),
	@EveryoneRoleId nvarchar(256)
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		([RoleId] = @RoleId or [RoleId] = @EveryoneRoleId /* Everyone */)
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByRoleIdStatusId] 
	@ApplicationId uniqueidentifier,
	@RoleId nvarchar(256),
	@StatusId int,
	@EveryoneRoleId nvarchar(256)
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		([RoleId] = @RoleId or [RoleId] = @EveryoneRoleId /*Everyone*/) and 
		WSA.[StatusId] = @StatusId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone] 
	@ApplicationId uniqueidentifier,
	@RoleId nvarchar(256),
	@StatusId int
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		 WSA.[RoleId] = @RoleId and WSA.[StatusId] = @StatusId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByStatusId] 
	@ApplicationId uniqueidentifier,
	@StatusId int
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		WSA.[StatusId] = @StatusId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetNextStatus] 
	@ApplicationId uniqueidentifier,
	@StatusId int
AS
BEGIN
	declare @nextStatusWeight int
	declare @Weight int
	declare @wfId int

	IF @StatusId = -1
		BEGIN		
			SET @Weight = -1
			SELECT @wfId = [WorkFlowId] FROM [Workflow] 
				WHERE [ApplicationId] = @ApplicationId and [IsDefault] = 1
		END
	ELSE
		SELECT @Weight = WS.[Weight], @wfId = WS.[WorkflowId] FROM [WorkflowStatus] WS
		INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
			WHERE W.[ApplicationId] = @ApplicationId and WS.[StatusId] = @StatusId

	SELECT @nextStatusWeight = ISNULL(MIN([Weight]), -1) FROM [WorkflowStatus] WS 
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId and WS.[Weight] > @Weight
	
	SELECT ISNULL(WS.[StatusId], -1) StatusId, RoleId FROM [WorkflowStatus] WS 
	INNER JOIN [WorkflowStatusAccess] A ON WS.[StatusId] = A.[StatusId]
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId and 
			WS.[Weight] = @nextStatusWeight and WS.[WorkflowId] = @wfId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetPrevStatus] 
	@ApplicationId uniqueidentifier,
	@StatusId int
AS
BEGIN
	declare @prevStatusWeight int
	declare @Weight int
	declare @wfId int

	IF @StatusId = -1 
		RETURN

	SELECT @Weight = [Weight], @wfId = WS.[WorkflowId] FROM [WorkflowStatus] WS
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId and [StatusId] = @StatusId

	SELECT @prevStatusWeight = ISNULL(MAX(WS.[Weight]), -1) FROM [WorkflowStatus] WS
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and WS.[Weight] < @Weight and WS.[Weight] > -1

	IF @prevStatusWeight = -1
		RETURN
	
	SELECT ISNULL(WS.[StatusId], -1) StatusId, A.[RoleId] FROM [WorkflowStatus] WS 
	INNER JOIN [WorkflowStatusAccess] A ON WS.[StatusId] = A.[StatusId]
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		WS.[Weight] = @prevStatusWeight and WS.[WorkFlowId] = @wfId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_Add]
	@StatusId int,
	@RoleId nvarchar(256),
	@retval int output
AS
BEGIN
	INSERT INTO [WorkflowStatusAccess] (StatusId, RoleId)
	VALUES (@StatusId, @RoleId)
	SET @retval = SCOPE_IDENTITY()
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_Delete] 
	@StatusAccessId int
AS
BEGIN
	DELETE FROM [WorkflowStatusAccess] WHERE [StatusAccessId] = @StatusAccessId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetById]
	@StatusAccessId int
AS
BEGIN
	SELECT [StatusAccessId], [StatusId], [RoleId] FROM [WorkflowStatusAccess]
		WHERE [StatusAccessId] = @StatusAccessId
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_Update] 
	@StatusAccessId int,
	@StatusId int,
	@RoleId nvarchar(256)
AS
BEGIN
	UPDATE [WorkflowStatusAccess] 
	SET
		[StatusId] = @StatusId,
		[RoleId] = @RoleId
	WHERE [StatusAccessId] = @StatusAccessId
END'

/* ---------- Stored Procedures (removing the ones not used) ------------ */	
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_FileAccessAdd]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_FileAccessDelete]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_FileAccessLoadByFileId]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_FileAccessLoadById]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_FileAccessLoadByPrimaryKeys]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_FileAccessUpdate]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageStatusAdd]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageStatusDelete]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageStatusGetAll]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageStatusGetById]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageAccessAdd]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageAccessCheckAccess]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageAccessDelete]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageAccessUpdate]'
exec dbo.sp_executesql @statement = N'DROP TABLE [main_PageAccess]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_LanguageLoadAll]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageTreeAccess_GetByAll]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [main_PageVersionGetAll]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkFlowStatusAccess_Add]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkFlowStatusAccess_Delete]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetAll]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkFlowStatusAccess_GetById]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetByRoleId]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetByRoleIdStatusId]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetByStatusId]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetNextStatus]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkflowStatusAccess_GetPrevStatus]'
exec dbo.sp_executesql @statement = N'DROP PROCEDURE [WorkFlowStatusAccess_Update]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ March 12, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 19;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_PageVersionAdd] 
	@ApplicationId uniqueidentifier,
	@PageId int,
	@TemplateId int,
	@LangId int,
--	@StatusId int,
	@CreatorUID uniqueidentifier,
	@StateId int,
	@Comment nvarchar(1024),
	@retval int output
AS
 BEGIN
	DECLARE @WorkFlowId INT 
	DECLARE @WorkFlowStatus INT 
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE ApplicationId = @ApplicationId AND IsDefault = 1 
	SELECT @WorkFlowStatus = [StatusId] FROM [WorkFlowStatus] WHERE ([Weight] = 0) AND ([WorkFlowId] = @WorkFlowId)
	
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, 0, @LangId, @WorkFlowStatus, GETUTCDATE(), @CreatorUID, GETUTCDATE(), @CreatorUID, @StateId, @Comment)
	set @retval = SCOPE_IDENTITY()
 END'
 
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_PageVersionAdd2] 
	@ApplicationId uniqueidentifier,
	@PageId int,
	@TemplateId int,
	@VersionNum int,
	@LangId int,
	@StatusId int,
	@Created datetime,
	@CreatorUID uniqueidentifier,
	@Edited datetime,
	@EditorUID uniqueidentifier,
	@StateId int,
	@Comment nvarchar(1024),
	@retval int output
AS
 BEGIN
	declare @statusToInsert int

	set @statusToInsert = @StatusId

	DECLARE @WorkFlowId INT
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE ApplicationId = @ApplicationId AND IsDefault = 1

	if(not exists(select null from [WorkflowStatus] where [StatusId]=@StatusId and [WorkflowId]=@WorkflowId)) 
	begin
		-- if status doesn''t exist, insert status with weight 0
		SELECT @statusToInsert = [Weight] FROM [WorkFlowStatus] WHERE ([Weight] = 0) AND ([WorkFlowId] = @WorkFlowId)
	end
	
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, @VersionNum, @LangId, @statusToInsert, @Created, @CreatorUID, @Edited, @EditorUID, @StateId, @Comment)
	set @retval = SCOPE_IDENTITY()
 END'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------------ March 18, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 20;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_page_PageVersionGetByUserId2] 
	@ApplicationId uniqueidentifier,
	@UserId uniqueidentifier,
	@RoleNames nvarchar(1000)
AS
BEGIN
SELECT  PV.[VersionId], PV.[TemplateId], PV.[VersionNum], PV.[LangId], PV.[StatusId], PV.[Created], PV.[CreatorUID], PV.[Edited], PV.[EditorUID], PV.[StateId], PV.[Comment], PV.[PageId], P.SiteId
	FROM main_PageVersion PV
		INNER JOIN main_PageTree P ON PV.PageId = P.PageId
		INNER JOIN [Site] S ON P.SiteId = S.SiteId 
	WHERE
		S.ApplicationId = @ApplicationId AND 
		PV.StatusId IN (
			SELECT StatusId FROM WorkflowStatusAccess
				WHERE 
					RoleId IN (SELECT Item from cms_splitlist(@RoleNames)) OR
					RoleID = N''Everyone''
			)
UNION	 		 
SELECT  PV.[VersionId], PV.[TemplateId], PV.[VersionNum], PV.[LangId], PV.[StatusId], PV.[Created], PV.[CreatorUID], PV.[Edited], PV.[EditorUID], PV.[StateId], PV.[Comment], PV.[PageId], P.SiteId
		FROM main_PageVersion PV
		INNER JOIN main_PageTree P ON PV.PageId = P.PageId
		INNER JOIN [Site] S ON P.SiteId = S.SiteId
	WHERE 
		S.ApplicationId = @ApplicationId AND
		PV.CreatorUID = @UserId  AND PV.StatusId = -1
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_menu_MenuGetById]
	@MenuId int
AS
SELECT [MenuId],[FriendlyName]
	FROM dbo.main_Menu
	WHERE ([MenuId] = @MenuId)'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- April 10, 2009 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 21;

Select @Installed = InstallDate  from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeUpdate]
	@PageId int,
	@Name nvarchar(250),
	@IsPublic bit,
	@IsFolder bit,
	@IsDefault bit,
	@MasterPage nvarchar(256),
	@SiteId uniqueidentifier
 AS
DECLARE @OutlineOld nvarchar(2048)
DECLARE @OutlineNew nvarchar(2048)
DECLARE @NameOld nvarchar(250)
--get old Outline
SELECT @OutlineOld = [Outline], @NameOld = [Name]
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId

IF @NameOld <> @Name
BEGIN
--exclude old file name 
	SET @OutlineNew = REVERSE(@OutlineOld)
	PRINT @OutlineNew
	SET @OutlineNew = SUBSTRING(@OutlineNew,2,LEN(@OutlineNew) )
	PRINT @OutlineNew
	SET @OutlineNew = SUBSTRING(@OutlineNew,CHARINDEX(''/'',@OutlineNew) ,LEN(@OutlineNew) - LEN(@NameOld) + 1)
	SET @OutlineNew = REVERSE(@OutlineNew)
	--finish new outline
	SET @OutlineNew = @OutlineNew + @Name
	IF (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @PageId) = 1
		SET @OutlineNew = @OutlineNew + ''/''
	--replace old outline and update
	UPDATE dbo.main_PageTree 
		SET 
		[Name] = @Name,
		[Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew),
		[IsPublic] = @IsPublic,
		[IsDefault] = @IsDefault,
		[MasterPage] = @MasterPage,
		[SiteId] = @SiteId
		WHERE ([PageId] = @PageId) 
	--replace old outline in child outline
	UPDATE dbo.main_PageTree 
		SET [Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew)
		WHERE ([Outline] LIKE @OutlineOld + ''%'') AND [SiteId]=@SiteId
END
ELSE
BEGIN
	UPDATE dbo.main_PageTree 
		SET 
		[Name] = @Name,
		[IsPublic] = @IsPublic,
		[IsDefault] = @IsDefault,
		[MasterPage] = @MasterPage,
		[SiteId] = @SiteId
		WHERE ([PageId] = @PageId)
END'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- June 2, 2009 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 22;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [cms_menu_MenuAdd]
	@FriendlyName nvarchar(250),
	@SiteId uniqueidentifier,
	@retval int output
 AS
	INSERT INTO [main_Menu]
		([FriendlyName], [SiteId]) VALUES (@FriendlyName, @SiteId)
	SET @retval = SCOPE_IDENTITY()
	-- add new virtual root to main_MenuItem
	-- insert default values in all columns
	INSERT INTO [main_MenuItem]
		(
			[MenuId], 
			[CommandText],
			[CommandType],
			[Text], 
			[LeftImageUrl],
			[RightImageUrl],
			[OutlineLevel], 
			[Outline], 
			[IsVisible],
			[IsInherits],
			[IsRoot],
			[Order] 
		)
	VALUES 
		(
			@retval,		-- MenuId
			'''',			-- CommandText
			-1,				-- CommandType
			@FriendlyName,	-- Text
			'''',			-- LeftImageUrl
			'''',			-- RightImageUrl
			0,				-- OutlineLevel
			''.'',			-- Outline
			0,				-- IsVisible
			0,				-- IsInherits
			1,				-- IsRoot
			0				-- Order
		)'
		
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- June 22, 2009 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 23;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_Site]
    @ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier = null
AS
BEGIN
	if(LEN(@SiteId) = 0)
		set @SiteId = null

	SELECT S.* from [Site] S
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.IsActive = 1 AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT G.* from [main_GlobalVariables] G
		INNER JOIN [Site] S ON G.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.IsActive = 1 AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT L.* from [SiteLanguage] L
		INNER JOIN [Site] S ON L.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND 
		S.IsActive = 1 AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)
END'
		
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- July 03, 2009 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 24;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_Site]
    @ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier = null,
	@ReturnInactive bit = 0
AS
BEGIN
	if(LEN(@SiteId) = 0)
		set @SiteId = null

	SELECT S.* from [Site] S
	WHERE
		S.ApplicationId = @ApplicationId AND
		(S.IsActive = 1 or @ReturnInactive = 1) AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT G.* from [main_GlobalVariables] G
		INNER JOIN [Site] S ON G.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND
		(S.IsActive = 1 or @ReturnInactive = 1) AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT L.* from [SiteLanguage] L
		INNER JOIN [Site] S ON L.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND 
		(S.IsActive = 1 or @ReturnInactive = 1) AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)
END'
		
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 10, 2009 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 25;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_menu_MenuAdd]
	@FriendlyName nvarchar(250),
	@SiteId uniqueidentifier,
	@retval int output
 AS
	INSERT INTO [main_Menu]
		([FriendlyName], [SiteId]) VALUES (@FriendlyName, @SiteId)
	SET @retval = SCOPE_IDENTITY()
	--add new virtual root to main_MenuItem
	INSERT INTO [main_MenuItem]
		([MenuId], [CommandType], [Text], [Order], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [IsInherits])
	VALUES 
		(@retval, 0, @FriendlyName, 0, ''.'', 0, 1, 0, 0)'
		
--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- October 29, 2009 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 26;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER TABLE [main_LanguageInfo] ALTER COLUMN [LangName] nvarchar(50) NOT NULL'
exec dbo.sp_executesql @statement = N'ALTER TABLE [main_LanguageInfo] ALTER COLUMN [FriendlyName] nvarchar(50) NULL'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_Add]
	@LangName nvarchar(50),
	@FriendlyName nvarchar(50),
	@IsDefault bit,
	@ApplicationId uniqueidentifier,
	@retval int output
 AS
INSERT INTO [main_LanguageInfo]
	([LangName], [FriendlyName], [IsDefault], [ApplicationId]) VALUES (@LangName, @FriendlyName, @IsDefault, @ApplicationId)
SET @retval = SCOPE_IDENTITY()'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_GetByLangName] 
	@langName nvarchar(50),
	@ApplicationId uniqueidentifier
AS
 BEGIN
	SELECT [langId], [langName], [FriendlyName], [IsDefault], ApplicationId
	FROM main_LanguageInfo
	WHERE langName = @langName and ApplicationId = @ApplicationId
 END'
 
 exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_LanguageInfo_Update] 
	@LangId as int,
	@LangName as nvarchar(50),
	@FriendlyName as nvarchar(50),
	@IsDefault as bit,
	@ApplicationId uniqueidentifier
AS
UPDATE dbo.main_LanguageInfo
	SET LangName = @LangName, FriendlyName = @FriendlyName, IsDefault = @IsDefault, ApplicationId = @ApplicationId
	WHERE LangId = @LangId'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- May 18, 2010 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 27;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_FileTreeMoveTo] 
	@PageId int,
	@NewParentId int
AS

DECLARE @Count int, @MaxOrder int
DECLARE @OutlineOld nvarchar(2048), @OutlineNew nvarchar(2048)

DECLARE @SiteId uniqueidentifier
DECLARE @OrderPar int, @FirstOrder int, @ParLevel int, @FirstLevel int

--if parent IsFolder = 1 - proceed
IF (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @NewParentId) = 1 
BEGIN

	-- get siteId, parent Order, parent outline
	SELECT @SiteId = [SiteId], @OrderPar = [Order], @OutlineNew = [Outline], @ParLevel = [OutlineLevel] 
		FROM dbo.main_PageTree WHERE [PageId] = @NewParentId

	-- if @PageId specified the page, move only this page; otherwise it''s a folder it''ll be moved with all its pages (by outline)
	-- @useOutline is used to determine whether to move only the page or the whole folder
	declare @useOutline bit
	select @useOutline = [IsFolder], @OutlineOld = [Outline], 
			@OutlineNew = case [IsFolder]
							when 1 then @OutlineNew + [Name] + ''/''
							else @OutlineNew + [Name]
						  end,
			@FirstOrder = [Order] - 1,
			@FirstLevel = [OutlineLevel] - 1
		from dbo.[main_PageTree] 
			where [PageId] = @PageId

	set @useOutline = coalesce(@useOutline, 0)

	--get element count
	SELECT @Count = COUNT(*), @MaxOrder = MAX([Order]) FROM dbo.main_PageTree
		WHERE ([PageId] = @PageId) OR (@useOutline=1 AND ([Outline] LIKE @outlineOld + ''%'' AND [SiteId]=@SiteId))

	--update order
	UPDATE dbo.main_PageTree
		SET [Order] = [Order] - @Count
			WHERE [Order] > @MaxOrder AND [SiteId]=@SiteId	
	UPDATE dbo.main_PageTree
		SET [Order] = [Order] + @Count
		WHERE [Order] > @OrderPar AND [SiteId]=@SiteId

	--update outline, order, outline level
	UPDATE dbo.main_PageTree
		SET [Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew),
			[Order] = [Order] - @FirstOrder + @OrderPar,
			[OutlineLevel] = [OutlineLevel] - @FirstLevel + @ParLevel
		WHERE ([PageId] = @PageId) OR (@useOutline=1 AND ([Outline] LIKE @OutlineOld + ''%'' AND [SiteId]=@SiteId))
END'
 
 exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[cms_fs_FileTreeAdd]
	@Name nvarchar(250),
	@IsPublic bit,
	@IsFolder bit,
	@IsDefault bit,
	@MasterPage nvarchar(256),
	@SiteId uniqueidentifier,
	@retval int output 
 AS
-- get maxOrder
DECLARE @MaxOrder int
SELECT @MaxOrder = MAX([Order]) FROM dbo.main_PageTree 
	WHERE [SiteId]=@SiteId
SET @MaxOrder = COALESCE(@MaxOrder, -1)
--add new element to root
INSERT INTO dbo.[main_PageTree]
	([Name],[IsPublic], [IsFolder], [IsDefault], [Outline], [OutlineLevel], [Order], [MasterPage], [SiteId]) 
	VALUES
	(@Name, @IsPublic, @IsFolder, @IsDefault, 
		case @IsFolder
				when 1 then CAST(''/''+@Name+''/'' AS NVARCHAR(2048))
				else CAST(''/''+@Name AS NVARCHAR(2048))
			   end,
		1, @MaxOrder + 1, @MasterPage, @SiteId)
SET @retval = SCOPE_IDENTITY()'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- June 4, 2010 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 28;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_MenuItemDelete]
	@MenuItemId int
 AS
--get menu id
DECLARE @MenuId int
SELECT @MenuId = MenuId
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
--get element order
DECLARE @OrderFirst int
SELECT @OrderFirst = [Order]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
--get outline
DECLARE @Outline nvarchar(2048)
SELECT @Outline = [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) +''.''
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
--get count of items to remove (menu item and its children)
DECLARE @ItemCount int
SELECT @ItemCount = COUNT(*) + 1
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId 
		AND [Outline] LIKE @Outline +''%''
--preserve order for remaining menu items
--remove menu item and its children
DELETE FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId 
		OR [Outline] LIKE @Outline + ''%''
'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '


END
GO

-------------------- February 8th, 2012 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 29;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_main_PageVersion_main_LanguageInfo]'') AND parent_object_id = OBJECT_ID(N''[dbo].[main_PageVersion]''))
ALTER TABLE [dbo].[main_PageVersion]  WITH NOCHECK ADD  CONSTRAINT [FK_main_PageVersion_main_LanguageInfo] FOREIGN KEY([LangId])
REFERENCES [main_LanguageInfo] ([LangId])
ON DELETE CASCADE
ALTER TABLE [dbo].[main_PageVersion] CHECK CONSTRAINT [FK_main_PageVersion_main_LanguageInfo]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


-------------------- February 22nd, 2012 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 30;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_main_WorkflowStatus_main_Workflow]'') AND parent_object_id = OBJECT_ID(N''[dbo].[WorkflowStatus]''))
ALTER TABLE [dbo].[WorkflowStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_main_WorkflowStatus_main_Workflow] FOREIGN KEY([WorkflowId])
REFERENCES [Workflow] ([WorkflowId])
ON DELETE CASCADE
ALTER TABLE [dbo].[WorkflowStatus] CHECK CONSTRAINT [FK_main_WorkflowStatus_main_Workflow]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


-------------------- February 23rd, 2012 --------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 31;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_MenuItemAdd]
	@MenuId int,
	@CommandText nvarchar(1024) = '''',
	@CommandType int = 0,
	@Text nvarchar(250) = ''Mediachase CMS'',
	@LeftImageUrl nvarchar(1024) = NULL,
	@RightImageUrl nvarchar(1024) = NULL,
	@IsVisible bit = 1,
	@IsInherits bit = 0,
	@Order int = 0,
	@retval int output
AS
BEGIN
--get menu item [Outline]
DECLARE @Outline  nvarchar(1024)
SELECT @Outline = [Outline]  + CAST([MenuItemId] AS NVARCHAR(2048)) + ''.''
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId AND [IsRoot] = 1
--append item to bottom
INSERT INTO dbo.main_MenuItem
	([MenuId],[CommandText],[CommandType],[Text],[LeftImageUrl],[RightImageUrl],[IsVisible],[IsInherits],[Order],[Outline],[OutlineLevel], [IsRoot])
	VALUES
	(@MenuId, @CommandText, @CommandType, @Text, @LeftImageUrl, @RightImageUrl, @IsVisible, @IsInherits, @Order, @Outline, 1, 0 )
SET @retval = SCOPE_IDENTITY()
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[main_MenuItemUpdate]
	@MenuItemId int,
	@CommandText nvarchar(1024) = '''',
	@CommandType int = 0,
	@Text nvarchar(250) = ''Mediachase CMS'',
	@LeftImageUrl nvarchar(1024) = NULL,
	@RightImageUrl nvarchar(1024) = NULL,
	@IsVisible bit = 1,
	@IsInherits bit = 0,
	@Order int = 0
AS
	UPDATE dbo.main_MenuItem
	SET
		[CommandText] = @CommandText,
		[CommandType] = @CommandType,
		[Text] = @Text,
		[LeftImageUrl] = @LeftImageUrl,
		[RightImageUrl] = @RightImageUrl,
		[IsVisible] = @IsVisible,
		[IsInherits] = @IsInherits,
		[Order] = @Order
	WHERE [MenuItemId] = @MenuItemId' 
--## END Schema Patch ##

Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 32;

Select @Installed = InstallDate from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_main_WorkflowStatusAccess_main_WorkflowStatus]'') AND parent_object_id = OBJECT_ID(N''[dbo].[WorkflowStatusAccess]''))
ALTER TABLE [dbo].[WorkflowStatusAccess]  WITH NOCHECK ADD  CONSTRAINT [FK_main_WorkflowStatusAccess_main_WorkflowStatus] FOREIGN KEY([StatusId])
REFERENCES [WorkflowStatus] ([StatusId])
ON DELETE CASCADE
ALTER TABLE [dbo].[WorkflowStatusAccess] CHECK CONSTRAINT [FK_main_WorkflowStatusAccess_main_WorkflowStatus]'

--## END Schema Patch ##
Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

declare @major int = 5, @minor int = 0, @patch int = 33
if not exists (select 1 from SchemaVersion where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @sql nvarchar(4000)
    declare procedure_drops cursor local for
        select 'drop procedure [' + s.name + '].[' + REPLACE(o.name, ']', ']]') + ']'
        from sys.schemas s
        join sys.objects o on s.schema_id = o.schema_id
        where o.type = 'P' 
          and o.name in (
            'dps_TemporaryStorage_Add', 
            'dps_TemporaryStorage_GetById', 
            'dps_TemporaryStorage_GetByPageVersionId', 
            'dps_TemporaryStorage_Update',
            'main_PageVersionUpdate')
    open procedure_drops
    while 1=1
    begin
        fetch next from procedure_drops into @sql
        if @@FETCH_STATUS != 0 break
        exec dbo.sp_executesql @sql
    end
    close procedure_drops

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_Add]
	@PageVersionId as int,
	@Expire as int,
	@PageDocument as image,
	@CreatorUID as uniqueidentifier,
	@retval int output
AS
BEGIN
    declare @utcnow datetime = GETUTCDATE()
    DELETE FROM dps_TemporaryStorage 
    WHERE DATEADD(mi, Expire, Created) < @utcnow

    INSERT INTO dps_TemporaryStorage (PageVersionId, Created, Expire, PageDocument, CreatorUID)
    VALUES (@PageVersionId, @utcnow, @Expire, @PageDocument, @CreatorUID)

    select @retval = @@identity
END'

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_GetById]
	@StorageId as int
AS
BEGIN
    DELETE FROM dps_TemporaryStorage
    WHERE DATEADD(mi, Expire, Created) < GETUTCDATE()

    SELECT StorageId, PageVersionId, Created, Expire, PageDocument, CreatorUID 
    FROM dps_TemporaryStorage 
    WHERE StorageId = @StorageId
END'

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_GetByPageVersionId]
	@PageVersionId as int,
	@CreatorUID as uniqueidentifier
AS
BEGIN
    DELETE FROM dps_TemporaryStorage 
    WHERE DATEADD(mi, Expire, Created) < GETUTCDATE()

    SELECT StorageId, PageVersionId, Created, Expire, PageDocument, CreatorUID 
    FROM dps_TemporaryStorage 
    WHERE PageVersionId = @PageVersionId and CreatorUID=@CreatorUID
END'

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_Update]
	@StorageId as int,
	@PageVersionId as int,
	@Expire as int,
	@PageDocument as image,
	@CreatorUID as uniqueidentifier	
AS
BEGIN
    UPDATE dps_TemporaryStorage 
    SET PageVersionId = @PageVersionId, Created = GETUTCDATE(), Expire = @Expire, PageDocument = @PageDocument, CreatorUID = @CreatorUID
    WHERE StorageId = @StorageId
END' 

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[main_PageVersionUpdate] 
	@VersionId INT,
	@TemplateId INT,
	@LangId INT,
	@OldStatusId INT,
	@NewStatusId INT,
	@EditorUID UNIQUEIDENTIFIER,
	@StateId INT,
	@Comment NVARCHAR(1024),
	@retval INT OUTPUT
AS
BEGIN
	DECLARE @PageId INT
	DECLARE @VersionNum INT
	DECLARE @Created DATETIME
	DECLARE @CreatorUID uniqueidentifier

	SELECT @PageId = [PageId], @VersionNum = [VersionNum], @Created = [Created], @CreatorUID = [CreatorUID]
		FROM [dbo].[main_PageVersion]
	WHERE [VersionId] = @VersionId

	-- update old page status
	UPDATE [dbo].[main_PageVersion] SET
		[VersionNum] = @VersionNum + 1,
		[TemplateId] = @TemplateId,
		[StatusId] = @NewStatusId,
		[LangId] = @LangId,
		[Edited] = GETUTCDATE(),
		[EditorUID] = @EditorUID,
		[StateId] = @StateId,
		[Comment] = @Comment
	WHERE [VersionId] = @VersionId
END'

    insert into SchemaVersion (Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(varchar(2),@major) + '.' + CONVERT(varchar(2),@minor) + '.' +  CONVERT(varchar(3),@patch) + ' was applied successfully '
end
go
