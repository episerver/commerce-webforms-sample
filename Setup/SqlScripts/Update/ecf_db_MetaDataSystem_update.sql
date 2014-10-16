/********************************************************************
             Pre Release Upgrade Script
*********************************************************************/

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


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 1;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
--## Schema Patch ##
-- Just filling in the patch number. All changes from 5.2.1 are in 5.2.2 below.
--## END Schema Patch ##
Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


--------------- June 2, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 2;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
--## Schema Patch ##

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesActivate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesActivate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesActivate]
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesActivate]
AS
BEGIN
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog'';
	
	if (not exists (select * from sys.fulltext_catalogs where name = @CatalogName))
	begin
		set @statement = ''create fulltext catalog '' + @CatalogName
		execute dbo.sp_executesql @statement
	end
END' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]
	@TableName sysname,
	@KeyName sysname,
	@ColumnName sysname,
	@Add bit
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''
	
	declare @CatalogId int
	select @CatalogId = fulltext_catalog_id from sys.fulltext_catalogs where name = @CatalogName

	declare @TableId int	
	select @TableId = OBJECT_ID(@TableName)
	
	if @Add = 1
	begin
		-- Add the column to full text indexing.
		
		if (not exists(select * from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)))
		begin
			-- the table is not indexed. create the index.
			set @statement = ''create fulltext index on ['' + @TableName + ''] key index ['' + @KeyName + ''] on '' + @CatalogName
			execute dbo.sp_executesql @statement
		end
		
		if (not exists(
			select *
			from sys.fulltext_index_columns ftic
			join sys.columns c on ftic.object_id = c.object_id and ftic.column_id = c.column_id
			where c.object_id = OBJECT_ID(@TableName) and c.name = @ColumnName))
		begin
			-- the column is not indexed. add the column to the index.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] add (['' + @ColumnName + ''])''
			execute dbo.sp_executesql @statement
		end
	
		if ((select is_enabled from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)) != 1)
		begin
			-- the index is not enabled.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] enable''
			execute dbo.sp_executesql @statement
		end
		
		if ((select change_tracking_state from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)) != ''A'')
		begin
			-- the index is not in auto mode.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] set change_tracking auto''
			execute dbo.sp_executesql @statement
		end
	end
	else
	begin
		-- Remove the column from full text indexing.
		
		if (exists(
			select *
			from sys.fulltext_index_columns ftic
			join sys.columns c on ftic.object_id = c.object_id and ftic.column_id = c.column_id
			where c.object_id = OBJECT_ID(@TableName) and c.name = @ColumnName))
		begin
			-- the column is indexed. remove the column from the index.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] drop (['' + @ColumnName + ''])''
			execute dbo.sp_executesql @statement
		end
		
		if (not exists(select * from sys.fulltext_index_columns where object_id = OBJECT_ID(@TableName)))
		begin
			-- no columns are indexed on the table. remove the index.
			set @statement = ''drop fulltext index on ['' + @TableName + '']''
			execute dbo.sp_executesql @statement
		end
	end	
end'

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]
	@MetaClassId int,
	@MetaFieldId int,
	@Add bit
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''
		
	declare @TableName nvarchar(256)
	declare @KeyName nvarchar(256)
	declare @ColumnName nvarchar(256)
	select
		@TableName = TableName,
		@KeyName = PrimaryKeyName
	from MetaClass
	where MetaClassId = @MetaClassId
		
	select @ColumnName = Name
	from MetaField
	where MetaFieldId = @MetaFieldId
	  and (@Add = 0 or DataTypeId in (select DataTypeId from MetaDataType where SqlName in (N''char'', N''nchar'', N''varchar'', N''nvarchar'', N''text'', N''ntext'')))
	
	
	if (@TableName is not null and @KeyName is not null and @ColumnName is not null)
	begin
		exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, @KeyName, @ColumnName, @Add
		
		set @TableName = @TableName + ''_Localization''
		set @KeyName = null
		select @KeyName = CONSTRAINT_NAME
		from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where TABLE_NAME = @TableName
		if @KeyName is not null exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, @KeyName, @ColumnName, @Add	
	end
end' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesAddAllFields] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesAddAllFields]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesAddAllFields]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesAddAllFields] 
as
begin
	declare @MetaClassId int
	declare @MetaFieldId int
	declare searchable_fields_cursor cursor local for
		select mcmfr.MetaClassId, mcmfr.MetaFieldId
		from MetaClassMetaFieldRelation mcmfr
		join MetaField mf on mcmfr.MetaFieldId = mf.MetaFieldId
		where (mf.SystemMetaClassId = 0 or mf.SystemMetaClassId = mcmfr.MetaClassId)
	   -- and mf.AllowSearch = 1  ** REMOVED: Adding a meta field always adds it to the index, ignoring AllowSearch.  Removing this check is incorrect, but is consistent with how the system behaved before the fulltext update.

	open searchable_fields_cursor
	fetch next from searchable_fields_cursor into @MetaClassId, @MetaFieldId
	while @@FETCH_STATUS = 0
	begin
		execute dbo.mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 1
		fetch next from searchable_fields_cursor into @MetaClassId, @MetaFieldId
	end
		
	close searchable_fields_cursor
	deallocate searchable_fields_cursor
end' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields] 
as
begin
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	declare @TableName sysname
	declare @ColumnName sysname
	declare indexed_column_cursor cursor local for
		select tabs.name, cols.name
		from sys.fulltext_catalogs ftc 
		join sys.fulltext_indexes fti on fti.fulltext_catalog_id = ftc.fulltext_catalog_id
		join sys.fulltext_index_columns ftic on fti.object_id = ftic.object_id
		join sys.objects tabs on ftic.object_id = tabs.object_id
		join sys.columns cols on ftic.object_id = cols.object_id and ftic.column_id = cols.column_id
		where ftc.name = @CatalogName
		
	open indexed_column_cursor
	fetch next from indexed_column_cursor into @TableName, @ColumnName
	while (@@FETCH_STATUS = 0)
	begin
		exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, '''', @ColumnName, 0
		fetch next from indexed_column_cursor into @TableName, @ColumnName
	end
	
	close indexed_column_cursor
	deallocate indexed_column_cursor
end'

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesDeactivate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesDeactivate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesDeactivate]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesDeactivate]
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''
	
	exec dbo.mdpsp_sys_FullTextQueriesDeleteAllFields
	if (exists(select * from sys.fulltext_catalogs where name = @CatalogName))
	begin	
		set @statement = ''drop fulltext catalog '' + @CatalogName
		execute dbo.sp_executesql @statement
	end
end' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesEnable] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesEnable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesEnable]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesEnable] 
as
begin
	declare @IsFullTextInstalled int
	declare @IsFulltextEnabled int
	select @IsFullTextInstalled = FULLTEXTSERVICEPROPERTY(''IsFullTextInstalled'')
	if (@IsFullTextInstalled = 1) select @IsFulltextEnabled = DatabaseProperty (DB_NAME(DB_ID()), ''IsFulltextEnabled'')
	
	select case when @IsFullTextInstalled = 1 and @IsFulltextEnabled = 1 then 1 else 0 end
end' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''
	
	declare @TableName sysname
	declare fulltext_index_cursor cursor local for
		select o.[name] as TableName
		from sys.fulltext_catalogs c
		join sys.fulltext_indexes i on c.[fulltext_catalog_id] = i.[fulltext_catalog_id]
		join sys.all_objects o on i.[object_id] = o.[object_id]
		where c.[name] = @CatalogName
	
	alter fulltext catalog MetaDataFullTextQueriesCatalog rebuild
	
	open fulltext_index_cursor
	fetch next from fulltext_index_cursor into @TableName
	while (@@FETCH_STATUS = 0)
	begin
		set @statement = ''alter fulltext index on ['' + @TableName + ''] start full population''
		execute dbo.sp_executesql @statement
		
		fetch next from fulltext_index_cursor into @TableName
	end	
	
	close fulltext_index_cursor
	deallocate fulltext_index_cursor	
end' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete] 
AS
begin
	declare @ecf5_job_name nvarchar(100)
	set @ecf5_job_name = N''ECF50_''+db_name()

	if (exists(select job_id from msdb.dbo.sysjobs where name = @ecf5_job_name))
	begin
		exec msdb.dbo.sp_delete_job @job_name = @ecf5_job_name
	end
end' 

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate] 
AS
begin
    -- the scheduled task is no longer be needed.
	exec dbo.mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete
end' 

exec [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]

exec [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]

exec [dbo].[mdpsp_sys_FullTextQueriesAddAllFields]

--## END Schema Patch ##
Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


--------------- June 2, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 3;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
--## Schema Patch ##
/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]
	@TableName sysname,
	@KeyName sysname,
	@ColumnName sysname,
	@Add bit
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''
	
	declare @CatalogId int
	select @CatalogId = fulltext_catalog_id from sys.fulltext_catalogs where name = @CatalogName

	if @Add = 1
	begin
		-- Add the column to full text indexing.
		
		if (not exists(select * from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)))
		begin
			-- the table is not indexed. create the index.
			set @statement = ''create fulltext index on ['' + @TableName + ''] key index ['' + @KeyName + ''] on '' + @CatalogName
			execute dbo.sp_executesql @statement
		end
		
		if (not exists(
			select *
			from sys.fulltext_index_columns ftic
			join sys.columns c on ftic.object_id = c.object_id and ftic.column_id = c.column_id
			where c.object_id = OBJECT_ID(@TableName) and c.name = @ColumnName))
		begin
			-- the column is not indexed. add the column to the index.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] add (['' + @ColumnName + ''])''
			execute dbo.sp_executesql @statement
		end
	
		if ((select is_enabled from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)) != 1)
		begin
			-- the index is not enabled.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] enable''
			execute dbo.sp_executesql @statement
		end
		
		if ((select change_tracking_state from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)) != ''A'')
		begin
			-- the index is not in auto mode.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] set change_tracking auto''
			execute dbo.sp_executesql @statement
		end
	end
	else
	begin
		-- Remove the column from full text indexing.
		
		if (exists(
			select *
			from sys.fulltext_index_columns ftic
			join sys.columns c on ftic.object_id = c.object_id and ftic.column_id = c.column_id
			where c.object_id = OBJECT_ID(@TableName) and c.name = @ColumnName))
		begin
			-- the column is indexed. remove the column from the index.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] drop (['' + @ColumnName + ''])''
			execute dbo.sp_executesql @statement
		end
		
		if (exists(select * from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName))
		    and not exists(select * from sys.fulltext_index_columns where object_id = OBJECT_ID(@TableName)))
		begin
			-- no columns are indexed on the table. remove the index.
			set @statement = ''drop fulltext index on ['' + @TableName + '']''
			execute dbo.sp_executesql @statement
		end
	end	
end'

--## END Schema Patch ##
Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-- Default constraint deletion fix.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 4;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_DeleteDContrainByTableAndField] 
	@TableName	NVARCHAR(256),
	@FieldName	NVARCHAR(256)
AS
	SET NOCOUNT ON

	DECLARE @DConstrainName NVARCHAR(256)

	DECLARE DConstrainCursor CURSOR local FOR 
	    select df_constraints.name
	    from sys.objects df_constraints
	    join sys.columns cols on df_constraints.object_id = cols.default_object_id
	    where cols.object_id = OBJECT_ID(@TableName, ''TABLE'')
	      and cols.name = @FieldName

	OPEN DConstrainCursor

	FETCH NEXT FROM DConstrainCursor  INTO @DConstrainName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC(''ALTER TABLE [dbo].['' + @TableName +''] DROP  CONSTRAINT ''+ @DConstrainName)
		--
		FETCH NEXT FROM DConstrainCursor  INTO @DConstrainName
	END

	CLOSE DConstrainCursor
	DEALLOCATE DConstrainCursor' 

--## END Schema Patch ##
Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 5;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
    -- NOTE: this patch is obsolete. all effects are superceded by patch 5.2.13.

    Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 6;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
    -- NOTE: this patch is obsolete. all effects are superceded by patch 5.2.13.

    Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 7;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @sql nvarchar(4000)

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'MetaField' and COLUMN_NAME = 'IsKeyField')
begin
    select @sql = N'alter table dbo.MetaField drop [' + df.name + N']'
    from sys.schemas s
    join sys.objects tabs on s.schema_id = tabs.schema_id
    join sys.columns cols on cols.object_id = tabs.object_id
    join sys.default_constraints df on cols.default_object_id = df.object_id
    where s.name = 'dbo'
      and tabs.name = 'MetaField'
      and cols.name = 'IsKeyField'
    if @sql is not null exec dbo.sp_executesql @sql
    
    set @sql = N'alter table dbo.MetaField drop column IsKeyField'
    exec dbo.sp_executesql @sql
end

set @sql = 'alter table dbo.MetaField add IsKeyField bit not null default (0)'
exec dbo.sp_executesql @sql

set @sql = case when exists ( select 1
            from sys.schemas s
            join sys.objects tabs on tabs.schema_id = s.schema_id
            join sys.triggers tr on tr.parent_id = tabs.object_id
            where s.name = 'dbo' and tabs.name = 'MetaField' and tr.name = 'mdptr_sys_MetaField_IsKeyField')
    then 'alter' else 'create' end + ' trigger dbo.mdptr_sys_MetaField_IsKeyField
on MetaField after insert, update
as
begin
    set nocount on
    if update(SystemMetaClassId)
    begin
        update dst
		set IsKeyField = cast(case when exists(
                select 1
	            from MetaClass mc
	            join INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu on kcu.CONSTRAINT_NAME = mc.PrimaryKeyName and kcu.CONSTRAINT_SCHEMA = ''dbo''
	            where mc.MetaClassId = dst.SystemMetaClassId
	              and kcu.COLUMN_NAME = dst.Name)
	        then 1 else 0 end as bit)
		from MetaField dst
        where dst.MetaFieldId in (select i.MetaFieldId from inserted i)
        -- do not check for actual value change. updates to MetaClass.PrimaryKeyName will fire this
		-- trigger with "update MetaField set SystemMetaClassId=SystemMetaClassId".
    end
end'
exec dbo.sp_executesql @sql

set @sql = case when exists ( select 1
            from sys.schemas s
            join sys.objects tabs on tabs.schema_id = s.schema_id
            join sys.triggers tr on tr.parent_id = tabs.object_id
            where s.name = 'dbo' and tabs.name = 'MetaClass' and tr.name = 'mdptr_sys_MetaClass_PrimaryKeyName')
    then 'alter' else 'create' end + ' trigger dbo.mdptr_sys_MetaClass_PrimaryKeyName
on MetaClass after insert, update
as
begin
    if update(PrimaryKeyName)
    begin
        update MetaField
        set SystemMetaClassId = SystemMetaClassId -- cause mdptr_sys_MetaField_IsKeyField to fire.
        where SystemMetaClassId in (
            select i.MetaClassId
            from inserted i
            left outer join deleted d on i.MetaClassId = d.MetaClassId
            where (d.MetaClassId is null or i.PrimaryKeyName != d.PrimaryKeyName))
    end
end'
exec dbo.sp_executesql @sql
            
set @sql = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'mdpsp_sys_LoadMetaFieldListByMetaClassId')
    then 'alter' else 'create' end +
' procedure [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]
    @MetaClassId int
as
begin
    select 
        mf.[MetaFieldId],
        mf.[Namespace],
        mf.[Name],
        mf.[FriendlyName],
        mf.[Description],
        mf.[SystemMetaClassId],
        mf.[DataTypeId],
        mf.[Length],
        mf.[AllowNulls],
        mf.[SaveHistory],
        mf.[MultiLanguageValue],
        mf.[AllowSearch],
        mf.[Tag],
        mf.[IsEncrypted],
        cfr.[Weight],
        cfr.[Enabled],
        cast(case when mf.SystemMetaClassId = 0 then ROW_NUMBER() over (partition by mf.SystemMetaClassId order by mf.Name)
            else null end as int) as ParameterIndex
    from MetaField mf
    join MetaClassMetaFieldRelation cfr ON cfr.MetaFieldId = mf.MetaFieldId
    where cfr.MetaClassId = @MetaClassId
    order by mf.IsKeyField desc, cfr.[Weight]
end' 
exec dbo.sp_executesql @sql

-- cause the trigger to run on all rows.
update MetaField set SystemMetaClassId = SystemMetaClassId

--## END Schema Patch ##
Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 2;
Set @Patch = 8;
Select @Installed = InstallDate from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch
If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @sql nvarchar(4000)
set @sql = case when exists(select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'mdpsp_sys_HandleMetaClassProcedureOverflow')
	then 'alter' else 'create' end + ' procedure mdpsp_sys_HandleMetaClassProcedureOverflow
    @MetaClassId int = null,
    @MetaFieldId int = null
as
begin
    select
        ProcedureName,
        case when r.ROUTINE_NAME is null then ''create '' else ''alter '' end + ProcedureStatement as ProcedureStatement
    from MetaClassProcedureOverflow mcpo
    left outer join INFORMATION_SCHEMA.ROUTINES r on mcpo.ProcedureName = r.ROUTINE_NAME and r.ROUTINE_SCHEMA = ''dbo''
    where (@MetaClassId is null or mcpo.MetaClassId = @MetaClassId)
      and (@MetaFieldId is null or mcpo.MetaClassId in (select cfr.MetaClassId from MetaClassMetaFieldRelation cfr where cfr.MetaFieldId = @MetaFieldId))
    order by ProcedureName
end'
exec dbo.sp_executesql @sql

set @sql = case when exists(select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'mdpsp_sys_RemoveMetaClassProcedureOverflow')
	then 'alter' else 'create' end + ' procedure mdpsp_sys_RemoveMetaClassProcedureOverflow
    @ProcedureName sysname
as
begin
    delete from MetaClassProcedureOverflow
    where ProcedureName = @ProcedureName
end'
exec dbo.sp_executesql @sql

exec dbo.mdpsp_sys_CreateMetaClassProcedureAll

--## END Schema Patch ##
Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

declare @Major int = 5, @Minor int = 2, @Patch int = 9
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch and InstallDate is not null)
begin	
    -- NOTE: this patch is obsolete. all effects are superceded by patch 5.2.13.

	insert into SchemaVersion_MetaDataSystem (Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GETDATE())
	print 'Schema Patch v' + CONVERT(varchar(2),@Major) + '.' + CONVERT(varchar(2),@Minor) + '.' + CONVERT(varchar(3),@Patch) + ' was applied successfully '
end
go

declare @Major int = 5, @Minor int = 2, @Patch int = 10
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch and InstallDate is not null)
begin
    -- NOTE: this patch is obsolete. all effects are superceded by patch 5.2.13.

	insert into SchemaVersion_MetaDataSystem (Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GETDATE())
	print 'Schema Patch v' + CONVERT(varchar(2),@Major) + '.' + CONVERT(varchar(2),@Minor) + '.' + CONVERT(varchar(3),@Patch) + ' was applied successfully '
end
go


declare @major int = 5
declare @minor int = 2
declare @patch int = 11
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @sql nvarchar(4000)
    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'mdpsp_sys_MetaFieldAllowSearch')
        set @sql = 'alter '
    else
        set @sql = 'create '

    set @sql = @sql + 'procedure dbo.mdpsp_sys_MetaFieldAllowSearch
    @MetaFieldId int,
    @AllowSearch bit,
    @UpdateFullTextIndexes bit
as
begin
    set nocount on

    if not exists (select 1 from MetaField where MetaFieldId = @MetaFieldId)
    begin
        raiserror(''The specified meta field does not exists or is a system field.'', 16,1)
    end
    else
    begin
        update MetaField 
        set AllowSearch = @AllowSearch
        where MetaFieldId = @MetaFieldId

        if @UpdateFullTextIndexes = 1
        begin
            declare @metaClassId int
            declare class_w_search cursor local for
                select mc.MetaClassId 
                from MetaClass mc
                join MetaClassMetaFieldRelation mcmfr on mc.MetaClassId = mcmfr.MetaClassId
                join MetaField mf on mcmfr.MetaFieldId = mf.MetaFieldId
                where mf.MetaFieldId = @MetaFieldId and (mc.IsSystem = 1 or mf.SystemMetaClassId = 0)
            open class_w_search
            while 1=1
            begin
                fetch next from class_w_search into @metaClassId
                if @@FETCH_STATUS != 0 break

                exec dbo.mdpsp_sys_FullTextQueriesFieldUpdate @metaClassId, @MetaFieldId, @AllowSearch
            end
            close class_w_search
            deallocate class_w_search
        end
    end
end'
    exec dbo.sp_executesql @sql

    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'mdpsp_sys_FullTextQueriesUpdateAllFields')
        set @sql = 'alter '
    else
        set @sql = 'create '

    set @sql = @sql + 'procedure dbo.mdpsp_sys_FullTextQueriesUpdateAllFields
as
begin
    declare @metaClassId int, @metaFieldId int, @allowSearch bit
    declare all_fields cursor local for
        select mc.MetaClassId, mf.MetaFieldId, mf.AllowSearch
        from dbo.MetaClass mc
        join dbo.MetaClassMetaFieldRelation mcmfr on mc.MetaClassId = mcmfr.MetaClassId
        join dbo.MetaField mf on mcmfr.MetaFieldId = mf.MetaFieldId
        order by AllowSearch desc, MetaClassId, MetaFieldId
    open all_fields
    while 1=1
    begin
        fetch next from all_fields into @metaClassId, @metaFieldId, @allowSearch
        if @@FETCH_STATUS != 0 break
        
        exec dbo.mdpsp_sys_FullTextQueriesFieldUpdate @metaClassId, @metaFieldId, @allowSearch
    end
    close all_fields
end'

    exec dbo.sp_executesql @sql

    insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go


declare @major int = 5
declare @minor int = 2
declare @patch int = 12
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    -- NOTE: parts of this patch are obsolete. effects of removed portions are supoerceded by patch 5.2.13.

    declare @ddl table (ordering int not null identity(1,1), ddl nvarchar(max))
    
    insert into @ddl (ddl)
    select 'drop procedure [' + ROUTINE_SCHEMA + '].[' + ROUTINE_NAME + ']'
    from INFORMATION_SCHEMA.ROUTINES 
    where ROUTINE_SCHEMA = 'dbo'
      and ROUTINE_NAME in ('mdpsp_sys_HandleMetaClassProcedureOverflow', 'mdpsp_sys_RemoveMetaClassProcedureOverflow')

    insert into @ddl (ddl)
    select 'drop table [' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']'
    from INFORMATION_SCHEMA.TABLES 
    where TABLE_SCHEMA = 'dbo' 
      and TABLE_NAME = 'MetaClassProcedureOverflow'

    declare @ddl_statement nvarchar(max)
    declare ddl_cursor cursor local for select ddl from @ddl order by ordering
    open ddl_cursor
    while 1=1
    begin
        fetch next from ddl_cursor into @ddl_statement
        if @@FETCH_STATUS != 0 break

        exec dbo.sp_executesql @ddl_statement
    end
    close ddl_cursor

    insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go


declare @major int = 5
declare @minor int = 2
declare @patch int = 13
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    set nocount on
    declare @ddl table (ordering int not null identity(1,1), ddl nvarchar(max))

    -- create statements to drop all procedures being dropped or modified
    insert into @ddl (ddl)
    select 'drop procedure [' + s.name + '].[' + sp.name + ']'
    from sys.schemas s
    join sys.objects sp on s.schema_id = sp.schema_id
    where s.name = 'dbo'
      and sp.type = 'P'
      and sp.name in (
        'mdpsp_sys_CreateMetaClassHistoryTriggers', -- dropped
        'mdpsp_sys_CreateMetaClassHistoryTrigger', -- dropped
        'mdpsp_sys_CreateMetaClassLocalizationTrigger', -- dropped
        'mdpsp_sys_MetaFieldSaveHistory', -- dropped
        'mdpsp_sys_CreateMetaClassHistoryTriggers', -- dropped
        'mdpsp_sys_CheckReplaceUser',
        'mdpsp_sys_CreateMetaClassProcedure',
        'mdpsp_sys_CreateMetaClass',
        'mdpsp_sys_DeleteMetaClassProcedure',
        'mdpsp_sys_DeleteMetaClass',
        'mdpsp_sys_AddMetaField',
        'mdpsp_sys_AddMetaFieldToMetaClass',
        'mdpsp_sys_DeleteMetaFieldFromMetaClass',
        'mdpsp_sys_LoadMetaField',
        'mdpsp_sys_LoadMetaFieldByName',
        'mdpsp_sys_LoadMetaFieldByNamespace',
        'mdpsp_sys_LoadMetaFieldList',
        'mdpsp_sys_LoadMetaFieldListByMetaClassId',
        'mdpsp_sys_RefreshSystemMetaClassInfo',
        'mdpsp_sys_RegisterMetaFieldInSystemClass',
        'mdpsp_sys_ReplaceUser');

    -- create statements to drop all metadata system history triggers
    ;with actual_triggers as (
        select s.name as schema_name, t.name as table_name, tr.name as trigger_name
        from sys.schemas s
        join sys.tables t on s.schema_id = t.schema_id
        join sys.triggers tr on t.object_id = tr.parent_id
        where s.name = 'dbo'
    ),
    meta_triggers as (
        select TableName, 'mdptr_avto_' + TableName + '_History' as TriggerName from MetaClass mc
        union all
        select TableName + '_Localization', 'mdptr_avto_' + TableName + '_LocalizationHistory' from MetaClass mc
    )
    insert into @ddl (ddl)
    select 'drop trigger [' + dt.schema_name + '].[' + dt.trigger_name + ']'
    from actual_triggers dt
    join meta_triggers mt on dt.table_name = mt.TableName and dt.trigger_name = mt.TriggerName

    -- create statements to drop all metadata system history tables
    insert into @ddl (ddl)
    select 'drop table [' + s.name + '].[' + t.name + ']'
    from sys.schemas s
    join sys.tables t on s.schema_id = t.schema_id
    join MetaClass mc on t.name = mc.TableName + '_History'
    where s.name = 'dbo'

    -- create statements to drop all metadata history procedures
    insert into @ddl (ddl)
    select 'drop procedure [' + s.name + '].[' + sp.name + ']'
    from sys.schemas s
    join sys.objects sp on s.schema_id = sp.schema_id
    join MetaClass mc on sp.name = 'mdpsp_avto_' + mc.TableName + '_History'
    where s.name = 'dbo' and sp.type = 'P'

    -- create statements to drop constraints on SaveHistory column
    ;with column_constraints as (
        select name, parent_object_id, parent_column_id from sys.check_constraints
        union all
        select name, parent_object_id, parent_column_id from sys.default_constraints
    )
    insert into @ddl (ddl)
    select 'alter table [' + s.name + '].[' + t.name + '] drop constraint [' + cc.name + ']'
    from sys.schemas s
    join sys.tables t on s.schema_id = t.schema_id
    join sys.columns c on t.object_id = c.object_id
    join column_constraints cc on c.object_id = cc.parent_object_id and c.column_id = cc.parent_column_id
    where s.name = 'dbo' and t.name = 'MetaField' and c.name = 'SaveHistory'

    -- create statements to drop SaveHistory column
    insert into @ddl (ddl)
    select 'alter table [' + s.name + '].[' + t.name + '] drop column [' + c.name + ']'
    from sys.schemas s
    join sys.tables t on s.schema_id = t.schema_id
    join sys.columns c on t.object_id = c.object_id
    where s.name = 'dbo' and t.name = 'MetaField' and c.name = 'SaveHistory'

    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_CheckReplaceUser]
	@OldUserId AS nvarchar(100),
	@Retval AS INT OUTPUT
AS
	SET NOCOUNT ON

	SET @Retval = 0

	DECLARE classall_cursor CURSOR FOR
		SELECT MetaClassId, TableName FROM MetaClass WHERE IsSystem =0 AND IsAbstract = 0

	DECLARE @MetaClassId	INT
	DECLARE @TableName		NVARCHAR(255)

	OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName

	DECLARE @SQLString NVARCHAR(500)

	WHILE(@@FETCH_STATUS = 0 AND @Retval = 0)
	BEGIN

		SET @SQLString  = N''IF EXISTS(SELECT TOP 1 * FROM '' + @TableName  + '' WHERE CreatorId = @OldUserId) SELECT 1''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100)'', @OldUserId = @OldUserId
		IF @@ROWCOUNT <> 0
		BEGIN
			SET @Retval = 1
			BREAK
		END

		SET @SQLString  = N''IF EXISTS(SELECT TOP 1 * FROM '' + @TableName  + '' WHERE ModifierId = @OldUserId) SELECT 1''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100)'', @OldUserId = @OldUserId
		IF @@ROWCOUNT <> 0
		BEGIN
			SET @Retval = 1
			BREAK
		END

		FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName
	END

	CLOSE classall_cursor
	DEALLOCATE classall_cursor
RETURN')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedure]
    @MetaClassId int
as
begin
    set nocount on
    begin try
        declare @CRLF nchar(1) = CHAR(10)
        declare @MetaClassName nvarchar(256)
        declare @TableName sysname
        select @MetaClassName = Name, @TableName = TableName from MetaClass where MetaClassId = @MetaClassId
        if @MetaClassName is null raiserror(''Metaclass not found.'',16,1)

        -- get required info for each field
        declare @ParameterIndex int
        declare @ColumnName sysname
        declare @FieldIsMultilanguage bit
        declare @FieldIsEncrypted bit
        declare @FieldIsNullable bit
        declare @ColumnDataType sysname
        declare fields cursor local for
            select
                mfindex.ParameterIndex,
                mf.Name as ColumnName,
                mf.MultiLanguageValue as FieldIsMultilanguage,
                mf.IsEncrypted as FieldIsEncrypted,
                mf.AllowNulls,
                mdt.SqlName + case
                        when mdt.Variable = 1 then ''('' + CAST(mf.Length as nvarchar) + '')''
                        when mf.DataTypeId in (5,24) and mfprecis.Value is not null and mfscale.Value is not null then ''('' + cast(mfprecis.Value as nvarchar) + '','' + cast(mfscale.Value as nvarchar) + '')''
                        else '''' end as ColumnDataType
            from (
                select ROW_NUMBER() over (order by innermf.Name) as ParameterIndex, innermf.MetaFieldId
                from MetaField innermf
                where innermf.SystemMetaClassId = 0
                  and exists (select 1 from MetaClassMetaFieldRelation cfr where cfr.MetaClassId = @MetaClassId and cfr.MetaFieldId = innermf.MetaFieldId)) mfindex
            join MetaField mf on mfindex.MetaFieldId = mf.MetaFieldId
            join MetaDataType mdt on mf.DataTypeId = mdt.DataTypeId
            left outer join MetaAttribute mfprecis on mf.MetaFieldId = mfprecis.AttrOwnerId and mfprecis.AttrOwnerType = 2 and mfprecis.[Key] = ''MdpPrecision''
            left outer join MetaAttribute mfscale on mf.MetaFieldId = mfscale.AttrOwnerId and mfscale.AttrOwnerType = 2 and mfscale.[Key] = ''MdpScale''

        -- aggregate field parts into lists for stored procedures
        declare @ParameterName nvarchar(max)
        declare @ColumnReadBase nvarchar(max)
        declare @ColumnReadLocal nvarchar(max)
        declare @WriteValue nvarchar(max)
        declare @ParameterDefinitions nvarchar(max) = ''''
        declare @UnlocalizedSelectValues nvarchar(max) = ''''
        declare @LocalizedSelectValues nvarchar(max) = ''''
        declare @AllInsertColumns nvarchar(max) = ''''
        declare @AllInsertValues nvarchar(max) = ''''
        declare @BaseInsertColumns nvarchar(max) = ''''
        declare @BaseInsertValues nvarchar(max) = ''''
        declare @LocalInsertColumns nvarchar(max) = ''''
        declare @LocalInsertValues nvarchar(max) = ''''
        declare @AllUpdateActions nvarchar(max) = ''''
        declare @BaseUpdateActions nvarchar(max) = ''''
        declare @LocalUpdateActions nvarchar(max) = ''''
        open fields
        while 1=1
        begin
            fetch next from fields into @ParameterIndex, @ColumnName, @FieldIsMultilanguage, @FieldIsEncrypted, @FieldIsNullable, @ColumnDataType
            if @@FETCH_STATUS != 0 break

            set @ParameterName = ''@f'' + cast(@ParameterIndex as nvarchar(10))
            set @ColumnReadBase = case when @FieldIsEncrypted = 1 then ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @ColumnName + ''],0)'' + '' as ['' + @ColumnName + '']'' else ''T.['' + @ColumnName + '']'' end
            set @ColumnReadLocal = case when @FieldIsEncrypted = 1 then ''dbo.mdpfn_sys_EncryptDecryptString(L.['' + @ColumnName + ''],0)'' + '' as ['' + @ColumnName + '']'' else ''L.['' + @ColumnName + '']'' end
            set @WriteValue = case when @FieldIsEncrypted = 1 then ''dbo.mdpfn_sys_EncryptDecryptString('' + @ParameterName + '',1)'' else @ParameterName end

            set @ParameterDefinitions = @ParameterDefinitions + '','' + @ParameterName + '' '' + @ColumnDataType
            set @UnlocalizedSelectValues = @UnlocalizedSelectValues + '','' + @ColumnReadBase
            set @LocalizedSelectValues = @LocalizedSelectValues + '','' + case when @FieldIsMultilanguage = 1 then @ColumnReadLocal else @ColumnReadBase end
            set @AllInsertColumns = @AllInsertColumns + '',['' + @ColumnName + '']''
            set @AllInsertValues = @AllInsertValues + '','' + @WriteValue
            set @BaseInsertColumns = @BaseInsertColumns + case when @FieldIsMultilanguage = 0 then '',['' + @ColumnName + '']'' else '''' end
            set @BaseInsertValues = @BaseInsertValues + case when @FieldIsMultilanguage = 0 then '','' + @WriteValue else '''' end
            set @LocalInsertColumns = @LocalInsertColumns + case when @FieldIsMultilanguage = 1 then '',['' + @ColumnName + '']'' else '''' end
            set @LocalInsertValues = @LocalInsertValues + case when @FieldIsMultilanguage = 1 then '','' + @WriteValue else '''' end
            set @AllUpdateActions = @AllUpdateActions + '',['' + @ColumnName + '']='' + @WriteValue
            set @BaseUpdateActions = @BaseUpdateActions + '',['' + @ColumnName + '']='' + case when @FieldIsMultilanguage = 0 then @WriteValue when @FieldIsNullable = 1 then ''null'' else ''default'' end
            set @LocalUpdateActions = @LocalUpdateActions + '',['' + @ColumnName + '']='' + case when @FieldIsMultilanguage = 1 then @WriteValue when @FieldIsNullable = 1 then ''null'' else ''default'' end
        end
        close fields

        declare @OpenEncryptionKey nvarchar(max)
        declare @CloseEncryptionKey nvarchar(max)
        if exists(  select 1
                    from MetaField mf
                    join MetaClassMetaFieldRelation cfr on mf.MetaFieldId = cfr.MetaFieldId
                    where cfr.MetaClassId = @MetaClassId and mf.SystemMetaClassId = 0 and mf.IsEncrypted = 1)
        begin
            set @OpenEncryptionKey = ''exec dbo.mdpsp_sys_OpenSymmetricKey'' + @CRLF
            set @CloseEncryptionKey = ''exec dbo.mdpsp_sys_CloseSymmetricKey'' + @CRLF
        end
        else
        begin
            set @OpenEncryptionKey = ''''
            set @CloseEncryptionKey = ''''
        end

        -- create stored procedures
        declare @procedures table (name sysname, defn nvarchar(max), verb nvarchar(max))

        insert into @procedures (name, defn)
        values (''mdpsp_avto_'' + @TableName + ''_Get'',
            ''procedure dbo.[mdpsp_avto_'' + @TableName + ''_Get] @ObjectId int,@Language nvarchar(20)=null as '' + @CRLF +
            ''begin'' + @CRLF +
            @OpenEncryptionKey +
            ''if @Language is null select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified'' + @UnlocalizedSelectValues + @CRLF +
            ''from ['' + @TableName + ''] T where ObjectId=@ObjectId'' + @CRLF +
            ''else select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified'' + @LocalizedSelectValues + @CRLF +
            ''from ['' + @TableName + ''] T'' + @CRLF +
            ''left join ['' + @TableName + ''_Localization] L on T.ObjectId=L.ObjectId and L.Language=@Language'' + @CRLF +
            ''where T.ObjectId= @ObjectId'' + @CRLF +
            @CloseEncryptionKey +
            ''end'' + @CRLF)

        insert into @procedures (name, defn)
        values (''mdpsp_avto_'' + @TableName + ''_Update'',
            ''procedure dbo.[mdpsp_avto_'' + @TableName + ''_Update]'' + @CRLF +
            ''@ObjectId int,@Language nvarchar(20)=null,@CreatorId nvarchar(100),@Created datetime,@ModifierId nvarchar(100),@Modified datetime,@Retval int out'' + @ParameterDefinitions + '' as'' + @CRLF +
            ''begin'' + @CRLF +
            ''set nocount on'' + @CRLF +
            ''declare @ins bit'' + @CRLF +
            ''begin try'' + @CRLF +
            ''begin transaction'' + @CRLF +
            @OpenEncryptionKey +
            ''if @ObjectId=-1 select @ObjectId=isnull(MAX(ObjectId),0)+1, @Retval=@ObjectId, @ins=0 from ['' + @TableName + '']'' + @CRLF +
            ''else set @ins=case when exists(select 1 from ['' + @TableName + ''] where ObjectId=@ObjectId) then 0 else 1 end'' + @CRLF +
            ''if @Language is null'' + @CRLF +
            ''begin'' + @CRLF +
            ''  if @ins=1 insert ['' + @TableName + ''] (ObjectId,CreatorId,Created,ModifierId,Modified'' + @AllInsertColumns + '')'' + @CRLF +
            ''  values (@ObjectId,@CreatorId,@Created,@ModifierId,@Modified'' + @AllInsertValues + '')'' + @CRLF +
            ''  else update ['' + @TableName + ''] set CreatorId=@CreatorId,Created=@Created,ModifierId=@ModifierId,Modified=@Modified'' + @AllUpdateActions + @CRLF +
            ''  where ObjectId=@ObjectId'' + @CRLF +
            ''end'' + @CRLF +
            ''else'' + @CRLF +
            ''begin'' + @CRLF +
            ''  if @ins=1 insert ['' + @TableName + ''] (ObjectId,CreatorId,Created,ModifierId,Modified'' + @BaseInsertColumns + '')'' + @CRLF +
            ''  values (@ObjectId,@CreatorId,@Created,@ModifierId,@Modified'' + @BaseInsertValues + '')'' + @CRLF +
            ''  else update ['' + @TableName + ''] set CreatorId=@CreatorId,Created=@Created,ModifierId=@ModifierId,Modified=@Modified'' + @BaseUpdateActions + @CRLF +
            ''  where ObjectId=@ObjectId'' + @CRLF +
            ''  if not exists (select 1 from ['' + @TableName + ''_Localization] where ObjectId=@ObjectId and Language=@Language)'' + @CRLF +
            ''  insert ['' + @TableName + ''_Localization] (ObjectId,Language,ModifierId,Modified'' + @LocalInsertColumns + '')'' + @CRLF +
            ''  values (@ObjectId,@Language,@ModifierId,@Modified'' + @LocalInsertValues + '')'' + @CRLF +
            ''  else update ['' + @TableName + ''_Localization] set ModifierId=@ModifierId,Modified=@Modified'' + @LocalUpdateActions + @CRLF +
            ''  where ObjectId=@ObjectId and Language=@language'' + @CRLF +
            ''end'' + @CRLF +
            @CloseEncryptionKey +
            ''commit transaction'' + @CRLF +
            ''end try'' + @CRLF +
            ''begin catch'' + @CRLF +
            ''  declare @m nvarchar(4000),@v int,@t int'' + @CRLF +
            ''  select @m=ERROR_MESSAGE(),@v=ERROR_SEVERITY(),@t=ERROR_STATE()'' + @CRLF +
            ''  rollback transaction'' + @CRLF +
            ''  raiserror(@m, @v, @t)'' + @CRLF +
            ''end catch'' + @CRLF +
            ''end'' + @CRLF)

        insert into @procedures (name, defn)
        values (''mdpsp_avto_'' + @TableName + ''_Delete'',
            ''procedure dbo.[mdpsp_avto_'' + @TableName + ''_Delete] @ObjectId int as'' + @CRLF +
            ''begin'' + @CRLF +
            ''delete ['' + @TableName + ''] where ObjectId=@ObjectId'' + @CRLF +
            ''delete ['' + @TableName + ''_Localization] where ObjectId=@ObjectId'' + @CRLF +
            ''exec dbo.mdpsp_sys_DeleteMetaKeyObjects '' + CAST(@MetaClassId as nvarchar(10)) + '',-1,@ObjectId'' + @CRLF +
            ''end'' + @CRLF)

        insert into @procedures (name, defn)
        values (''mdpsp_avto_'' + @TableName + ''_List'',
            ''procedure dbo.[mdpsp_avto_'' + @TableName + ''_List] @Language nvarchar(20)=null,@select_list nvarchar(max)='''''''',@search_condition nvarchar(max)='''''''' as'' + @CRLF +
            ''begin'' + @CRLF +
            @OpenEncryptionKey +
            ''if @Language is null select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified'' + @UnlocalizedSelectValues + '' from ['' + @TableName + ''] T'' + @CRLF +
            ''else select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified'' + @LocalizedSelectValues + @CRLF +
            ''from ['' + @TableName + ''] T'' + @CRLF +
            ''left join ['' + @TableName + ''_Localization] L on T.ObjectId=L.ObjectId and L.Language=@Language'' + @CRLF +
            @CloseEncryptionKey +
            ''end'' + @CRLF)

        insert into @procedures (name, defn)
        values (''mdpsp_avto_'' + @TableName + ''_Search'',
            ''procedure dbo.[mdpsp_avto_'' + @TableName + ''_Search] @Language nvarchar(20)=null,@select_list nvarchar(max)='''''''',@search_condition nvarchar(max)='''''''' as'' + @CRLF +
            ''begin'' + @CRLF +
            ''if len(@select_list)>0 set @select_list='''',''''+@select_list'' + @CRLF +
            @OpenEncryptionKey +
            ''if @Language is null exec(''''select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified'' + @UnlocalizedSelectValues + ''''''+@select_list+'''' from ['' + @TableName + ''] T ''''+@search_condition)'' + @CRLF +
            ''else exec(''''select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified'' + @LocalizedSelectValues + ''''''+@select_list+'''' from ['' + @TableName + ''] T left join ['' + @TableName + ''_Localization] L on T.ObjectId=L.ObjectId and L.Language=@Language ''''+@search_condition)'' + @CRLF +
            @CloseEncryptionKey +
            ''end'' + @CRLF)

        update tgt
        set verb = case when r.ROUTINE_NAME is null then ''create '' else ''alter '' end
        from @procedures tgt
        left outer join INFORMATION_SCHEMA.ROUTINES r on r.ROUTINE_SCHEMA = ''dbo'' and r.ROUTINE_NAME = tgt.name

        -- install procedures
        declare @sqlstatement nvarchar(max)
        declare procedure_cursor cursor local for select verb + defn from @procedures
        open procedure_cursor
        while 1=1
        begin
            fetch next from procedure_cursor into @sqlstatement
            if @@FETCH_STATUS != 0 break
            exec(@sqlstatement)
        end
        close procedure_cursor
    end try
    begin catch
        declare @m nvarchar(4000), @v int, @t int
        select @m = ERROR_MESSAGE(), @v = ERROR_SEVERITY(), @t = ERROR_STATE()
        raiserror(@m,@v,@t)
    end catch
end')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_CreateMetaClass]
	@Namespace 		NVARCHAR(1024),
	@Name 		NVARCHAR(256),
	@FriendlyName		NVARCHAR(256),
	@TableName 		NVARCHAR(256),
	@ParentClassId 		INT,
	@IsSystem		BIT,
	@IsAbstract		BIT	=	0,
	@Description 		NTEXT,
	@Retval 		INT OUTPUT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON
	SET @Retval = -1

BEGIN TRAN
	-- Step 1. Insert a new record in to the MetaClass table
	INSERT INTO [MetaClass] ([Namespace],[Name], [FriendlyName],[Description], [TableName], [ParentClassId], [PrimaryKeyName], [IsSystem], [IsAbstract])
		VALUES (@Namespace, @Name, @FriendlyName, @Description, @TableName, @ParentClassId, ''undefined'', @IsSystem, @IsAbstract)

	IF @@ERROR <> 0 GOTO ERR

	SET @Retval = @@IDENTITY

	IF @IsSystem = 1
	BEGIN
		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE [NAME] = @TableName AND [type] = ''U'')
		BEGIN
			RAISERROR (''Wrong System TableName.'', 16,1 )
			GOTO ERR
		END

		-- Step 3-2. Insert a new record in to the MetaField table
		INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls],  [MultiLanguageValue], [AllowSearch], [IsEncrypted])
			 SELECT @Namespace+ N''.'' + @Name, SC .[name] , SC .[name] , @Retval ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0  FROM SYSCOLUMNS AS SC
				INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.[ID]
				INNER JOIN SYSTYPES ST ON ST.[xtype] = SC.[xtype]
				INNER JOIN MetaDataType MDT ON MDT.[Name] = ST.[name]
			WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname''
			ORDER BY COLORDER /* Aug 29, 2006 */

		IF @@ERROR<> 0 GOTO ERR

		-- Step 3-2. Insert a new record in to the MetaClassMetaFieldRelation table
		INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
			SELECT @Retval, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @Retval
	END
	ELSE
	BEGIN
		IF @IsAbstract = 0
		BEGIN
			-- Step 2. Create the @TableName table.
			EXEC(''CREATE TABLE [dbo].['' + @TableName  + ''] ([ObjectId] [int] NOT NULL , [CreatorId] [nvarchar](100), [Created] [datetime], [ModifierId] [nvarchar](100) , [Modified] [datetime] ) ON [PRIMARY]'')

			IF @@ERROR <> 0 GOTO ERR

			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''] PRIMARY KEY  CLUSTERED ([ObjectId])  ON [PRIMARY]'')

			IF @@ERROR <> 0 GOTO ERR

			IF EXISTS(SELECT * FROM MetaClass WHERE MetaClassId = @ParentClassId /* AND @IsSystem = 1 */ )
			BEGIN
				-- Step 3-2. Insert a new record in to the MetaClassMetaFieldRelation table
				INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
					SELECT @Retval, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @ParentClassId
			END

			IF @@ERROR<> 0 GOTO ERR

			-- Step 2-2. Create the @TableName_Localization table
			EXEC(''CREATE TABLE [dbo].['' + @TableName + ''_Localization] ([Id] [int] IDENTITY (1, 1)  NOT NULL, [ObjectId] [int] NOT NULL , [ModifierId] [nvarchar](100), [Modified] [datetime], [Language] nvarchar(20) NOT NULL) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''_Localization] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''_Localization] PRIMARY KEY  CLUSTERED ([Id])  ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC (''CREATE NONCLUSTERED INDEX IX_'' + @TableName + ''_Localization_Language ON dbo.'' + @TableName + ''_Localization ([Language]) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC (''CREATE UNIQUE NONCLUSTERED INDEX IX_'' + @TableName + ''_Localization_ObjectId ON dbo.'' + @TableName + ''_Localization (ObjectId,[Language]) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC mdpsp_sys_CreateMetaClassProcedure @Retval
			IF @@ERROR <> 0 GOTO ERR
		END
	END

	-- Update PK Value
	DECLARE @PrimaryKeyName	NVARCHAR(256)
	SELECT @PrimaryKeyName = name FROM Sysobjects WHERE OBJECTPROPERTY(id, N''IsPrimaryKey'') = 1 and parent_obj = OBJECT_ID(@TableName) and OBJECTPROPERTY(parent_obj, N''IsUserTable'') = 1

	IF @PrimaryKeyName IS NOT NULL
		UPDATE [MetaClass] SET PrimaryKeyName = @PrimaryKeyName WHERE MetaClassId = @Retval

	COMMIT TRAN
RETURN

ERR:
	ROLLBACK TRAN
	SET @Retval = -1
RETURN
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaClassProcedure]
	@MetaClassId	INT
AS
	SET NOCOUNT ON

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is system or not existed.'', 16,1)
		GOTO ERR
	END

	-- Step 1. Create SQL Code
	PRINT''Step 1. Create SQL Code''

	DECLARE	@MetaClassTable			NVARCHAR(256)
	DECLARE	@MetaClassGetSpName			NVARCHAR(256)
	DECLARE	@MetaClassUpdateSpName		NVARCHAR(256)
	DECLARE	@MetaClassDeleteSpName		NVARCHAR(256)
	DECLARE	@MetaClassListSpName		NVARCHAR(256)

	SELECT @MetaClassTable = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

	SET @MetaClassGetSpName 		= ''mdpsp_avto_'' +@MetaClassTable +''_Get''
	SET @MetaClassUpdateSpName 	= ''mdpsp_avto_'' +@MetaClassTable +''_Update''
	SET @MetaClassDeleteSpName 	= ''mdpsp_avto_'' +@MetaClassTable +''_Delete''
	SET @MetaClassListSpName 	= ''mdpsp_avto_'' +@MetaClassTable +''_List''

	-- Step 2. Drop operation
	PRINT''Step 2. Drop operation''

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassUpdateSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassUpdateSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassGetSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassGetSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassDeleteSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassDeleteSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassListSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassListSpName)
	IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
RETURN')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaClass]
	@MetaClassId	INT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON

	BEGIN TRAN

	DECLARE @MetaFieldOwnerTable	NVARCHAR(256)

	-- Check Childs Table
	IF EXISTS(SELECT *  FROM MetaClass MC WHERE ParentClassId = @MetaClassId)
	BEGIN
		RAISERROR (''The class have childs.'', 16, 1)
		GOTO ERR
	END

	-- Step 1. Find a TableName
	IF EXISTS(SELECT *  FROM MetaClass MC WHERE MetaClassId = @MetaClassId)
	BEGIN
		IF EXISTS(SELECT *  FROM MetaClass MC WHERE MetaClassId = @MetaClassId AND IsSystem = 0 AND IsAbstract = 0)
		BEGIN
			SELECT @MetaFieldOwnerTable = TableName  FROM MetaClass MC WHERE MetaClassId = @MetaClassId AND IsSystem = 0 AND IsAbstract = 0

			IF @@ERROR <> 0 GOTO ERR

			EXEC mdpsp_sys_DeleteMetaClassProcedure @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 2. Delete Table
			EXEC(''DROP TABLE [dbo].['' + @MetaFieldOwnerTable + '']'')

			IF @@ERROR <> 0 GOTO ERR

			EXEC(''DROP TABLE [dbo].['' + @MetaFieldOwnerTable + ''_Localization]'')

				-- Delete Meta Dictionary Relations
			--DELETE FROM MetaMultiValueDictionary  WHERE MetaKey IN
			--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaClassId = @MetaClassId)

			-- IF @@ERROR <> 0 GOTO ERR

			-- Delete Meta File
			--DELETE FROM MetaFileValue  WHERE MetaKey IN
			--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaClassId = @MetaClassId)

			-- IF @@ERROR <> 0 GOTO ERR

			-- Delete Meta Key
			--DELETE FROM MetaKey WHERE MetaClassId = @MetaClassId

			EXEC mdpsp_sys_DeleteMetaKeyObjects @MetaClassId
			 IF @@ERROR <> 0 GOTO ERR

			-- Delete Meta Attribute
			EXEC mdpsp_sys_ClearMetaAttribute @MetaClassId, 1

			 IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaField Relations
			DELETE FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaClass
			DELETE FROM MetaClass WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR
		END
		ELSE
		BEGIN
			-- Delete Meta Attribute
			EXEC mdpsp_sys_ClearMetaAttribute @MetaClassId, 1

			 IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaField Relations
			DELETE FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaField
			DELETE FROM MetaField WHERE SystemMetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaClass
			DELETE FROM MetaClass WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

		END
	END
	ELSE
	BEGIN
		RAISERROR (''Wrong @MetaClassId.'', 16, 1)
		GOTO ERR
	END

	COMMIT TRAN
	RETURN

ERR:
	ROLLBACK TRAN
	RETURN
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaField]
	@Namespace 		NVARCHAR(1024) = N''Mediachase.MetaDataPlus.User'',
	@Name		NVARCHAR(256),
	@FriendlyName	NVARCHAR(256),
	@Description	NTEXT,
	@DataTypeId	INT,
	@Length	INT,
	@AllowNulls	BIT,
	@MultiLanguageValue BIT,
	@AllowSearch	BIT,
	@IsEncrypted	BIT,
	@Retval 	INT OUTPUT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON
	SET @Retval = -1

    BEGIN TRAN
	    DECLARE @DataTypeVariable	INT
	    DECLARE @DataTypeLength	INT

	    SELECT @DataTypeVariable = Variable, @DataTypeLength = Length FROM MetaDataType WHERE DataTypeId = @DataTypeId

	    IF (@Length <= 0 OR @Length > @DataTypeLength )
		    SET @Length = @DataTypeLength

	    -- Step 2. Insert a record in to MetaField table.
	    INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [Description], [DataTypeId], [Length], [AllowNulls],  [MultiLanguageValue], [AllowSearch], [IsEncrypted])
		    VALUES(@Namespace, @Name,  @FriendlyName, @Description, @DataTypeId, @Length, @AllowNulls, @MultiLanguageValue, @AllowSearch, @IsEncrypted)

	    IF @@ERROR <> 0 GOTO ERR

	    SET @Retval = IDENT_CURRENT(''[MetaField]'')

	    COMMIT TRAN
    RETURN

ERR:
	SET @Retval = -1
	ROLLBACK TRAN
    RETURN
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaFieldToMetaClass]
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Weight	INT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON

	DECLARE @IsAbstractClass	BIT
	SELECT @IsAbstractClass = IsAbstract FROM MetaClass WHERE MetaClassId = @MetaClassId

    BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId AND IsSystem = 0)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is system or not exists.'', 16,1)
		GOTO ERR
	END

	IF NOT EXISTS( SELECT * FROM MetaField WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0)
	BEGIN
		RAISERROR (''Wrong @MetaFieldId. The field is system or not exists.'', 16,1)
		GOTO ERR
	END

	IF @IsAbstractClass = 0
	BEGIN
		-- Step 1. Insert a new column.
		DECLARE @Name		NVARCHAR(256)
		DECLARE @DataTypeId	INT
		DECLARE @Length		INT
		DECLARE @AllowNulls		BIT
		DECLARE @MultiLanguageValue BIT
		DECLARE @AllowSearch	BIT
		DECLARE @IsEncrypted	BIT

		SELECT @Name = [Name], @DataTypeId = DataTypeId,  @Length = [Length], @AllowNulls = AllowNulls, @MultiLanguageValue = MultiLanguageValue, @AllowSearch = AllowSearch, @IsEncrypted = IsEncrypted
		FROM [MetaField]
        WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0

		-- Step 1-1. Create a new column query.

		DECLARE @MetaClassTableName NVARCHAR(256)
		DECLARE @SqlDataTypeName NVARCHAR(256)
		DECLARE @IsVariableDataType BIT
		DECLARE @DefaultValue	NVARCHAR(50)

		SELECT @MetaClassTableName = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

		IF @@ERROR<> 0 GOTO ERR

		SELECT @SqlDataTypeName = SqlName,  @IsVariableDataType = Variable, @DefaultValue = DefaultValue FROM MetaDataType WHERE DataTypeId= @DataTypeId

		IF @@ERROR<> 0 GOTO ERR

		DECLARE @ExecLine 			NVARCHAR(1024)
		DECLARE @ExecLineLocalization 	NVARCHAR(1024)

		SET @ExecLine = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''] ADD [''+@Name+''] '' + @SqlDataTypeName
		SET @ExecLineLocalization = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''_Localization] ADD [''+@Name+''] '' + @SqlDataTypeName

		IF @IsVariableDataType = 1
		BEGIN
			SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
			SET @ExecLineLocalization = @ExecLineLocalization + '' ('' + STR(@Length) + '')''
		END
		ELSE
		BEGIN
			IF @DataTypeId = 5 OR @DataTypeId = 24
			BEGIN
				DECLARE @MdpPrecision NVARCHAR(10)
				DECLARE @MdpScale NVARCHAR(10)

				SET @MdpPrecision = NULL
				SET @MdpScale = NULL

				SELECT @MdpPrecision = [Value] FROM MetaAttribute
				WHERE
					AttrOwnerId = @MetaFieldId AND
					AttrOwnerType = 2 AND
					[Key] = ''MdpPrecision''

				SELECT @MdpScale = [Value] FROM MetaAttribute
				WHERE
					AttrOwnerId = @MetaFieldId AND
					AttrOwnerType = 2 AND
					[Key] = ''MdpScale''

				IF @MdpPrecision IS NOT NULL AND @MdpScale IS NOT NULL
				BEGIN
					SET @ExecLine = @ExecLine + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
					SET @ExecLineLocalization = @ExecLineLocalization + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
				END
			END
		END

		SET @ExecLineLocalization = @ExecLineLocalization + '' NULL''

		IF @AllowNulls = 1
		BEGIN
			SET @ExecLine = @ExecLine + '' NULL''
		END
		ELSE
			BEGIN
				SET @ExecLine = @ExecLine + '' NOT NULL DEFAULT '' + @DefaultValue

				--IF @IsVariableDataType = 1
				--BEGIN
					--SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
				--END

				SET @ExecLine = @ExecLine  +''  WITH VALUES''
			END

		--PRINT (@ExecLine)

		-- Step 1-2. Create a new column.
		EXEC (@ExecLine)

		IF @@ERROR<> 0 GOTO ERR

		-- Step 1-3. Create a new localization column.
		EXEC (@ExecLineLocalization)

		IF @@ERROR <> 0 GOTO ERR
	END

	-- Step 2. Insert a record in to MetaClassMetaFieldRelation table.
	INSERT INTO [MetaClassMetaFieldRelation] (MetaClassId, MetaFieldId, Weight) VALUES(@MetaClassId, @MetaFieldId, @Weight)

	IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0 GOTO ERR
	END

	--EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1

	--IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN

	IF @IsAbstractClass = 0 AND @@TRANCOUNT = 0
	BEGIN
		-- execute outside transaction
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1
	END
    RETURN

ERR:
	ROLLBACK TRAN
    RETURN
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]
	@MetaClassId	INT,
	@MetaFieldId	INT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM MetaClassMetaFieldRelation WHERE MetaFieldId = @MetaFieldId AND MetaClassId = @MetaClassId)
	BEGIN
		--RAISERROR (''Wrong @MetaFieldId and @MetaClassId.'', 16, 1)
		-- GOTO ERR
		RETURN
	END

	-- Step 0. Prepare
	SET NOCOUNT ON

	DECLARE @MetaFieldName NVARCHAR(256)
	DECLARE @MetaFieldOwnerTable NVARCHAR(256)
	DECLARE @BaseMetaFieldOwnerTable NVARCHAR(256)
	DECLARE @IsAbstractClass BIT

	-- Step 1. Find a Field Name
	-- Step 2. Find a TableName
	IF NOT EXISTS(SELECT * FROM MetaField MF WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0 )
	BEGIN
		RAISERROR (''Wrong @MetaFieldId.'', 16, 1)
		GOTO ERR
	END

	SELECT @MetaFieldName = MF.[Name] FROM MetaField MF WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0

	IF NOT EXISTS(SELECT * FROM MetaClass MC WHERE MetaClassId = @MetaClassId AND IsSystem = 0)
	BEGIN
		RAISERROR (''Wrong @MetaClassId.'', 16, 1)
		GOTO ERR
	END

	SELECT @BaseMetaFieldOwnerTable = MC.TableName, @IsAbstractClass = MC.IsAbstract FROM MetaClass MC
		WHERE MetaClassId = @MetaClassId AND IsSystem = 0

	SET @MetaFieldOwnerTable = @BaseMetaFieldOwnerTable

	 IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		-- need to remove full text indexes before removing item
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 0
	END

	BEGIN TRAN

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_DeleteMetaKeyObjects @MetaClassId, @MetaFieldId
		 IF @@ERROR <> 0 GOTO ERR

		-- Delete Meta Dictionary Relations
		--DELETE FROM MetaMultiValueDictionary  WHERE MetaKey IN
		--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaFieldId = @MetaFieldId AND MK.MetaClassId = @MetaClassId)

		-- IF @@ERROR <> 0 GOTO ERR

		-- Delete Meta File
		--DELETE FROM MetaFileValue  WHERE MetaKey IN
		--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaFieldId = @MetaFieldId AND MK.MetaClassId = @MetaClassId)

		-- IF @@ERROR <> 0 GOTO ERR

		--DELETE FROM MetaKey WHERE MetaFieldId = @MetaFieldId AND MetaClassId = @MetaClassId

		-- IF @@ERROR <> 0 GOTO ERR

		-- Step 3. Delete Constrains
		EXEC mdpsp_sys_DeleteDContrainByTableAndField @MetaFieldOwnerTable, @MetaFieldName

		IF @@ERROR <> 0 GOTO ERR

		-- Step 4. Delete Field
		EXEC (''ALTER TABLE [''+@MetaFieldOwnerTable+''] DROP COLUMN ['' + @MetaFieldName + '']'')

		IF @@ERROR <> 0 GOTO ERR

		-- Update 2007/10/05: Remove meta field from Localization table (if table exists)
		SET @MetaFieldOwnerTable = @BaseMetaFieldOwnerTable + ''_Localization''

		if exists (select * from dbo.sysobjects where id = object_id(@MetaFieldOwnerTable) and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
		begin
			-- a). Delete constraints
			EXEC mdpsp_sys_DeleteDContrainByTableAndField @MetaFieldOwnerTable, @MetaFieldName
			-- a). Drop column
			EXEC (''ALTER TABLE [''+@MetaFieldOwnerTable+''] DROP COLUMN ['' + @MetaFieldName + '']'')
		end
	END

	-- Step 5. Delete Field Info Record
	DELETE FROM MetaClassMetaFieldRelation WHERE MetaFieldId = @MetaFieldId AND MetaClassId = @MetaClassId
	IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0 GOTO ERR

		--EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 0

		--IF @@ERROR <> 0 GOTO ERR
	END

	COMMIT TRAN
	RETURN
ERR:
	ROLLBACK TRAN

	-- readd indexes if error occured
	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 1
	END

	RETURN @@Error
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaField]
	@MetaFieldId	INT
AS
BEGIN
	SELECT [MetaFieldId] , [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField WHERE MetaFieldId = @MetaFieldId
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByName]
	@Name		NVARCHAR(256)
AS
BEGIN
	SELECT [MetaFieldId] ,  [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField WHERE  [Name] = @Name	AND SystemMetaClassId = 0
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByNamespace]
	@Namespace		NVARCHAR(1024),
	@Deep			BIT
AS
BEGIN
	IF @Deep = 1
		SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
		FROM MetaField WHERE Namespace = @Namespace OR Namespace LIKE (@Namespace + ''.%'')
	ELSE
		SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
		FROM MetaField WHERE Namespace = @Namespace
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldList]
AS
BEGIN
	SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]
    @MetaClassId int
as
begin
    select
        mf.[MetaFieldId],
        mf.[Namespace],
        mf.[Name],
        mf.[FriendlyName],
        mf.[Description],
        mf.[SystemMetaClassId],
        mf.[DataTypeId],
        mf.[Length],
        mf.[AllowNulls],
        mf.[MultiLanguageValue],
        mf.[AllowSearch],
        mf.[Tag],
        mf.[IsEncrypted],
        cfr.[Weight],
        cfr.[Enabled],
        cast(case when mf.SystemMetaClassId = 0 then ROW_NUMBER() over (partition by mf.SystemMetaClassId order by mf.Name)
            else null end as int) as ParameterIndex
    from MetaField mf
    join MetaClassMetaFieldRelation cfr ON cfr.MetaFieldId = mf.MetaFieldId
    where cfr.MetaClassId = @MetaClassId
    order by mf.IsKeyField desc, cfr.[Weight]
end')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]
	@MetaClassId	INT
AS
	SET NOCOUNT ON
BEGIN
    BEGIN TRAN
	DECLARE @TableName NVARCHAR(256)
	DECLARE @Namespace NVARCHAR(1024)
	DECLARE @Name NVARCHAR(256)

	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId AND IsSystem = 1)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is neither system nor existed.'', 16,1)
		GOTO ERR
	END

	SELECT @Name = [Name], @TableName = TableName, @Namespace = Namespace FROM MetaClass WHERE MetaClassId = @MetaClassId AND IsSystem = 1

	-- Step 1. Remove old fields
	DELETE FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId
	IF @@ERROR<> 0 GOTO ERR

	DELETE FROM MetaClassMetaFieldRelation WHERE MetaFieldId IN (SELECT MetaFieldId FROM MetaField WHERE SystemMetaClassId = @MetaClassId)
	IF @@ERROR<> 0 GOTO ERR

	DELETE FROM MetaField WHERE SystemMetaClassId = @MetaClassId
	IF @@ERROR<> 0 GOTO ERR

	-- Step 2. Create new fields
	INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [IsEncrypted])
	SELECT @Namespace + N''.'' + @Name, SC.[name], SC.[name], @MetaClassId, MDT.[DataTypeId], SC.[length], SC.[isnullable], 0, 0, 0
    FROM SYSCOLUMNS AS SC
	INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.ID
	INNER JOIN SYSTYPES ST ON ST.[xtype] = SC .[xtype]
	INNER JOIN MetaDataType MDT ON MDT.[Name] = ST .[name]
    WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname''
	ORDER BY COLORDER /* Aug 29, 2006 */

	IF @@ERROR<> 0 GOTO ERR

	INSERT INTO [MetaClassMetaFieldRelation] (MetaClassId, MetaFieldId)
	SELECT @MetaClassId, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @MetaClassId

	IF @@ERROR<> 0 GOTO ERR

	-- Step 3. Update child-field relations
	INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
	SELECT MC.MetaClassId, MF.MetaFieldId FROM MetaField MF, MetaClass MC
	WHERE MF.[SystemMetaClassId] = @MetaClassId AND MC.ParentClassId = @MetaClassId ORDER BY MC.MetaClassId

	IF @@ERROR<> 0 GOTO ERR

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
    RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
    RETURN
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_RegisterMetaFieldInSystemClass]
-- Add the parameters for the stored procedure here
	@ClassName nvarchar(255), 
	@TableName nvarchar(255),
	@Namespace nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ClassId int
	DECLARE @FieldName nvarchar(255)
	DECLARE @FriendlyFieldName nvarchar(255)
	DECLARE @DataTypeId int
	DECLARE @Length int
	DECLARE @Nullable bit
	DECLARE @DUMMY int

    SELECT @ClassId = [MetaClassId] FROM [MetaClass] WHERE [Name] = @ClassName

	DECLARE fieldCursor CURSOR FOR 
		SELECT @Namespace+ N''.'' + @ClassName, SC .[name] as Name , SC .[name] , @ClassId ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0, 0  FROM SYSCOLUMNS AS SC  
			INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.[ID]
			INNER JOIN SYSTYPES ST ON ST.[xtype] = SC.[xtype]
			INNER JOIN MetaDataType MDT ON MDT.[Name] = ST.[name]
		WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname'' and SC .[name] NOT IN (SELECT MF.Name FROM [MetaField] MF WHERE SystemMetaClassId = @ClassId)
		ORDER BY COLORDER 

	OPEN fieldCursor
	FETCH NEXT FROM fieldCursor INTO @Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable, @DUMMY, @DUMMY, @DUMMY, @DUMMY
	WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT ''Registering new MetaField'' + @FieldName 

			INSERT INTO [MetaField] ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [IsEncrypted]) 
            VALUES (@Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable,  0, 0, 0)
			
            INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
					SELECT MC.[MetaClassId], @@IDENTITY FROM (
						SELECT [MetaClassId] FROM MetaClass WHERE ParentClassId = @ClassId UNION
						SELECT @ClassId
					) MC

			FETCH NEXT FROM fieldCursor INTO @Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable, @DUMMY, @DUMMY, @DUMMY, @DUMMY
		END 
	CLOSE fieldCursor
	DEALLOCATE fieldCursor
END')
    insert into @ddl (ddl) values (N'CREATE PROCEDURE [dbo].[mdpsp_sys_ReplaceUser]
	@OldUserId AS nvarchar(100),
	@NewUserId AS nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRAN
	DECLARE classall_cursor CURSOR FOR
		SELECT MetaClassId, TableName FROM MetaClass WHERE IsSystem =0 AND IsAbstract = 0

	DECLARE @MetaClassId	INT
	DECLARE @TableName		NVARCHAR(255)

	OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName

	DECLARE @SQLString NVARCHAR(500)

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @SQLString  = N''UPDATE '' + @TableName  + '' SET CreatorId = @NewUserId WHERE CreatorId = @OldUserId''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100), @NewUserId AS nvarchar(100)'', @OldUserId = @OldUserId, @NewUserId = @NewUserId
		IF @@ERROR <> 0 GOTO ERR

		SET @SQLString  = N''UPDATE '' + @TableName  + '' SET ModifierId = @NewUserId WHERE ModifierId = @OldUserId''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100), @NewUserId AS nvarchar(100)'', @OldUserId = @OldUserId, @NewUserId = @NewUserId
		IF @@ERROR <> 0 GOTO ERR

	    FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName
	END

	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	COMMIT TRAN
    RETURN

ERR:
	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	ROLLBACK TRAN
    RETURN
END')

    declare @ddl_statement nvarchar(max)
    declare ddl_cursor cursor local for select ddl from @ddl order by ordering
    open ddl_cursor
    while 1=1
    begin
        fetch next from ddl_cursor into @ddl_statement
        if @@FETCH_STATUS != 0 break

        exec dbo.sp_executesql @ddl_statement
    end
    close ddl_cursor

    -- rebuild all metaclass procedures.
    exec dbo.mdpsp_sys_CreateMetaClassProcedureAll

    insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go

declare @major int = 5, @minor int = 2, @patch int = 14
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @sql nvarchar(4000)
    declare constraint_drops cursor local for
        select 'alter table [' + s.name + '].[' + t.name + '] drop constraint [' + REPLACE(df.name, ']', ']]') + ']'
        from sys.schemas s
        join sys.tables t on t.schema_id = s.schema_id
        join sys.columns c on c.object_id = t.object_id
        join sys.default_constraints df on df.parent_object_id = c.object_id and df.parent_column_id = c.column_id
        where s.name = 'dbo' and t.name = 'MetaFileValue' and c.name in ('CreationTime', 'LastWriteTime', 'LastReadTime')
    open constraint_drops
    while 1=1
    begin
        fetch next from constraint_drops into @sql
        if @@FETCH_STATUS != 0 break

        exec dbo.sp_executesql @sql
    end
    close constraint_drops

    exec dbo.sp_executesql N'alter table dbo.MetaFileValue add constraint DF_MetaFileValue_CreationTime default (GETUTCDATE()) for CreationTime'
    exec dbo.sp_executesql N'alter table dbo.MetaFileValue add constraint DF_MetaFileValue_LastReadTime default (GETUTCDATE()) for LastReadTime'
    exec dbo.sp_executesql N'alter table dbo.MetaFileValue add constraint DF_MetaFileValue_LastWriteTime default (GETUTCDATE()) for LastWriteTime'

    insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go



declare @major int = 5, @minor int = 2, @patch int = 15
if not exists (select 1 from SchemaVersion_MetaDataSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    if OBJECT_ID('[dbo].[mdpsp_sys_CreateMetaClass]', 'P') is not null exec dbo.sp_executesql N'drop procedure [dbo].[mdpsp_sys_CreateMetaClass]'
	exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[mdpsp_sys_CreateMetaClass]
	@Namespace 		NVARCHAR(1024),
	@Name 		NVARCHAR(256),
	@FriendlyName		NVARCHAR(256),
	@TableName 		NVARCHAR(256),
	@ParentClassId 		INT,
	@IsSystem		BIT,
	@IsAbstract		BIT	=	0,
	@Description 		NTEXT,
	@Retval 		INT OUTPUT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON
	SET @Retval = -1

BEGIN TRAN
	-- Step 1. Insert a new record in to the MetaClass table
	INSERT INTO [MetaClass] ([Namespace],[Name], [FriendlyName],[Description], [TableName], [ParentClassId], [PrimaryKeyName], [IsSystem], [IsAbstract])
		VALUES (@Namespace, @Name, @FriendlyName, @Description, @TableName, @ParentClassId, ''undefined'', @IsSystem, @IsAbstract)

	IF @@ERROR <> 0 GOTO ERR

	SET @Retval = @@IDENTITY

	IF @IsSystem = 1
	BEGIN
		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE [NAME] = @TableName AND [type] = ''U'')
		BEGIN
			RAISERROR (''Wrong System TableName.'', 16,1 )
			GOTO ERR
		END

		-- Step 3-2. Insert a new record in to the MetaField table
		INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls],  [MultiLanguageValue], [AllowSearch], [IsEncrypted])
			 SELECT @Namespace+ N''.'' + @Name, SC .[name] , SC .[name] , @Retval ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0  FROM SYSCOLUMNS AS SC
				INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.[ID]
				INNER JOIN SYSTYPES ST ON ST.[xtype] = SC.[xtype]
				INNER JOIN MetaDataType MDT ON MDT.[Name] = ST.[name]
			WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname''
			ORDER BY COLORDER /* Aug 29, 2006 */

		IF @@ERROR<> 0 GOTO ERR

		-- Step 3-2. Insert a new record in to the MetaClassMetaFieldRelation table
		INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
			SELECT @Retval, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @Retval
	END
	ELSE
	BEGIN
		IF @IsAbstract = 0
		BEGIN
			-- Step 2. Create the @TableName table.
			EXEC(''CREATE TABLE [dbo].['' + @TableName  + ''] ([ObjectId] [int] NOT NULL , [CreatorId] [nvarchar](100), [Created] [datetime], [ModifierId] [nvarchar](100) , [Modified] [datetime] ) ON [PRIMARY]'')

			IF @@ERROR <> 0 GOTO ERR

			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''] PRIMARY KEY  CLUSTERED ([ObjectId])  ON [PRIMARY]'')

			IF @@ERROR <> 0 GOTO ERR

			IF EXISTS(SELECT * FROM MetaClass WHERE MetaClassId = @ParentClassId /* AND @IsSystem = 1 */ )
			BEGIN
				-- Step 3-2. Insert a new record in to the MetaClassMetaFieldRelation table
				INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
					SELECT @Retval, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @ParentClassId
			END

			IF @@ERROR<> 0 GOTO ERR

			-- Step 2-2. Create the @TableName_Localization table
			EXEC(''CREATE TABLE [dbo].['' + @TableName + ''_Localization] ([Id] [int] IDENTITY (1, 1)  NOT NULL, [ObjectId] [int] NOT NULL , [ModifierId] [nvarchar](100), [Modified] [datetime], [Language] nvarchar(20) NOT NULL) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''_Localization] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''_Localization] PRIMARY KEY  CLUSTERED ([Id])  ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC (''CREATE NONCLUSTERED INDEX IX_'' + @TableName + ''_Localization_Language ON dbo.'' + @TableName + ''_Localization ([Language]) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC (''CREATE UNIQUE NONCLUSTERED INDEX IX_'' + @TableName + ''_Localization_ObjectId ON dbo.'' + @TableName + ''_Localization (ObjectId,[Language]) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			declare @system_root_class_id int
			;with cte as (
				select MetaClassId, ParentClassId, IsSystem
				from MetaClass
				where MetaClassId = @ParentClassId
				union all
				select mc.MetaClassId, mc.ParentClassId, mc.IsSystem
				from cte
				join MetaClass mc on cte.ParentClassId = mc.MetaClassId and cte.IsSystem = 0
			)
			select @system_root_class_id = MetaClassId
			from cte
			where IsSystem = 1

			if exists (select 1 from MetaClass where MetaClassId = @ParentClassId and IsSystem = 1)
			begin
				declare @parent_table sysname
				declare @parent_key_column sysname
				select @parent_table = mc.TableName, @parent_key_column = c.name
				from MetaClass mc
				join sys.key_constraints kc on kc.parent_object_id = OBJECT_ID(''[dbo].['' + mc.TableName + '']'', ''U'')
				join sys.index_columns ic on kc.parent_object_id = ic.object_id and kc.unique_index_id = ic.index_id
				join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
				where mc.MetaClassId = @system_root_class_id
				  and kc.type = ''PK''
				  and ic.index_column_id = 1
				
				declare @child_table nvarchar(4000)
				declare child_tables cursor local for select @TableName as table_name union all select @TableName + ''_Localization''
				open child_tables
				while 1=1
				begin
					fetch next from child_tables into @child_table
					if @@FETCH_STATUS != 0 break
					
					declare @fk_name nvarchar(4000) = ''FK_'' + @child_table + ''_'' + @parent_table
					declare @fk_sql nvarchar(4000) =
						''alter table [dbo].['' + @child_table + ''] add '' +
						case when LEN(@fk_name) <= 128 then ''constraint ['' + @fk_name + ''] '' else '''' end +
						''foreign key (ObjectId) references [dbo].['' + @parent_table + ''] (['' + @parent_key_column + '']) on delete cascade on update cascade''
						
					execute dbo.sp_executesql @fk_sql
				end
				close child_tables
				
				if @@ERROR != 0 goto ERR
			end

			EXEC mdpsp_sys_CreateMetaClassProcedure @Retval
			IF @@ERROR <> 0 GOTO ERR
		END
	END

	-- Update PK Value
	DECLARE @PrimaryKeyName	NVARCHAR(256)
	SELECT @PrimaryKeyName = name FROM Sysobjects WHERE OBJECTPROPERTY(id, N''IsPrimaryKey'') = 1 and parent_obj = OBJECT_ID(@TableName) and OBJECTPROPERTY(parent_obj, N''IsUserTable'') = 1

	IF @PrimaryKeyName IS NOT NULL
		UPDATE [MetaClass] SET PrimaryKeyName = @PrimaryKeyName WHERE MetaClassId = @Retval

	COMMIT TRAN
RETURN

ERR:
	ROLLBACK TRAN
	SET @Retval = -1
RETURN
END'

    if OBJECT_ID('[dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]', 'P') is not null exec dbo.sp_executesql N'drop procedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]'
	exec dbo.sp_executesql N'create procedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]
	@MetaClassId int,
	@MetaFieldId int,
	@Add bit
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	declare @TableName nvarchar(256)
	declare @KeyName nvarchar(256)
	declare @ColumnName nvarchar(256)
	select
		@TableName = TableName,
		@KeyName = PrimaryKeyName
	from MetaClass
	where MetaClassId = @MetaClassId

	select @ColumnName = Name
	from MetaField
	where MetaFieldId = @MetaFieldId
	  and (@Add = 0 or DataTypeId in (select DataTypeId from MetaDataType where SqlName in (N''char'', N''nchar'', N''varchar'', N''nvarchar'', N''text'', N''ntext'')))


	if (@TableName is not null and @KeyName is not null and @ColumnName is not null)
	begin
		exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, @KeyName, @ColumnName, @Add

		set @TableName = @TableName + ''_Localization''
		set @KeyName = null
		select @KeyName = CONSTRAINT_NAME
		from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where TABLE_NAME = @TableName
		  and CONSTRAINT_TYPE != ''FOREIGN KEY''
		if @KeyName is not null exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, @KeyName, @ColumnName, @Add
	end
end'

	-- delete any meta table rows that are the result of the previous leaky delete and will violate new constraints.
	declare @delete_orphaned_row_sql nvarchar(4000)
	declare orphaned_row_sql_cursor cursor local for
	with orphans as
	(
		select TableName as RootTableName, MetaClassId, IsSystem, TableName
		from MetaClass p
		where IsSystem = 1
		union all
		select RootTableName, mc.MetaClassId, mc.IsSystem, mc.TableName
		from orphans
		join MetaClass mc on mc.ParentClassId = orphans.MetaClassId
	),
	all_orphans as (
		select RootTableName, TableName
		from orphans
		where IsSystem = 0
		union all
		select RootTableName, TableName + '_Localization'
		from orphans
		where IsSystem = 0
	)
	select 'delete meta_table from [dbo].[' + o.TableName + '] meta_table where not exists (select 1 from [dbo].[' + o.RootTableName + '] root_table where meta_table.ObjectId = root_table.[' + c.name + '])'
	from all_orphans o
	join sys.key_constraints kc on kc.parent_object_id = OBJECT_ID('[dbo].[' + o.RootTableName + ']', 'U')
	join sys.index_columns ic on kc.parent_object_id = ic.object_id and kc.unique_index_id = ic.index_id
	join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
	where kc.type = 'PK' and ic.index_column_id = 1
	open orphaned_row_sql_cursor
	while 1=1
	begin
		fetch next from orphaned_row_sql_cursor into @delete_orphaned_row_sql
		if @@FETCH_STATUS != 0 break

		exec dbo.sp_executesql @delete_orphaned_row_sql
	end
	close orphaned_row_sql_cursor

	declare @fk_sql nvarchar(4000)
	declare keys_cursor cursor local for
	with table_pairs as (
		select cmc.TableName as child_table, pmc.TableName as parent_table
		from MetaClass cmc
		join MetaClass pmc on cmc.ParentClassId = pmc.MetaClassId
		where pmc.IsSystem = 1
		union all
		select cmc.TableName + '_Localization' as child_table, pmc.TableName as parent_table
		from MetaClass cmc
		join MetaClass pmc on cmc.ParentClassId = pmc.MetaClassId
		where pmc.IsSystem = 1
	),
	keys_to_create as (
		select 
			pair.child_table, 
			pair.parent_table,
			c.name as parent_key_column,
			'FK_' + pair.child_table + '_' + pair.parent_table as fk_name
		from table_pairs pair
		join sys.key_constraints kc on kc.parent_object_id = OBJECT_ID('[dbo].[' + pair.parent_table+ ']', 'U')
		join sys.index_columns ic on kc.parent_object_id = ic.object_id and kc.unique_index_id = ic.index_id
		join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
		where kc.type = 'PK'
		  and ic.index_column_id = 1
		  and not exists (select 1 from sys.foreign_keys fk
			where fk.parent_object_id = OBJECT_ID('[dbo].[' + pair.child_table + ']', 'U')
			  and fk.referenced_object_id = OBJECT_ID('[dbo].[' + pair.parent_table + ']', 'U')
			  and fk.key_index_id = kc.unique_index_id)
	)
	select
		'alter table [dbo].[' + child_table + '] add ' +
		case when LEN(fk_name) <= 128 then 'constraint [' + fk_name + '] ' else '' end +
		'foreign key (ObjectId) references [dbo].[' + parent_table + '] ([' + parent_key_column + ']) on delete cascade on update cascade'
	from keys_to_create
	open keys_cursor
	while 1=1
	begin
		fetch next from keys_cursor into @fk_sql
		if @@FETCH_STATUS != 0 break
	
		exec dbo.sp_executesql @fk_sql
	end
	close keys_cursor
						
    insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go
