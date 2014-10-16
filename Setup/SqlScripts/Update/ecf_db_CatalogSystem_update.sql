/********************************************************************
             Pre Release Upgrade Script
*********************************************************************/

----November 27, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNodeSearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @InsertQuery_tmp nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname


	-- Create a temp table to store the select results
	CREATE TABLE #PageIndex
	(
	    IndexId int IDENTITY (1, 1) NOT NULL,
	    ObjectId int,
	    Rank int
	)

		-- 1. Cycle through all the available catalog node meta classes
		print ''Iterating through meta classes''
		DECLARE MetaClassCursor CURSOR READ_ONLY
		FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
			WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
			and C.IsSystem = 0 and C2.[Name] = ''CatalogNode''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
			end

			-- Attach the system table
			-- use static join string here instead of dynamic, since we know it is always going to be CatalogEntry
			set @JoinQuery_tmp = ''INNER JOIN [CatalogNode] SYS_TBL ON SYS_TBL.[CatalogNodeId] = META.[KEY]''
			--EXEC [dbo].[ecf_ord_CreateMetaJoinQuery] ''META.[KEY]'', @TableName_tmp, @JoinQuery_tmp OUT

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			-- Create insert command
			SET @InsertQuery_tmp = N''INSERT INTO #PageIndex (ObjectId, Rank) '' + N'' SELECT [Key], Rank '' + N'' FROM ('' + @query_tmp + N'') META '' + @JoinQuery_tmp

			-- print @InsertQuery_tmp
			EXEC (@InsertQuery_tmp) 

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Insert items to the sorted list

	CREATE TABLE #PageIndexSorted
	(
	    IndexId int IDENTITY (1, 1) NOT NULL,
	    ObjectId int,
	    Rank int
	)

	
	set @FilterQuery_tmp = N''SELECT DISTINCT ObjectId, Rank FROM #PageIndex INNER JOIN CatalogNode ON ObjectId = CatalogNode.CatalogNodeId''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN CatalogNodeRelation NR ON CatalogNode.CatalogNodeId = NR.ChildNodeId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN [Catalog] CR ON NR.CatalogId = NR.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN [Catalog] C ON C.CatalogId = CatalogNode.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CN ON CatalogNode.ParentNodeId = CN.CatalogNodeId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CNR ON NR.ParentNodeId = CNR.CatalogNodeId''


	/* CATALOG AND NODE FILTERING */
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ((C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CN.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = '''' + @FilterQuery_tmp + N'') OR ((CR.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CNR.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	
	set @FilterQuery_tmp = ''('' + @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	if(Len(@OrderBy) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' ORDER BY '' + @OrderBy

	SET @InsertQuery_tmp = N''INSERT INTO #PageIndexSorted (ObjectId, Rank) '' + @FilterQuery_tmp

	print ''Insert QRY: '' + @InsertQuery_tmp
	exec(@InsertQuery_tmp)

	set @RecordCount = @@rowcount
	
	INSERT INTO CatalogNodeSearchResults (SearchSetId, CatalogNodeId)
	SELECT DISTINCT @SearchSetId, ObjectId 
	FROM #PageIndexSorted 
	WHERE
	ObjectId in 
	(
		select ObjectId from #PageIndexSorted where IndexId > @StartingRec AND IndexId <= @StartingRec + @NumRecords
	)
	--ORDER BY IndexId

	DROP TABLE #PageIndex
	DROP TABLE #PageIndexSorted

	SET NOCOUNT OFF
END
' 

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_CatalogNode]
    @SearchSetId uniqueidentifier
AS
BEGIN

	SELECT N.* from [CatalogNode] N
	WHERE
		N.CatalogNodeId IN (SELECT [CatalogNodeId] FROM [CatalogNodeSearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.CatalogNodeId IN (SELECT [CatalogNodeId] FROM [CatalogNodeSearchResults] WHERE [SearchSetId] = @SearchSetId)

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM CatalogNodeSearchResults WHERE @SearchSetId = SearchSetId

END

' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 2;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @InsertQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	-- Create filter query
	--set @FilterQuery_tmp = N''INNER JOIN CatalogEntry ON ObjectId = CatalogEntry.CatalogEntryId''	
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN NodeEntryRelation NodeEntryRelation ON NodeEntryRelation.CatalogEntryId = CatalogEntry.CatalogEntryId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN Variation Variation ON Variation.CatalogEntryId = CatalogEntry.CatalogEntryId''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	/*
	if(Len(@OrderBy) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' ORDER BY '' + @OrderBy
	*/

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end

		-- Attach the system table
		-- use static join string here instead of dynamic, since we know it is always going to be CatalogEntry
		set @JoinQuery_tmp = ''INNER JOIN [CatalogEntry] ON CatalogEntry.[CatalogEntryId] = META.[KEY]''
		--EXEC [dbo].[ecf_ord_CreateMetaJoinQuery] ''META.[KEY]'', @TableName_tmp, @JoinQuery_tmp OUT

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
		
		-- Create insert command
		SET @InsertQuery_tmp = N''FROM ('' + @query_tmp + N'') META '' + @JoinQuery_tmp + @FilterQuery_tmp

		-- order by statement here
		if(Len(@OrderBy) = 0)
			set @OrderBy = ''CatalogEntry.CatalogEntryId''

		if(@FullQuery is null)
			set @FullQuery = N''SELECT [Key], Rank, ROW_NUMBER() OVER(PARTITION BY [Catalog].CatalogId ORDER BY '' + @OrderBy + N'') RowNumber '' + @InsertQuery_tmp
		else
			set @FullQuery = N'' UNION SELECT [Key], Rank, ROW_NUMBER() OVER(PARTITION BY [Catalog].CatalogId ORDER BY '' + @OrderBy + N'') RowNumber '' + @InsertQuery_tmp

		--SET @InsertQuery_tmp = N''INSERT INTO #PageIndex (ObjectId, Rank) '' + N'' SELECT [Key], Rank '' + N'' FROM ('' + @query_tmp + N'') META '' + @JoinQuery_tmp + @FilterQuery_tmp

		--print @InsertQuery_tmp
		--EXECUTE sp_executesql ''select @RecordCount = count(*) '' + @InsertQuery_tmp

		-- Count the records
		if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			declare @RecordCount_temp int
			set @SelectCountQuery_tmp = N''select @RecordCount = count(*) '' + @InsertQuery_tmp
			exec sp_executesql @SelectCountQuery_tmp, N''@RecordCount int output'', @RecordCount = @RecordCount_temp OUTPUT
			set @RecordCount = @RecordCount + @RecordCount_temp
		end

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--set @RecordCount = @@rowcount

	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', [Key] as ObjectId FROM OrderedResults WHERE RowNumber BETWEEN '' + cast(@StartingRec as nvarchar(50)) + '' AND '' + cast(@StartingRec + @NumRecords as nvarchar(50)) + '';''
	--print(@FullQuery)
	exec(@FullQuery)
	SET NOCOUNT OFF
END
' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 3;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @InsertQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN NodeEntryRelation NodeEntryRelation ON NodeEntryRelation.CatalogEntryId = CatalogEntry.CatalogEntryId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN Variation Variation ON Variation.CatalogEntryId = CatalogEntry.CatalogEntryId''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
		
		-- Create insert command
		SET @InsertQuery_tmp = N''FROM [CatalogEntry]'' + N'' LEFT OUTER JOIN ('' + @query_tmp + N'') META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

		-- order by statement here
		if(Len(@OrderBy) = 0)
			set @OrderBy = ''CatalogEntry.CatalogEntryId''

		if(@FullQuery is null)
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(PARTITION BY [Catalog].CatalogId ORDER BY '' + @OrderBy + N'') RowNumber '' + @InsertQuery_tmp
		else
			set @FullQuery = N'' UNION SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(PARTITION BY [Catalog].CatalogId ORDER BY '' + @OrderBy + N'') RowNumber '' + @InsertQuery_tmp

		-- Count the records
		if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			declare @RecordCount_temp int
			set @SelectCountQuery_tmp = N''select @RecordCount = count(*) '' + @InsertQuery_tmp
			exec sp_executesql @SelectCountQuery_tmp, N''@RecordCount int output'', @RecordCount = @RecordCount_temp OUTPUT
			set @RecordCount = @RecordCount + @RecordCount_temp
		end

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--set @RecordCount = @@rowcount

	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId FROM OrderedResults WHERE RowNumber BETWEEN '' + cast(@StartingRec + 1 as nvarchar(50)) + '' AND '' + cast(@StartingRec + @NumRecords as nvarchar(50)) + '';''
	--print(@FullQuery)
	exec(@FullQuery)
	SET NOCOUNT OFF
END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 4;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @InsertQuery_tmp nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname


	-- Create a temp table to store the select results
	CREATE TABLE #PageIndex
	(
	    IndexId int IDENTITY (1, 1) NOT NULL,
	    ObjectId int,
	    Rank int
	)

		-- 1. Cycle through all the available product meta classes
		print ''Iterating through meta classes''
		DECLARE MetaClassCursor CURSOR READ_ONLY
		FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
			WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
			and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
			end

			-- Attach the system table
			-- use static join string here instead of dynamic, since we know it is always going to be CatalogEntry
			set @JoinQuery_tmp = ''INNER JOIN [CatalogEntry] SYS_TBL ON SYS_TBL.[CatalogEntryId] = META.[KEY]''
			--EXEC [dbo].[ecf_ord_CreateMetaJoinQuery] ''META.[KEY]'', @TableName_tmp, @JoinQuery_tmp OUT

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			-- Create insert command
			SET @InsertQuery_tmp = N''INSERT INTO #PageIndex (ObjectId, Rank) '' + N'' SELECT [Key], Rank '' + N'' FROM ('' + @query_tmp + N'') META '' + @JoinQuery_tmp


			print @InsertQuery_tmp
			EXEC (@InsertQuery_tmp) 

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Insert items to the sorted list

	CREATE TABLE #PageIndexSorted
	(
	    IndexId int IDENTITY (1, 1) NOT NULL,
	    ObjectId int,
	    Rank int
	)

	
	set @FilterQuery_tmp = N''SELECT ObjectId, Rank FROM #PageIndex INNER JOIN CatalogEntry ON ObjectId = CatalogEntry.CatalogEntryId''
	
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN Catalog C ON C.CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = CatalogEntry.CatalogEntryId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN Variation Variation ON Variation.CatalogEntryId = CatalogEntry.CatalogEntryId''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CN.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	if(Len(@OrderBy) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' ORDER BY '' + @OrderBy

	SET @InsertQuery_tmp = N''INSERT INTO #PageIndexSorted (ObjectId, Rank) '' + @FilterQuery_tmp

	--exec(@FilterQuery_tmp)
	--print ''Insert QRY: '' + @InsertQuery_tmp
	exec(@InsertQuery_tmp)

	set @RecordCount = @@rowcount

	INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId)
	SELECT @SearchSetId, ObjectId 
	FROM #PageIndexSorted 
	WHERE
	ObjectId in 
	(
		select distinct ObjectId from #PageIndexSorted where IndexId > @StartingRec AND IndexId <= @StartingRec + @NumRecords
	)
	ORDER BY IndexId

	DROP TABLE #PageIndex
	DROP TABLE #PageIndexSorted

	SET NOCOUNT OFF
END
' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_CatalogEntry]
    @SearchSetId uniqueidentifier
AS
BEGIN

	SELECT N.* from [CatalogEntry] N INNER JOIN [CatalogEntrySearchResults] R ON N.CatalogEntryId = R.CatalogEntryId where R.[SearchSetId] = @SearchSetId

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT * from Offer
	WHERE
		CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END
'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 5;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: December 4, 2007
	Known issues:
		- Procedure was not tested with multiple meta classes, might not work correctly.
	TODO:
		- need to improve performance by using count(*) over() instead of current two way execution
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @InsertQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON NodeEntryRelation.CatalogEntryId = CatalogEntry.CatalogEntryId''
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' LEFT OUTER JOIN Variation Variation ON Variation.CatalogEntryId = CatalogEntry.CatalogEntryId''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
		
		-- Create insert command
		SET @InsertQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN ('' + @query_tmp + N'') META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

		-- order by statement here
		if(Len(@OrderBy) = 0)
			set @OrderBy = ''CatalogEntry.CatalogEntryId''

		if(@FullQuery is null)
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @InsertQuery_tmp
		else
			set @FullQuery = N'' UNION SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @InsertQuery_tmp

		-- Count the records
		if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			declare @RecordCount_temp int
			set @SelectCountQuery_tmp = N''select @RecordCount = count(*) '' + @InsertQuery_tmp
			exec sp_executesql @SelectCountQuery_tmp, N''@RecordCount int output'', @RecordCount = @RecordCount_temp OUTPUT
			set @RecordCount = @RecordCount + @RecordCount_temp
		end

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--set @RecordCount = @@rowcount

	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	--set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId) SELECT DISTINCT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec + 1 as nvarchar(50)) + '' and RowNumber <= '' + cast(@StartingRec + 1 + @NumRecords as nvarchar(50)) + '' ;''
	--print(@FullQuery)
	exec(@FullQuery)
	SET NOCOUNT OFF
END

' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 6;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: December 5, 2007
	Known issues:
		no known issues
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select * from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0)
		set @OrderBy = ''CatalogEntry.CatalogEntryId''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp

			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			set @FullQuery = ''declare @Page_temp table (TotalRecords int,ObjectId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 7;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'DROP TABLE [dbo].[CatalogEntrySearchResults]'
EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[CatalogEntrySearchResults](
	[SearchSetId] [uniqueidentifier] NOT NULL,
	[CatalogEntryId] [int] NOT NULL,
	[Created] [datetime] NULL CONSTRAINT [DF__CatalogEn__Creat__0EF836A4]  DEFAULT (getutcdate()),
	[SortOrder] [int] NULL
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[CatalogEntrySearchResults]  WITH CHECK ADD  CONSTRAINT [FK_CatalogEntrySearchResults_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [dbo].[CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[CatalogEntrySearchResults] CHECK CONSTRAINT [FK_CatalogEntrySearchResults_CatalogEntry]'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: December 5, 2007
	Known issues:
		no known issues
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', META.* from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select * from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0)
		set @OrderBy = ''CatalogEntry.CatalogEntryId''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp

			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			set @FullQuery = ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END
' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_CatalogEntry]
    @SearchSetId uniqueidentifier
AS
BEGIN

/*
	SELECT C.* from CatalogEntry C
	WHERE
		C.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)
*/
	SELECT N.* from [CatalogEntrySearchResults] R LEFT JOIN [CatalogEntry] N ON N.CatalogEntryId = R.CatalogEntryId 
	where R.[SearchSetId] = @SearchSetId
	order by SortOrder
		
	--SELECT N.* from [CatalogEntry] N INNER JOIN [CatalogEntrySearchResults] R ON N.CatalogEntryId = R.CatalogEntryId where R.[SearchSetId] = @SearchSetId

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT * from Offer
	WHERE
		CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 8;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @SearchSetId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
	INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId)
	SELECT @SearchSetId, [OrderGroupId] FROM [OrderGroup_ShoppingCart] C INNER JOIN OrderGroup OG ON C.ObjectId = OG.OrderGroupId WHERE (C.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
END
' 
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @SearchSetId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64)
AS
BEGIN
	INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId)
	SELECT @SearchSetId, [OrderGroupId] FROM [OrderGroup_PaymentPlan] PO INNER JOIN OrderGroup OG ON PO.ObjectId = OG.OrderGroupId WHERE ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId
END' 

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan_Customer]
	@ApplicationId uniqueidentifier,
    @SearchSetId uniqueidentifier,
    @CustomerId uniqueidentifier
AS
BEGIN
	INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId)
	SELECT @SearchSetId, [OrderGroupId] FROM [OrderGroup_PaymentPlan] PO INNER JOIN OrderGroup OG ON PO.ObjectId = OG.OrderGroupId WHERE ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
END' 

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @SearchSetId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
	INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId)
	SELECT @SearchSetId, [OrderGroupId] FROM [OrderGroup_PaymentPlan] PO INNER JOIN OrderGroup OG ON PO.ObjectId = OG.OrderGroupId WHERE (PO.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- 12/25/2007 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 9;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Variation]
    @CatalogEntryId int
AS
BEGIN
	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId = @CatalogEntryId

	SELECT * from [SalePrice]
	WHERE
		[ItemCode] IN (SELECT [Code] FROM [CatalogEntry] WHERE [CatalogEntryId] = @CatalogEntryId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId = @CatalogEntryId
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_CatalogEntry]
    @SearchSetId uniqueidentifier
AS
BEGIN
	SELECT N.* from [CatalogEntrySearchResults] R LEFT JOIN [CatalogEntry] N ON N.CatalogEntryId = R.CatalogEntryId 
	where R.[SearchSetId] = @SearchSetId
	order by SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT SP.* from [SalePrice] SP
	INNER JOIN [CatalogEntry] E ON E.Code = SP.ItemCode
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---------------------- 12/28/2007 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 10;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[Offer] DROP CONSTRAINT [FK_VariationOffer_ProductVariation]'
EXEC dbo.sp_executesql @statement = N'DROP TABLE [dbo].[Offer]'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---------------------- 11/01/2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 11;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[CatalogNodeRelation]
	DROP CONSTRAINT [FK_CatalogItemCategory_CatalogItem]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[CatalogNodeRelation] ADD CONSTRAINT
	[FK_CatalogItemCategory_CatalogItem] FOREIGN KEY
	(
	ChildNodeId
	) REFERENCES [dbo].[CatalogNode]
	(
	CatalogNodeId
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNode]
    @CatalogId int,
	@ParentNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT * FROM [CatalogNode] WHERE CatalogNodeId IN
		(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			N.CatalogId = @CatalogId AND (N.ParentNodeId = @ParentNodeId OR NR.ParentNodeId = @ParentNodeId) AND
			((N.IsActive = 1) or @ReturnInactive = 1))

	SELECT S.* from CatalogItemSeo S WHERE CatalogNodeId IN
	(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			N.CatalogId = @CatalogId AND (N.ParentNodeId = @ParentNodeId OR NR.ParentNodeId = @ParentNodeId) AND
			((N.IsActive = 1) or @ReturnInactive = 1))

END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---------------------- 11/01/2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 12;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNode]
    @CatalogId int,
	@ParentNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT * FROM [CatalogNode] WHERE CatalogNodeId IN
		(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			((N.CatalogId = @CatalogId AND N.ParentNodeId = @ParentNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @ParentNodeId)) AND
			((N.IsActive = 1) or @ReturnInactive = 1))

	SELECT S.* from CatalogItemSeo S WHERE CatalogNodeId IN
	(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			((N.CatalogId = @CatalogId AND N.ParentNodeId = @ParentNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @ParentNodeId)) AND
			((N.IsActive = 1) or @ReturnInactive = 1))

END'

EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [CategoryDeleteTrigger] ON [dbo].[CatalogNode] 
FOR DELETE 
AS
BEGIN
	DELETE [CatalogNodeRelation] WHERE ParentNodeId IN (SELECT CatalogNodeId FROM [deleted])
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 13;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: February 5, 2007
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		no known issues
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct * from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0)
		set @OrderBy = ''CatalogEntry.CatalogEntryId''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp

			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			set @FullQuery = ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 14;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##


EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Associated]
    @CatalogEntryId int,
	@AssociationName nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null

	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAccociation CA ON CA.CatalogEntryId = A.CatalogEntryId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAccociation CA ON CA.CatalogEntryId = A.CatalogEntryId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
' 

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
    @CatalogEntryCode nvarchar(50),
	@AssociationName nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null

	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		N.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAccociation CA ON CA.CatalogEntryId = A.CatalogEntryId
	WHERE
		N.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 15;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Associated]
    @CatalogEntryId int,
	@AssociationName nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null

	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END' 

EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
    @CatalogEntryCode nvarchar(50),
	@AssociationName nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((NE.IsActive = 1) or @ReturnInactive = 1)
	
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 16;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

BEGIN
CREATE TABLE [dbo].[CatalogItemAsset](
	[CatalogNodeId] [int] NULL,
	[CatalogEntryId] [int] NULL,
	[AssetType] [nvarchar](254) NOT NULL,
	[AssetKey] [nvarchar](254) NOT NULL
) ON [PRIMARY]
END

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_Asset]
    @CatalogEntryId int
AS
BEGIN
	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogEntryId = @CatalogEntryId
END' 

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_Asset]
    @CatalogNodeId int
AS
BEGIN
	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogNodeId = @CatalogNodeId
END
' 

ALTER TABLE [dbo].[CatalogItemAsset]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItemAsset_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [dbo].[CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemAsset_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]'))
ALTER TABLE [dbo].[CatalogItemAsset]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItemAsset_CatalogNode] FOREIGN KEY([CatalogNodeId])
REFERENCES [dbo].[CatalogNode] ([CatalogNodeId])

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 17;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemAsset_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]'))
ALTER TABLE [dbo].[CatalogItemAsset] DROP CONSTRAINT [FK_CatalogItemAsset_CatalogEntry]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemAsset_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]'))
ALTER TABLE [dbo].[CatalogItemAsset] DROP CONSTRAINT [FK_CatalogItemAsset_CatalogNode]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]') AND type in (N'U'))
DROP TABLE [dbo].[CatalogItemAsset]

CREATE TABLE [dbo].[CatalogItemAsset](
	[CatalogNodeId] [int] NULL,
	[CatalogEntryId] [int] NULL,
	[AssetType] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AssetKey] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GroupName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortOrder] [int] NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[CatalogItemAsset]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItemAsset_CatalogEntry] FOREIGN KEY([CatalogEntryId])
REFERENCES [dbo].[CatalogEntry] ([CatalogEntryId])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[CatalogItemAsset] CHECK CONSTRAINT [FK_CatalogItemAsset_CatalogEntry]

ALTER TABLE [dbo].[CatalogItemAsset]  WITH CHECK ADD  CONSTRAINT [FK_CatalogItemAsset_CatalogNode] FOREIGN KEY([CatalogNodeId])
REFERENCES [dbo].[CatalogNode] ([CatalogNodeId])

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 18;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_CatalogEntry]
    @SearchSetId uniqueidentifier
AS
BEGIN
	SELECT N.* from [CatalogEntrySearchResults] R LEFT JOIN [CatalogEntry] N ON N.CatalogEntryId = R.CatalogEntryId 
	where R.[SearchSetId] = @SearchSetId
	order by SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT SP.* from [SalePrice] SP
	INNER JOIN [CatalogEntry] E ON E.Code = SP.ItemCode
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)
		
	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)		

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 19;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]
	@CatalogName nvarchar(50),
    @CatalogNodeCode nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		CN.Code = @CatalogNodeCode AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		CN.Code = @CatalogNodeCode AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END
' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]
	@CatalogName nvarchar(50),
    @CatalogNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		R.CatalogNodeId = @CatalogNodeId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		R.CatalogNodeId = @CatalogNodeId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNodeId]
	@CatalogId int,
    @CatalogNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	WHERE
		R.CatalogNodeId = @CatalogNodeId AND
		R.CatalogId = @CatalogId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	WHERE
		R.CatalogNodeId = @CatalogNodeId AND
		R.CatalogId = @CatalogId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_ParentEntryId]
    @ParentEntryId int,
	@ClassTypeId nvarchar(50) = '''',
	@RelationTypeId nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@ClassTypeId = '''')
		set @ClassTypeId = null

	if(@RelationTypeId = '''')
		set @RelationTypeId = null

	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		R.ParentEntryId = @ParentEntryId AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND COALESCE(@RelationTypeId, R.RelationTypeId) = R.RelationTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		R.ParentEntryId = @ParentEntryId AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND COALESCE(@RelationTypeId, R.RelationTypeId) = R.RelationTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		no known issues
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct * from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0)
		set @OrderBy = ''NodeEntryRelation.SortOrder''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp

			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			set @FullQuery = ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogName]
    @CatalogName nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT N.* from [CatalogNode] N
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY N.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)	

END
' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_SiteId]
    @SiteId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogNode] N 
	INNER JOIN SiteCatalog SC ON SC.CatalogId = N.CatalogId
	WHERE
		N.ParentNodeId = 0 AND
		SC.SiteId = @SiteId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY N.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	INNER JOIN SiteCatalog SC ON SC.CatalogId = N.CatalogId
	WHERE
		N.ParentNodeId = 0 AND
		SC.SiteId = @SiteId AND
		((N.IsActive = 1) or @ReturnInactive = 1)	

END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNode]
    @CatalogId int,
	@ParentNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT * FROM [CatalogNode] WHERE CatalogNodeId IN
		(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			((N.CatalogId = @CatalogId AND N.ParentNodeId = @ParentNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @ParentNodeId)) AND
			((N.IsActive = 1) or @ReturnInactive = 1))
	ORDER BY SortOrder

	SELECT S.* from CatalogItemSeo S WHERE CatalogNodeId IN
	(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			((N.CatalogId = @CatalogId AND N.ParentNodeId = @ParentNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @ParentNodeId)) AND
			((N.IsActive = 1) or @ReturnInactive = 1))

END
' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogId]
    @CatalogId int,
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT N.* from [CatalogNode] N
	WHERE
		N.CatalogId = @CatalogId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY N.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.CatalogId = @CatalogId AND
		((N.IsActive = 1) or @ReturnInactive = 1)	

END
' 


--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO



-- March 27, 2008
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 20;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Name]
    @Name nvarchar(50) = '''',
	@ClassTypeId nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@ClassTypeId = '''')
		set @ClassTypeId = null

	if(@Name = '''')
		set @Name = null

	SELECT N.* from [CatalogEntry] N
	WHERE
		N.[Name] like @Name AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT DISTINCT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		N.[Name] like @Name AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-- March 30, 2008
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 21;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		no known issues
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0)
		set @OrderBy = ''NodeEntryRelation.SortOrder''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp

			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			set @FullQuery = ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-- April 1, 2008
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 22;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		no known issues
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin

			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0)
		set @OrderBy = ''NodeEntryRelation.SortOrder''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp

			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			set @FullQuery = ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-- April 2, 2008
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 23;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_CatalogName]
	@CatalogName nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN [Catalog] C ON N.CatalogId = C.CatalogId
	WHERE
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN [Catalog] C ON N.CatalogId = C.CatalogId
	WHERE
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)

END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-- April 2, 2008
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 24;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified
	if(Len(@CatalogNodes) != 0/* and CHARINDEX('','', @CatalogNodes) != 0*/)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogEntry.CatalogId in (select * from @Catalogs_temp))''

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0 and CHARINDEX('','', @CatalogNodes) != 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')));''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-- April 2, 2008
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 25;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified
	if(Len(@CatalogNodes) != 0/* and CHARINDEX('','', @CatalogNodes) != 0*/)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogEntry.CatalogId in (select * from @Catalogs_temp)''

	-- If node specified, make sure to unclude items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')));''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END
' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---- April 4, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 26;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_ParentEntryId]
    @ParentEntryId int,
	@ClassTypeId nvarchar(50) = '''',
	@RelationTypeId nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@ClassTypeId = '''')
		set @ClassTypeId = null

	if(@RelationTypeId = '''')
		set @RelationTypeId = null

	SELECT N.*, R.Quantity, R.RelationTypeId, R.GroupName, R.SortOrder from [CatalogEntry] N
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		R.ParentEntryId = @ParentEntryId AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND COALESCE(@RelationTypeId, R.RelationTypeId) = R.RelationTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		R.ParentEntryId = @ParentEntryId AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND COALESCE(@RelationTypeId, R.RelationTypeId) = R.RelationTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- April 8, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 27;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')));''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- April 21, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 28;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry]'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] '' + @FilterQuery_tmp

	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---- April 24, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 29;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogNodeRelation ADD CONSTRAINT
	PK_CatalogNodeRelation PRIMARY KEY CLUSTERED 
	(
	CatalogId,
	ParentNodeId,
	ChildNodeId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogEntryRelation ADD CONSTRAINT
	PK_CatalogEntryRelation PRIMARY KEY CLUSTERED 
	(
	ParentEntryId,
	ChildEntryId,
	RelationTypeId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.NodeEntryRelation ADD CONSTRAINT
	PK_NodeEntryRelation PRIMARY KEY CLUSTERED 
	(
	CatalogId,
	CatalogEntryId,
	CatalogNodeId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---- April 29, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 30;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CreateTableJoinQuery]
(
	@SourceTableName   	sysname,	
	@TargetQuery 	sysname,
	@SourceJoinKey		sysname, 
	@TargetJoinKey		sysname,
	@JoinType			nvarchar(50),
	@JoinQuery 			nvarchar(max) OUTPUT
)
AS
BEGIN

	SET @SourceTableName = LTRIM(RTRIM(@SourceTableName))

	IF (SUBSTRING(@SourceTableName, 1, 1) <> N''['' OR SUBSTRING(@SourceTableName, LEN(@SourceTableName),1) <> N'']'')
	BEGIN
		SET @SourceTableName=N''[''+@SourceTableName+N'']''
	END
	
	SET @TargetQuery = LTRIM(RTRIM(@TargetQuery))
/*
	IF (SUBSTRING(@TargetTableName, 1, 1) <> N''['' OR SUBSTRING(@TargetTableName, LEN(@TargetTableName),1) <> N'']'')
	BEGIN
		SET @TargetTableName=N''[''+@TargetTableName+N'']''
	END
*/
	--set @JoinQuery = @JoinType + N'' '' + @TargetTableName + N'' '' + @TargetTableName + N'' ON '' + @SourceTableName + N''.['' + @SourceJoinKey + N''] = '' + @TargetTableName + N''.['' + @TargetJoinKey + N'']''
	set @JoinQuery = @JoinType + N'' '' + @TargetQuery + N'' ON '' + @SourceTableName + N''.['' + @SourceJoinKey + N''] = '' + @TargetJoinKey
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				nvarchar(50),	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.* /*, LOC.**/ FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId '' +
			N'' WHERE LOC.Language = '''''' + @Language + N''''''''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END' 


EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@JoinType					nvarchar(50),
	@SourceTableName			sysname,
	@TargetQuery			sysname,
	@SourceJoinKey				sysname,
	@TargetJoinKey				sysname,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	April 24, 2008
		- added support for joining tables
		- added language filters for meta fields
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_CreateFTSQuery] @Language, @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry] CatalogEntry'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] ''

	-- attach inner join if needed
	if(@JoinType is not null and Len(@JoinType) > 0)
	begin
		set @Query_tmp = ''''
		EXEC [ecf_CreateTableJoinQuery] @SourceTableName, @TargetQuery, @SourceJoinKey, @TargetJoinKey, @JoinType, @Query_tmp OUT
		print(@Query_tmp)
		set @FromQuery_tmp = @FromQuery_tmp + N'' '' + @Query_tmp
	end
	--print(@FromQuery_tmp)
	
	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---- May 15, 2008------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 31;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogEntryAssociation ADD CONSTRAINT
	PK_CatalogEntryAssociation PRIMARY KEY CLUSTERED 
	(
	CatalogAssociationId,
	CatalogEntryId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogItemSeo ADD CONSTRAINT
	PK_CatalogItemSeo PRIMARY KEY CLUSTERED 
	(
	LanguageCode,
	Uri
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogLanguage  ADD CONSTRAINT
	PK_CatalogLanguage PRIMARY KEY CLUSTERED 
	(
	CatalogID,
	LanguageCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'


EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Inventory  ADD CONSTRAINT
	PK_Inventory PRIMARY KEY CLUSTERED 
	(
	SkuId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'
	
EXEC dbo.sp_executesql @statement = N'CREATE TABLE dbo.Tmp_MetaStringDictionaryValue
	(
	MetaKey int NOT NULL,
	[Key] nvarchar(100) NOT NULL,
	Value ntext NOT NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'IF EXISTS(SELECT * FROM dbo.MetaStringDictionaryValue)
	 EXEC(''INSERT INTO dbo.Tmp_MetaStringDictionaryValue (MetaKey, [Key], Value)
		SELECT MetaKey, CONVERT(nvarchar(100), [Key]), Value FROM dbo.MetaStringDictionaryValue WITH (HOLDLOCK TABLOCKX)'')'

EXEC dbo.sp_executesql @statement = N'DROP TABLE dbo.MetaStringDictionaryValue'

EXECUTE sp_rename N'dbo.Tmp_MetaStringDictionaryValue', N'MetaStringDictionaryValue', 'OBJECT' 

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.MetaStringDictionaryValue ADD CONSTRAINT
	PK_MetaStringDictionaryValue PRIMARY KEY CLUSTERED 
	(
	MetaKey,
	[Key]
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX IX_MetaStringDictionaryMetaKey ON dbo.MetaStringDictionaryValue
	(
	MetaKey
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'


--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- May 16, 2008------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 32;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemAsset_CatalogEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]'))
ALTER TABLE [dbo].[CatalogItemAsset] DROP CONSTRAINT [FK_CatalogItemAsset_CatalogEntry]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatalogItemAsset_CatalogNode]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatalogItemAsset]'))
ALTER TABLE [dbo].[CatalogItemAsset] DROP CONSTRAINT [FK_CatalogItemAsset_CatalogNode]

EXEC dbo.sp_executesql @statement = N'CREATE TABLE dbo.Tmp_CatalogItemAsset
	(
	CatalogNodeId int NOT NULL,
	CatalogEntryId int NOT NULL,
	AssetType nvarchar(50) NOT NULL,
	AssetKey nvarchar(254) NOT NULL,
	GroupName nvarchar(100) NULL,
	SortOrder int NOT NULL
	)  ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Tmp_CatalogItemAsset ADD CONSTRAINT
	DF_CatalogItemAsset_CatalogNodeId DEFAULT 0 FOR CatalogNodeId'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Tmp_CatalogItemAsset ADD CONSTRAINT
	DF_CatalogItemAsset_CatalogEntryId DEFAULT 0 FOR CatalogEntryId'

EXEC dbo.sp_executesql @statement = N'IF EXISTS(SELECT * FROM dbo.CatalogItemAsset)
	 EXEC(''INSERT INTO dbo.Tmp_CatalogItemAsset (CatalogNodeId, CatalogEntryId, AssetType, AssetKey, GroupName, SortOrder)
		SELECT isnull(CatalogNodeId, 0), isnull(CatalogEntryId, 0), CONVERT(nvarchar(50), AssetType), AssetKey, GroupName, SortOrder FROM dbo.CatalogItemAsset WITH (HOLDLOCK TABLOCKX)'')'

EXEC dbo.sp_executesql @statement = N'DROP TABLE dbo.CatalogItemAsset'

EXECUTE sp_rename N'dbo.Tmp_CatalogItemAsset', N'CatalogItemAsset', 'OBJECT' 

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogItemAsset ADD CONSTRAINT
	PK_CatalogItemAsset PRIMARY KEY CLUSTERED 
	(
	CatalogNodeId,
	CatalogEntryId,
	AssetType,
	AssetKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX IX_CatalogItemAsset_EntryId ON dbo.CatalogItemAsset
	(
	CatalogEntryId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX IX_CatalogItemAsset_NodeId ON dbo.CatalogItemAsset
	(
	CatalogNodeId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- June 27, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 33;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
    @OrderClause nvarchar(100),
    @StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder]
						FROM [CatalogNode] CN WHERE CatalogNodeId IN
					(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
					LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
					WHERE
						((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
						((N.IsActive = 1) or @ReturnInactive = 1))

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0 
						from [CatalogEntry] CE
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId], CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder]
					FROM [CatalogNode] CN WHERE CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId], CE.[Name], CE.ClassTypeId, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0 
					from [CatalogEntry] CE
				INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int, 
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords	int,
						@ReturnInactive	bit'';
	exec sp_executesql @execStmtString, @ParamDefinition, 
			@CatalogId = @CatalogId, 
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords	= @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- July 01, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 34;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
    @OrderClause nvarchar(100),
    @StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder]
						FROM [CatalogNode] CN WHERE CatalogNodeId IN
					(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
					LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
					WHERE
						((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
						((N.IsActive = 1) or @ReturnInactive = 1))

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0 
						from [CatalogEntry] CE
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder]
					FROM [CatalogNode] CN WHERE CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0 
					from [CatalogEntry] CE
				INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int, 
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords	int,
						@ReturnInactive	bit'';
	exec sp_executesql @execStmtString, @ParamDefinition, 
			@CatalogId = @CatalogId, 
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords	= @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 02, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 35;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = N''##MS_DatabaseMasterKey##'')
	CREATE MASTER KEY ENCRYPTION BY PASSWORD = ''5F18E937-6F17-4EED-8265-D2CBC9FEA553'''

EXEC dbo.sp_executesql @statement = N'IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = N''Mediachase_ECF50_MDP'')
	CREATE CERTIFICATE Mediachase_ECF50_MDP WITH SUBJECT = ''Mediachase Certificate'''
	
EXEC dbo.sp_executesql @statement = N'IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = N''Mediachase_ECF50_MDP_Key'')
	CREATE SYMMETRIC KEY Mediachase_ECF50_MDP_Key WITH ALGORITHM = RC4_128 ENCRYPTION BY CERTIFICATE Mediachase_ECF50_MDP'
	
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.MetaField ADD IsEncrypted bit NOT NULL CONSTRAINT DF_MetaField_Encrypt DEFAULT 0'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_OpenSymmetricKey] AS
	OPEN SYMMETRIC KEY Mediachase_ECF50_MDP_Key DECRYPTION BY CERTIFICATE Mediachase_ECF50_MDP'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_CloseSymmetricKey] AS
	CLOSE SYMMETRIC KEY Mediachase_ECF50_MDP_Key'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedure] 
	@MetaClassId	INT
AS
	SET NOCOUNT ON

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is System or not exists.'', 16,1)
		GOTO ERR
	END

	-- Step 1. Create SQL Code
	--PRINT''Step 1. Create SQL Code''

	DECLARE	@MetaClassTable	NVARCHAR(256)
	DECLARE	@MetaClassGetSpName	NVARCHAR(256)
	DECLARE	@MetaClassUpdateSpName NVARCHAR(256)
	DECLARE	@MetaClassDeleteSpName NVARCHAR(256)
	DECLARE	@MetaClassListSpName NVARCHAR(256)
	DECLARE	@MetaClassHistorySpName NVARCHAR(256)

	DECLARE	@CRLF NCHAR(1)

	SELECT @MetaClassTable = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

	SET @MetaClassGetSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Get'' 
	SET @MetaClassUpdateSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Update''
	SET @MetaClassDeleteSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Delete''
	SET @MetaClassListSpName = ''mdpsp_avto_'' +@MetaClassTable +''_List''
	SET @MetaClassHistorySpName	= ''mdpsp_avto_'' +@MetaClassTable +''_History''

	SET @CRLF = CHAR(10)

	-- Step 2. Drop operation
	--PRINT''Step 2. Drop operation''

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassGetSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassGetSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassUpdateSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassUpdateSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassDeleteSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassDeleteSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassListSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassListSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassHistorySpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassHistorySpName)
	IF @@ERROR <> 0 GOTO ERR

	-- Step 3. Create Procedure operation
	--PRINT''Step 3. ALTER Procedure operation''

	DECLARE @OPEN_SYMMETRIC_KEY NVARCHAR(4000)
	DECLARE @CLOSE_SYMMETRIC_KEY NVARCHAR(4000)

	SET @OPEN_SYMMETRIC_KEY = ''''
	SET @CLOSE_SYMMETRIC_KEY = ''''

	DECLARE	@MetaClassFieldList	NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_E	NVARCHAR(4000)
	DECLARE	@MetaClassFieldListWithAt NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet NVARCHAR(4000)
	DECLARE	@MetaClassFieldListInsert NVARCHAR(4000)

	DECLARE	@MetaClassFieldList_L NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L1 NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L2 NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_LI NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L1 NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L2 NVARCHAR(4000)

	SET @MetaClassFieldList = ''ObjectId, CreatorId, Created, ModifierId, Modified''
	SET @MetaClassFieldList_E = ''ObjectId, CreatorId, Created, ModifierId, Modified''
	SET @MetaClassFieldListWithAt = ''@ObjectId INT, @Language NVARCHAR(20)=NULL, @CreatorId nvarchar(100), @Created DATETIME, @ModifierId nvarchar(100), @Modified DATETIME, @Retval INT OUT''
	SET @MetaClassFieldListSet = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListInsert = ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 

	SET @MetaClassFieldList_L = ''T.ObjectId, T.CreatorId, T.Created, T.ModifierId, T.Modified''
	SET @MetaClassFieldListSet_L1 = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListSet_L2 = ''ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldList_LI = ''ObjectId, Language, ModifierId, Modified''
	SET @MetaClassFieldListInsert_L1 =  ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 
	SET @MetaClassFieldListInsert_L2 = ''@ObjectId, @Language, @ModifierId, @Modified'' 

	DECLARE field_cursor CURSOR FOR 
		SELECT MF.[Name], DT.SqlName, DT.Variable, MF.Length, MF.MultiLanguageValue, MF.IsEncrypted FROM MetaField MF 
			INNER JOIN MetaDataType DT ON DT.DataTypeId = MF.DataTypeId
			INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
		WHERE MCFR.MetaClassId = @MetaClassId AND MF.SystemMetaClassId = 0 ORDER BY MCFR.Weight	

	DECLARE @Name 	NVARCHAR(256)
	DECLARE @SqlName 	NVARCHAR(256)
	DECLARE @Variable 	BIT
	DECLARE @Length 	INT
	DECLARE @MultiLanguageValue BIT
	DECLARE @IsEncrypted BIT	
	DECLARE @UseSymmetricKey BIT
	
	SET @UseSymmetricKey = 0

	OPEN field_cursor	
	FETCH NEXT FROM field_cursor INTO @Name, @SqlName, @Variable, @Length, @MultiLanguageValue, @IsEncrypted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @MetaClassFieldList = @MetaClassFieldList + '', ''
		SET @MetaClassFieldList_E = @MetaClassFieldList_E + '', ''
		SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '', ''
		SET @MetaClassFieldListSet = @MetaClassFieldListSet + '', ''
		SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + '', ''
		SET @MetaClassFieldList_L = @MetaClassFieldList_L + '', ''
		SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + '', ''
		SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + '', ''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + '', ''
		SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + '', ''
		SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2  + '', ''

		SET @MetaClassFieldList = @MetaClassFieldList + ''['' + @Name + '']''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + ''['' + @Name + '']''

		IF @IsEncrypted = 1 BEGIN
			SET @UseSymmetricKey = 1 
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''dbo.mdpfn_sys_EncryptDecryptString(['' + @Name + ''], 0) '''''' + @Name + ''''''''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
		END
		ELSE BEGIN
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''['' + @Name + '']''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = @'' + @Name 
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''@'' + @Name 
		END

		IF @MultiLanguageValue = 0
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @Name + ''], 0) '''''' + @Name + ''''''''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''T.['' + @Name + '']''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''@'' + @Name + ''''
			END
			SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + '' NULL ''
		END
		ELSE
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(TL.['' + @Name + ''], 0) '''''' + @Name + ''''''''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)'' 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''TL.['' + @Name + '']''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''@'' + @Name
			END
			SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1 + '' NULL ''
		END

		IF @Variable = 0
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName 
		ELSE
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName + ''('' + CAST(@Length AS NVARCHAR(20)) + '') '' 

	FETCH NEXT FROM field_cursor INTO @Name, @SqlName, @Variable, @Length, @MultiLanguageValue, @IsEncrypted
	END

	CLOSE field_cursor
	DEALLOCATE field_cursor

	IF @UseSymmetricKey = 1 BEGIN
		SET @OPEN_SYMMETRIC_KEY = ''exec mdpsp_sys_OpenSymmetricKey''
		SET @CLOSE_SYMMETRIC_KEY = ''exec mdpsp_sys_CloseSymmetricKey''
	END

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS OFF 

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassGetSpName + ''] ''  + @CRLF +
		'' @ObjectId INT ,''+@CRLF +
		'' @Language NVARCHAR(20)=NULL AS '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T ''+ @CRLF +
		'' LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId   AND TL.Language = @Language WHERE T.ObjectId = @ObjectId'' + @CRLF + @CLOSE_SYMMETRIC_KEY  
		)

	IF @@ERROR <> 0 GOTO ERR

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassUpdateSpName + ''] ''  + @CRLF +
		 @MetaClassFieldListWithAt + 
		'' AS '' + @CRLF +
		'' SET NOCOUNT ON '' + @CRLF +
		'' BEGIN TRAN '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		''  IF @ObjectId = -1 BEGIN ''+ @CRLF + 
		''    SELECT @ObjectId = MAX(ObjectId)+1 FROM '' + @MetaClassTable + '' IF (@ObjectId IS NULL)  SET @ObjectId = 1 END '' + @CRLF +
		'' SET @Retval = @ObjectId '' + @CRLF +
		'' IF @Language IS NULL '' +  @CRLF +
		'' BEGIN '' +  @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' ELSE '' + @CRLF +
		'' BEGIN '' +  @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet_L1 + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert_L1 + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' '' + @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +''_Localization WHERE ObjectId = @ObjectId AND Language = @Language  ) UPDATE '' + @MetaClassTable + ''_Localization SET '' + @MetaClassFieldListSet_L2 + '' WHERE ObjectId = @ObjectId AND Language = @Language '' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + ''_Localization (''+ @MetaClassFieldList_LI + '') VALUES ('' + @MetaClassFieldListInsert_L2 + '')'' + @CRLF + @CLOSE_SYMMETRIC_KEY + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' COMMIT TRAN '' + @CRLF + 
		'' RETURN '' + @CRLF + 
		'' ERR: ROLLBACK TRAN '' + @CRLF + 
		'' RETURN ''
	)

	IF @@ERROR <> 0  GOTO ERR
	--PRINT @MetaClassUpdateSpName

	DECLARE @MetaClassIdSTR NVARCHAR(10)
	SET @MetaClassIdSTR = CAST( @MetaClassId AS NVARCHAR(10) )

	EXEC (''CREATE PROCEDURE [dbo].['' + @MetaClassDeleteSpName + '']  @ObjectId INT AS '' + @CRLF +
		'' DELETE FROM ''  + @MetaClassTable + '' WHERE ObjectId = @ObjectId '' +  @CRLF +
		'' DELETE FROM '' + @MetaClassTable + ''_Localization WHERE ObjectId = @ObjectId '' + @CRLF +
		'' DELETE FROM '' + @MetaClassTable +''_History WHERE ObjectId = @ObjectId '' + @CRLF +
		'' EXEC mdpsp_sys_DeleteMetaKeyObjects ''+@MetaClassIdSTR+'', -1, @ObjectId '')

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassDeleteSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassListSpName + ''] ''  + '' @Language NVARCHAR(20)=NULL  AS '' +  @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId  AND TL.Language = @Language'' + @CRLF + @CLOSE_SYMMETRIC_KEY 
		)

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassListSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassHistorySpName + ''] ''  + '' @ObjectId INT, @Language NVARCHAR(20)=NULL  AS ''+  @CRLF +
	'' SELECT * FROM '' +@MetaClassTable + ''_History WHERE ObjectId = @ObjectId AND Language = @Language'' )

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassHistorySpName

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS ON 

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
RETURN'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_LoadMetaField]
	@MetaFieldId	INT
AS	
	SELECT [MetaFieldId] , [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[SaveHistory],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField WHERE MetaFieldId = @MetaFieldId'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByName]
	@Name		NVARCHAR(256)
AS	
	SELECT [MetaFieldId] ,  [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[SaveHistory],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField WHERE  [Name] = @Name	AND SystemMetaClassId = 0'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByNamespace]
	@Namespace		NVARCHAR(1024),
	@Deep			BIT
AS
	IF @Deep = 1 
		SELECT [MetaFieldId] ,  [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[SaveHistory],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
		FROM MetaField WHERE Namespace = @Namespace OR Namespace LIKE (@Namespace + ''.%'')
	ELSE
		SELECT [MetaFieldId] ,  [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[SaveHistory],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
		FROM MetaField WHERE Namespace = @Namespace'
		
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldList]
AS	
	SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[SaveHistory],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]
	@MetaClassId INT
AS	
	SELECT MF.[MetaFieldId], MF.[Namespace], MF.[Name], MF.[FriendlyName], MF.[Description], MF.[SystemMetaClassId] , MF.[DataTypeId], MF.[Length], MF.[AllowNulls], MF.[SaveHistory], MF.[MultiLanguageValue], MF.[AllowSearch] , MF.Tag, MF.[IsEncrypted], MCFR.[Weight], MCFR.[Enabled]
		FROM MetaField MF
	INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
	WHERE MCFR.MetaClassId = @MetaClassId
	ORDER BY MCFR.[Weight]'
					
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_AddMetaField] 
	@Namespace 		NVARCHAR(1024) = N''Mediachase.MetaDataPlus.User'',
	@Name		NVARCHAR(256),
	@FriendlyName	NVARCHAR(256),
	@Description	NTEXT,
	@DataTypeId	INT,
	@Length	INT,
	@AllowNulls	BIT,
	@SaveHistory	BIT,
	@MultiLanguageValue BIT, 
	@AllowSearch	BIT,
	@IsEncrypted	BIT,
	@Retval 	INT OUTPUT
AS
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
	INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [Description], [DataTypeId], [Length], [AllowNulls],  [SaveHistory], [MultiLanguageValue], [AllowSearch], [IsEncrypted])
		VALUES(@Namespace, @Name,  @FriendlyName, @Description, @DataTypeId, @Length, @AllowNulls, @SaveHistory,@MultiLanguageValue, @AllowSearch, @IsEncrypted)

	IF @@ERROR <> 0 GOTO ERR

	SET @Retval = IDENT_CURRENT(''[MetaField]'')

	COMMIT TRAN
RETURN

ERR:
	SET @Retval = -1
	ROLLBACK TRAN
RETURN'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_RefreshSystemMetaClassInfo] 
	@MetaClassId	INT
AS
	SET NOCOUNT ON

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
	INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls],  [SaveHistory], [MultiLanguageValue], [AllowSearch], [IsEncrypted])
			 SELECT @Namespace+ N''.'' + @Name, SC .[name] , SC .[name] , @MetaClassId ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0, 0  FROM SYSCOLUMNS AS SC  
				INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.ID 
				INNER JOIN SYSTYPES ST ON ST.[xtype] = SC .[xtype]
				INNER JOIN MetaDataType MDT ON MDT.[Name] = ST .[name]
			WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname''
			ORDER BY COLORDER /* Aug 29, 2006 */
	
	IF @@ERROR<> 0 GOTO ERR

	INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
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
' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_AddMetaFieldToMetaClass] 
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Weight	INT
AS
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
		DECLARE @SaveHistory	BIT
		DECLARE @MultiLanguageValue BIT
		DECLARE @AllowSearch	BIT
		DECLARE @IsEncrypted	BIT
	
		SELECT @Name = [Name], @DataTypeId = DataTypeId,  @Length = [Length], @AllowNulls = AllowNulls, 
			@SaveHistory = SaveHistory, @MultiLanguageValue = MultiLanguageValue, @AllowSearch = AllowSearch, @IsEncrypted = IsEncrypted
		FROM [MetaField] WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0 
	
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
		DECLARE @ExecLineHistory 		NVARCHAR(1024)
		DECLARE @ExecLineLocalization 	NVARCHAR(1024)
		
		SET @ExecLine = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''] ADD [''+@Name+''] '' + @SqlDataTypeName
		SET @ExecLineHistory = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''_History] ADD [''+@Name+''] '' + @SqlDataTypeName
		SET @ExecLineLocalization = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''_Localization] ADD [''+@Name+''] '' + @SqlDataTypeName
	
		IF @IsVariableDataType = 1 
		BEGIN
			SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
			SET @ExecLineHistory = @ExecLineHistory + '' ('' + STR(@Length) + '')''
			SET @ExecLineLocalization = @ExecLineLocalization + '' ('' + STR(@Length) + '')''
		END
	
		SET @ExecLineHistory = @ExecLineHistory + '' NULL''
		SET @ExecLineLocalization = @ExecLineLocalization + '' NULL''
	
		IF @AllowNulls = 1 
		BEGIN
			SET @ExecLine = @ExecLine + '' NULL''
			--SET @ExecLineHistory = @ExecLineHistory + '' NULL''
		END
		ELSE
			BEGIN
				SET @ExecLine = @ExecLine + '' NOT NULL DEFAULT '' + @DefaultValue 
				--SET @ExecLineHistory = @ExecLineHistory + '' NOT NULL DEFAULT '' + @DefaultValue
	
				--IF @IsVariableDataType = 1 
				--BEGIN
					--SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
					--SET @ExecLineHistory = @ExecLineHistory + '' ('' + STR(@Length) + '')''
				--END
	
				SET @ExecLine = @ExecLine  +''  WITH VALUES'' 
				--SET @ExecLineHistory = @ExecLineHistory  +''  WITH VALUES'' 
			END
	
		--PRINT (@ExecLine)
		--PRINT (@ExecLineHistory)
	
		-- Step 1-2. Create a new column.
		EXEC (@ExecLine)
	
		IF @@ERROR<> 0 GOTO ERR
	
		-- Step 1-2. Create a new history column.
		EXEC (@ExecLineHistory)
	
		IF @@ERROR <> 0 GOTO ERR

		-- Step 1-3. Create a new localization column.
		EXEC (@ExecLineLocalization)
	
		IF @@ERROR <> 0 GOTO ERR
	END

	-- Step 1-3. Create or Modify the Trigger 	mdpt_@MetaClassTableName_History

	-- Step 1-4. Create or Modify the View 	mdpv_@MetaClassTableName

	-- Step 2. Insert a record in to MetaClassMetaFieldRelation table.
	INSERT INTO [MetaClassMetaFieldRelation] (MetaClassId, MetaFieldId, Weight) VALUES(@MetaClassId, @MetaFieldId, @Weight)

	IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId
	
		IF @@ERROR <> 0 GOTO ERR
	
		EXEC mdpsp_sys_CreateMetaClassHistoryTrigger @MetaClassId
	
		IF @@ERROR <> 0 GOTO ERR

		EXEC mdpsp_sys_CreateMetaClassLocalizationTrigger @MetaClassId
	
		IF @@ERROR <> 0 GOTO ERR
	END

	--EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1
	
	--IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN

	IF @IsAbstractClass = 0
	BEGIN
		-- execute outside transaction
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1
	END
RETURN

ERR:
	ROLLBACK TRAN
RETURN' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_CreateMetaClass]  
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
	INSERT INTO [MetaClass] ([Namespace],[Name], [FriendlyName],[Description], [TableName], [ParentClassId], [IsSystem], [IsAbstract])
		VALUES (@Namespace, @Name, @FriendlyName, @Description, @TableName, @ParentClassId, @IsSystem, @IsAbstract)

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
		INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls],  [SaveHistory], [MultiLanguageValue], [AllowSearch], [IsEncrypted])
			 SELECT @Namespace+ N''.'' + @Name, SC .[name] , SC .[name] , @Retval ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0, 0  FROM SYSCOLUMNS AS SC  
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
		
			-- Step 2-1. Create the @TableName_History table
			EXEC(''CREATE TABLE [dbo].['' + @TableName  + ''_History] ([Id] [int] IDENTITY (1, 1)  NOT NULL, [ObjectId] [int] NOT NULL , [ModifierId] [nvarchar](100),	[Modified] [datetime], [Language] nvarchar(20) ) ON [PRIMARY]'')
		
			IF @@ERROR <> 0 GOTO ERR
		
			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''_History] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''_History] PRIMARY KEY  CLUSTERED ([Id])  ON [PRIMARY]'') 
		
			IF @@ERROR<> 0 GOTO ERR
	
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
END'			

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_MetaFieldIsEncrypted]
	@MetaFieldId 	INT,
	@IsEncrypted	BIT
AS
	SET NOCOUNT ON

	BEGIN TRAN

	IF NOT EXISTS( SELECT * FROM MetaField WHERE MetaFieldId = @MetaFieldId)
	BEGIN
		RAISERROR (''Wrong @MetaFieldId. The field is system or not exists.'', 16,1)
		GOTO ERR
	END

	UPDATE MetaField SET IsEncrypted = @IsEncrypted WHERE MetaFieldId = @MetaFieldId

	DECLARE class_w_search CURSOR FOR
		SELECT MCMFR.MetaClassId FROM MetaClassMetaFieldRelation MCMFR
			INNER JOIN MetaField MF ON MF.MetaFieldId = MCMFR.MetaFieldId
			INNER JOIN MetaClass MC ON MC.MetaClassId = MCMFR.MetaClassId
		WHERE MCMFR.MetaFieldId = @MetaFieldId AND (MC.IsSystem = 1 OR MF.SystemMetaClassId = 0 )

	DECLARE @MetaClassId INT
	
	OPEN class_w_search	
	FETCH NEXT FROM class_w_search INTO @MetaClassId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0 
		BEGIN
			CLOSE class_w_search
			DEALLOCATE class_w_search

			GOTO ERR
		END

		FETCH NEXT FROM class_w_search INTO @MetaClassId
	END

	CLOSE class_w_search
	DEALLOCATE class_w_search

	COMMIT TRAN
	
RETURN

ERR:
	ROLLBACK TRAN
RETURN'
		
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 03, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 36;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNodeCode]
    @CatalogName nvarchar(100),
	@ParentNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN
	declare @CatalogId int
	declare @ParentNodeId int

	select @CatalogId = CatalogId from [Catalog] where [Name] = @CatalogName
	select @ParentNodeId = CatalogNodeId from [CatalogNode] where Code = @ParentNodeCode

	EXECUTE [ecf_CatalogNode_CatalogParentNode] @CatalogId,@ParentNodeId,@ReturnInactive
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 11, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 37;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_AssetKey]
    @AssetKey nvarchar(254)
AS
BEGIN
	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.AssetKey = @AssetKey
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 22, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 38;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[Warehouse](
	[WarehouseId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CreatorId] [nvarchar](100) NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[ModifierId] [nvarchar](100) NULL,
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[FirstName] [nvarchar](64) NULL,
	[LastName] [nvarchar](64) NULL,
	[Organization] [nvarchar](64) NULL,
	[Line1] [nvarchar](80) NULL,
	[Line2] [nvarchar](80) NULL,
	[City] [nvarchar](64) NULL,
	[State] [nvarchar](64) NULL,
	[CountryCode] [nvarchar](50) NULL,
	[CountryName] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](20) NULL,
	[RegionCode] [nvarchar](50) NULL,
	[RegionName] [nvarchar](64) NULL,
	[DaytimePhoneNumber] [nvarchar](32) NULL,
	[EveningPhoneNumber] [nvarchar](32) NULL,
	[FaxNumber] [nvarchar](32) NULL,
	[Email] [nvarchar](64) NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 30, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 39;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_Inventory_CatalogEntry]'') AND parent_object_id = OBJECT_ID(N''[dbo].[Inventory]''))
ALTER TABLE [dbo].[Inventory] DROP CONSTRAINT [FK_Inventory_CatalogEntry]'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 31, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 40;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_AddMetaFieldToMetaClass] 
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Weight	INT
AS
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
		DECLARE @SaveHistory	BIT
		DECLARE @MultiLanguageValue BIT
		DECLARE @AllowSearch	BIT
		DECLARE @IsEncrypted	BIT
	
		SELECT @Name = [Name], @DataTypeId = DataTypeId,  @Length = [Length], @AllowNulls = AllowNulls, 
			@SaveHistory = SaveHistory, @MultiLanguageValue = MultiLanguageValue, @AllowSearch = AllowSearch, @IsEncrypted = IsEncrypted
		FROM [MetaField] WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0 
	
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
		DECLARE @ExecLineHistory 		NVARCHAR(1024)
		DECLARE @ExecLineLocalization 	NVARCHAR(1024)
		
		SET @ExecLine = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''] ADD [''+@Name+''] '' + @SqlDataTypeName
		SET @ExecLineHistory = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''_History] ADD [''+@Name+''] '' + @SqlDataTypeName
		SET @ExecLineLocalization = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''_Localization] ADD [''+@Name+''] '' + @SqlDataTypeName
	
		IF @IsVariableDataType = 1 
		BEGIN
			SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
			SET @ExecLineHistory = @ExecLineHistory + '' ('' + STR(@Length) + '')''
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
					SET @ExecLineHistory = @ExecLineHistory + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
					SET @ExecLineLocalization = @ExecLineLocalization + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
				END
			END
		END 
	
		SET @ExecLineHistory = @ExecLineHistory + '' NULL''
		SET @ExecLineLocalization = @ExecLineLocalization + '' NULL''
	
		IF @AllowNulls = 1 
		BEGIN
			SET @ExecLine = @ExecLine + '' NULL''
			--SET @ExecLineHistory = @ExecLineHistory + '' NULL''
		END
		ELSE
			BEGIN
				SET @ExecLine = @ExecLine + '' NOT NULL DEFAULT '' + @DefaultValue 
				--SET @ExecLineHistory = @ExecLineHistory + '' NOT NULL DEFAULT '' + @DefaultValue
	
				--IF @IsVariableDataType = 1 
				--BEGIN
					--SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
					--SET @ExecLineHistory = @ExecLineHistory + '' ('' + STR(@Length) + '')''
				--END
	
				SET @ExecLine = @ExecLine  +''  WITH VALUES'' 
				--SET @ExecLineHistory = @ExecLineHistory  +''  WITH VALUES'' 
			END
	
		--PRINT (@ExecLine)
		--PRINT (@ExecLineHistory)
	
		-- Step 1-2. Create a new column.
		EXEC (@ExecLine)
	
		IF @@ERROR<> 0 GOTO ERR
	
		-- Step 1-2. Create a new history column.
		EXEC (@ExecLineHistory)
	
		IF @@ERROR <> 0 GOTO ERR

		-- Step 1-3. Create a new localization column.
		EXEC (@ExecLineLocalization)
	
		IF @@ERROR <> 0 GOTO ERR
	END

	-- Step 1-3. Create or Modify the Trigger 	mdpt_@MetaClassTableName_History

	-- Step 1-4. Create or Modify the View 	mdpv_@MetaClassTableName

	-- Step 2. Insert a record in to MetaClassMetaFieldRelation table.
	INSERT INTO [MetaClassMetaFieldRelation] (MetaClassId, MetaFieldId, Weight) VALUES(@MetaClassId, @MetaFieldId, @Weight)

	IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId
	
		IF @@ERROR <> 0 GOTO ERR
	
		EXEC mdpsp_sys_CreateMetaClassHistoryTrigger @MetaClassId
	
		IF @@ERROR <> 0 GOTO ERR

		EXEC mdpsp_sys_CreateMetaClassLocalizationTrigger @MetaClassId
	
		IF @@ERROR <> 0 GOTO ERR
	END

	--EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1
	
	--IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN

	IF @IsAbstractClass = 0
	BEGIN
		-- execute outside transaction
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1
	END
RETURN

ERR:
	ROLLBACK TRAN
RETURN'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 01, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 41;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				nvarchar(50),	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId '' +
			N'' WHERE LOC.Language = '''''' + @Language + N''''''''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 06, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 42;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

--DECLARE @IsFulltextEnabled INT
--SELECT @IsFulltextEnabled = (CASE FULLTEXTSERVICEPROPERTY( 'IsFullTextInstalled' ) WHEN 1 THEN CASE DatabaseProperty (DB_NAME(DB_ID()),  'IsFulltextEnabled') WHEN 1 THEN 1 ELSE 0 END ELSE 0 END)
--IF @IsFulltextEnabled = 1
--BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate] 
AS 
declare @cur_dbname sysname
set @cur_dbname = db_name(db_id())

declare @execStmt nvarchar(4000)
set @execStmt = N''use ''+@cur_dbname+N'' if (exists(select * from sysfulltextcatalogs where [name]=N''''MetaDataFullTextQueriesCatalog'''')) exec sp_fulltext_catalog N''''MetaDataFullTextQueriesCatalog'''', N''''start_incremental'''' ''

BEGIN TRANSACTION            

declare @ecf5_job_name nvarchar(100)
set @ecf5_job_name = N''ECF50_''+db_name()

  declare @id BINARY(16)  
  declare @ReturnCode int    
  select @ReturnCode = 0     
  IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N''Full-Text'') < 1 
  	EXEC msdb.dbo.sp_add_category @name = N''Full-Text''

  -- Delete the job with the same name (if it exists)
  SELECT @id = job_id from msdb.dbo.sysjobs WHERE name = @ecf5_job_name

  IF (@id IS NOT NULL)    
  BEGIN
	-- Delete the job with the same name
   	exec msdb.dbo.sp_delete_job @job_name = @ecf5_job_name
   	select @id = NULL
  END

  -- Add the job
  exec @ReturnCode = msdb.dbo.sp_add_job @job_name = @ecf5_job_name, 
	@description = N''Repopulates ECF Fulltext catalog every five minutes.'', 
	@enabled = 1, @start_step_id = 1, 
	@notify_level_eventlog = 2, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @delete_level = 0, 
	@category_name = N''Full-Text'', @job_id = @id OUTPUT
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  exec msdb.dbo.sp_help_job @job_id = @id, @job_aspect = N''job''

  -- Add the job steps
  exec @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @id, @step_id = 1, @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @flags = 0, @step_name = N''Full-Text Indexing'', @subsystem = N''TSQL'', @command = @execStmt, @database_name = @cur_dbname
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

  -- Add the job server
  exec @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @id, @server_name = @@servername
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

  -- Add the job schedule
  exec msdb..sp_add_jobschedule @job_id = @id, @name = N''RepopulateSchedule1'', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 5, @freq_relative_interval = 0, @freq_recurrence_factor = 1, @active_start_date = NULL, @active_end_date = 99991231, @active_start_time = 0, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION          
GOTO EndJobCreate
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndJobCreate:'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete] 
AS 
declare @ecf5_job_name nvarchar(100)
set @ecf5_job_name = N''ECF50_''+db_name()

IF EXISTS(SELECT job_id from msdb.dbo.sysjobs WHERE name = @ecf5_job_name)
	exec msdb.dbo.sp_delete_job @job_name = @ecf5_job_name'
--END

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 43;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCatalogSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_CatalogSystem]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_CatalogSystem])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]

	/*DECLARE @Major int, @Minor int, @Patch int, @Installed datetime	

	SELECT @Major = (SELECT max([Major]) FROM [SchemaVersion_CatalogSystem])
	SELECT @Minor = (SELECT max([Minor]) FROM [SchemaVersion_CatalogSystem])
	SELECT @Patch = (SELECT max([Patch]) FROM [SchemaVersion_CatalogSystem])
	SELECT @Installed = (SELECT [InstallDate] FROM [SchemaVersion_CatalogSystem] 
							WHERE [Major]=@Major AND [Minor]=@Minor AND [Patch]=@Patch)

	SELECT @Major as Major, @Minor as Minor, @Patch as Patch, @Installed as InstallDate*/'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 19, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 44;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogId]
	@CatalogId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.CatalogId = @CatalogId

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.CatalogId = @CatalogId
		
	SELECT * FROM [AssociationType]
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 27, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 45;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				nvarchar(50),	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'' WHERE LOC.Language = '''''' + @Language + N'''''''' + 
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId '' +
			N'' WHERE LOC.Language = '''''' + @Language + N''''''''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 28, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 46;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogName]
    @CatalogName nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT N.* from [CatalogNode] N
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		C.[Name] = @CatalogName AND N.ParentNodeId = 0 AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY N.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		C.[Name] = @CatalogName AND N.ParentNodeId = 0 AND 
		((N.IsActive = 1) or @ReturnInactive = 1)	

END
' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 2, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 47;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@JoinType					nvarchar(50),
	@SourceTableName			sysname,
	@TargetQuery			sysname,
	@SourceJoinKey				sysname,
	@TargetJoinKey				sysname,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	September 2, 2008
		- corrected order for queries, should be ObjectId, Rank instead of Rank, ObjectId
	April 24, 2008
		- added support for joining tables
		- added language filters for meta fields
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_CreateFTSQuery] @Language, @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry] CatalogEntry'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] ''

	-- attach inner join if needed
	if(@JoinType is not null and Len(@JoinType) > 0)
	begin
		set @Query_tmp = ''''
		EXEC [ecf_CreateTableJoinQuery] @SourceTableName, @TargetQuery, @SourceJoinKey, @TargetJoinKey, @JoinType, @Query_tmp OUT
		print(@Query_tmp)
		set @FromQuery_tmp = @FromQuery_tmp + N'' '' + @Query_tmp
	end
	--print(@FromQuery_tmp)
	
	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 5, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 48;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodeSearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 			nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 			nvarchar(max),
	@FTSPhrase 					nvarchar(max),
  @AdvancedFTSPhrase 	nvarchar(max),
  @OrderBy 					  nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					  nvarchar(max) = N'''',
  @StartingRec 				int,
	@NumRecords   			int,
	@RecordCount				int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname

	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available catalog node meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogNode''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			if(@SelectMetaQuery_tmp is null)
				set @SelectMetaQuery_tmp = @Query_tmp;
			else
				set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM CatalogNode'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogNode.CatalogNodeId = META.[KEY] ''

	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN CatalogNodeRelation NR ON CatalogNode.CatalogNodeId = NR.ChildNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] CR ON NR.CatalogId = NR.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] C ON C.CatalogId = CatalogNode.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CN ON CatalogNode.ParentNodeId = CN.CatalogNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CNR ON NR.ParentNodeId = CNR.CatalogNodeId''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogNode.CatalogNodeId''
	end

	/* CATALOG AND NODE FILTERING */
	set @FilterQuery_tmp =  N'' WHERE ((C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = '''' + @FilterQuery_tmp + N'' OR ((CR.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CNR.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	set @FullQuery = N''SELECT count(CatalogNode.CatalogNodeId) OVER() TotalRecords, CatalogNode.CatalogNodeId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, CatalogNodeId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogNodeId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, CatalogNodeId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogNodeSearchResults (SearchSetId, CatalogNodeId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogNodeId from @Page_temp;''
	print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 8, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 49;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodeSearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
  @AdvancedFTSPhrase 			nvarchar(max),
  @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
  @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available catalog node meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogNode''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			if(@SelectMetaQuery_tmp is null)
				set @SelectMetaQuery_tmp = @Query_tmp;
			else
				set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM CatalogNode'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogNode.CatalogNodeId = META.[KEY] ''

	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN CatalogNodeRelation NR ON CatalogNode.CatalogNodeId = NR.ChildNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] CR ON NR.CatalogId = NR.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] C ON C.CatalogId = CatalogNode.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CN ON CatalogNode.ParentNodeId = CN.CatalogNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CNR ON NR.ParentNodeId = CNR.CatalogNodeId''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogNode.CatalogNodeId''
	end

	/* CATALOG AND NODE FILTERING */
	set @FilterQuery_tmp =  N'' WHERE (1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR (1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = '''' + @FilterQuery_tmp + N'' AND (CR.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CNR.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	set @FullQuery = N''SELECT count(CatalogNode.CatalogNodeId) OVER() TotalRecords, CatalogNode.CatalogNodeId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, CatalogNodeId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogNodeId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, CatalogNodeId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogNodeSearchResults (SearchSetId, CatalogNodeId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogNodeId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 9, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 50;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogId]
	@CatalogId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.CatalogId = @CatalogId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.CatalogId = @CatalogId
	ORDER BY CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryCode]
	@CatalogId int,
    @CatalogEntryCode nvarchar(100)
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		(CE.Code = @CatalogEntryCode) AND
		(CE.CatalogId = @CatalogId)
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		(CE.Code = @CatalogEntryCode) AND
		(CE.CatalogId = @CatalogId)
	ORDER BY CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociationByName]
    @AssociationName nvarchar(150)
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.AssociationName = @AssociationName
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		(CA.AssociationName = @AssociationName) OR ((CA.AssociationName IS NULL) AND (@AssociationName IS NULL))
	ORDER BY CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation]
    @CatalogAssociationId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogAssociationId = @CatalogAssociationId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogAssociationId = @CatalogAssociationId
	ORDER BY CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
	/*SELECT DISTINCT AT.* FROM [AssociationType] AT 
	INNER JOIN [CatalogEntryAssociation] CEA ON AT.AssociationTypeId = CEA.AssociationTypeId
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId*/
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryId]
    @CatalogEntryId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId = @CatalogEntryId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId
	ORDER BY CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 11, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 51;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##


EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Associated]
    @CatalogEntryId int,
	@AssociationName nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null

	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER
	

END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryCode]
	@CatalogId int,
    @CatalogEntryCode nvarchar(100)
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		(CE.Code = @CatalogEntryCode) AND
		(CE.CatalogId = @CatalogId)
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		(CE.Code = @CatalogEntryCode) AND
		(CE.CatalogId = @CatalogId)
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
    @CatalogEntryCode nvarchar(50),
	@AssociationName nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER	

END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogId]
	@CatalogId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.CatalogId = @CatalogId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.CatalogId = @CatalogId
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociationByName]
    @AssociationName nvarchar(150)
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.AssociationName = @AssociationName
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		(CA.AssociationName = @AssociationName) OR ((CA.AssociationName IS NULL) AND (@AssociationName IS NULL))
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation]
    @CatalogAssociationId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogAssociationId = @CatalogAssociationId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogAssociationId = @CatalogAssociationId
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
	/*SELECT DISTINCT AT.* FROM [AssociationType] AT 
	INNER JOIN [CatalogEntryAssociation] CEA ON AT.AssociationTypeId = CEA.AssociationTypeId
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId*/
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryId]
    @CatalogEntryId int
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId = @CatalogEntryId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Association]
    @CatalogEntryId int
AS
BEGIN

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId = @CatalogEntryId
	ORDER BY CA.SORTORDER

	/*
	SELECT CEA.* from [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId
	*/
END' 

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 12, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 52;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CatalogNodeRelation]') AND name = N'PK_CatalogNodeRelation')
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[CatalogNodeRelation] ADD  CONSTRAINT [PK_CatalogNodeRelation] PRIMARY KEY CLUSTERED 
(
	[CatalogId] ASC,
	[ParentNodeId] ASC,
	[ChildNodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 30, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 53;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_SearchInsertList]
	@SearchSetId uniqueidentifier,
	@List nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO [CatalogEntrySearchResults]
           ([SearchSetId]
           ,[CatalogEntryId]
           ,[Created]
           ,[SortOrder])
     select @SearchSetId, Item, getdate(), 0 from ecf_splitlist(@List)
	SET NOCOUNT OFF;

END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- October 1, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 54;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
CREATE TABLE [dbo].[CatalogLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Operation] [nvarchar](50) NOT NULL,
	[ObjectKey] [nvarchar](100) NOT NULL,
	[ObjectType] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Succeeded] [bit] NOT NULL,
	[Notes] [nvarchar](255) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CatalogLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE ecf_CatalogLog
	@ApplicationId uniqueidentifier,
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
		select *, row_number() over(order by LogId) as RowNumber from CatalogLog where COALESCE(@Operation, Operation) = Operation and COALESCE(@ObjectType, ObjectType) = ObjectType and COALESCE(@Created, Created) <= Created
	),
	OrderedLogsCount(TotalCount) as
	(
		select count(LogId) from OrderedLogs
	)
	select LogId, Operation, ObjectKey, ObjectType, Username, Created, Succeeded, Notes, ApplicationId, TotalCount from OrderedLogs, OrderedLogsCount
	where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
	SET NOCOUNT OFF;
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- October 8, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 55;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_SearchInsertList]
	@SearchSetId uniqueidentifier,
	@List nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [CatalogEntrySearchResults]
           ([SearchSetId]
           ,[CatalogEntryId]
           ,[Created]
           ,[SortOrder])
     select @SearchSetId, L.Item, getdate(), 0 from ecf_splitlist(@List) L inner join CatalogEntry E ON E.CatalogEntryId = L.Item

	SET NOCOUNT OFF;
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- October 17, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 56;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Associated]
    @CatalogEntryId int,
	@AssociationName nvarchar(150) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null

	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	WHERE
		CA.CatalogEntryId = @CatalogEntryId AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
    @CatalogEntryCode nvarchar(100),
	@AssociationName nvarchar(150) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogName]
	@CatalogName nvarchar(150),
	@ReturnInactive bit = 0
AS
BEGIN	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN [Catalog] C ON N.CatalogId = C.CatalogId
	WHERE
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN [Catalog] C ON N.CatalogId = C.CatalogId
	WHERE
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]
	@CatalogName nvarchar(150),
    @CatalogNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		CN.Code = @CatalogNodeCode AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		CN.Code = @CatalogNodeCode AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]
	@CatalogName nvarchar(150),
    @CatalogNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		R.CatalogNodeId = @CatalogNodeId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		R.CatalogNodeId = @CatalogNodeId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Name]
    @Name nvarchar(100) = '''',
	@ClassTypeId nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@ClassTypeId = '''')
		set @ClassTypeId = null

	if(@Name = '''')
		set @Name = null

	SELECT N.* from [CatalogEntry] N
	WHERE
		N.[Name] like @Name AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT DISTINCT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		N.[Name] like @Name AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogName]
    @CatalogName nvarchar(150),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogNode] N
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		C.[Name] = @CatalogName AND N.ParentNodeId = 0 AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY N.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		C.[Name] = @CatalogName AND N.ParentNodeId = 0 AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNodeCode]
    @CatalogName nvarchar(150),
	@ParentNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN
	declare @CatalogId int
	declare @ParentNodeId int

	select @CatalogId = CatalogId from [Catalog] where [Name] = @CatalogName
	select @ParentNodeId = CatalogNodeId from [CatalogNode] where Code = @ParentNodeCode

	EXECUTE [ecf_CatalogNode_CatalogParentNode] @CatalogId,@ParentNodeId,@ReturnInactive
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_Code]
    @CatalogNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN	
	SELECT N.* from [CatalogNode] N
	WHERE
		N.Code = @CatalogNodeCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.Code = @CatalogNodeCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogRelation]
	@CatalogId int,
	@CatalogNodeId int,
    @CatalogEntryId int,
	@GroupName nvarchar(100),
	@ResponseGroup int
AS
BEGIN
	declare @CatalogNode as int
	declare @CatalogEntry as int
	declare @NodeEntry as int

	set @CatalogNode = 1
    set @CatalogEntry = 2
    set @NodeEntry = 4

	if(@ResponseGroup & @CatalogNode = @CatalogNode)
		select * from CatalogNodeRelation
	else
		select top 0 * from CatalogNodeRelation

	if(@ResponseGroup & @CatalogEntry = @CatalogEntry)
		select * from CatalogEntryRelation 
		where 
			(ParentEntryId = @CatalogEntryId OR @CatalogEntryId = 0) and 
			(GroupName = @GroupName or len(@GroupName) = 0)
	else
		select top 0 * from CatalogEntryRelation

	if(@ResponseGroup & @NodeEntry = @NodeEntry)
		select * from NodeEntryRelation
		where 
			(CatalogId = @CatalogId or @CatalogId = 0) AND
			(CatalogNodeId = @CatalogNodeId or @CatalogNodeId = 0) AND
			(CatalogEntryId = @CatalogEntryId or @CatalogEntryId = 0)
		order by sortorder
	else
		select top 0 * from NodeEntryRelation
END'

EXEC dbo.sp_executesql @statement = N'DROP PROCEDURE [ecf_CatalogSearch]'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				sysname,
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'' WHERE LOC.Language = '''''' + @Language + N'''''''' + 
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId '' +
			N'' WHERE LOC.Language = '''''' + @Language + N''''''''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@SearchSetId uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@JoinType					nvarchar(50),
	@SourceTableName			sysname,
	@TargetQuery				sysname,
	@SourceJoinKey				sysname,
	@TargetJoinKey				sysname,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	September 2, 2008
		- corrected order for queries, should be ObjectId, Rank instead of Rank, ObjectId
	April 24, 2008
		- added support for joining tables
		- added language filters for meta fields
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_CreateFTSQuery] @Language, @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry] CatalogEntry'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] ''

	-- attach inner join if needed
	if(@JoinType is not null and Len(@JoinType) > 0)
	begin
		set @Query_tmp = ''''
		EXEC [ecf_CreateTableJoinQuery] @SourceTableName, @TargetQuery, @SourceJoinKey, @TargetJoinKey, @JoinType, @Query_tmp OUT
		print(@Query_tmp)
		set @FromQuery_tmp = @FromQuery_tmp + N'' '' + @Query_tmp
	end
	--print(@FromQuery_tmp)
	
	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodeSearch]
(
	@SearchSetId			uniqueidentifier,
	@Language 				nvarchar(50),
	@Catalogs 				nvarchar(max),
	@CatalogNodes 			nvarchar(max),
	@SQLClause 				nvarchar(max),
	@MetaSQLClause 			nvarchar(max),
	@FTSPhrase 				nvarchar(max),
	@AdvancedFTSPhrase 		nvarchar(max),
	@OrderBy 				nvarchar(max),
	@Namespace				nvarchar(1024) = N'''',
	@Classes				nvarchar(max) = N'''',
	@StartingRec 			int,
	@NumRecords   			int,
	@RecordCount			int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available catalog node meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogNode''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			if(@SelectMetaQuery_tmp is null)
				set @SelectMetaQuery_tmp = @Query_tmp;
			else
				set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM CatalogNode'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogNode.CatalogNodeId = META.[KEY] ''

	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN CatalogNodeRelation NR ON CatalogNode.CatalogNodeId = NR.ChildNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] CR ON NR.CatalogId = NR.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] C ON C.CatalogId = CatalogNode.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CN ON CatalogNode.ParentNodeId = CN.CatalogNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CNR ON NR.ParentNodeId = CNR.CatalogNodeId''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogNode.CatalogNodeId''
	end

	/* CATALOG AND NODE FILTERING */
	set @FilterQuery_tmp =  N'' WHERE (1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR (1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = '''' + @FilterQuery_tmp + N'' AND (CR.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CNR.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	set @FullQuery = N''SELECT count(CatalogNode.CatalogNodeId) OVER() TotalRecords, CatalogNode.CatalogNodeId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, CatalogNodeId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogNodeId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, CatalogNodeId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogNodeSearchResults (SearchSetId, CatalogNodeId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogNodeId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- November 01, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 57;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Currency]
    @ApplicationId uniqueidentifier
AS
BEGIN
	
	SELECT C.* from [Currency] C
	WHERE
		C.ApplicationId = @ApplicationId
	ORDER BY C.[CurrencyCode]

	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.FromCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId
	UNION ALL
	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.ToCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Currency_CurrencyId]
    @ApplicationId uniqueidentifier,
	@CurrencyId int
AS
BEGIN
	
	SELECT C.* from [Currency] C
	WHERE
		C.ApplicationId = @ApplicationId and C.[CurrencyId]=@CurrencyId

	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.FromCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId and R.[FromCurrencyId]=@CurrencyId
	UNION ALL
	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.ToCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId and R.[ToCurrencyId]=@CurrencyId
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Currency_Code]
    @ApplicationId uniqueidentifier,
	@CurrencyCode nchar(3)
AS
BEGIN
	
	SELECT C.* from [Currency] C
	WHERE
		C.ApplicationId = @ApplicationId and C.[CurrencyCode]=@CurrencyCode

	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.FromCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId and C.[CurrencyCode]=@CurrencyCode
	UNION ALL
	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.ToCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId and C.[CurrencyCode]=@CurrencyCode
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Warehouse]
	@ApplicationId uniqueidentifier
AS
BEGIN
	select * from [Warehouse] 
		where [ApplicationId] = @ApplicationId
		order by [Name]
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Warehouse_WarehouseId]
	@ApplicationId uniqueidentifier,
	@WarehouseId int
AS
BEGIN
	select * from [Warehouse] 
		where [ApplicationId] = @ApplicationId and [WarehouseId] = @WarehouseId
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- November 01, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 58;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_TaxCategory]
    @ApplicationId uniqueidentifier
AS
BEGIN
	
	SELECT T.* from [TaxCategory] T
	WHERE
		T.ApplicationId = @ApplicationId
	ORDER BY T.[Name]
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_TaxCategory_TaxCategoryId]
    @ApplicationId uniqueidentifier,
	@TaxCategoryId int
AS
BEGIN
	
	SELECT T.* from [TaxCategory] T
	WHERE
		T.[ApplicationId] = @ApplicationId and T.[TaxCategoryId] = @TaxCategoryId
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_TaxCategory_Name]
    @ApplicationId uniqueidentifier,
	@Name nvarchar(50)
AS
BEGIN
	
	SELECT T.* from [TaxCategory] T
	WHERE
		T.[ApplicationId] = @ApplicationId and T.[Name] = @Name
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- December 08, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 59;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Currency]
    @ApplicationId uniqueidentifier
AS
BEGIN
	
	SELECT C.* from [Currency] C
	WHERE
		C.ApplicationId = @ApplicationId
	ORDER BY C.[CurrencyCode]

	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.FromCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId
	INTERSECT
	SELECT R.* from [CurrencyRate] R
		INNER JOIN [Currency] C ON R.ToCurrencyId = C.CurrencyId
	WHERE
		C.ApplicationId = @ApplicationId
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- December 17, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 60;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedure] 
	@MetaClassId	INT
AS
	SET NOCOUNT ON

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is System or not exists.'', 16,1)
		GOTO ERR
	END

	-- Step 1. Create SQL Code
	--PRINT''Step 1. Create SQL Code''

	DECLARE	@MetaClassTable	NVARCHAR(256)
	DECLARE	@MetaClassGetSpName	NVARCHAR(256)
	DECLARE	@MetaClassUpdateSpName NVARCHAR(256)
	DECLARE	@MetaClassDeleteSpName NVARCHAR(256)
	DECLARE	@MetaClassListSpName NVARCHAR(256)
	DECLARE	@MetaClassHistorySpName NVARCHAR(256)

	DECLARE	@CRLF NCHAR(1)

	SELECT @MetaClassTable = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

	SET @MetaClassGetSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Get'' 
	SET @MetaClassUpdateSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Update''
	SET @MetaClassDeleteSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Delete''
	SET @MetaClassListSpName = ''mdpsp_avto_'' +@MetaClassTable +''_List''
	SET @MetaClassHistorySpName	= ''mdpsp_avto_'' +@MetaClassTable +''_History''

	SET @CRLF = CHAR(10)

	-- Step 2. Drop operation
	--PRINT''Step 2. Drop operation''

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassGetSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassGetSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassUpdateSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassUpdateSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassDeleteSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassDeleteSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassListSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassListSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassHistorySpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassHistorySpName)
	IF @@ERROR <> 0 GOTO ERR

	-- Step 3. Create Procedure operation
	--PRINT''Step 3. ALTER Procedure operation''

	DECLARE @OPEN_SYMMETRIC_KEY NVARCHAR(4000)
	DECLARE @CLOSE_SYMMETRIC_KEY NVARCHAR(4000)

	SET @OPEN_SYMMETRIC_KEY = ''''
	SET @CLOSE_SYMMETRIC_KEY = ''''

	DECLARE	@MetaClassFieldList	NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_E	NVARCHAR(4000)
	DECLARE	@MetaClassFieldListWithAt NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet NVARCHAR(4000)
	DECLARE	@MetaClassFieldListInsert NVARCHAR(4000)

	DECLARE	@MetaClassFieldList_L NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L1 NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L2 NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_LI NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L1 NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L2 NVARCHAR(4000)

	SET @MetaClassFieldList = ''ObjectId, CreatorId, Created, ModifierId, Modified''
	SET @MetaClassFieldList_E = ''ObjectId, CreatorId, Created, ModifierId, Modified''
	SET @MetaClassFieldListWithAt = ''@ObjectId INT, @Language NVARCHAR(20)=NULL, @CreatorId nvarchar(100), @Created DATETIME, @ModifierId nvarchar(100), @Modified DATETIME, @Retval INT OUT''
	SET @MetaClassFieldListSet = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListInsert = ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 

	SET @MetaClassFieldList_L = ''T.ObjectId, T.CreatorId, T.Created, T.ModifierId, T.Modified''
	SET @MetaClassFieldListSet_L1 = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListSet_L2 = ''ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldList_LI = ''ObjectId, Language, ModifierId, Modified''
	SET @MetaClassFieldListInsert_L1 =  ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 
	SET @MetaClassFieldListInsert_L2 = ''@ObjectId, @Language, @ModifierId, @Modified'' 

	DECLARE field_cursor CURSOR FOR 
		SELECT MF.[MetaFieldId], MF.[Name], DT.SqlName, DT.Variable, MF.Length, DT.DataTypeId, MF.MultiLanguageValue, MF.IsEncrypted FROM MetaField MF 
			INNER JOIN MetaDataType DT ON DT.DataTypeId = MF.DataTypeId
			INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
		WHERE MCFR.MetaClassId = @MetaClassId AND MF.SystemMetaClassId = 0 ORDER BY MCFR.Weight	

	DECLARE @MetaFieldId INT
	DECLARE @Name 	NVARCHAR(256)
	DECLARE @SqlName 	NVARCHAR(256)
	DECLARE @Variable 	BIT
	DECLARE @Length 	INT
	DECLARE @DataTypeId INT
	DECLARE @MultiLanguageValue BIT
	DECLARE @IsEncrypted BIT	
	DECLARE @UseSymmetricKey BIT
	
	SET @UseSymmetricKey = 0

	OPEN field_cursor	
	FETCH NEXT FROM field_cursor INTO @MetaFieldId, @Name, @SqlName, @Variable, @Length, @DataTypeId, @MultiLanguageValue, @IsEncrypted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @MetaClassFieldList = @MetaClassFieldList + '', ''
		SET @MetaClassFieldList_E = @MetaClassFieldList_E + '', ''
		SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '', ''
		SET @MetaClassFieldListSet = @MetaClassFieldListSet + '', ''
		SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + '', ''
		SET @MetaClassFieldList_L = @MetaClassFieldList_L + '', ''
		SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + '', ''
		SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + '', ''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + '', ''
		SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + '', ''
		SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2  + '', ''

		SET @MetaClassFieldList = @MetaClassFieldList + ''['' + @Name + '']''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + ''['' + @Name + '']''

		IF @IsEncrypted = 1 BEGIN
			SET @UseSymmetricKey = 1 
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''dbo.mdpfn_sys_EncryptDecryptString(['' + @Name + ''], 0) '''''' + @Name + ''''''''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
		END
		ELSE BEGIN
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''['' + @Name + '']''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = @'' + @Name 
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''@'' + @Name 
		END

		IF @MultiLanguageValue = 0
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @Name + ''], 0) '''''' + @Name + ''''''''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''T.['' + @Name + '']''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''@'' + @Name + ''''
			END
			SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + '' NULL ''
		END
		ELSE
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(TL.['' + @Name + ''], 0) '''''' + @Name + ''''''''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)'' 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''TL.['' + @Name + '']''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''@'' + @Name
			END
			SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1 + '' NULL ''
		END

		IF @Variable = 0
		BEGIN
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName 

			IF @DataTypeId = 5 OR @DataTypeId = 24
			BEGIN
				-- 2007-01-16 Allows to set custom Precision And Scale for Decimal and Numeric
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
					SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
				END
			END
		END
		ELSE
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName + ''('' + CAST(@Length AS NVARCHAR(20)) + '') '' 

	FETCH NEXT FROM field_cursor INTO @MetaFieldId, @Name, @SqlName, @Variable, @Length, @DataTypeId, @MultiLanguageValue, @IsEncrypted
	END

	CLOSE field_cursor
	DEALLOCATE field_cursor

	IF @UseSymmetricKey = 1 BEGIN
		SET @OPEN_SYMMETRIC_KEY = ''exec mdpsp_sys_OpenSymmetricKey''
		SET @CLOSE_SYMMETRIC_KEY = ''exec mdpsp_sys_CloseSymmetricKey''
	END

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS OFF 

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassGetSpName + ''] ''  + @CRLF +
		'' @ObjectId INT ,''+@CRLF +
		'' @Language NVARCHAR(20)=NULL AS '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T ''+ @CRLF +
		'' LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId   AND TL.Language = @Language WHERE T.ObjectId = @ObjectId'' + @CRLF + @CLOSE_SYMMETRIC_KEY  
		)

	IF @@ERROR <> 0 GOTO ERR

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassUpdateSpName + ''] ''  + @CRLF +
		 @MetaClassFieldListWithAt + 
		'' AS '' + @CRLF +
		'' SET NOCOUNT ON '' + @CRLF +
		'' BEGIN TRAN '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		''  IF @ObjectId = -1 BEGIN ''+ @CRLF + 
		''    SELECT @ObjectId = MAX(ObjectId)+1 FROM '' + @MetaClassTable + '' IF (@ObjectId IS NULL)  SET @ObjectId = 1 END '' + @CRLF +
		'' SET @Retval = @ObjectId '' + @CRLF +
		'' IF @Language IS NULL '' +  @CRLF +
		'' BEGIN '' +  @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' ELSE '' + @CRLF +
		'' BEGIN '' +  @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet_L1 + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert_L1 + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' '' + @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +''_Localization WHERE ObjectId = @ObjectId AND Language = @Language  ) UPDATE '' + @MetaClassTable + ''_Localization SET '' + @MetaClassFieldListSet_L2 + '' WHERE ObjectId = @ObjectId AND Language = @Language '' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + ''_Localization (''+ @MetaClassFieldList_LI + '') VALUES ('' + @MetaClassFieldListInsert_L2 + '')'' + @CRLF + @CLOSE_SYMMETRIC_KEY + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' COMMIT TRAN '' + @CRLF + 
		'' RETURN '' + @CRLF + 
		'' ERR: ROLLBACK TRAN '' + @CRLF + 
		'' RETURN ''
	)

	IF @@ERROR <> 0  GOTO ERR
	--PRINT @MetaClassUpdateSpName

	DECLARE @MetaClassIdSTR NVARCHAR(10)
	SET @MetaClassIdSTR = CAST( @MetaClassId AS NVARCHAR(10) )

	EXEC (''CREATE PROCEDURE [dbo].['' + @MetaClassDeleteSpName + '']  @ObjectId INT AS '' + @CRLF +
		'' DELETE FROM ''  + @MetaClassTable + '' WHERE ObjectId = @ObjectId '' +  @CRLF +
		'' DELETE FROM '' + @MetaClassTable + ''_Localization WHERE ObjectId = @ObjectId '' + @CRLF +
		'' DELETE FROM '' + @MetaClassTable +''_History WHERE ObjectId = @ObjectId '' + @CRLF +
		'' EXEC mdpsp_sys_DeleteMetaKeyObjects ''+@MetaClassIdSTR+'', -1, @ObjectId '')

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassDeleteSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassListSpName + ''] ''  + '' @Language NVARCHAR(20)=NULL  AS '' +  @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId  AND TL.Language = @Language'' + @CRLF + @CLOSE_SYMMETRIC_KEY 
		)

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassListSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassHistorySpName + ''] ''  + '' @ObjectId INT, @Language NVARCHAR(20)=NULL  AS ''+  @CRLF +
	'' SELECT * FROM '' +@MetaClassTable + ''_History WHERE ObjectId = @ObjectId AND Language = @Language'' )

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassHistorySpName

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS ON 

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
RETURN'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- December 18, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 61;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedure] 
	@MetaClassId	INT
AS
	SET NOCOUNT ON

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is System or not exists.'', 16,1)
		GOTO ERR
	END

	-- Step 1. Create SQL Code
	--PRINT''Step 1. Create SQL Code''

	DECLARE	@MetaClassTable	NVARCHAR(256)
	DECLARE	@MetaClassGetSpName	NVARCHAR(256)
	DECLARE	@MetaClassUpdateSpName NVARCHAR(256)
	DECLARE	@MetaClassDeleteSpName NVARCHAR(256)
	DECLARE	@MetaClassListSpName NVARCHAR(256)
	DECLARE	@MetaClassSearchSpName NVARCHAR(256)
	DECLARE	@MetaClassHistorySpName NVARCHAR(256)

	DECLARE	@CRLF NCHAR(1)

	SELECT @MetaClassTable = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

	SET @MetaClassGetSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Get'' 
	SET @MetaClassUpdateSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Update''
	SET @MetaClassDeleteSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Delete''
	SET @MetaClassListSpName = ''mdpsp_avto_'' +@MetaClassTable +''_List''
	SET @MetaClassSearchSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Search''
	SET @MetaClassHistorySpName	= ''mdpsp_avto_'' +@MetaClassTable +''_History''

	SET @CRLF = CHAR(10)

	-- Step 2. Drop operation
	--PRINT''Step 2. Drop operation''

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassGetSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassGetSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassUpdateSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassUpdateSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassDeleteSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassDeleteSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassListSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassListSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassSearchSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassSearchSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassHistorySpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassHistorySpName)
	IF @@ERROR <> 0 GOTO ERR

	-- Step 3. Create Procedure operation
	--PRINT''Step 3. ALTER Procedure operation''

	DECLARE @OPEN_SYMMETRIC_KEY NVARCHAR(4000)
	DECLARE @CLOSE_SYMMETRIC_KEY NVARCHAR(4000)

	SET @OPEN_SYMMETRIC_KEY = ''''
	SET @CLOSE_SYMMETRIC_KEY = ''''

	DECLARE	@MetaClassFieldList	NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_E	NVARCHAR(4000)
	DECLARE	@MetaClassFieldListWithAt NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet NVARCHAR(4000)
	DECLARE	@MetaClassFieldListInsert NVARCHAR(4000)

	DECLARE	@MetaClassFieldList_L NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L1 NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L2 NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_LI NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L1 NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L2 NVARCHAR(4000)

	SET @MetaClassFieldList = ''ObjectId, CreatorId, Created, ModifierId, Modified''
	SET @MetaClassFieldList_E = ''T.ObjectId, T.CreatorId, T.Created, T.ModifierId, T.Modified''
	SET @MetaClassFieldListWithAt = ''@ObjectId INT, @Language NVARCHAR(20)=NULL, @CreatorId nvarchar(100), @Created DATETIME, @ModifierId nvarchar(100), @Modified DATETIME, @Retval INT OUT''
	SET @MetaClassFieldListSet = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListInsert = ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 

	SET @MetaClassFieldList_L = ''T.ObjectId, T.CreatorId, T.Created, T.ModifierId, T.Modified''
	SET @MetaClassFieldListSet_L1 = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListSet_L2 = ''ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldList_LI = ''ObjectId, Language, ModifierId, Modified''
	SET @MetaClassFieldListInsert_L1 =  ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 
	SET @MetaClassFieldListInsert_L2 = ''@ObjectId, @Language, @ModifierId, @Modified'' 

	DECLARE field_cursor CURSOR FOR 
		SELECT MF.[MetaFieldId], MF.[Name], DT.SqlName, DT.Variable, MF.Length, DT.DataTypeId, MF.MultiLanguageValue, MF.IsEncrypted FROM MetaField MF 
			INNER JOIN MetaDataType DT ON DT.DataTypeId = MF.DataTypeId
			INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
		WHERE MCFR.MetaClassId = @MetaClassId AND MF.SystemMetaClassId = 0 ORDER BY MCFR.Weight	

	DECLARE @MetaFieldId INT
	DECLARE @Name 	NVARCHAR(256)
	DECLARE @SqlName 	NVARCHAR(256)
	DECLARE @Variable 	BIT
	DECLARE @Length 	INT
	DECLARE @DataTypeId INT
	DECLARE @MultiLanguageValue BIT
	DECLARE @IsEncrypted BIT	
	DECLARE @UseSymmetricKey BIT
	
	SET @UseSymmetricKey = 0

	OPEN field_cursor	
	FETCH NEXT FROM field_cursor INTO @MetaFieldId, @Name, @SqlName, @Variable, @Length, @DataTypeId, @MultiLanguageValue, @IsEncrypted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @MetaClassFieldList = @MetaClassFieldList + '', ''
		SET @MetaClassFieldList_E = @MetaClassFieldList_E + '', ''
		SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '', ''
		SET @MetaClassFieldListSet = @MetaClassFieldListSet + '', ''
		SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + '', ''
		SET @MetaClassFieldList_L = @MetaClassFieldList_L + '', ''
		SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + '', ''
		SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + '', ''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + '', ''
		SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + '', ''
		SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2  + '', ''

		SET @MetaClassFieldList = @MetaClassFieldList + ''['' + @Name + '']''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + ''['' + @Name + '']''

		IF @IsEncrypted = 1 BEGIN
			SET @UseSymmetricKey = 1 
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @Name + ''], 0) AS '' + @Name + ''''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
		END
		ELSE BEGIN
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''T.['' + @Name + '']''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = @'' + @Name 
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''@'' + @Name 
		END

		IF @MultiLanguageValue = 0
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @Name + ''], 0) AS '' + @Name + ''''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''T.['' + @Name + '']''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''@'' + @Name + ''''
			END
			SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + '' NULL ''
		END
		ELSE
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(TL.['' + @Name + ''], 0) AS '' + @Name + ''''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)'' 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''TL.['' + @Name + '']''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''@'' + @Name
			END
			SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1 + '' NULL ''
		END

		IF @Variable = 0
		BEGIN
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName 

			IF @DataTypeId = 5 OR @DataTypeId = 24
			BEGIN
				-- 2007-01-16 Allows to set custom Precision And Scale for Decimal and Numeric
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
					SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
				END
			END
		END
		ELSE
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName + ''('' + CAST(@Length AS NVARCHAR(20)) + '') '' 

	FETCH NEXT FROM field_cursor INTO @MetaFieldId, @Name, @SqlName, @Variable, @Length, @DataTypeId, @MultiLanguageValue, @IsEncrypted
	END

	CLOSE field_cursor
	DEALLOCATE field_cursor

	IF @UseSymmetricKey = 1 BEGIN
		SET @OPEN_SYMMETRIC_KEY = ''exec mdpsp_sys_OpenSymmetricKey''
		SET @CLOSE_SYMMETRIC_KEY = ''exec mdpsp_sys_CloseSymmetricKey''
	END

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS OFF 

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassGetSpName + ''] ''  + @CRLF +
		'' @ObjectId INT ,''+@CRLF +
		'' @Language NVARCHAR(20)=NULL AS '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + '' AS T WHERE T.ObjectId = @ObjectId'' + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T ''+ @CRLF +
		'' LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId   AND TL.Language = @Language WHERE T.ObjectId = @ObjectId'' + @CRLF + @CLOSE_SYMMETRIC_KEY  
		)

	IF @@ERROR <> 0 GOTO ERR

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassUpdateSpName + ''] ''  + @CRLF +
		 @MetaClassFieldListWithAt + 
		'' AS '' + @CRLF +
		'' SET NOCOUNT ON '' + @CRLF +
		'' BEGIN TRAN '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		''  IF @ObjectId = -1 BEGIN ''+ @CRLF + 
		''    SELECT @ObjectId = MAX(ObjectId)+1 FROM '' + @MetaClassTable + '' IF (@ObjectId IS NULL)  SET @ObjectId = 1 END '' + @CRLF +
		'' SET @Retval = @ObjectId '' + @CRLF +
		'' IF @Language IS NULL '' +  @CRLF +
		'' BEGIN '' +  @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' ELSE '' + @CRLF +
		'' BEGIN '' +  @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet_L1 + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert_L1 + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' '' + @CRLF +
                           '' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +''_Localization WHERE ObjectId = @ObjectId AND Language = @Language  ) UPDATE '' + @MetaClassTable + ''_Localization SET '' + @MetaClassFieldListSet_L2 + '' WHERE ObjectId = @ObjectId AND Language = @Language '' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + ''_Localization (''+ @MetaClassFieldList_LI + '') VALUES ('' + @MetaClassFieldListInsert_L2 + '')'' + @CRLF + @CLOSE_SYMMETRIC_KEY + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' COMMIT TRAN '' + @CRLF + 
		'' RETURN '' + @CRLF + 
		'' ERR: ROLLBACK TRAN '' + @CRLF + 
		'' RETURN ''
	)

	IF @@ERROR <> 0  GOTO ERR
	--PRINT @MetaClassUpdateSpName

	DECLARE @MetaClassIdSTR NVARCHAR(10)
	SET @MetaClassIdSTR = CAST( @MetaClassId AS NVARCHAR(10) )

	EXEC (''CREATE PROCEDURE [dbo].['' + @MetaClassDeleteSpName + '']  @ObjectId INT AS '' + @CRLF +
		'' DELETE FROM ''  + @MetaClassTable + '' WHERE ObjectId = @ObjectId '' +  @CRLF +
		'' DELETE FROM '' + @MetaClassTable + ''_Localization WHERE ObjectId = @ObjectId '' + @CRLF +
		'' DELETE FROM '' + @MetaClassTable +''_History WHERE ObjectId = @ObjectId '' + @CRLF +
		'' EXEC mdpsp_sys_DeleteMetaKeyObjects ''+@MetaClassIdSTR+'', -1, @ObjectId '')

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassDeleteSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassListSpName + ''] ''  +  @CRLF + 
		'' @Language NVARCHAR(20)=NULL  AS '' +  @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + '' AS T '' + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId  AND TL.Language = @Language'' + @CRLF + @CLOSE_SYMMETRIC_KEY 
		)
	
	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassSearchSpName + ''] '' +  @CRLF + 
		''	@Language nvarchar(20) = NULL,'' +  @CRLF +
		''	@select_list nvarchar(max) = '''''''','' +  @CRLF + 
		''	@search_condition nvarchar(max) = '''''''' AS '' +  @CRLF + 
		''IF LEN(@select_list) > 0'' +  @CRLF + 
		''	SET @select_list = '''', '''' + @select_list '' + @CRLF + 
		@OPEN_SYMMETRIC_KEY + @CRLF +
		''IF @Language IS NULL '' + @CRLF +
		''	exec(''''SELECT '' + @MetaClassFieldList_E + '''''' + @select_list + '''' FROM '' + @MetaClassTable + '' AS T '''' + @search_condition ) '' + @CRLF +
		''ELSE '' + @CRLF +
		''	exec(''''SELECT '' + @MetaClassFieldList_L + '''''' + @select_list + '''' FROM '' + @MetaClassTable + '' AS T LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId  AND TL.Language = @Language '''' + @search_condition ) '' + @CRLF + 
		@CLOSE_SYMMETRIC_KEY 
		)

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassListSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassHistorySpName + ''] ''  + '' @ObjectId INT, @Language NVARCHAR(20)=NULL  AS ''+  @CRLF +
	'' SELECT * FROM '' +@MetaClassTable + ''_History WHERE ObjectId = @ObjectId AND Language = @Language'' )

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassHistorySpName

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS ON 

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
RETURN'

EXEC dbo.sp_executesql @statement = N'mdpsp_sys_CreateMetaClassProcedureAll'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- December 24, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 62;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_RotateEncryptionKeys] AS
DECLARE @Query_tmp  nvarchar(max)

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION

DECLARE @MetaClassTable NVARCHAR(256), @MetaFieldName NVARCHAR(256), @MultiLanguageValue BIT
DECLARE classall_cursor CURSOR FOR
	SELECT MF.Name, MF.MultiLanguageValue, MC.TableName FROM MetaField MF
		INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
		INNER JOIN MetaClass MC ON MC.MetaClassId = MCFR.MetaClassId
		WHERE MF.IsEncrypted = 1 AND MC.IsSystem = 0

--Open symmetric key
exec mdpsp_sys_OpenSymmetricKey

OPEN classall_cursor	
	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable

--Decrypt meta values
WHILE(@@FETCH_STATUS = 0)
BEGIN

	IF @MultiLanguageValue = 0
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 0)
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''
	ELSE
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''_Localization
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 0) 
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''

	EXEC(@Query_tmp)

	IF @@ERROR <> 0 GOTO ERR

	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable
END

CLOSE classall_cursor

--Close symmetric key
exec mdpsp_sys_CloseSymmetricKey

--Recreate symmetric key
DROP SYMMETRIC KEY Mediachase_ECF50_MDP_Key
CREATE SYMMETRIC KEY Mediachase_ECF50_MDP_Key
	WITH ALGORITHM = RC4_128 ENCRYPTION BY CERTIFICATE Mediachase_ECF50_MDP

--Open new symmetric key
exec mdpsp_sys_OpenSymmetricKey

OPEN classall_cursor	
	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable
	
--Encrypt meta values
WHILE(@@FETCH_STATUS = 0) 
BEGIN

	IF @MultiLanguageValue = 0
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 1)
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''
	ELSE
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''_Localization
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 1) 
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''

	EXEC(@Query_tmp)

	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable
END

CLOSE classall_cursor
DEALLOCATE classall_cursor

--Close new symmetric key
exec mdpsp_sys_CloseSymmetricKey

COMMIT TRAN
RETURN

ERR:
	ROLLBACK TRAN
RETURN'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- January 15, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 63;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

--
EXEC dbo.sp_executesql @statement = N'UPDATE CatalogEntryRelation SET RelationTypeId = ''ProductVariation'' WHERE RelationTypeId = ''product'''
EXEC dbo.sp_executesql @statement = N'UPDATE CatalogEntryRelation SET RelationTypeId = ''PackageEntry'' WHERE RelationTypeId = ''package'''
EXEC dbo.sp_executesql @statement = N'UPDATE CatalogEntryRelation SET RelationTypeId = ''BundleEntry'' WHERE RelationTypeId = ''bundle'' OR RelationTypeId = ''dynamicpackage'''

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- January 21, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 64;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

-- The patch has been moved to Application update script

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- March 16, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 65;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC sp_executesql @statement = N'ALTER TABLE CatalogNode ADD ApplicationId uniqueidentifier NULL'
EXEC sp_executesql @statement = N'UPDATE CatalogNode SET ApplicationId = C.ApplicationId FROM CatalogNode CN INNER JOIN [Catalog] C ON CN.CatalogId = C.CatalogId'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogNode ALTER COLUMN [ApplicationId] uniqueidentifier NOT NULL'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogNode DROP CONSTRAINT IX_CatalogItem'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogNode ADD CONSTRAINT IX_CatalogItem UNIQUE NONCLUSTERED (Code,ApplicationId) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC sp_executesql @statement = N'ALTER TABLE CatalogEntry ADD ApplicationId uniqueidentifier NULL'
EXEC sp_executesql @statement = N'UPDATE CatalogEntry SET ApplicationId = C.ApplicationId FROM CatalogEntry CE INNER JOIN [Catalog] C ON CE.CatalogId = C.CatalogId'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogEntry ALTER COLUMN [ApplicationId] uniqueidentifier NOT NULL'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogEntry DROP CONSTRAINT IX_CatalogEntity'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogEntry ADD CONSTRAINT IX_CatalogEntity UNIQUE NONCLUSTERED (Code,	ApplicationId) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC sp_executesql @statement = N'ALTER TABLE CatalogItemSeo ADD ApplicationId uniqueidentifier NULL'
EXEC sp_executesql @statement = N'UPDATE CatalogItemSeo SET ApplicationId = N.ApplicationId FROM CatalogItemSeo S INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId'
EXEC sp_executesql @statement = N'UPDATE CatalogItemSeo SET ApplicationId = N.ApplicationId FROM CatalogItemSeo S INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogItemSeo ALTER COLUMN ApplicationId uniqueidentifier NOT NULL'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogItemSeo DROP CONSTRAINT IX_CatalogItemSeo'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogItemSeo DROP CONSTRAINT PK_CatalogItemSeo'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogItemSeo ADD CONSTRAINT PK_CatalogItemSeo PRIMARY KEY CLUSTERED (LanguageCode,Uri,ApplicationId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'
EXEC sp_executesql @statement = N'ALTER TABLE CatalogItemSeo ADD CONSTRAINT IX_CatalogItemSeo UNIQUE NONCLUSTERED (LanguageCode,Uri,ApplicationId) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC sp_executesql @statement = N'ALTER TABLE Inventory ADD ApplicationId uniqueidentifier NULL'
EXEC sp_executesql @statement = N'UPDATE Inventory SET ApplicationId = CE.ApplicationId FROM Inventory I INNER JOIN [CatalogEntry] CE ON I.SkuId = CE.Code'
EXEC sp_executesql @statement = N'ALTER TABLE Inventory ALTER COLUMN ApplicationId uniqueidentifier NOT NULL'
EXEC sp_executesql @statement = N'ALTER TABLE Inventory DROP CONSTRAINT IX_VariationInventory'
EXEC sp_executesql @statement = N'ALTER TABLE Inventory DROP CONSTRAINT PK_Inventory'
EXEC sp_executesql @statement = N'ALTER TABLE Inventory ADD CONSTRAINT PK_Inventory PRIMARY KEY CLUSTERED (SkuId,ApplicationId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'
EXEC sp_executesql @statement = N'ALTER TABLE Inventory ADD CONSTRAINT IX_VariationInventory UNIQUE NONCLUSTERED (SkuId,ApplicationId) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryCode]
	@ApplicationId uniqueidentifier,
	@CatalogId int,
	@CatalogEntryCode nvarchar(100)
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
		INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		CE.Code = @CatalogEntryCode AND
		CE.CatalogId = @CatalogId
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
		INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
		INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		CE.Code = @CatalogEntryCode AND
		CE.CatalogId = @CatalogId
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogAssociationByName]
	@ApplicationId uniqueidentifier,
	@AssociationName nvarchar(150)
AS
BEGIN
	SELECT CA.* from [CatalogAssociation] CA
		INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		CA.AssociationName = @AssociationName
	ORDER BY CA.SORTORDER

	SELECT CEA.* from [CatalogEntryAssociation] CEA
		INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
		INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		(CA.AssociationName = @AssociationName OR (CA.AssociationName IS NULL AND @AssociationName IS NULL))
	ORDER BY CA.SORTORDER, CEA.SORTORDER
		
	SELECT * FROM [AssociationType]
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_AssetKey]
	@ApplicationId uniqueidentifier,
	@AssetKey nvarchar(254)
AS
BEGIN
	SELECT A.* from [CatalogItemAsset] A
		INNER JOIN [CatalogEntry] CE ON CE.CatalogEntryId = A.CatalogEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		A.AssetKey = @AssetKey
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
	@ApplicationId uniqueidentifier,
	@CatalogEntryCode nvarchar(100),
	@AssociationName nvarchar(150) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@AssociationName = '''')
		set @AssociationName = null
	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.ApplicationId = @ApplicationId AND
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryAssociation A ON A.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogAssociation CA ON CA.CatalogAssociationId = A.CatalogAssociationId
	INNER JOIN CatalogEntry NE ON NE.CatalogEntryId = CA.CatalogEntryId
	WHERE
		NE.ApplicationId = @ApplicationId AND
		NE.Code = @CatalogEntryCode AND COALESCE(@AssociationName, CA.AssociationName) = CA.AssociationName AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY CA.SORTORDER, A.SORTORDER
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogName]
	@ApplicationId uniqueidentifier,
	@CatalogName nvarchar(150),
	@ReturnInactive bit = 0
AS
BEGIN	
	SELECT N.* from [CatalogEntry] N
	INNER JOIN [Catalog] C ON N.CatalogId = C.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN [Catalog] C ON N.CatalogId = C.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]
	@ApplicationId uniqueidentifier,
	@CatalogName nvarchar(150),
	@CatalogNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		CN.Code = @CatalogNodeCode AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN CatalogNode CN ON R.CatalogNodeId = CN.CatalogNodeId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		CN.Code = @CatalogNodeCode AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]
	@ApplicationId uniqueidentifier,
	@CatalogName nvarchar(150),
	@CatalogNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogEntry] N
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		R.CatalogNodeId = @CatalogNodeId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY R.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	INNER JOIN [Catalog] C ON R.CatalogId = C.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		R.CatalogNodeId = @CatalogNodeId AND
		C.[Name] = @CatalogName AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Name]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(100) = '''',
	@ClassTypeId nvarchar(50) = '''',
	@ReturnInactive bit = 0
AS
BEGIN
	if(@ClassTypeId = '''')
		set @ClassTypeId = null

	if(@Name = '''')
		set @Name = null

	SELECT N.* from [CatalogEntry] N
	WHERE
		N.ApplicationId = @ApplicationId AND
		N.[Name] like @Name AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT DISTINCT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN CatalogEntryRelation R ON R.ChildEntryId = N.CatalogEntryId
	WHERE
		N.ApplicationId = @ApplicationId AND
		N.[Name] like @Name AND COALESCE(@ClassTypeId, N.ClassTypeId) = N.ClassTypeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_UriLanguage]
	@ApplicationId uniqueidentifier,
	@Uri nvarchar(255),
	@LanguageCode nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogEntry] N 
	INNER JOIN CatalogItemSeo S ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.ApplicationId = @ApplicationId AND
		S.Uri = @Uri and S.LanguageCode = @LanguageCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.Uri = @Uri and S.LanguageCode = @LanguageCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntryByCode]
	@ApplicationId uniqueidentifier,
	@CatalogEntryCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogEntry] N
	WHERE
		N.ApplicationId = @ApplicationId AND
		N.Code = @CatalogEntryCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.ApplicationId = @ApplicationId AND
		N.Code = @CatalogEntryCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogName]
	@ApplicationId uniqueidentifier,
	@CatalogName nvarchar(150),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT N.* from [CatalogNode] N
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		C.[Name] = @CatalogName AND N.ParentNodeId = 0 AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
	ORDER BY N.SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	INNER JOIN [Catalog] C ON C.CatalogId = N.CatalogId
	WHERE
		N.ApplicationId = @ApplicationId AND
		C.[Name] = @CatalogName AND N.ParentNodeId = 0 AND 
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNodeCode]
	@ApplicationId uniqueidentifier,
	@CatalogName nvarchar(150),
	@ParentNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN
	declare @CatalogId int
	declare @ParentNodeId int

	select @CatalogId = CatalogId from [Catalog] where [Name] = @CatalogName AND ApplicationId = @ApplicationId
	select @ParentNodeId = CatalogNodeId from [CatalogNode] where Code = @ParentNodeCode AND ApplicationId = @ApplicationId

	EXECUTE [ecf_CatalogNode_CatalogParentNode] @CatalogId,@ParentNodeId,@ReturnInactive
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_Code]
	@ApplicationId uniqueidentifier,
	@CatalogNodeCode nvarchar(100),
	@ReturnInactive bit = 0
AS
BEGIN	
	SELECT N.* from [CatalogNode] N
	WHERE
		N.ApplicationId = @ApplicationId AND
		N.Code = @CatalogNodeCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.ApplicationId = @ApplicationId AND
		N.Code = @CatalogNodeCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_UriLanguage]
	@ApplicationId uniqueidentifier,
	@Uri nvarchar(255),
	@LanguageCode nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogNode] N 
	INNER JOIN CatalogItemSeo S ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.ApplicationId = @ApplicationId AND
		S.Uri = @Uri and S.LanguageCode = @LanguageCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.Uri = @Uri and S.LanguageCode = @LanguageCode AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogRelation]
	@ApplicationId uniqueidentifier,
	@CatalogId int,
	@CatalogNodeId int,
	@CatalogEntryId int,
	@GroupName nvarchar(100),
	@ResponseGroup int
AS
BEGIN
	declare @CatalogNode as int
	declare @CatalogEntry as int
	declare @NodeEntry as int

	set @CatalogNode = 1
	set @CatalogEntry = 2
	set @NodeEntry = 4

	if(@ResponseGroup & @CatalogNode = @CatalogNode)
		SELECT  CNR.* FROM CatalogNodeRelation CNR
			INNER JOIN CatalogNode CN ON CN.CatalogNodeId = CNR.ParentNodeId
		WHERE CN.ApplicationId = @ApplicationId
		ORDER BY CNR.SortOrder 
	else
		select top 0 * from CatalogNodeRelation

	if(@ResponseGroup & @CatalogEntry = @CatalogEntry)
		SELECT CER.* FROM CatalogEntryRelation CER
			INNER JOIN CatalogEntry CE ON CE.CatalogEntryId = CER.ParentEntryId
		WHERE 
			CE.ApplicationId = @ApplicationId AND
			(CER.ParentEntryId = @CatalogEntryId OR @CatalogEntryId = 0) AND 
			(CER.GroupName = @GroupName OR LEN(@GroupName) = 0)
		ORDER BY CER.SortOrder
	else
		select top 0 * from CatalogEntryRelation

	if(@ResponseGroup & @NodeEntry = @NodeEntry)
		SELECT NER.* FROM NodeEntryRelation NER
			INNER JOIN [Catalog] C ON C.CatalogId = NER.CatalogId
		WHERE 
			C.ApplicationId = @ApplicationId AND
			(NER.CatalogId = @CatalogId or @CatalogId = 0) AND
			(NER.CatalogNodeId = @CatalogNodeId or @CatalogNodeId = 0) AND
			(NER.CatalogEntryId = @CatalogEntryId or @CatalogEntryId = 0)
		ORDER BY NER.SortOrder
	else
		select top 0 * from NodeEntryRelation
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodeSearch]
(
	@ApplicationId			uniqueidentifier,
	@SearchSetId			uniqueidentifier,
	@Language 				nvarchar(50),
	@Catalogs 				nvarchar(max),
	@CatalogNodes 			nvarchar(max),
	@SQLClause 				nvarchar(max),
	@MetaSQLClause 			nvarchar(max),
	@FTSPhrase 				nvarchar(max),
	@AdvancedFTSPhrase 		nvarchar(max),
	@OrderBy 				nvarchar(max),
	@Namespace				nvarchar(1024) = N'''',
	@Classes				nvarchar(max) = N'''',
	@StartingRec 			int,
	@NumRecords   			int,
	@RecordCount			int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available catalog node meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogNode''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			if(@SelectMetaQuery_tmp is null)
				set @SelectMetaQuery_tmp = @Query_tmp;
			else
				set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM CatalogNode'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogNode.CatalogNodeId = META.[KEY] ''

	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN CatalogNodeRelation NR ON CatalogNode.CatalogNodeId = NR.ChildNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] CR ON NR.CatalogId = NR.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] C ON C.CatalogId = CatalogNode.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CN ON CatalogNode.ParentNodeId = CN.CatalogNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CNR ON NR.ParentNodeId = CNR.CatalogNodeId''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogNode.CatalogNodeId''
	end

	/* CATALOG AND NODE FILTERING */
	set @FilterQuery_tmp =  N'' WHERE CatalogNode.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(100)) + '''''' AND ((1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR (1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = '''' + @FilterQuery_tmp + N'' AND (CR.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CNR.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	set @FullQuery = N''SELECT count(CatalogNode.CatalogNodeId) OVER() TotalRecords, CatalogNode.CatalogNodeId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, CatalogNodeId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogNodeId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, CatalogNodeId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogNodeSearchResults (SearchSetId, CatalogNodeId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogNodeId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@ApplicationId				uniqueidentifier,
	@SearchSetId				uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
	@AdvancedFTSPhrase 			nvarchar(max),
	@OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
	@StartingRec				int,
	@NumRecords					int,
	@JoinType					nvarchar(50),
	@SourceTableName			sysname,
	@TargetQuery				sysname,
	@SourceJoinKey				sysname,
	@TargetJoinKey				sysname,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	September 2, 2008
		- corrected order for queries, should be ObjectId, Rank instead of Rank, ObjectId
	April 24, 2008
		- added support for joining tables
		- added language filters for meta fields
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(100)) + '''''' AND ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_CreateFTSQuery] @Language, @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry] CatalogEntry'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] ''

	-- attach inner join if needed
	if(@JoinType is not null and Len(@JoinType) > 0)
	begin
		set @Query_tmp = ''''
		EXEC [ecf_CreateTableJoinQuery] @SourceTableName, @TargetQuery, @SourceJoinKey, @TargetJoinKey, @JoinType, @Query_tmp OUT
		print(@Query_tmp)
		set @FromQuery_tmp = @FromQuery_tmp + N'' '' + @Query_tmp
	end
	--print(@FromQuery_tmp)
	
	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_Inventory]
	@ApplicationId uniqueidentifier,
    @CatalogEntryId int
AS
BEGIN

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		I.ApplicationId = @ApplicationId AND
		E.CatalogEntryId = @CatalogEntryId

END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_CatalogEntry]
	@ApplicationId uniqueidentifier,
	@SearchSetId uniqueidentifier
AS
BEGIN
	SELECT N.* from [CatalogEntrySearchResults] R LEFT JOIN [CatalogEntry] N ON N.CatalogEntryId = R.CatalogEntryId 
	where R.[SearchSetId] = @SearchSetId
	order by SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		I.ApplicationId = @ApplicationId AND
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT SP.* from [SalePrice] SP
	INNER JOIN [CatalogEntry] E ON E.Code = SP.ItemCode
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- June 11, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 66;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Catalog]
    @ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier = null,
	@CatalogId int = null,
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT DISTINCT C.* from [Catalog] C
		LEFT OUTER JOIN SiteCatalog SC ON SC.CatalogId = C.CatalogId
	WHERE
		(
			(SC.SiteId = COALESCE(@SiteId,SC.SiteId) or (@SiteId is null and SC.SiteId is null)) 
			AND 
			(C.CatalogId = COALESCE(@CatalogId,C.CatalogId) or (@CatalogId is null and C.CatalogId is null))
		) and 
		(C.IsActive = 1 or @ReturnInactive = 1)
		and
		(C.ApplicationId = @ApplicationId)
/*
	exec [ecf_Catalog_Permissions] @ApplicationId, @SiteId, @CatalogId
*/

	SELECT DISTINCT L.* from [CatalogLanguage] L
		LEFT OUTER JOIN [Catalog] C ON C.CatalogId = L.CatalogId
		LEFT OUTER JOIN SiteCatalog SC ON SC.CatalogId = C.CatalogId
	WHERE
		(
			(SC.SiteId = COALESCE(@SiteId,SC.SiteId) or (@SiteId is null and SC.SiteId is null)) 
			AND 
			(C.CatalogId = COALESCE(@CatalogId,C.CatalogId) or (@CatalogId is null and C.CatalogId is null))
		) and 
		(C.IsActive = 1 or @ReturnInactive = 1)
		and
		(C.ApplicationId = @ApplicationId)

	SELECT DISTINCT SC.* from SiteCatalog SC
		INNER JOIN [Catalog] C ON SC.CatalogId = C.CatalogId
	WHERE
		(
			(SC.SiteId = COALESCE(@SiteId,SC.SiteId)) 
			AND 
			(C.CatalogId = COALESCE(@CatalogId,C.CatalogId) or (@CatalogId is null and C.CatalogId is null))
		) and 
		(C.IsActive = 1 or @ReturnInactive = 1)
		and
		(C.ApplicationId = @ApplicationId)
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 07, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 67;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC sp_executesql @statement = N'ALTER TABLE [MetaFileValue] ALTER COLUMN [ContentType] nvarchar(256) NULL'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 21, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 68;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N' ALTER TABLE dbo.Catalog ADD
	Owner nvarchar(MAX) NULL'

EXEC dbo.sp_executesql @statement = N' ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
    @OrderClause nvarchar(100),
    @StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], C.Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) 
								OR 
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							) 
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, C.Owner 
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], C.Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
					WHERE CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, C.Owner 
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int, 
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords	int,
						@ReturnInactive	bit'';
	exec sp_executesql @execStmtString, @ParamDefinition, 
			@CatalogId = @CatalogId, 
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords	= @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- October 02, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 69;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.CatalogItemSeo
	DROP CONSTRAINT IX_CatalogItemSeo'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- November 05, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 70;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [mdpsp_sys_CreateMetaClassProcedure] 
	@MetaClassId INT
AS
	SET NOCOUNT ON

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is System or not exists.'', 16,1)
		GOTO ERR
	END

	-- Step 1. Create SQL Code
	--PRINT''Step 1. Create SQL Code''

	DECLARE	@MetaClassTable	NVARCHAR(256)
	DECLARE	@MetaClassGetSpName	NVARCHAR(256)
	DECLARE	@MetaClassUpdateSpName NVARCHAR(256)
	DECLARE	@MetaClassDeleteSpName NVARCHAR(256)
	DECLARE	@MetaClassListSpName NVARCHAR(256)
	DECLARE	@MetaClassSearchSpName NVARCHAR(256)
	DECLARE	@MetaClassHistorySpName NVARCHAR(256)

	DECLARE	@CRLF NCHAR(1)

	SELECT @MetaClassTable = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

	SET @MetaClassGetSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Get'' 
	SET @MetaClassUpdateSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Update''
	SET @MetaClassDeleteSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Delete''
	SET @MetaClassListSpName = ''mdpsp_avto_'' +@MetaClassTable +''_List''
	SET @MetaClassSearchSpName = ''mdpsp_avto_'' +@MetaClassTable +''_Search''
	SET @MetaClassHistorySpName	= ''mdpsp_avto_'' +@MetaClassTable +''_History''

	SET @CRLF = CHAR(10)

	-- Step 2. Drop operation
	--PRINT''Step 2. Drop operation''

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassGetSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassGetSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassUpdateSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassUpdateSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassDeleteSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassDeleteSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassListSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassListSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassSearchSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassSearchSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassHistorySpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassHistorySpName)
	IF @@ERROR <> 0 GOTO ERR

	-- Step 3. Create Procedure operation
	--PRINT''Step 3. ALTER Procedure operation''

	DECLARE @OPEN_SYMMETRIC_KEY NVARCHAR(4000)
	DECLARE @CLOSE_SYMMETRIC_KEY NVARCHAR(4000)

	SET @OPEN_SYMMETRIC_KEY = ''''
	SET @CLOSE_SYMMETRIC_KEY = ''''

	DECLARE	@MetaClassFieldList	NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_E	NVARCHAR(4000)
	DECLARE	@MetaClassFieldListWithAt NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet NVARCHAR(4000)
	DECLARE	@MetaClassFieldListInsert NVARCHAR(4000)

	DECLARE	@MetaClassFieldList_L NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L1 NVARCHAR(4000)
	DECLARE	@MetaClassFieldListSet_L2 NVARCHAR(4000)
	DECLARE	@MetaClassFieldList_LI NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L1 NVARCHAR(4000)
	DECLARE @MetaClassFieldListInsert_L2 NVARCHAR(4000)

	SET @MetaClassFieldList = ''ObjectId, CreatorId, Created, ModifierId, Modified''
	SET @MetaClassFieldList_E = ''T.ObjectId, T.CreatorId, T.Created, T.ModifierId, T.Modified''
	SET @MetaClassFieldListWithAt = ''@ObjectId INT, @Language NVARCHAR(20)=NULL, @CreatorId nvarchar(100), @Created DATETIME, @ModifierId nvarchar(100), @Modified DATETIME, @Retval INT OUT''
	SET @MetaClassFieldListSet = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListInsert = ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 

	SET @MetaClassFieldList_L = ''T.ObjectId, T.CreatorId, T.Created, T.ModifierId, T.Modified''
	SET @MetaClassFieldListSet_L1 = ''CreatorId = @CreatorId, Created = @Created, ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldListSet_L2 = ''ModifierId = @ModifierId, Modified = @Modified''
	SET @MetaClassFieldList_LI = ''ObjectId, Language, ModifierId, Modified''
	SET @MetaClassFieldListInsert_L1 =  ''@ObjectId, @CreatorId, @Created, @ModifierId, @Modified'' 
	SET @MetaClassFieldListInsert_L2 = ''@ObjectId, @Language, @ModifierId, @Modified'' 

	DECLARE field_cursor CURSOR FOR 
		SELECT MF.[MetaFieldId], MF.[Name], DT.SqlName, DT.Variable, MF.Length, MF.[AllowNulls], DT.DataTypeId, MF.MultiLanguageValue, MF.IsEncrypted FROM MetaField MF 
			INNER JOIN MetaDataType DT ON DT.DataTypeId = MF.DataTypeId
			INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
		WHERE MCFR.MetaClassId = @MetaClassId AND MF.SystemMetaClassId = 0 ORDER BY MCFR.Weight	

	DECLARE @MetaFieldId INT
	DECLARE @Name 	NVARCHAR(256)
	DECLARE @SqlName 	NVARCHAR(256)
	DECLARE @Variable 	BIT
	DECLARE @Length 	INT
	DECLARE @DataTypeId INT
	DECLARE @MultiLanguageValue BIT
	DECLARE @IsEncrypted BIT	
	DECLARE @UseSymmetricKey BIT
	DECLARE @AllowNulls BIT
	
	SET @UseSymmetricKey = 0

	OPEN field_cursor	
	FETCH NEXT FROM field_cursor INTO @MetaFieldId, @Name, @SqlName, @Variable, @Length, @AllowNulls, @DataTypeId, @MultiLanguageValue, @IsEncrypted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @MetaClassFieldList = @MetaClassFieldList + '', ''
		SET @MetaClassFieldList_E = @MetaClassFieldList_E + '', ''
		SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '', ''
		SET @MetaClassFieldListSet = @MetaClassFieldListSet + '', ''
		SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + '', ''
		SET @MetaClassFieldList_L = @MetaClassFieldList_L + '', ''
		SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + '', ''
		SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + '', ''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + '', ''
		SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + '', ''
		SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2  + '', ''

		SET @MetaClassFieldList = @MetaClassFieldList + ''['' + @Name + '']''
		SET @MetaClassFieldList_LI = @MetaClassFieldList_LI + ''['' + @Name + '']''

		IF @IsEncrypted = 1 BEGIN
			SET @UseSymmetricKey = 1 
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @Name + ''], 0) AS '' + @Name + ''''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
		END
		ELSE BEGIN
			SET @MetaClassFieldList_E = @MetaClassFieldList_E + ''T.['' + @Name + '']''
			SET @MetaClassFieldListSet = @MetaClassFieldListSet + ''['' +@Name + ''] = @'' + @Name 
			SET @MetaClassFieldListInsert = @MetaClassFieldListInsert + ''@'' + @Name 
		END

		IF @MultiLanguageValue = 0
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(T.['' + @Name + ''], 0) AS '' + @Name + ''''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''T.['' + @Name + '']''
				SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1  + ''@'' + @Name + ''''
			END
			SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] =  NULL''
			SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + '' NULL ''
		END
		ELSE
		BEGIN
			IF @IsEncrypted = 1 BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''dbo.mdpfn_sys_EncryptDecryptString(TL.['' + @Name + ''], 0) AS '' + @Name + ''''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)'' 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''dbo.mdpfn_sys_EncryptDecryptString(@'' + @Name + '', 1)''
			END
			ELSE BEGIN
				SET @MetaClassFieldList_L = @MetaClassFieldList_L + ''TL.['' + @Name + '']''
				SET @MetaClassFieldListSet_L2 = @MetaClassFieldListSet_L2 + ''['' +@Name + ''] = @'' + @Name 
				SET @MetaClassFieldListInsert_L2 = @MetaClassFieldListInsert_L2 + ''@'' + @Name
			END
			SET @MetaClassFieldListSet_L1 = @MetaClassFieldListSet_L1 + ''['' +@Name + ''] = default''
			SET @MetaClassFieldListInsert_L1 = @MetaClassFieldListInsert_L1 + '' default ''
		END

		IF @Variable = 0
		BEGIN
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName 

			IF @DataTypeId = 5 OR @DataTypeId = 24
			BEGIN
				-- 2007-01-16 Allows to set custom Precision And Scale for Decimal and Numeric
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
					SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
				END
			END
		END
		ELSE
			SET @MetaClassFieldListWithAt = @MetaClassFieldListWithAt + ''@'' + @Name + '' '' + @SqlName + ''('' + CAST(@Length AS NVARCHAR(20)) + '') '' 

	FETCH NEXT FROM field_cursor INTO @MetaFieldId, @Name, @SqlName, @Variable, @Length, @AllowNulls, @DataTypeId, @MultiLanguageValue, @IsEncrypted
	END

	CLOSE field_cursor
	DEALLOCATE field_cursor

	IF @UseSymmetricKey = 1 BEGIN
		SET @OPEN_SYMMETRIC_KEY = ''exec mdpsp_sys_OpenSymmetricKey''
		SET @CLOSE_SYMMETRIC_KEY = ''exec mdpsp_sys_CloseSymmetricKey''
	END

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS OFF 

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassGetSpName + ''] ''  + @CRLF +
		'' @ObjectId INT ,''+@CRLF +
		'' @Language NVARCHAR(20)=NULL AS '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + '' AS T WHERE T.ObjectId = @ObjectId'' + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T ''+ @CRLF +
		'' LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId   AND TL.Language = @Language WHERE T.ObjectId = @ObjectId'' + @CRLF + @CLOSE_SYMMETRIC_KEY  
		)

	IF @@ERROR <> 0 GOTO ERR

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassUpdateSpName + ''] ''  + @CRLF +
		 @MetaClassFieldListWithAt + 
		'' AS '' + @CRLF +
		'' SET NOCOUNT ON '' + @CRLF +
		'' BEGIN TRAN '' + @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		''  IF @ObjectId = -1 BEGIN ''+ @CRLF + 
		''    SELECT @ObjectId = MAX(ObjectId)+1 FROM '' + @MetaClassTable + '' IF (@ObjectId IS NULL)  SET @ObjectId = 1 END '' + @CRLF +
		'' SET @Retval = @ObjectId '' + @CRLF +
		'' IF @Language IS NULL '' +  @CRLF +
		'' BEGIN '' +  @CRLF +
			'' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' ELSE '' + @CRLF +
		'' BEGIN '' +  @CRLF +
			'' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +'' WHERE ObjectId = @ObjectId  ) UPDATE '' + @MetaClassTable + '' SET '' + @MetaClassFieldListSet_L1 + '' WHERE ObjectId = @ObjectId'' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + '' (''+ @MetaClassFieldList + '') VALUES ('' + @MetaClassFieldListInsert_L1 + '')'' + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' '' + @CRLF +
			'' IF EXISTS(SELECT * FROM ''+ @MetaClassTable +''_Localization WHERE ObjectId = @ObjectId AND Language = @Language  ) UPDATE '' + @MetaClassTable + ''_Localization SET '' + @MetaClassFieldListSet_L2 + '' WHERE ObjectId = @ObjectId AND Language = @Language '' + @CRLF +
		'' ELSE INSERT INTO '' + @MetaClassTable + ''_Localization (''+ @MetaClassFieldList_LI + '') VALUES ('' + @MetaClassFieldListInsert_L2 + '')'' + @CRLF + @CLOSE_SYMMETRIC_KEY + @CRLF +
		'' IF @@ERROR <> 0 GOTO ERR ''+ @CRLF +
		'' END '' + @CRLF +
		'' COMMIT TRAN '' + @CRLF + 
		'' RETURN '' + @CRLF + 
		'' ERR: ROLLBACK TRAN '' + @CRLF + 
		'' RETURN ''
	)

	IF @@ERROR <> 0  GOTO ERR
	--PRINT @MetaClassUpdateSpName

	DECLARE @MetaClassIdSTR NVARCHAR(10)
	SET @MetaClassIdSTR = CAST( @MetaClassId AS NVARCHAR(10) )

	EXEC (''CREATE PROCEDURE [dbo].['' + @MetaClassDeleteSpName + '']  @ObjectId INT AS '' + @CRLF +
		'' DELETE FROM ''  + @MetaClassTable + '' WHERE ObjectId = @ObjectId '' +  @CRLF +
		'' DELETE FROM '' + @MetaClassTable + ''_Localization WHERE ObjectId = @ObjectId '' + @CRLF +
		'' DELETE FROM '' + @MetaClassTable +''_History WHERE ObjectId = @ObjectId '' + @CRLF +
		'' EXEC mdpsp_sys_DeleteMetaKeyObjects ''+@MetaClassIdSTR+'', -1, @ObjectId '')

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassDeleteSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassListSpName + ''] ''  +  @CRLF + 
		'' @Language NVARCHAR(20)=NULL  AS '' +  @CRLF + @OPEN_SYMMETRIC_KEY + @CRLF +
		'' IF @Language IS NULL '' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_E + '' FROM '' +@MetaClassTable + '' AS T '' + @CRLF +
		'' ELSE'' + @CRLF +
		'' SELECT '' + @MetaClassFieldList_L + '' FROM '' +@MetaClassTable + '' AS T LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId  AND TL.Language = @Language'' + @CRLF + @CLOSE_SYMMETRIC_KEY 
		)
	
	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassSearchSpName + ''] '' +  @CRLF + 
		''	@Language nvarchar(20) = NULL,'' +  @CRLF +
		''	@select_list nvarchar(max) = '''''''','' +  @CRLF + 
		''	@search_condition nvarchar(max) = '''''''' AS '' +  @CRLF + 
		''IF LEN(@select_list) > 0'' +  @CRLF + 
		''	SET @select_list = '''', '''' + @select_list '' + @CRLF + 
		@OPEN_SYMMETRIC_KEY + @CRLF +
		''IF @Language IS NULL '' + @CRLF +
		''	exec(''''SELECT '' + @MetaClassFieldList_E + '''''' + @select_list + '''' FROM '' + @MetaClassTable + '' AS T '''' + @search_condition ) '' + @CRLF +
		''ELSE '' + @CRLF +
		''	exec(''''SELECT '' + @MetaClassFieldList_L + '''''' + @select_list + '''' FROM '' + @MetaClassTable + '' AS T LEFT JOIN '' +@MetaClassTable+ ''_Localization AS TL ON T.ObjectId = TL.ObjectId  AND TL.Language = @Language '''' + @search_condition ) '' + @CRLF + 
		@CLOSE_SYMMETRIC_KEY 
		)

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassListSpName

	EXEC(''CREATE PROCEDURE [dbo].['' + @MetaClassHistorySpName + ''] ''  + '' @ObjectId INT, @Language NVARCHAR(20)=NULL  AS ''+  @CRLF +
	'' SELECT * FROM '' +@MetaClassTable + ''_History WHERE ObjectId = @ObjectId AND Language = @Language'' )

	IF @@ERROR <> 0 GOTO ERR
	--PRINT @MetaClassHistorySpName

	SET QUOTED_IDENTIFIER OFF 
	SET ANSI_NULLS ON 

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
RETURN'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- November 11, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 71;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX IX_CatalogItemSeo_CatalogEntryId ON dbo.CatalogItemSeo
	(
	CatalogEntryId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX IX_CatalogItemSeo_CatalogNodeId ON dbo.CatalogItemSeo
	(
	CatalogNodeId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX IX_SalePrice_ItemCode ON dbo.SalePrice
	(
	ItemCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogRelation]
	@ApplicationId uniqueidentifier,
	@CatalogId int,
	@CatalogNodeId int,
	@CatalogEntryId int,
	@GroupName nvarchar(100),
	@ResponseGroup int
AS
BEGIN
	declare @CatalogNode as int
	declare @CatalogEntry as int
	declare @NodeEntry as int

	set @CatalogNode = 1
	set @CatalogEntry = 2
	set @NodeEntry = 4

	if(@ResponseGroup & @CatalogNode = @CatalogNode)
		SELECT  CNR.* FROM CatalogNodeRelation CNR
			INNER JOIN CatalogNode CN ON CN.CatalogNodeId = CNR.ParentNodeId
		WHERE CN.ApplicationId = @ApplicationId
		ORDER BY CNR.SortOrder 
	else
		select top 0 * from CatalogNodeRelation

	if(@ResponseGroup & @CatalogEntry = @CatalogEntry)
		SELECT CER.* FROM CatalogEntryRelation CER
			INNER JOIN CatalogEntry CE ON CE.CatalogEntryId = CER.ParentEntryId
		WHERE 
			CE.ApplicationId = @ApplicationId AND
			(CER.ParentEntryId = @CatalogEntryId OR @CatalogEntryId = 0) AND 
			(CER.GroupName = @GroupName OR LEN(@GroupName) = 0)
		ORDER BY CER.SortOrder
	else
		select top 0 * from CatalogEntryRelation

	if(@ResponseGroup & @NodeEntry = @NodeEntry) 
	BEGIN
		declare @execStmt nvarchar(1000)
		set @execStmt = ''SELECT NER.* FROM NodeEntryRelation NER
			INNER JOIN [Catalog] C ON C.CatalogId = NER.CatalogId
		WHERE 
			C.ApplicationId = @ApplicationId '' 
		
		if @CatalogId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogId = @CatalogId) ''
		if @CatalogNodeId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogNodeId = @CatalogNodeId) ''
		if @CatalogEntryId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogEntryId = @CatalogEntryId) ''

		set @execStmt = @execStmt + '' ORDER BY NER.SortOrder''
		
		declare @pars nvarchar(500)
		set @pars = ''@ApplicationId uniqueidentifier, @CatalogId int, @CatalogNodeId int, @CatalogEntryId int''
		exec sp_executesql @execStmt, @pars, 
			@ApplicationId=@ApplicationId, @CatalogId=@CatalogId, @CatalogNodeId=@CatalogNodeId, @CatalogEntryId=@CatalogEntryId
	END
	else
		select top 0 * from NodeEntryRelation
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 20, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 72;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@ApplicationId				uniqueidentifier,
	@SearchSetId				uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
	@AdvancedFTSPhrase 			nvarchar(max),
	@OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
	@StartingRec				int,
	@NumRecords					int,
	@JoinType					nvarchar(50),
	@SourceTableName			sysname,
	@TargetQuery				sysname,
	@SourceJoinKey				sysname,
	@TargetJoinKey				sysname,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	September 2, 2008
		- corrected order for queries, should be ObjectId, Rank instead of Rank, ObjectId
	April 24, 2008
		- added support for joining tables
		- added language filters for meta fields
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname

	-- Precalculate length for constant strings
	DECLARE @MetaSQLClauseLength bigint
	DECLARE @FTSPhraseLength bigint
	DECLARE @AdvancedFTSPhraseLength bigint
	SET @MetaSQLClauseLength = LEN(@MetaSQLClause)
	SET @FTSPhraseLength = LEN(@FTSPhrase)
	SET @AdvancedFTSPhraseLength = LEN(@AdvancedFTSPhrase)

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(100)) + '''''' AND ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(@FTSPhraseLength>0 OR @AdvancedFTSPhraseLength>0)
				EXEC [dbo].[ecf_CreateFTSQuery] @Language, @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			IF(@FTSPhraseLength>0)
				-- Search by Name in CatalogEntry
				SET @Query_tmp = ''SELECT META.ObjectId AS ''''Key'''', 100 AS ''''Rank'''' FROM '' + @TableName_tmp + '' META JOIN CatalogEntry ON CatalogEntry.CatalogEntryId = META.ObjectId WHERE CatalogEntry.Name LIKE N''''%'' + @FTSPhrase + ''%''''''
			ELSE
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		--print ''@Query_tmp: '' + @Query_tmp

		-- Add meta Where clause
		if(@MetaSQLClauseLength>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp

	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry] CatalogEntry'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] ''

	-- attach inner join if needed
	if(@JoinType is not null and Len(@JoinType) > 0)
	begin
		set @Query_tmp = ''''
		EXEC [ecf_CreateTableJoinQuery] @SourceTableName, @TargetQuery, @SourceJoinKey, @TargetJoinKey, @JoinType, @Query_tmp OUT
		print(@Query_tmp)
		set @FromQuery_tmp = @FromQuery_tmp + N'' '' + @Query_tmp
	end
	--print(@FromQuery_tmp)
	
	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- November 23, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 73;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ecf_splitlist_with_rowid]
(
	@List nvarchar(max)
)
RETURNS 
@ParsedList table
(
	Item nvarchar(100),
	RowId int
)
AS
BEGIN
	DECLARE @Item nvarchar(100), @Pos int, @RowId int
	SET @RowId = 0

	SET @List = LTRIM(RTRIM(@List))+ '',''
	SET @Pos = CHARINDEX('','', @List, 1)

	IF REPLACE(@List, '','', '''') <> ''''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @Item = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
			IF @Item <> ''''
			BEGIN
				SET @RowId = @RowId + 1
				INSERT INTO @ParsedList (Item, RowId) 
				VALUES (CAST(@Item AS nvarchar(100)), @RowId) --Use Appropriate conversion
			END
			SET @List = RIGHT(@List, LEN(@List) - @Pos)
			SET @Pos = CHARINDEX('','', @List, 1)
		END
	END	
	RETURN
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_SearchInsertList]
	@SearchSetId uniqueidentifier,
	@List nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [CatalogEntrySearchResults]
           ([SearchSetId]
           ,[CatalogEntryId]
           ,[Created]
           ,[SortOrder])
     select @SearchSetId, L.Item, getdate(), L.RowId from ecf_splitlist_with_rowid(@List) L inner join CatalogEntry E ON E.CatalogEntryId = L.Item ORDER BY L.RowId

	SET NOCOUNT OFF;
END'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 3, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 74;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogRelation]
	@ApplicationId uniqueidentifier,
	@CatalogId int,
	@CatalogNodeId int,
	@CatalogEntryId int,
	@GroupName nvarchar(100),
	@ResponseGroup int
AS
BEGIN
	declare @CatalogNode as int
	declare @CatalogEntry as int
	declare @NodeEntry as int

	set @CatalogNode = 1
	set @CatalogEntry = 2
	set @NodeEntry = 4

	if(@ResponseGroup & @CatalogNode = @CatalogNode)
		SELECT CNR.* FROM CatalogNodeRelation CNR
			INNER JOIN CatalogNode CN ON CN.CatalogNodeId = CNR.ParentNodeId AND (CN.CatalogId = @CatalogId OR @CatalogId = 0)
		WHERE CN.ApplicationId = @ApplicationId
		ORDER BY CNR.SortOrder 
	else
		select top 0 * from CatalogNodeRelation

	if(@ResponseGroup & @CatalogEntry = @CatalogEntry)
		SELECT CER.* FROM CatalogEntryRelation CER
			INNER JOIN CatalogEntry CE ON CE.CatalogEntryId = CER.ParentEntryId AND (CE.CatalogId = @CatalogId OR @CatalogId = 0)
		WHERE
			CE.ApplicationId = @ApplicationId AND
			(CER.ParentEntryId = @CatalogEntryId OR @CatalogEntryId = 0) AND
			(CER.GroupName = @GroupName OR LEN(@GroupName) = 0)
		ORDER BY CER.SortOrder
	else
		select top 0 * from CatalogEntryRelation

	if(@ResponseGroup & @NodeEntry = @NodeEntry)
	BEGIN
		declare @execStmt nvarchar(1000)
		set @execStmt = ''SELECT NER.* FROM NodeEntryRelation NER
			INNER JOIN [Catalog] C ON C.CatalogId = NER.CatalogId
		WHERE
			C.ApplicationId = @ApplicationId ''
		
		if @CatalogId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogId = @CatalogId) ''
		if @CatalogNodeId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogNodeId = @CatalogNodeId) ''
		if @CatalogEntryId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogEntryId = @CatalogEntryId) ''

		set @execStmt = @execStmt + '' ORDER BY NER.SortOrder''
		
		declare @pars nvarchar(500)
		set @pars = ''@ApplicationId uniqueidentifier, @CatalogId int, @CatalogNodeId int, @CatalogEntryId int''
		exec sp_executesql @execStmt, @pars,
			@ApplicationId=@ApplicationId, @CatalogId=@CatalogId, @CatalogNodeId=@CatalogNodeId, @CatalogEntryId=@CatalogEntryId
	END
	else
		select top 0 * from NodeEntryRelation
END'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 4, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 75;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
	@OrderClause nvarchar(100),
	@StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], C.Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId)
								OR
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							)
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, C.Owner
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0

		-- Get the original catalog id for the given catalog node
		SELECT @CatalogId = [CatalogId] FROM [CatalogNode] WHERE [CatalogNodeId] = @CatalogNodeId

		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], C.Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
					WHERE CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, C.Owner
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int,
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords int,
						@ReturnInactive bit'';
	exec sp_executesql @execStmtString, @ParamDefinition,
			@CatalogId = @CatalogId,
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords = @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END
'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---------------------- May 12, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 76;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_CatalogEntry]
	@ApplicationId uniqueidentifier,
	@SearchSetId uniqueidentifier
AS
BEGIN
	SELECT N.* from [CatalogEntrySearchResults] R LEFT JOIN [CatalogEntry] N ON N.CatalogEntryId = R.CatalogEntryId 
	where R.[SearchSetId] = @SearchSetId
	order by SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		I.ApplicationId = @ApplicationId AND
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT SP.* from [SalePrice] SP
	INNER JOIN [CatalogEntry] E ON E.Code = SP.ItemCode
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT NER.* from [NodeEntryRelation] NER
	WHERE
		NER.CatalogEntryId in (SELECT [CatalogEntryId] from [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)	    

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END
'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- May 27, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 77;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Catalog_RebuildFullTextIndexes]
AS
BEGIN
	declare @RebuildSql nvarchar(4000)
	declare @SchemaName sysname
	declare @TableName sysname
	declare fulltext_index_cursor cursor local for
		select s.[name] as SchemaName, o.[name] as TableName
		from sys.fulltext_catalogs c
		join sys.fulltext_indexes i on c.[fulltext_catalog_id] = i.[fulltext_catalog_id]
		join sys.all_objects o on i.[object_id] = o.[object_id]
		join sys.schemas s on o.[schema_id] = s.[schema_id]
		where c.[name] = N''MetaDataFullTextQueriesCatalog''
	
	alter fulltext catalog MetaDataFullTextQueriesCatalog rebuild
	
	open fulltext_index_cursor
	fetch next from fulltext_index_cursor into @SchemaName, @TableName
	while (@@FETCH_STATUS = 0)
	begin
		set @RebuildSql = ''alter fulltext index on ['' + @SchemaName + ''].['' + @TableName + ''] start full population''
		execute dbo.sp_executesql @RebuildSql
		
		fetch next from fulltext_index_cursor into @SchemaName, @TableName
	end	
	
	close fulltext_index_cursor
	deallocate fulltext_index_cursor	
END'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- May 27, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 78;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
if (exists(select * from sys.objects where object_id = OBJECT_ID(N'[dbo].[ecf_Catalog_RebuildFullTextIndexes]') AND type in (N'P', N'PC')))
execute dbo.sp_executesql @statement = N'DROP PROCEDURE [dbo].[ecf_Catalog_RebuildFullTextIndexes]'
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- June 13, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 79;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(6)
declare @statement nvarchar(max)

if exists (select * from sys.objects where object_id = object_id(N'[dbo].[CatalogEntrySearchResults_SingleSort]') AND type in (N'U'))
begin
	set @statement = 'drop table [dbo].[CatalogEntrySearchResults_SingleSort]'
	execute dbo.sp_executesql @statement
end

set @statement =
'create table [dbo].[CatalogEntrySearchResults_SingleSort](
    [SearchSetId] [uniqueidentifier] NOT NULL,
    [ResultIndex] [int] NOT NULL,
    [CatalogEntryId] [int] NOT NULL,
    constraint [PK_CatalogEntrySearchResults_SingleSort] primary key ([SearchSetId], [ResultIndex]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]'
execute dbo.sp_executesql @statement


set @verb = case when exists (select * from sys.objects where object_id = object_id(N'[dbo].[ecf_CatalogEntrySearch_Init]') and type in (N'P', N'PC')) then 'alter' else 'create' end
set @statement = @verb + ' procedure [dbo].[ecf_CatalogEntrySearch_Init]
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null
as
begin
    declare @MetaTableName sysname
    declare @MetaTablesSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @MetaTablesSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.Namespace like ''Mediachase.Commerce.Catalog%''
          and childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @MetaTablesSubquery = 
            case when @MetaTablesSubquery is null then '''' else @MetaTablesSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor
        
    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.IsActive = 1 '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @MetaTablesSubquery + '')''

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
execute dbo.sp_executesql @statement


set @verb = case when exists (select * from sys.objects where object_id = object_id(N'[dbo].[ecf_CatalogEntrySearch_GetResults]') and type in (N'P', N'PC')) then 'alter' else 'create' end
set @statement = @verb + ' procedure [dbo].[ecf_CatalogEntrySearch_GetResults]
    @SearchSetId uniqueidentifier,
    @FirstResultIndex int,
    @MaxResultCount int
as
begin
    declare @LastResultIndex int
    set @LastResultIndex = @FirstResultIndex + @MaxResultCount - 1
    
    select * from CatalogEntry
    where CatalogEntryId in (
        select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    order by CatalogEntryId
    
    select * from CatalogItemSeo
    where CatalogEntryId in (
        select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    order by CatalogEntryId
    
    select * from Variation
    where CatalogEntryId in (
        select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    order by CatalogEntryId
                    
    select * from Merchant
    where MerchantId in (
        select v.MerchantId 
        from Variation v        
        join CatalogEntrySearchResults_SingleSort ix on v.CatalogEntryId = ix.CatalogEntryId
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    
    select * from Inventory
    where SkuId in (
        select ce.Code
   	    from CatalogEntry ce
   	    join CatalogEntrySearchResults_SingleSort ix on ce.CatalogEntryId = ix.CatalogEntryId
   	    where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
   	
   	select * from SalePrice
   	where ItemCode in (
   	    select ce.Code
   	    from CatalogEntry ce
   	    join CatalogEntrySearchResults_SingleSort ix on ce.CatalogEntryId = ix.CatalogEntryId
   	    where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
   	
   	select * from CatalogAssociation
    where CatalogEntryId in (
        select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    order by CatalogEntryId

   	select * from CatalogItemAsset
    where CatalogEntryId in (
        select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    order by CatalogEntryId

   	select * from NodeEntryRelation
    where CatalogEntryId in (
        select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
        where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex)
    order by CatalogEntryId

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	delete from CatalogEntrySearchResults_SingleSort
	where @SearchSetId = SearchSetId and ResultIndex between @FirstResultIndex and @LastResultIndex
end'
execute dbo.sp_executesql @statement


--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO



-------------------- June 13, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 80;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(6)
declare @statement nvarchar(max)

if exists (select * from sys.objects where object_id = object_id(N'[dbo].[CatalogEntrySearchResults_SingleSort]') AND type in (N'U'))
begin
	set @statement = 'drop table [dbo].[CatalogEntrySearchResults_SingleSort]'
	execute dbo.sp_executesql @statement
end

set @statement =
'create table [dbo].[CatalogEntrySearchResults_SingleSort](
    [SearchSetId] [uniqueidentifier] NOT NULL,
    [ResultIndex] [int] NOT NULL,
    [Created] [datetime] NOT NULL CONSTRAINT DF_CatalogEntrySearchResults_SingleSort_Created DEFAULT GETUTCDATE(),
    [CatalogEntryId] [int] NOT NULL,
    constraint [PK_CatalogEntrySearchResults_SingleSort] primary key ([SearchSetId], [ResultIndex]),
)'
execute dbo.sp_executesql @statement

set @statement = 'create index [IX_CatalogEntrySearchResults_SingleSort_Created] on [CatalogEntrySearchResults_SingleSort] ([Created])'
execute dbo.sp_executesql @statement

set @verb = case when exists (select * from sys.objects where object_id = object_id(N'[dbo].[ecf_CatalogEntrySearch_Init]') and type in (N'P', N'PC')) then 'alter' else 'create' end
set @statement = @verb + ' procedure [dbo].[ecf_CatalogEntrySearch_Init]
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null
as
begin
    declare @purgedate datetime
	begin try
		set @purgedate = DATEADD(day, -3, GETUTCDATE())
		delete from [CatalogEntrySearchResults_SingleSort] where Created < @purgedate
	end try
	begin catch
	end catch

    declare @MetaTableName sysname
    declare @MetaTablesSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @MetaTablesSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.Namespace like ''Mediachase.Commerce.Catalog%''
          and childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @MetaTablesSubquery = 
            case when @MetaTablesSubquery is null then '''' else @MetaTablesSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor
        
    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.IsActive = 1 '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @MetaTablesSubquery + '')''

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
execute dbo.sp_executesql @statement

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO




-------------------- June 13, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 81;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(6)
declare @statement nvarchar(max)
set @verb = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'ecf_CatalogEntrySearch_GetResults') then 'alter' else 'create' end
set @statement = @verb + N' procedure [dbo].[ecf_CatalogEntrySearch_GetResults]
    @SearchSetId uniqueidentifier,
    @FirstResultIndex int,
    @MaxResultCount int
as
begin
    declare @LastResultIndex int
    set @LastResultIndex = @FirstResultIndex + @MaxResultCount - 1
    
    declare @keyset table (CatalogEntryId int)
    insert into @keyset 
    select CatalogEntryId from CatalogEntrySearchResults_SingleSort ix
    where ix.SearchSetId = @SearchSetId and ix.ResultIndex between @FirstResultIndex and @LastResultIndex
    
    select * from CatalogEntry
    where CatalogEntryId in (select CatalogEntryId from @keyset)
    order by CatalogEntryId
    
    select * from CatalogItemSeo
    where CatalogEntryId in (select CatalogEntryId from @keyset)
    order by CatalogEntryId
    
    select * from Variation
    where CatalogEntryId in (select CatalogEntryId from @keyset)
    order by CatalogEntryId
                    
    select * from Merchant
    where MerchantId in (
        select v.MerchantId 
        from Variation v 
        where v.CatalogEntryId in (select * from @keyset))
    
    select * from Inventory
    where SkuId in (
        select ce.Code
   	    from CatalogEntry ce
   	    where ce.CatalogEntryId in (select * from @keyset))
   	    
   	select * from SalePrice
   	where ItemCode in (
   	    select ce.Code
   	    from CatalogEntry ce
   	    where ce.CatalogEntryId in (select * from @keyset))
   	    
   	select * from CatalogAssociation
    where CatalogEntryId in (select CatalogEntryId from @keyset)
    order by CatalogEntryId

   	select * from CatalogItemAsset
    where CatalogEntryId in (select CatalogEntryId from @keyset)
    order by CatalogEntryId

   	select * from NodeEntryRelation
    where CatalogEntryId in (select CatalogEntryId from @keyset)
    order by CatalogEntryId

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	delete from CatalogEntrySearchResults_SingleSort
	where @SearchSetId = SearchSetId and ResultIndex between @FirstResultIndex and @LastResultIndex
end'
execute dbo.sp_executesql @statement

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- December 13, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 82;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(6)
declare @statement nvarchar(max)
set @verb = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'ecf_CatalogRelationByChildEntryId') then 'alter' else 'create' end
set @statement = @verb + N' PROCEDURE [dbo].[ecf_CatalogRelationByChildEntryId]
	@ApplicationId uniqueidentifier,
	@ChildEntryId int
AS
BEGIN
	select top 0 * from CatalogNodeRelation

	SELECT CER.* FROM CatalogEntryRelation CER
	INNER JOIN CatalogEntry CE ON CE.CatalogEntryId = CER.ChildEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		CER.ChildEntryId = @ChildEntryId
	ORDER BY CER.SortOrder
	
	select top 0 * from NodeEntryRelation
END'
execute dbo.sp_executesql @statement

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- December 21, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 83;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(6)
declare @statement nvarchar(max)

set @statement = N'alter table [dbo].[NodeEntryRelation] add [Modified] datetime not null default (getutcdate())'
execute dbo.sp_executesql @statement

set @verb = case when exists (select * from sys.objects where name = 'NodeEntryRelation_UpsertTrigger' and type = 'TR') then 'alter' else 'create' end
set @statement = @verb + N' trigger [dbo].[NodeEntryRelation_UpsertTrigger]
	on [dbo].[NodeEntryRelation]
	after update, insert
	as
	begin
		set nocount on
    
		update [dbo].[NodeEntryRelation]
		set [Modified] = GETUTCDATE()
		from [dbo].[NodeEntryRelation] ner
		join inserted
			on ner.[CatalogId] = inserted.[CatalogId]
			and ner.[CatalogEntryId] = inserted.[CatalogEntryId]
			and ner.[CatalogNodeId] = inserted.[CatalogNodeId]
	end'
execute dbo.sp_executesql @statement

set @verb = case when exists (select * from sys.objects where name = 'NodeEntryRelation_DeleteTrigger' and type = 'TR') then 'alter' else 'create' end
set @statement = @verb + N' trigger [dbo].[NodeEntryRelation_DeleteTrigger]
	on [dbo].[NodeEntryRelation]
	after delete
	as
	begin
		set nocount on
    
		insert into ApplicationLog ([Source], [Operation], [ObjectKey], [ObjectType], [Username], [Created], [Succeeded], [ApplicationId])
		select ''catalog'', ''Modified'', deleted.CatalogEntryId, ''relation'', ''database-trigger'', GETUTCDATE(), 1, ISNULL(app.ApplicationId, fallback_app.ApplicationId)
		from deleted
		left outer join Catalog app on deleted.CatalogEntryId = app.CatalogId
		cross join (select top 1 ApplicationId from Application) fallback_app
	end'
execute dbo.sp_executesql @statement


set @verb = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'ecf_CatalogEntrySearch_Init') then 'alter' else 'create' end
set @statement = @verb + N' procedure [dbo].[ecf_CatalogEntrySearch_Init]
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null,
    @DatabaseClockOffsetMS int = null
as
begin
	declare @purgedate datetime
	begin try
		set @purgedate = datediff(day, -3, GETUTCDATE())
		delete from [CatalogEntrySearchResults_SingleSort] where Created < @purgedate
	end try
	begin catch
	end catch

    declare @MetaTableName sysname
    declare @CatalogEntryIdSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @CatalogEntryIdSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.Namespace like ''Mediachase.Commerce.Catalog%''
          and childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @CatalogEntryIdSubquery = 
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor

    -- more @CatalogEntryIdSubquery: find all the catalog entries that have modified relations in NodeEntryRelation, or deleted relations in ApplicationLog
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null)
    begin
        -- adjust modified date filters to account for clock difference between database server and application server clocks    
        if (@EarliestModifiedDate is not null and isnull(@DatabaseClockOffsetMS, 0) > 0)
        begin
            set @EarliestModifiedDate = DATEADD(MS, -@DatabaseClockOffsetMS, @EarliestModifiedDate)
        
            if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
            else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
            else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
            else set @ModifiedFilter = ''''    
        end
    
        declare @ApplicationLogCreatedFilter nvarchar(4000)
        set @ApplicationLogCreatedFilter = REPLACE(REPLACE(@ModifiedFilter, '' where '', '' and ''), ''Modified'', ''Created'')
        
        set @CatalogEntryIdSubquery =
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select CatalogEntryId from NodeEntryRelation'' + @ModifiedFilter +
            '' union all '' +
            ''select cast(ObjectKey as int) as CatalogEntryId from ApplicationLog where [Source] = ''''catalog'''' and [Operation] = ''''Modified'''' and [ObjectType] = ''''relation'''''' + @ApplicationLogCreatedFilter
    end
   
    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.IsActive = 1 '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @CatalogEntryIdSubquery + '')''

    print @query

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
exec dbo.sp_executesql @statement

set @verb = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'ecf_CatalogRelation') then 'alter' else 'create' end
set @statement = @verb + N' PROCEDURE [dbo].[ecf_CatalogRelation]
	@ApplicationId uniqueidentifier,
	@CatalogId int,
	@CatalogNodeId int,
	@CatalogEntryId int,
	@GroupName nvarchar(100),
	@ResponseGroup int
AS
BEGIN
	declare @CatalogNode as int
	declare @CatalogEntry as int
	declare @NodeEntry as int

	set @CatalogNode = 1
	set @CatalogEntry = 2
	set @NodeEntry = 4

	if(@ResponseGroup & @CatalogNode = @CatalogNode)
		SELECT CNR.* FROM CatalogNodeRelation CNR
			INNER JOIN CatalogNode CN ON CN.CatalogNodeId = CNR.ParentNodeId AND (CN.CatalogId = @CatalogId OR @CatalogId = 0)
		WHERE CN.ApplicationId = @ApplicationId
		ORDER BY CNR.SortOrder
	else
		select top 0 * from CatalogNodeRelation

	if(@ResponseGroup & @CatalogEntry = @CatalogEntry)
		SELECT CER.* FROM CatalogEntryRelation CER
			INNER JOIN CatalogEntry CE ON CE.CatalogEntryId = CER.ParentEntryId AND (CE.CatalogId = @CatalogId OR @CatalogId = 0)
		WHERE
			CE.ApplicationId = @ApplicationId AND
			(CER.ParentEntryId = @CatalogEntryId OR @CatalogEntryId = 0) AND
			(CER.GroupName = @GroupName OR LEN(@GroupName) = 0)
		ORDER BY CER.SortOrder
	else
		select top 0 * from CatalogEntryRelation

	if(@ResponseGroup & @NodeEntry = @NodeEntry)
	BEGIN
		declare @execStmt nvarchar(1000)
		set @execStmt = ''SELECT NER.CatalogId, NER.CatalogEntryId, NER.CatalogNodeId, NER.SortOrder FROM NodeEntryRelation NER
			INNER JOIN [Catalog] C ON C.CatalogId = NER.CatalogId
		WHERE 
			C.ApplicationId = @ApplicationId ''
		
		if @CatalogId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogId = @CatalogId) ''
		if @CatalogNodeId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogNodeId = @CatalogNodeId) ''
		if @CatalogEntryId!=0
			set @execStmt = @execStmt + '' AND (NER.CatalogEntryId = @CatalogEntryId) ''

		set @execStmt = @execStmt + '' ORDER BY NER.SortOrder''
		
		declare @pars nvarchar(500)
		set @pars = ''@ApplicationId uniqueidentifier, @CatalogId int, @CatalogNodeId int, @CatalogEntryId int''
		exec sp_executesql @execStmt, @pars,
			@ApplicationId=@ApplicationId, @CatalogId=@CatalogId, @CatalogNodeId=@CatalogNodeId, @CatalogEntryId=@CatalogEntryId
	END
	else
		select top 0 CatalogId, CatalogEntryId, CatalogNodeId, SortOrder from NodeEntryRelation
END'
execute dbo.sp_executesql @statement

set @verb = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'ecf_Search_CatalogEntry') then 'alter' else 'create' end
set @statement = @verb + N' PROCEDURE [dbo].[ecf_Search_CatalogEntry]
	@ApplicationId uniqueidentifier,
	@SearchSetId uniqueidentifier
AS
BEGIN
	SELECT N.* from [CatalogEntrySearchResults] R LEFT JOIN [CatalogEntry] N ON N.CatalogEntryId = R.CatalogEntryId 
	where R.[SearchSetId] = @SearchSetId
	order by SortOrder

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT V.* from [Variation] V
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT M.* from [Merchant] M
	INNER JOIN [Variation] V ON V.MerchantId = M.MerchantId
	WHERE
		V.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT I.* from [Inventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId
	WHERE
		I.ApplicationId = @ApplicationId AND
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT SP.* from [SalePrice] SP
	INNER JOIN [CatalogEntry] E ON E.Code = SP.ItemCode
	WHERE
		E.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT CA.* from [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogEntryId IN (SELECT [CatalogEntryId] FROM [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)

	SELECT NER.CatalogId, NER.CatalogEntryId, NER.CatalogNodeId, NER.SortOrder from [NodeEntryRelation] NER
	WHERE
		NER.CatalogEntryId in (SELECT [CatalogEntryId] from [CatalogEntrySearchResults] WHERE [SearchSetId] = @SearchSetId)	    

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	DELETE FROM CatalogEntrySearchResults WHERE @SearchSetId = SearchSetId

END'
execute dbo.sp_executesql @statement

set @verb = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'ecf_CatalogRelationByChildEntryId') then 'alter' else 'create' end
set @statement = @verb + N' PROCEDURE [dbo].[ecf_CatalogRelationByChildEntryId]
	@ApplicationId uniqueidentifier,
	@ChildEntryId int
AS
BEGIN
	select top 0 * from CatalogNodeRelation

	SELECT CER.* FROM CatalogEntryRelation CER
	INNER JOIN CatalogEntry CE ON CE.CatalogEntryId = CER.ChildEntryId
	WHERE
		CE.ApplicationId = @ApplicationId AND
		CER.ChildEntryId = @ChildEntryId
	ORDER BY CER.SortOrder
	
	select top 0 CatalogId, CatalogEntryId, CatalogNodeId, SortOrder from NodeEntryRelation
END'
execute dbo.sp_executesql @statement

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- January 9, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 84;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb varchar(8000)
declare @statement varchar(8000)

if exists (select * from sys.objects where object_id = object_id(N'[dbo].[CatalogEntrySearchResults_SingleSort]') AND type in (N'U'))
begin
	set @statement = 'drop table [dbo].[CatalogEntrySearchResults_SingleSort]'
	--execute dbo.sp_executesql @statement
	EXEC(@statement)
end

set @statement =
'create table [dbo].[CatalogEntrySearchResults_SingleSort](
    [SearchSetId] [uniqueidentifier] NOT NULL,
    [ResultIndex] [int] NOT NULL,
	[Created] [datetime] NOT NULL CONSTRAINT DF_CatalogEntrySearchResults_SingleSort_Created DEFAULT GETUTCDATE(),
    [CatalogEntryId] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
    constraint [PK_CatalogEntrySearchResults_SingleSort] primary key ([SearchSetId], [ResultIndex]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]'
--execute dbo.sp_executesql @statement
EXEC(@statement)

set @verb = case when exists (select * from sys.objects where object_id = object_id(N'[dbo].[ecf_CatalogEntrySearch_Init]') and type in (N'P', N'PC')) then 'alter' else 'create' end
set @statement = @verb + ' procedure [dbo].[ecf_CatalogEntrySearch_Init]
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null,
	@DatabaseClockOffsetMS int = null
as
begin
    declare @purgedate datetime
	begin try
		set @purgedate = DATEADD(day, -3, GETUTCDATE())
		delete from [CatalogEntrySearchResults_SingleSort] where Created < @purgedate
	end try
	begin catch
	end catch

    declare @MetaTableName sysname
    declare @CatalogEntryIdSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @CatalogEntryIdSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @CatalogEntryIdSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.Namespace like ''Mediachase.Commerce.Catalog%''
          and childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @CatalogEntryIdSubquery = 
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor
	
	-- more @CatalogEntryIdSubquery: find all the catalog entries that have modified relations in NodeEntryRelation, or deleted relations in ApplicationLog
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null)
	begin
		 -- adjust modified date filters to account for clock difference between database server and application server clocks    
        if (@EarliestModifiedDate is not null and isnull(@DatabaseClockOffsetMS, 0) > 0)
        begin
            set @EarliestModifiedDate = DATEADD(MS, -@DatabaseClockOffsetMS, @EarliestModifiedDate)

			if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''			else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
			else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
			else set @ModifiedFilter = ''''
        end
		
		declare @ApplicationLogCreatedFilter nvarchar(4000)
        set @ApplicationLogCreatedFilter = REPLACE(REPLACE(@ModifiedFilter, '' where '', '' and ''), ''Modified'', ''Created'')

		set @CatalogEntryIdSubquery =
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select CatalogEntryId from NodeEntryRelation'' + @ModifiedFilter +
            '' union all '' +
            ''select cast(ObjectKey as int) as CatalogEntryId from ApplicationLog where [Source] = ''''catalog'''' and [Operation] = ''''Modified'''' and [ObjectType] = ''''relation'''''' + @ApplicationLogCreatedFilter
	end   

    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId, ApplicationId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId, ApplicationId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.IsActive = 1 '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @CatalogEntryIdSubquery + '')''

	print @query

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
--execute dbo.sp_executesql @statement
EXEC(@statement)

set @verb = case when exists (select * from sys.objects where object_id = object_id(N'[dbo].[ecf_CatalogEntrySearch_GetResults]') and type in (N'P', N'PC')) then 'alter' else 'create' end
set @statement = @verb + ' procedure [dbo].[ecf_CatalogEntrySearch_GetResults]
    @SearchSetId uniqueidentifier,
    @FirstResultIndex int,
    @MaxResultCount int
as
begin
    declare @LastResultIndex int
    set @LastResultIndex = @FirstResultIndex + @MaxResultCount - 1
    
    declare @keyset table (CatalogEntryId int, ApplicationId uniqueidentifier)
    insert into @keyset 
    select CatalogEntryId, ApplicationId
    from CatalogEntrySearchResults_SingleSort ix
    where ix.SearchSetId = @SearchSetId
      and ix.ResultIndex between @FirstResultIndex and @LastResultIndex
    
    select ce.*
    from CatalogEntry ce
    join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId and ce.ApplicationId = ks.ApplicationId
    order by ce.CatalogEntryId
    
    select cis.*
    from CatalogItemSeo cis
    join @keyset ks on cis.CatalogEntryId = ks.CatalogEntryId and cis.ApplicationId = ks.ApplicationId
    order by cis.CatalogEntryId
    
    select v.*
    from Variation v
    join @keyset ks on v.CatalogEntryId = ks.CatalogEntryId
    order by v.CatalogEntryId
                    
    select distinct m.*
    from Merchant m
    join Variation v on m.MerchantId = v.MerchantId
    join @keyset ks on v.CatalogEntryId = ks.CatalogEntryId and m.ApplicationId = ks.ApplicationId
    
    select i.*
    from Inventory i
    join CatalogEntry ce on i.SkuId = ce.Code and i.ApplicationId = ce.ApplicationId
    join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId and ce.ApplicationId = ks.ApplicationId
   	    
   	select sp.*
   	from SalePrice sp
   	join CatalogEntry ce on sp.ItemCode = ce.Code
   	join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId and ce.ApplicationId = ks.ApplicationId
   	    
   	select ca.*
   	from CatalogAssociation ca
   	join @keyset ks on ca.CatalogEntryId = ks.CatalogEntryId
    order by ca.CatalogEntryId

   	select cia.*
   	from CatalogItemAsset cia
   	join @keyset ks on cia.CatalogEntryId = ks.CatalogEntryId
    order by cia.CatalogEntryId

   	select ner.*
   	from NodeEntryRelation ner
   	join @keyset ks on ner.CatalogEntryId = ks.CatalogEntryId
    order by ner.CatalogEntryId

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	delete from CatalogEntrySearchResults_SingleSort
	where @SearchSetId = SearchSetId and ResultIndex between @FirstResultIndex and @LastResultIndex
end'
--execute dbo.sp_executesql @statement
EXEC(@statement)


--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- January 11, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 85;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

/* 
 * This script updates a pre-SP2 metadata schema to mark all fields with search enabled as searchable,
 * sortable, and stored; tokenizing any fields that were already set to tokenize or are of type
 * LongHtmlString (which gets special parsing in solr to remove html tags). All fields of string-like
 * types are included the default search.
 *
 * This script should preserve the search behavior of most existing environments.  If any undesired 
 * differences are found in search behavior, they are most likely due to changes in which fields are
 * stored in the default search field, or due to the presence of LongHtmlString-typed metafields that
 * the implementation does not wish to be tokenized.  Both of these settings can be modified in the
 * commerce manager by editing the metafields in question.
 */

begin try
    begin transaction

	set nocount on

    declare @user_entry_fields table (
        MetaFieldId int not null,
        DataTypeName nvarchar(256) not null,
        WasSearchable bit not null,
        WasStored bit not null,
        WasTokenized bit not null,
        IsSearchable bit,
        IsSortable bit,
        IsStored bit,
        IsTokenized bit,
        IsDefaultSearch bit
    )

    ;with
    catalog_entry_classes (MetaClassId) as
    (
        select mc.MetaClassId from MetaClass mc where mc.IsSystem = 1 and mc.Name = 'CatalogEntry'
        union all
        select mc.MetaClassId
        from MetaClass mc
        join catalog_entry_classes on mc.ParentClassId = catalog_entry_classes.MetaClassId
    )
    insert into @user_entry_fields (MetaFieldId, DataTypeName, WasSearchable, WasStored, WasTokenized)
    select
        mf.MetaFieldId,
        mdt.Name as DataTypeName,
        mf.AllowSearch,
        case when exists (select * from MetaAttribute where AttrOwnerId = mf.MetaFieldId and [Key] = 'indexstored' and LOWER(CAST(Value as nvarchar)) = 'true')
            then 1 else 0 end as WasStored,
        case when exists (select * from MetaAttribute where AttrOwnerId = mf.MetaFieldId and [Key] = 'indexfield' and LOWER(CAST(Value as nvarchar)) = 'tokenized')
            then 1 else 0 end as WasStored
    from MetaField mf
    join MetaDataType mdt on mf.DataTypeId = mdt.DataTypeId
    where mf.SystemMetaClassId = 0
      and mf.MetaFieldId in (
            select mcmfr.MetaFieldId
            from MetaClassMetaFieldRelation mcmfr
            join catalog_entry_classes c on mcmfr.MetaClassId = c.MetaClassId)


    -- convert the indexing attributes
    update @user_entry_fields
    set
        IsSearchable = WasSearchable,
        IsSortable = WasSearchable,
        IsStored = case when WasStored = 1 or WasSearchable = 1 then 1 else 0 end

    update @user_entry_fields
    set IsTokenized = case
        when WasTokenized = 1 then 1
        when DataTypeName = 'LongHtmlString' then 1
        else 0 end

    update @user_entry_fields
    set IsDefaultSearch = case
        when WasSearchable = 1
         and DataTypeName in (
            'Char', 'NChar', 'NText', 'NVarChar', 'Text', 'VarChar',
            'ShortString', 'LongString', 'LongHtmlString',
            'DictionarySingleValue', 'DictionaryMultiValue', 'EnumSingleValue', 'EnumMultiValue', 'StringDictionary')
        then 1 else 0 end

    
    -- update the indexing attributes
    merge into MetaField dst
    using @user_entry_fields src
    on dst.MetaFieldId = src.MetaFieldId
    when matched then update set dst.AllowSearch = src.IsSearchable;

    merge into MetaAttribute dst
    using (
        select
            MetaFieldId,
            'indexsortable' as AttrKey,
            case when IsSortable = 1 then 'True' else 'False' end as AttrValue
        from @user_entry_fields
        union all
        select
            MetaFieldId,
            'indexstored' as AttrKey,
            case when IsStored = 1 then 'True' else 'False' end as AttrValue
        from @user_entry_fields
        where WasStored != IsStored
        union all
        select
            MetaFieldId,
            'indexfield' as AttrKey,
            case when IsTokenized = 1 then 'tokenized' else 'untokenized' end as AttrValue
        from @user_entry_fields
        where WasTokenized != IsTokenized
        union all
        select
            MetaFieldId,
            'includeindefaultsearch' as AttrKey,
            case when IsDefaultSearch = 1 then 'True' else 'False' end as AttrValue
        from @user_entry_fields) src
    on dst.AttrOwnerId = src.MetaFieldId and dst.AttrOwnerType = 2 and dst.[Key] = src.AttrKey
    when matched then update set dst.Value = src.AttrValue
    when not matched then insert (AttrOwnerId, AttrOwnerType, [Key], Value)
        values (src.MetaFieldId, 2, src.AttrKey, src.AttrValue);

	Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

	Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
        
	set nocount off

    commit transaction
end try
begin catch
    rollback transaction
     
    declare @ERROR_MESSAGE nvarchar (4000)
    declare @ERROR_SEVERITY int
    declare @ERROR_STATE int

    select @ERROR_MESSAGE = ERROR_MESSAGE(), @ERROR_SEVERITY = ERROR_SEVERITY(), @ERROR_STATE = ERROR_STATE()
    raiserror (@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE)       
end catch


--## END Schema Patch ##
-- patch number added within transaction
END
GO



DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 86;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

declare @sql varchar(8000)
set @sql = case when exists(select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogEntrySearch_Init')
	then 'alter' else 'create' end + N' procedure dbo.ecf_CatalogEntrySearch_Init
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @IncludeInactive bit,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null,
    @DatabaseClockOffsetMS int = null
as
begin
	declare @purgedate datetime
	begin try
		set @purgedate = datediff(day, -3, GETUTCDATE())
		delete from [CatalogEntrySearchResults_SingleSort] where Created < @purgedate
	end try
	begin catch
	end catch

    declare @MetaTableName sysname
    declare @CatalogEntryIdSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @CatalogEntryIdSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.Namespace like ''Mediachase.Commerce.Catalog%''
          and childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @CatalogEntryIdSubquery = 
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor

    -- more @CatalogEntryIdSubquery: find all the catalog entries that have modified relations in NodeEntryRelation, or deleted relations in ApplicationLog
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null)
    begin
        -- adjust modified date filters to account for clock difference between database server and application server clocks    
        if (@EarliestModifiedDate is not null and isnull(@DatabaseClockOffsetMS, 0) > 0)
        begin
            set @EarliestModifiedDate = DATEADD(MS, -@DatabaseClockOffsetMS, @EarliestModifiedDate)
        
            if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
            else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
            else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
            else set @ModifiedFilter = ''''    
        end
    
        declare @ApplicationLogCreatedFilter nvarchar(4000)
        set @ApplicationLogCreatedFilter = REPLACE(REPLACE(@ModifiedFilter, '' where '', '' and ''), ''Modified'', ''Created'')
        
        set @CatalogEntryIdSubquery =
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select CatalogEntryId from NodeEntryRelation'' + @ModifiedFilter +
            '' union all '' +
            ''select cast(ObjectKey as int) as CatalogEntryId from ApplicationLog where [Source] = ''''catalog'''' and [Operation] = ''''Modified'''' and [ObjectType] = ''''relation'''''' + @ApplicationLogCreatedFilter
    end
   
    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId, ApplicationId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId, ApplicationId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @CatalogEntryIdSubquery + '')''
      
    if @IncludeInactive = 0 set @query = @query + '' and CatalogEntry.IsActive = 1''

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
exec(@sql)

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO



DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 87;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

declare @sql varchar(8000)
set @sql = case when exists(select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogEntry_UriLanguage')
	then 'alter' else 'create' end + N' PROCEDURE [dbo].[ecf_CatalogEntry_UriLanguage]
	@ApplicationId uniqueidentifier,
	@Uri nvarchar(255),
	@LanguageCode nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT TOP(1) N.* from [CatalogEntry] N 
	INNER JOIN CatalogItemSeo S ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.ApplicationId = @ApplicationId AND
		S.Uri = @Uri AND (S.LanguageCode = @LanguageCode OR @LanguageCode is NULL) AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.Uri = @Uri AND (S.LanguageCode = @LanguageCode OR @LanguageCode is NULL) AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'
exec(@sql)

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO





DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 88;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
    declare @sql nvarchar(4000)
    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CreateFTSQuery') set @sql = 'alter '
    else set @sql = 'create '

    set @sql = @sql + ' PROCEDURE [dbo].[ecf_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				sysname,
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

    /*
    example query, for table CatalogEntryEx_Example, FTSFunction FreeTextTable, language en, and FTSPhrase ''phrase'':
    select fts.ObjectId as [KEY], MIN(fts.Rank) as Rank
    from (
        select c.ObjectId, fts.Rank
        from FreeTextTable(CatalogEntryEx_Example,*,N''phrase'') fts
        join CatalogEntryEx_Example_Localization c on fts.[KEY] = c.ObjectId and c.Language = N''en''
        union
        select c.ObjectId, fts.Rank
        from FreeTextTable(CatalogEntryEx_Example_Localization,*,N''phrase'') fts
        join CatalogEntryEx_Example_Localization c on fts.[KEY] = c.[Id] where c.Language = N''en''
    ) fts
    group by fts.ObjectId
    */

	set @FTSQuery =
	    N''select fts.ObjectId as [KEY], MIN(fts.Rank) as Rank '' +
	    N''from ('' +
	        N''select c.ObjectId, fts.Rank '' + 
	        N''from '' + @FTSFunction + N''('' + @TableName + N'',*,N'''''' + @FTSPhrase + N'''''') fts '' +
	        N''join '' + @TableName + ''_Localization c on fts.[KEY] = c.ObjectId and c.[Language] = '''''' + @Language + N'''''' '' +
	        N''union '' +
	        N''select c.ObjectId, fts.Rank '' +
	        N''from '' + @FTSFunction + N''('' + @TableName + N''_Localization,*,N'''''' + @FTSPhrase + N'''''') fts '' +
	        N''join '' + @TableName + ''_Localization c on fts.[KEY] = c.[Id] and c.[Language] = '''''' + @Language + N'''''''' +
	    N'') fts '' +
	    N''group by fts.ObjectId''
END'
    
    exec dbo.sp_executesql @sql

    Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 89;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
    declare @sql nvarchar(4000)

    set @sql = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogEntrySearch_GetResults')
        then N'alter'
        else N'create' end +
N' procedure [dbo].[ecf_CatalogEntrySearch_GetResults]
    @SearchSetId uniqueidentifier,
    @FirstResultIndex int,
    @MaxResultCount int
as
begin
    declare @LastResultIndex int
    set @LastResultIndex = @FirstResultIndex + @MaxResultCount - 1
    
    declare @keyset table (CatalogEntryId int, ApplicationId uniqueidentifier)
    insert into @keyset 
    select CatalogEntryId, ApplicationId
    from CatalogEntrySearchResults_SingleSort ix
    where ix.SearchSetId = @SearchSetId
      and ix.ResultIndex between @FirstResultIndex and @LastResultIndex
    
    select ce.*
    from CatalogEntry ce
    join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId and ce.ApplicationId = ks.ApplicationId
    order by ce.CatalogEntryId
    
    select cis.*
    from CatalogItemSeo cis
    join @keyset ks on cis.CatalogEntryId = ks.CatalogEntryId and cis.ApplicationId = ks.ApplicationId
    order by cis.CatalogEntryId
    
    select v.*
    from Variation v
    join @keyset ks on v.CatalogEntryId = ks.CatalogEntryId
    order by v.CatalogEntryId
                    
    select distinct m.*
    from Merchant m
    join Variation v on m.MerchantId = v.MerchantId
    join @keyset ks on v.CatalogEntryId = ks.CatalogEntryId and m.ApplicationId = ks.ApplicationId
    
    select i.*
    from Inventory i
    join CatalogEntry ce on i.SkuId = ce.Code and i.ApplicationId = ce.ApplicationId
    join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId and ce.ApplicationId = ks.ApplicationId
   	    
   	select ca.*
   	from CatalogAssociation ca
   	join @keyset ks on ca.CatalogEntryId = ks.CatalogEntryId
    order by ca.CatalogEntryId

   	select cia.*
   	from CatalogItemAsset cia
   	join @keyset ks on cia.CatalogEntryId = ks.CatalogEntryId
    order by cia.CatalogEntryId

   	select ner.*
   	from NodeEntryRelation ner
   	join @keyset ks on ner.CatalogEntryId = ks.CatalogEntryId
    order by ner.CatalogEntryId

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	delete from CatalogEntrySearchResults_SingleSort
	where @SearchSetId = SearchSetId and ResultIndex between @FirstResultIndex and @LastResultIndex
end'
    exec dbo.sp_executesql @sql
    
    set @sql = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogEntry_Variation')
        then N'alter'
        else N'create' end +
N' procedure dbo.ecf_CatalogEntry_Variation
    @CatalogEntryId int
as
begin
	select v.*
	from Variation v
	where v.CatalogEntryId = @CatalogEntryId
	
	select m.*
	from Merchant m
	join Variation v on m.MerchantId = v.MerchantId
	where v.CatalogEntryId = @CatalogEntryId
end'
    exec dbo.sp_executesql @sql

    set @sql = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_CatalogEntry')
        then N'alter'
        else N'create' end +
N' procedure dbo.ecf_Search_CatalogEntry
	@ApplicationId uniqueidentifier,
	@SearchSetId uniqueidentifier
as
begin
    declare @results table (CatalogEntryId int, SortOrder int)
    insert into @results (CatalogEntryId, SortOrder)
    select r.CatalogEntryId, r.SortOrder
    from CatalogEntrySearchResults r
    where r.SearchSetId = @SearchSetId
    
	select n.*
	from CatalogEntry n
	join @results r on n.CatalogEntryId = r.CatalogEntryId
	order by r.SortOrder
	
	select s.*
	from CatalogItemSeo s
	join @results r on s.CatalogEntryId = r.CatalogEntryId

    select v.*
    from Variation v
    join @results r on v.CatalogEntryId = r.CatalogEntryId

    select m.*
    from Merchant m
    join Variation v on m.MerchantId = v.MerchantId
    join @results r on v.CatalogEntryId = r.CatalogEntryId

    select i.*
    from Inventory i
    join CatalogEntry n on i.SkuId = n.Code
    join @results r on n.CatalogEntryId = r.CatalogEntryId
    where i.ApplicationId = @ApplicationId -- should this join to n.ApplicationId? left as-is to maintain current behavior.
    
    select a.*
    from CatalogAssociation a
    join @results r on a.CatalogEntryId = r.CatalogEntryId

    select a.*
    from CatalogItemAsset a
    join @results r on a.CatalogEntryId = r.CatalogEntryId

    select er.CatalogId, er.CatalogEntryId, er.CatalogNodeId, er.SortOrder
    from NodeEntryRelation er
    join @results r on er.CatalogEntryId = r.CatalogEntryId

	delete CatalogEntrySearchResults
	where SearchSetId = @SearchSetId
end'
    exec dbo.sp_executesql @sql

    Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


-------------------- 
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 90;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##
declare @verb nvarchar(6)
declare @statement nvarchar(max)

set @verb = case when exists (select * from sys.objects where object_id = object_id(N'[dbo].[ecf_CatalogEntrySearch_Init]') and type in (N'P', N'PC')) then 'alter' else 'create' end
set @statement = @verb + ' procedure [dbo].[ecf_CatalogEntrySearch_Init]
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null
as
begin
    declare @MetaTableName sysname
    declare @MetaTablesSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @MetaTablesSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @MetaTablesSubquery = 
            case when @MetaTablesSubquery is null then '''' else @MetaTablesSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor
        
    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.IsActive = 1 '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @MetaTablesSubquery + '')''

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
execute dbo.sp_executesql @statement

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-----------------

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 91;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

declare @sql varchar(8000)
set @sql = case when exists(select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogEntrySearch_Init')
	then 'alter' else 'create' end + N' procedure dbo.ecf_CatalogEntrySearch_Init
    @ApplicationId uniqueidentifier,
    @CatalogId int,
    @SearchSetId uniqueidentifier,
    @IncludeInactive bit,
    @EarliestModifiedDate datetime = null,
    @LatestModifiedDate datetime = null,
    @DatabaseClockOffsetMS int = null
as
begin
	declare @purgedate datetime
	begin try
		set @purgedate = datediff(day, -3, GETUTCDATE())
		delete from [CatalogEntrySearchResults_SingleSort] where Created < @purgedate
	end try
	begin catch
	end catch

    declare @MetaTableName sysname
    declare @CatalogEntryIdSubquery nvarchar(max)
    declare @ModifiedFilter nvarchar(4000)
    declare @query nvarchar(max)
    set @CatalogEntryIdSubquery = null
    
    -- @ModifiedFilter: if there is a filter, build the where clause for it here.
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
    else set @ModifiedFilter = ''''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.Namespace like ''Mediachase.Commerce.Catalog%''
          and childClass.IsSystem = 0
          and parentClass.Name = ''CatalogEntry''
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @CatalogEntryIdSubquery = 
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select ObjectId from '' + @MetaTableName + @ModifiedFilter
            
        fetch metatables_cursor into @MetaTableName        
    end
    close metatables_cursor
    deallocate metatables_cursor

    -- more @CatalogEntryIdSubquery: find all the catalog entries that have modified relations in NodeEntryRelation, or deleted relations in ApplicationLog
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null)
    begin
        -- adjust modified date filters to account for clock difference between database server and application server clocks    
        if (@EarliestModifiedDate is not null and isnull(@DatabaseClockOffsetMS, 0) > 0)
        begin
            set @EarliestModifiedDate = DATEADD(MS, -@DatabaseClockOffsetMS, @EarliestModifiedDate)
        
            if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified between cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime) and cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
            else if (@EarliestModifiedDate is not null) set @ModifiedFilter = '' where Modified >= cast('''''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + '''''' as datetime)''
            else if (@LatestModifiedDate is not null) set @ModifiedFilter = '' where Modified <= cast(''''''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + '''''' as datetime)''
            else set @ModifiedFilter = ''''    
        end
    
        declare @ApplicationLogCreatedFilter nvarchar(4000)
        set @ApplicationLogCreatedFilter = REPLACE(REPLACE(@ModifiedFilter, '' where '', '' and ''), ''Modified'', ''Created'')
        
        set @CatalogEntryIdSubquery =
            case when @CatalogEntryIdSubquery is null then '''' else @CatalogEntryIdSubquery + '' union all '' end +
            ''select CatalogEntryId from NodeEntryRelation'' + @ModifiedFilter +
            '' union all '' +
            ''select cast(ObjectKey as int) as CatalogEntryId from ApplicationLog where [Source] = ''''catalog'''' and [Operation] = ''''Modified'''' and [ObjectType] = ''''relation'''''' + @ApplicationLogCreatedFilter
    end
   
    set @query = 
    ''insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId, ApplicationId) '' +
    ''select '''''' + cast(@SearchSetId as nvarchar(36)) + '''''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId, ApplicationId '' +
    ''from CatalogEntry '' +
    ''where CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(36)) + '''''' '' +
      ''and CatalogEntry.CatalogId = '' + cast(@CatalogId as nvarchar) + '' '' +
      ''and CatalogEntry.CatalogEntryId in ('' + @CatalogEntryIdSubquery + '')''
      
    if @IncludeInactive = 0 set @query = @query + '' and CatalogEntry.IsActive = 1''

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end'
exec(@sql)

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

-------------------- November 7, 2012 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 92;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodeSearch]
(
	@ApplicationId			uniqueidentifier,
	@SearchSetId			uniqueidentifier,
	@Language 				nvarchar(50),
	@Catalogs 				nvarchar(max),
	@CatalogNodes 			nvarchar(max),
	@SQLClause 				nvarchar(max),
	@MetaSQLClause 			nvarchar(max),
	@FTSPhrase 				nvarchar(max),
	@AdvancedFTSPhrase 		nvarchar(max),
	@OrderBy 				nvarchar(max),
	@Namespace				nvarchar(1024) = N'''',
	@Classes				nvarchar(max) = N'''',
	@StartingRec 			int,
	@NumRecords   			int,
	@RecordCount			int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available catalog node meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogNode''

		OPEN MetaClassCursor
		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		WHILE (@@fetch_status = 0)
		BEGIN 
			print ''Metaclass Table: '' + @TableName_tmp
			IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
			begin

				if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
					EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
				else
					set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end
			else
			begin 
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''' from '' + @TableName_tmp + '' META''
			end

			-- Add meta Where clause
			if(LEN(@MetaSQLClause)>0)
				set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause
			
			if(@SelectMetaQuery_tmp is null)
				set @SelectMetaQuery_tmp = @Query_tmp;
			else
				set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

		FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
		END
		CLOSE MetaClassCursor
		DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM CatalogNode'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON CatalogNode.CatalogNodeId = META.[KEY] ''

	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN CatalogNodeRelation NR ON CatalogNode.CatalogNodeId = NR.ChildNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] CR ON NR.CatalogId = NR.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [Catalog] C ON C.CatalogId = CatalogNode.CatalogId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CN ON CatalogNode.ParentNodeId = CN.CatalogNodeId''
	set @FromQuery_tmp = @FromQuery_tmp + N'' LEFT OUTER JOIN [CatalogNode] CNR ON NR.ParentNodeId = CNR.CatalogNodeId''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogNode.CatalogNodeId''
	end

	/* CATALOG AND NODE FILTERING */
	set @FilterQuery_tmp =  N'' WHERE CatalogNode.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(100)) + '''''' AND ((1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (C.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + REPLACE(@CatalogNodes,N'''''''',N'''''''''''') + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR (1=1''
	if(Len(@Catalogs) != 0)
		set @FilterQuery_tmp = '''' + @FilterQuery_tmp + N'' AND (CR.[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''

	if(Len(@CatalogNodes) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND (CNR.[Code] in (select Item from ecf_splitlist('''''' + REPLACE(@CatalogNodes,N'''''''',N'''''''''''') + ''''''))))''
	else
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	set @FullQuery = N''SELECT count(CatalogNode.CatalogNodeId) OVER() TotalRecords, CatalogNode.CatalogNodeId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, CatalogNodeId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogNodeId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, CatalogNodeId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogNodeSearchResults (SearchSetId, CatalogNodeId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogNodeId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END
' 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- November 19, 2012 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 93;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
	@OrderClause nvarchar(100),
	@StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId)
								OR
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							)
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, OG.[NAME] as Owner
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0

		-- Get the original catalog id for the given catalog node
		SELECT @CatalogId = [CatalogId] FROM [CatalogNode] WHERE [CatalogNodeId] = @CatalogNodeId

		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, OG.[NAME] as Owner
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int,
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords int,
						@ReturnInactive bit'';
	exec sp_executesql @execStmtString, @ParamDefinition,
			@CatalogId = @CatalogId,
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords = @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END
'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- December 03 , 2012 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 94;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
Declare @sql varchar(8000)
Set @sql = case when exists(select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogNodesList')
	Then 'Alter' else 'Create' end + N' procedure dbo.ecf_CatalogNodesList (
	@CatalogId int,
	@CatalogNodeId int,
	@OrderClause nvarchar(100),
	@StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId)
								OR
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							)
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, OG.[NAME] as Owner
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0

		-- Get the original catalog id for the given catalog node
		SELECT @CatalogId = [CatalogId] FROM [CatalogNode] WHERE [CatalogNodeId] = @CatalogNodeId

		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                        JOIN CatalogEntry CE ON CE.CatalogId = C.CatalogId
						--We actually dont need to join NodeEntryRelation to get the SortOrder because it is always 0
						--JOIN NodeEntryRelation NER ON (NER.CatalogId = CN.CatalogId And NER.CatalogNodeId = CN.CatalogNodeId  AND CE.CatalogEntryId = NER.CatalogEntryId ) 
                        --LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE CN.CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], R.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int,
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords int,
						@ReturnInactive bit'';
	exec sp_executesql @execStmtString, @ParamDefinition,
			@CatalogId = @CatalogId,
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords = @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END
'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-----January 2013--------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 93;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##
execute dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch_GetResults]
    @SearchSetId uniqueidentifier,
    @FirstResultIndex int,
    @MaxResultCount int
as
begin
    declare @LastResultIndex int
    declare @ApplicationId uniqueidentifier
    set @LastResultIndex = @FirstResultIndex + @MaxResultCount - 1
    
    declare @keyset table (CatalogEntryId int, ApplicationId uniqueidentifier)
    insert into @keyset 
    select CatalogEntryId, ApplicationId
    from CatalogEntrySearchResults_SingleSort ix
    where ix.SearchSetId = @SearchSetId
      and ix.ResultIndex between @FirstResultIndex and @LastResultIndex
    
    select top 1 @ApplicationId = ApplicationId
     from @keyset
      
    select ce.*
    from CatalogEntry ce
    join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId
    order by ce.CatalogEntryId
    
    select cis.*
    from CatalogItemSeo cis
    join @keyset ks on cis.CatalogEntryId = ks.CatalogEntryId
    where cis.ApplicationId=@ApplicationId
    order by cis.CatalogEntryId
    
    select v.*
    from Variation v
    join @keyset ks on v.CatalogEntryId = ks.CatalogEntryId
    order by v.CatalogEntryId
                    
    select distinct m.*
    from Merchant m
    join Variation v on m.MerchantId = v.MerchantId
    join @keyset ks on v.CatalogEntryId = ks.CatalogEntryId
    where m.ApplicationId=@ApplicationId
    
    
    select i.*
    from Inventory i
    join CatalogEntry ce on i.SkuId = ce.Code
    join @keyset ks on ce.CatalogEntryId = ks.CatalogEntryId
    where i.ApplicationId=@ApplicationId
    
   	    
   	select ca.*
   	from CatalogAssociation ca
   	join @keyset ks on ca.CatalogEntryId = ks.CatalogEntryId
    order by ca.CatalogEntryId

   	select cia.*
   	from CatalogItemAsset cia
   	join @keyset ks on cia.CatalogEntryId = ks.CatalogEntryId
    order by cia.CatalogEntryId

   	select ner.*
   	from NodeEntryRelation ner
   	join @keyset ks on ner.CatalogEntryId = ks.CatalogEntryId
    order by ner.CatalogEntryId

	-- Cleanup the loaded OrderGroupIds from SearchResults.
	delete from CatalogEntrySearchResults_SingleSort
	where @SearchSetId = SearchSetId and ResultIndex between @FirstResultIndex and @LastResultIndex
end'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO
---february 2013
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 194;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
begin
EXEC dbo.sp_executesql @statement =  N' CREATE FUNCTION [dbo].[CleanUriSegment](
		@Input VARCHAR(1000))
returns VARCHAR(1000)
AS
BEGIN
	--remove leading spaces
	SET @Input = (SELECT RTRIM(@Input));
	--replace one or more decimals
	SET @Input = (SELECT REPLACE(@Input,''.'',''-''))
	--replace all spaces with dash
	SET @Input = (SELECT REPLACE(@Input,'' '',''-''))
	--replace nonalaphnumerical characters
	Declare @NonAlphanumericalAndNonDash VARCHAR(255) = ''%[^a-z0-9-]%''
	While PatIndex(@NonAlphanumericalAndNonDash, @Input) > 0
        Set @Input = Stuff(@Input, PatIndex(@NonAlphanumericalAndNonDash, @Input), 1, '''')
	
	---replace all consecutive dashes
	While CHARINDEX(''--'', @Input) > 0
        Set @Input = Stuff(@Input,  CHARINDEX(''--'', @Input), 2, ''-'')
    
	return @Input
	
end'
EXEC dbo.sp_executesql @statement = N' ALTER TABLE dbo.CatalogLanguage ADD
									    UriSegment nvarchar(255) NULL'

EXEC dbo.sp_executesql @statement = N' ALTER TABLE dbo.CatalogItemSeo ADD
									    UriSegment nvarchar(255) NULL'

EXEC dbo.sp_executesql @statement = N'UPDATE CatalogItemSeo SET UriSegment = (SELECT dbo.CleanUriSegment(ce.Name) 
																					FROM CatalogEntry ce
																			  WHERE ce.CatalogEntryId = CatalogItemSeo.CatalogEntryId)
									  WHERE CatalogItemSeo.CatalogEntryId IS NOT NULL'										
	
EXEC dbo.sp_executesql @statement = N'UPDATE CatalogItemSeo SET UriSegment = (SELECT dbo.CleanUriSegment(cn.Name) 
																				FROM CatalogNode cn
																			  WHERE cn.CatalogNodeId = CatalogItemSeo.CatalogNodeId)
								      WHERE CatalogItemSeo.CatalogNodeId IS NOT NULL'

EXEC dbo.sp_executesql @statement = N'UPDATE CatalogLanguage SET UriSegment = (SELECT dbo.CleanUriSegment(ce.Name) 
											FROM Catalog ce
										WHERE ce.CatalogId = CatalogLanguage.CatalogId)'

EXEC dbo.sp_executesql @statement =  N'CREATE PROCEDURE [dbo].[UpdateDuplicateEntries]
AS
BEGIN

DECLARE @uriSegment VARCHAR(255)
DECLARE @oldUriSegment VARCHAR(255)
DECLARE @uri VARCHAR(255)
DECLARE @entryId INT
DECLARE @parentEntryId INT
DECLARE @oldParentEntryId INT
DECLARE @parentNodeEntryId INT
DECLARE @oldParentNodeEntryId INT
DECLARE @languageCode VARCHAR(50)
DECLARE @applicationId UNIQUEIDENTIFIER
DECLARE @counter INT
DECLARE @DuplicateEntries TABLE (DuplicateCount INT,
								  LanguageCode VARCHAR(50),
								  ApplicationId UNIQUEIDENTIFIER,
								  UriSegment VARCHAR(50),
								  ParentEntryId INT,
								  CatalogNodeId INT
								 );

WHILE 1=1
BEGIN
	INSERT INTO @DuplicateEntries SELECT count(*),cis.LanguageCode,cis.ApplicationId,cis.UriSegment,cer.ParentEntryId,NER.CatalogNodeId
									FROM CatalogItemSeo cis
									INNER JOIN NodeEntryRelation ner
									    ON ner.CatalogEntryId = CIS.CatalogEntryId
									LEFT JOIN CatalogEntryRelation cer
									    ON ner.CatalogEntryId = cer.ChildEntryId
									WHERE cis.CatalogEntryId IS NOT NULL
									GROUP BY LanguageCode,ApplicationId,UriSegment,cer.ParentEntryId,ner.CatalogNodeId
									HAVING COUNT(*) > 1
	IF @@ROWCOUNT = 0
		RETURN;
																		
	DECLARE db_cursor CURSOR FOR  
	SELECT cis.CatalogEntryId,cis.UriSegment,cer.ParentEntryId,ner.CatalogNodeId,
		  cis.Uri,cis.LanguageCode,cis.ApplicationId
	FROM @DuplicateEntries de
	 INNER JOIN CatalogItemSeo cis 
		ON cis.LanguageCode = de.LanguageCode
		AND cis.ApplicationId =de.ApplicationId
		AND cis.UriSegment = de.UriSegment
	 INNER JOIN NodeEntryRelation ner
		ON cis.CatalogEntryId = ner.CatalogEntryId
		AND ner.CatalogNodeId =  de.CatalogNodeId
	 LEFT JOIN CatalogEntryRelation cer
		ON ner.CatalogEntryId = cer.ChildEntryId
		AND cer.ParentEntryId = de.ParentEntryId
	WHERE cis.CatalogEntryId IS NOT NULL
	ORDER BY cis.UriSegment,cer.ParentEntryId,ner.CatalogNodeId
    
    
    
	OPEN db_cursor
	FETCH NEXT FROM db_cursor INTO @entryId,@uriSegment,@parentEntryId,@parentNodeEntryId,
									@uri,@languageCode,@applicationId   

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
	   IF (@oldUriSegment = @uriSegment AND 
			( ISNULL(@parentEntryId,-1) = ISNULL(@oldParentEntryId,-2) OR ISNULL(@parentNodeEntryId,-1) = ISNULL(@oldParentNodeEntryId,-2)))
	             
	   BEGIN
		   
		   UPDATE CatalogItemSeo  SET UriSegment = @UriSegment+''-''+LTRIM(STR(@counter,10))
		   WHERE CatalogItemSeo.CatalogEntryId = @entryId
		   AND CatalogItemSeo.Uri = @uri
		   AND CatalogItemSeo.ApplicationId = @applicationId
		   AND CatalogItemSeo.LanguageCode = @languageCode
		   SET @counter = @counter+1
		 END
	   ELSE
		BEGIN
		SET @counter = 1
		END
	   
	   SET @oldUriSegment = @uriSegment
	   
	   IF (@parentEntryId is not null)
			SET @oldParentEntryId = @parentEntryId
	   IF (@parentNodeEntryId is not null)
	        SET @oldParentNodeEntryId = @parentNodeEntryId
	   FETCH NEXT FROM db_cursor INTO @entryId,@uriSegment,@parentEntryId,@parentNodeEntryId,
									  @uri,@languageCode,@applicationId
	END   
   
   	CLOSE db_cursor   
	DEALLOCATE db_cursor 
							
END

END'
EXEC dbo.sp_executesql @statement =  N'CREATE PROCEDURE [dbo].[UpdateDuplicateNodes]
AS
BEGIN

DECLARE @uriSegment VARCHAR(255)
DECLARE @oldUriSegment VARCHAR(255)
DECLARE @uri VARCHAR(255)
DECLARE @applicationId UNIQUEIDENTIFIER
DECLARE @languageCode VARCHAR(50)
DECLARE @nodeId INT
DECLARE @parentNodeId INT
DECLARE @oldParentNodeId INT
DECLARE @counter INT
DECLARE @DuplicateNodes TABLE (DuplicateCount INT,
							   LanguageCode VARCHAR(50),
							   ApplicationId UNIQUEIDENTIFIER,
							   UriSegment VARCHAR(50),
							   ParentNodeId INT
								 );

WHILE 1=1
BEGIN
	INSERT INTO @DuplicateNodes SELECT count(*),cis.LanguageCode,cis.ApplicationId,cis.UriSegment,cn.ParentNodeId
									FROM CatalogItemSeo cis
										 INNER JOIN CatalogNode cn
										 ON cis.CatalogNodeId = cn.CatalogNodeId
										 AND cis.ApplicationId = cn.ApplicationId
									WHERE cis.CatalogNodeId IS NOT NULL
									GROUP by LanguageCode,cis.ApplicationId,UriSegment,cn.ParentNodeId
									HAVING COUNT(*) > 1
	IF @@ROWCOUNT = 0
		RETURN;								
	DECLARE db_cursor CURSOR FOR  
	SELECT cis.CatalogNodeId,cis.UriSegment,cn.ParentNodeId,
	       cis.Uri,cis.ApplicationId,cis.LanguageCode 
	FROM @DuplicateNodes de
		 INNER JOIN CatalogItemSeo cis
			ON cis.LanguageCode = de.LanguageCode
			AND cis.ApplicationId =de.ApplicationId
			AND cis.UriSegment = de.UriSegment
		 INNER JOIN CatalogNode cn
			ON cn.CatalogNodeId = cis.CatalogNodeId 
			AND cn.ParentNodeId = de.ParentNodeId 
	WHERE cis.CatalogNodeId IS NOT NULL
	ORDER BY cis.CatalogNodeId,cn.ParentNodeId,cis.UriSegment

	OPEN db_cursor
	FETCH NEXT FROM db_cursor INTO @nodeId,@uriSegment,@parentNodeId,
	                               @uri,@applicationId,@languageCode  

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
	   IF (@oldUriSegment = @uriSegment and @parentNodeId = @oldParentNodeId)
		BEGIN
		   
		   UPDATE CatalogItemSeo  SET UriSegment = @UriSegment+''-''+LTRIM(STR(@counter,10))
		   WHERE CatalogItemSeo.CatalogNodeId = @nodeId
		   AND CatalogItemSeo.Uri = @uri
		   AND CatalogItemSeo.ApplicationId = @applicationId
		   AND CatalogItemSeo.LanguageCode = @languageCode
		   SET @counter = @counter+1
		 END
	   ELSE
		BEGIN
		SET @counter = 1
		END
	   
	   SET @oldUriSegment = @uriSegment
	   SET @oldParentNodeId = @parentNodeId
	   FETCH NEXT FROM db_cursor INTO @nodeId,@uriSegment,@parentNodeId,
									 @uri,@applicationId,@languageCode
	END   

	CLOSE db_cursor   
	DEALLOCATE db_cursor 							

END
END'
EXEC dbo.sp_executesql @statement =  N'CREATE PROCEDURE [UpdateDuplicateCatalog]
AS
BEGIN

DECLARE @UriSegment VARCHAR(255)
DECLARE @OldUriSegment VARCHAR(255)
DECLARE @catalogId INT
DECLARE @counter INT
DECLARE @languageCode VARCHAR(50)
DECLARE @DuplicateCatalog TABLE (DuplicateCount INT,
								  UriSegment VARCHAR(50),
								  LanguageCode VARCHAR(50)
								 );

WHILE 1=1
BEGIN

	INSERT INTO @DuplicateCatalog SELECT count(*),UriSegment,LanguageCode
									FROM CatalogLanguage
									GROUP BY UriSegment,LanguageCode
									HAVING COUNT(*) > 1
	IF @@ROWCOUNT = 0
			RETURN;
	DECLARE db_cursor CURSOR FOR  
	SELECT cl.CatalogId,cl.UriSegment,cl.LanguageCode 
	FROM @DuplicateCatalog dc
		 INNER JOIN CatalogLanguage cl
		 ON cl.LanguageCode = dc.LanguageCode
		 AND cl.UriSegment = dc.UriSegment
	ORDER BY cl.CatalogId,dc.LanguageCode,dc.UriSegment


	OPEN db_cursor
	FETCH NEXT FROM db_cursor INTO @catalogId,@UriSegment,@languageCode   

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
	   IF (@OldUriSegment = @UriSegment)
		BEGIN
		   UPDATE CatalogLanguage  SET UriSegment = @UriSegment+''-''+LTRIM(STR(@counter,10))
		   WHERE CatalogLanguage.CatalogId = @catalogId
		   AND CatalogLanguage.LanguageCode = @languageCode
		   set @counter = @counter+1
		 END
	   ELSE
		BEGIN
		SET @counter = 1
		END
	   
	   SET @OldUriSegment = @UriSegment
	   FETCH NEXT FROM db_cursor INTO @catalogId,@UriSegment,@languageCode
	END   

	CLOSE db_cursor   
	DEALLOCATE db_cursor 							

END
END'
END
BEGIN

	EXEC dbo.sp_executesql @statement = N'UpdateDuplicateNodes'
	EXEC dbo.sp_executesql @statement = N'UpdateDuplicateEntries'
	EXEC dbo.sp_executesql @statement = N'UpdateDuplicateCatalog'

--	--DROP procedures and functions used for removing duplicate Urisegment and make uri claen
	EXEC dbo.sp_executesql @statement = N'DROP PROCEDURE UpdateDuplicateNodes'
	EXEC dbo.sp_executesql @statement = N'DROP PROCEDURE UpdateDuplicateEntries'
	EXEC dbo.sp_executesql @statement = N'DROP PROCEDURE UpdateDuplicateCatalog'
	EXEC dbo.sp_executesql @statement = N'DROP FUNCTION CleanUriSegment'
END
BEGIN
----## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
END
GO

-----Feb 2013--------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 195;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##
execute dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
	@OrderClause nvarchar(100),
	@StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId)
								OR
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							)
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, OG.[NAME] as Owner
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0

		-- Get the original catalog id for the given catalog node
		SELECT @CatalogId = [CatalogId] FROM [CatalogNode] WHERE [CatalogNodeId] = @CatalogNodeId

		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                        JOIN CatalogEntry CE ON CE.CatalogId = C.CatalogId
						LEFT JOIN NodeEntryRelation NER ON (NER.CatalogId = CN.CatalogId And NER.CatalogNodeId = CN.CatalogNodeId  AND CE.CatalogEntryId = NER.CatalogEntryId ) 
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE CN.CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], R.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber between @StartingRec and @StartingRec+@NumRecords-1
			order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int,
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords int,
						@ReturnInactive bit'';
	exec sp_executesql @execStmtString, @ParamDefinition,
			@CatalogId = @CatalogId,
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords = @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntry_UriLanguage]
	@ApplicationId uniqueidentifier,
	@Uri nvarchar(255),
	@LanguageCode nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT TOP(1) N.* from [CatalogEntry] N 
	INNER JOIN CatalogItemSeo S ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.ApplicationId = @ApplicationId AND
		S.Uri = @Uri AND (S.LanguageCode = @LanguageCode OR @LanguageCode is NULL) AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.Uri = @Uri AND (S.LanguageCode = @LanguageCode OR @LanguageCode is NULL) AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END' 


EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNode_UriLanguage]
	@ApplicationId uniqueidentifier,
	@Uri nvarchar(255),
	@LanguageCode nvarchar(50),
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogNode] N 
	INNER JOIN CatalogItemSeo S ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.ApplicationId = @ApplicationId AND
		S.Uri = @Uri AND (S.LanguageCode = @LanguageCode OR @LanguageCode is NULL) AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.Uri = @Uri AND (S.LanguageCode = @LanguageCode OR @LanguageCode is NULL) AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-- ensure a CatalogLanguage rows exist for each catalog's default language
declare @major int = 5
declare @minor int = 0
declare @patch int = 196
if not exists (select 1 from SchemaVersion_CatalogSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    insert into CatalogLanguage (CatalogId, LanguageCode)
    select CatalogId, DefaultLanguage
    from [Catalog] c
    where not exists (select 1 from CatalogLanguage existing where c.CatalogId = existing.CatalogId and c.DefaultLanguage = existing.LanguageCode)

    insert into SchemaVersion_CatalogSystem (Major, Minor, Patch, InstallDate)
    values (@major, @minor, @patch, GETDATE())

    print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go

----- March 20, 2013--------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 197;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##
execute dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
	@OrderClause nvarchar(100),
	@StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId)
								OR
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							)
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, OG.[NAME] as Owner
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0

		-- Get the original catalog id for the given catalog node
		SELECT @CatalogId = [CatalogId] FROM [CatalogNode] WHERE [CatalogNodeId] = @CatalogNodeId

		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
						--We actually dont need to join NodeEntryRelation to get the SortOrder because it is always 0
                        --JOIN CatalogEntry CE ON CE.CatalogId = C.CatalogId
						--LEFT JOIN NodeEntryRelation NER ON (NER.CatalogId = CN.CatalogId And NER.CatalogNodeId = CN.CatalogNodeId  AND CE.CatalogEntryId = NER.CatalogEntryId ) 
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE CN.CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], R.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select  TOP '' + cast(@NumRecords as nvarchar(50)) + '' ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber >= '' + cast(@StartingRec as nvarchar(50)) + 
			'' order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select  TOP '' + cast(@NumRecords as nvarchar(50)) + '' ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber >= '' + cast(@StartingRec as nvarchar(50)) +
			'' order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int,
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords int,
						@ReturnInactive bit'';
	exec sp_executesql @execStmtString, @ParamDefinition,
			@CatalogId = @CatalogId,
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords = @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END
'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-- March 26, 2013, set Code column of the Warehouse table to be not null and unique
DECLARE @major INT = 5
DECLARE @minor INT = 0
DECLARE @patch INT = 198
IF NOT EXISTS (SELECT 1 FROM SchemaVersion_CatalogSystem WHERE Major=@major AND Minor=@minor AND Patch=@patch)
BEGIN
--## Schema Patch ##
	UPDATE [Warehouse] SET [Code]='' WHERE [Code] IS NULL
	ALTER TABLE [Warehouse] ALTER COLUMN [Code] NVARCHAR(50) NOT NULL

	ALTER TABLE [Warehouse] ADD CONSTRAINT uc_WarehouseCode UNIQUE (Code)

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go


-- add ecf_CatalogNode_Delete stored procedure
declare @major int = 5
declare @minor int = 0
declare @patch int = 199
if not exists (select 1 from SchemaVersion_CatalogSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @sql nvarchar(max)
    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogNode_Delete') set @sql = 'alter '
    else set @sql = 'create '

    -- this is a long query... add it to the variable in parts of less than 4k chars each.

    set @sql = @sql + 
N'procedure dbo.ecf_CatalogNode_Delete
    @CatalogId int,
    @CatalogNodeId int
as
begin
    begin try
        begin transaction

        declare @affectedNodes table (CatalogNodeId int, MetaClassId int, IsDelete int)    
        declare @affectedEntries table (CatalogEntryId int, MetaClassId int, IsDelete int, ApplicationId uniqueidentifier)

        ;with all_catalog_relations as
        (
            select ParentNodeId, CatalogNodeId as ChildNodeId, 1 as IsDelete from CatalogNode where CatalogId = @CatalogId
            union
            select ParentNodeId, ChildNodeId, 0 as IsDelete from CatalogNodeRelation where CatalogId = @CatalogId
        ),
        affected_nodes as
        (
            select
                cn.CatalogNodeId,
                cn.MetaClassId,
                1 as IsDelete,
                ''|'' + CAST(@CatalogNodeId as nvarchar(4000)) + ''|'' as CurrentNodePath
            from CatalogNode cn
            where cn.CatalogNodeId = @CatalogNodeId
            union all
            select 
                cn.CatalogNodeId,
                cn.MetaClassId,            
                case when cte.IsDelete = 1 and r.IsDelete = 1 then 1 else 0 end,            
                cte.CurrentNodePath + CAST(r.ChildNodeId as nvarchar(4000)) + ''|''
            from affected_nodes cte
            join all_catalog_relations r on cte.CatalogNodeId = r.ParentNodeId and CHARINDEX(cast(r.ChildNodeId as nvarchar(4000)), cte.CurrentNodePath) = 0
            join CatalogNode cn on r.ChildNodeId = cn.CatalogNodeId
        )
        insert into @affectedNodes (CatalogNodeId, MetaClassId, IsDelete)
        select n.CatalogNodeId, n.MetaClassId, MAX(n.IsDelete)
        from affected_nodes n
        group by n.CatalogNodeId, n.MetaClassId

        insert into @affectedEntries (CatalogEntryId, MetaClassId, IsDelete, ApplicationId)
        select
            ce.CatalogEntryId, 
            ce.MetaClassId, 
            MIN(isnull(ce_parent_nodeinfo.IsDelete, 0)) as IsDelete,
            ce.ApplicationId            
        from @affectedNodes ns
        join NodeEntryRelation all_affected_node_relations on ns.CatalogNodeId = all_affected_node_relations.CatalogNodeId
        join CatalogEntry ce on all_affected_node_relations.CatalogEntryId = ce.CatalogEntryId
        join NodeEntryRelation ce_parents on ce.CatalogEntryId = ce_parents.CatalogEntryId
        left outer join @affectedNodes ce_parent_nodeinfo on ce_parents.CatalogNodeId = ce_parent_nodeinfo.CatalogNodeId
        group by ce.CatalogEntryId, ce.MetaClassId, ce.ApplicationId
'

        set @sql = @sql + N'
        insert into ApplicationLog ([Source], Operation, ObjectKey, ObjectType, Username, Created, Succeeded, IPAddress, Notes, ApplicationId)
        select ''catalog'', ''Deleted'', CatalogEntryId, ''entry'', '''', GETUTCDATE(), 1, ''127.0.0.1'', '''', ApplicationId
        from @affectedEntries
        where IsDelete = 1
        
        declare @objectId int
        declare @metaClassId int
        declare @metaName sysname
        declare @isEntry int
        declare @dynamic nvarchar(4000)
        
        declare entry_deletes cursor local for 
            select e.CatalogEntryId, mc.TableName
            from @affectedEntries e
            join MetaClass mc on e.MetaClassId = mc.MetaClassId
            where e.IsDelete = 1        
        open entry_deletes
        while 1=1
        begin
            fetch next from entry_deletes into @objectId, @metaName
            if @@FETCH_STATUS != 0 break
            
            set @dynamic = ''dbo.[mdpsp_avto_'' + @metaName + ''_Delete]''
            exec @dynamic @objectId 
        end
        close entry_deletes
        
        delete from CatalogItemSeo
        where CatalogEntryId in (select CatalogEntryId from @affectedEntries where IsDelete = 1)

        delete from CatalogEntry
        where CatalogEntryId in (select CatalogEntryId from @affectedEntries where IsDelete = 1)
        
        declare node_deletes cursor local for
            select n.CatalogNodeId, mc.TableName
            from @affectedNodes n
            join MetaClass mc on n.MetaClassId = mc.MetaClassId
            where n.IsDelete = 1
        open node_deletes
        while 1=1
        begin
            fetch next from node_deletes into @objectId, @metaName
            if @@FETCH_STATUS != 0 break
            
            set @dynamic = ''dbo.[mdpsp_avto_'' + @metaName + ''_Delete]''
            exec @dynamic @objectId
        end
        close node_deletes
        
        delete from NodeEntryRelation
        where CatalogNodeId in (select CatalogNodeId from @affectedNodes where IsDelete = 1)
        
        delete from CatalogItemSeo
        where CatalogNodeId in (select CatalogNodeId from @affectedNodes where IsDelete = 1)

        delete from CatalogNode
        where CatalogNodeId in (select CatalogNodeId from @affectedNodes where IsDelete = 1)  
'

        set @sql = @sql + N'        
        if OBJECT_ID(''tempdb.dbo.#updated_metaobjects'') is not null
        begin
            drop table #updated_metaobjects
        end
        
        create table #updated_metaobjects (MetaObjectId int)
        
        declare updated_metaobjects cursor local for
            select MetaClassId, 1 as IsEntry from @affectedEntries where IsDelete = 0
            union
            select MetaClassId, 0 as IsEntry from @affectedNodes where IsDelete = 0
        open updated_metaobjects
        while 1=1
        begin
            fetch next from updated_metaobjects into @metaClassId, @isEntry
            if @@FETCH_STATUS != 0 break
            
            select @metaName = TableName from MetaClass where MetaClassId = @metaClassId

            delete from #updated_metaobjects
            
            if @isEntry = 1
            begin
                insert into #updated_metaobjects (MetaObjectId)
                select CatalogEntryId
                from @affectedEntries
                where IsDelete = 0 and MetaClassId = @metaClassId
            end
            else
            begin
                insert into #updated_metaobjects (MetaObjectId)
                select CatalogNodeId
                from @affectedNodes
                where IsDelete = 0 and MetaClassId = @metaClassId
            end
            
            set @dynamic = ''update dbo.['' + @metaName + ''] set Modified = GETUTCDATE() where ObjectId in (select MetaObjectId from #updated_metaobjects)''
            exec dbo.sp_executesql @dynamic
            
            set @dynamic = ''update dbo.['' + @metaName + ''_Localization] set Modified = GETUTCDATE() where ObjectId in (select MetaObjectId from #updated_metaobjects)''
            exec dbo.sp_executesql @dynamic
        end

        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000) = ERROR_MESSAGE()
        declare @sev int = ERROR_SEVERITY()
        declare @state int = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @state)
    end catch
end
'
    
    exec dbo.sp_executesql @sql

    insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go


-- April 16, 2013, add columns to Warehouse table for store location flags
DECLARE @major INT = 5
DECLARE @minor INT = 0
DECLARE @patch INT = 200
IF NOT EXISTS (SELECT 1 FROM SchemaVersion_CatalogSystem WHERE Major=@major AND Minor=@minor AND Patch=@patch)
BEGIN
--## Schema Patch ##
	ALTER TABLE [Warehouse] ADD [IsFulfillmentCenter] BIT NOT NULL DEFAULT(0)
	ALTER TABLE [Warehouse] ADD [IsPickupLocation] BIT NOT NULL DEFAULT(0)
	ALTER TABLE [Warehouse] ADD [IsDeliveryLocation] BIT NOT NULL DEFAULT(0)

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go


declare @major int = 5
declare @minor int = 0
declare @patch int = 201
if not exists (select 1 from SchemaVersion_CatalogSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @procstab table (name sysname)
    insert into @procstab (name)
    select 'ecf_CatalogEntry_List'
    union all select 'ecf_CatalogNode_List'
    union all select 'ecf_CatalogRelation_NodeDelete'
    union all select 'ecf_CatalogNode_List'
    union all select 'ecf_Search_CatalogEntry'
    union all select 'ecf_CatalogNode_GetDeleteResults'

    declare @sql nvarchar(4000)
    declare @name sysname
    declare procs cursor local for select name from @procstab
    open procs
    while 1=1
    begin
        fetch next from procs into @name
        if @@FETCH_STATUS != 0 break
        if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = @name)
        begin
            set @sql = 'drop procedure dbo.[' + @name + ']'
            exec dbo.sp_executesql @sql
        end
    end
    close procs

    if exists (select 1 from sys.types t join sys.schemas s on t.schema_id = s.schema_id where s.name = 'dbo' and t.name = 'udttEntityList')
    begin
        set @sql='drop type dbo.udttEntityList'
        exec dbo.sp_executesql @sql
    end

    set @sql='create type dbo.udttEntityList as table (EntityId int, SortOrder int)'
    exec dbo.sp_executesql @sql

    set @sql='create procedure dbo.ecf_CatalogEntry_List
    @CatalogEntries udttEntityList readonly
as
begin
    select n.*
	from CatalogEntry n
	join @CatalogEntries r on n.CatalogEntryId = r.EntityId
	order by r.SortOrder
	
	select s.*
	from CatalogItemSeo s
	join @CatalogEntries r on s.CatalogEntryId = r.EntityId

    select v.*
    from Variation v
    join @CatalogEntries r on v.CatalogEntryId = r.EntityId

    select m.*
    from Merchant m
    join Variation v on m.MerchantId = v.MerchantId
    join @CatalogEntries r on v.CatalogEntryId = r.EntityId

    select i.*
    from Inventory i
    join CatalogEntry n on i.SkuId = n.Code and i.ApplicationId = n.ApplicationId
    join @CatalogEntries r on n.CatalogEntryId = r.EntityId
    
    select a.*
    from CatalogAssociation a
    join @CatalogEntries r on a.CatalogEntryId = r.EntityId

    select a.*
    from CatalogItemAsset a
    join @CatalogEntries r on a.CatalogEntryId = r.EntityId

    select er.CatalogId, er.CatalogEntryId, er.CatalogNodeId, er.SortOrder
    from NodeEntryRelation er
    join @CatalogEntries r on er.CatalogEntryId = r.EntityId
end'
    exec dbo.sp_executesql @sql


    set @sql='create procedure dbo.ecf_CatalogRelation_NodeDelete
    @CatalogEntries dbo.udttEntityList readonly,
    @CatalogNodes dbo.udttEntityList readonly
as
begin
    select * from CatalogNodeRelation cnr where 0=1
    
    select *
    from CatalogEntryRelation
    where ParentEntryId in (select EntityId from @CatalogEntries)
       or ChildEntryId in (select EntityId from @CatalogEntries)
       
    select CatalogId, CatalogEntryId, CatalogNodeId, SortOrder
    from NodeEntryRelation
    where CatalogEntryId in (select EntityId from @CatalogEntries)
       or CatalogNodeId in (select EntityId from @CatalogNodes)
end'
    exec dbo.sp_executesql @sql


    set @sql='create procedure dbo.ecf_CatalogNode_List
    @CatalogNodes udttEntityList readonly
as
begin
    select *
    from CatalogNode
    where CatalogNodeId in (select EntityId from @CatalogNodes)
    
    select *
    from CatalogItemSeo
    where CatalogNodeId in (select EntityId from @CatalogNodes)
end'
    exec dbo.sp_executesql @sql


    set @sql='create procedure dbo.ecf_Search_CatalogEntry
	@ApplicationId uniqueidentifier,
	@SearchSetId uniqueidentifier
as
begin
    declare @entries dbo.udttEntityList
    insert into @entries (EntityId, SortOrder)
    select r.CatalogEntryId, r.SortOrder
    from CatalogEntrySearchResults r
    where r.SearchSetId = @SearchSetId
    
	exec dbo.ecf_CatalogEntry_List @entries

	delete CatalogEntrySearchResults
	where SearchSetId = @SearchSetId
end'
    exec dbo.sp_executesql @sql


    set @sql='create procedure dbo.ecf_CatalogNode_GetDeleteResults
    @CatalogId int,
    @CatalogNodeId int
as
begin
    declare @affectedNodes table (CatalogNodeId int, IsDelete int)
    declare @affectedEntries table (CatalogEntryId int, IsDelete int)
    
    ;with all_catalog_relations as
    (
        select ParentNodeId, CatalogNodeId as ChildNodeId, 1 as IsDelete from CatalogNode where CatalogId = @CatalogId
        union
        select ParentNodeId, ChildNodeId, 0 as IsDelete from CatalogNodeRelation where CatalogId = @CatalogId
    ),
    affected_nodes as
    (
        select
            cn.CatalogNodeId,
            1 as IsDelete,
            ''|'' + CAST(@CatalogNodeId as nvarchar(4000)) + ''|'' as CurrentNodePath
        from CatalogNode cn
        where cn.CatalogNodeId = @CatalogNodeId
        union all
        select 
            cn.CatalogNodeId,          
            case when cte.IsDelete = 1 and r.IsDelete = 1 then 1 else 0 end,            
            cte.CurrentNodePath + CAST(r.ChildNodeId as nvarchar(4000)) + ''|''
        from affected_nodes cte
        join all_catalog_relations r on cte.CatalogNodeId = r.ParentNodeId and CHARINDEX(cast(r.ChildNodeId as nvarchar(4000)), cte.CurrentNodePath) = 0
        join CatalogNode cn on r.ChildNodeId = cn.CatalogNodeId
    )
    insert into @affectedNodes (CatalogNodeId, IsDelete)
    select n.CatalogNodeId, MAX(n.IsDelete)
    from affected_nodes n
    group by n.CatalogNodeId

    -- @result.IsCatalogEntry is always 0 at this point, joins do not need to specify that they are joining to nodes.
    insert into @affectedEntries (CatalogEntryId, IsDelete)
    select
        ce.CatalogEntryId, 
        MIN(isnull(ce_parent_nodeinfo.IsDelete, 0)) as IsDelete
    from @affectedNodes ns
    join NodeEntryRelation all_affected_node_relations on ns.CatalogNodeId = all_affected_node_relations.CatalogNodeId
    join CatalogEntry ce on all_affected_node_relations.CatalogEntryId = ce.CatalogEntryId
    join NodeEntryRelation ce_parents on ce.CatalogEntryId = ce_parents.CatalogEntryId
    left outer join @affectedNodes ce_parent_nodeinfo on ce_parents.CatalogNodeId = ce_parent_nodeinfo.CatalogNodeId
    group by ce.CatalogEntryId, ce.MetaClassId, ce.ApplicationId

    -- return entry updates, entry deletes, and node deletes; not node updates.
    -- node update rows only exist to populate the entry updates.
    select CatalogEntryId as EntityId, cast(1 as bit) as IsCatalogEntry, cast(IsDelete as bit) as IsDelete
    from @affectedEntries
    union all
    select CatalogNodeId, cast(0 as bit) as IsCatalogEntry, cast(IsDelete as bit) as IsDelete
    from @affectedNodes
    where IsDelete = 1    
end'
    exec dbo.sp_executesql @sql


    insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(nvarchar(30),@major) + '.' + CONVERT(nvarchar(30),@Minor) + '.' +  CONVERT(nvarchar(30),@Patch) + ' was applied successfully.'
end
go


-----May 2013--------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 202;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntryAssocations]
    @CatalogEntries dbo.udttEntityList readonly
AS
BEGIN
	SELECT CA.* FROM [CatalogAssociation] CA
	WHERE
		CA.CatalogEntryId IN (SELECT EntityId FROM  @CatalogEntries)
	
	SELECT CEA.* FROM [CatalogEntryAssociation] CEA
	INNER JOIN [CatalogAssociation] CA ON CA.CatalogAssociationId = CEA.CatalogAssociationId
	WHERE
		CA.CatalogEntryId IN (SELECT EntityId FROM  @CatalogEntries)
		
	SELECT * FROM [AssociationType]
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 203;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
 
  ALTER TABLE [CatalogEntry] ADD [ContentAssetsID] UNIQUEIDENTIFIER
  ALTER TABLE [CatalogNode] ADD [ContentAssetsID] UNIQUEIDENTIFIER
   
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO




declare @major int = 5
declare @minor int = 0
declare @patch int = 204
if not exists (select 1 from SchemaVersion_CatalogSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
	declare @sql nvarchar(4000)
	
	if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Catalog_GetAllChildEntries')
	begin
		set @sql = 'drop procedure dbo.ecf_CatalogNode_GetAllChildEntries';
		exec dbo.sp_executesql @sql
	end

    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_CatalogNode_GetAllChildEntries')
	begin
		set @sql = 'drop procedure dbo.ecf_CatalogNode_GetAllChildEntries';
		exec dbo.sp_executesql @sql
	end

	if exists (select 1 from sys.types t join sys.schemas s on t.schema_id = s.schema_id where s.name = 'dbo' and t.name = 'udttCatalogList')
	begin
		set @sql = 'drop type dbo.udttCatalogList'
		exec dbo.sp_executesql @sql
	end

	if exists (select 1 from sys.types t join sys.schemas s on t.schema_id = s.schema_id where s.name = 'dbo' and t.name = 'udttCatalogNodeList')
	begin
		set @sql = 'drop type dbo.udttCatalogNodeList'
		exec dbo.sp_executesql @sql
	end

	set @sql = 'create type dbo.udttCatalogList as table (CatalogId int)'
	exec dbo.sp_executesql @sql

	set @sql = 'create type dbo.udttCatalogNodeList as table (CatalogNodeId int)'
	exec dbo.sp_executesql @sql

	set @sql = 'create procedure ecf_CatalogNode_GetAllChildEntries
    @catalogNodeIds udttCatalogNodeList readonly
as
begin
    with all_node_relations as 
    (
        select ParentNodeId, CatalogNodeId as ChildNodeId from CatalogNode
        union
        select ParentNodeId, ChildNodeId from CatalogNodeRelation
    ),
    hierarchy as
    (
        select 
            n.CatalogNodeId,
            ''|'' + CAST(n.CatalogNodeId as nvarchar(4000)) + ''|'' as CyclePrevention
        from @catalogNodeIds n
        union all
        select
            children.ChildNodeId as CatalogNodeId,
            parent.CyclePrevention + CAST(children.ChildNodeId as nvarchar(4000)) + ''|'' as CyclePrevention
        from hierarchy parent
        join all_node_relations children on parent.CatalogNodeId = children.ParentNodeId
        where CHARINDEX(''|'' + CAST(children.ChildNodeId as nvarchar(4000)) + ''|'', parent.CyclePrevention) = 0
    )
    select distinct ce.CatalogEntryId, ce.ApplicationId
    from CatalogEntry ce
    join NodeEntryRelation ner on ce.CatalogEntryId = ner.CatalogEntryId
    where ner.CatalogNodeId in (select CatalogNodeId from hierarchy)
end'
	exec dbo.sp_executesql @sql

	set @sql = 'create procedure dbo.ecf_Catalog_GetAllChildEntries
	@catalogIds udttCatalogList readonly
as
begin
	select distinct ce.CatalogEntryId, ce.ApplicationId
	from CatalogEntry ce
	join NodeEntryRelation ner on ce.CatalogEntryId = ner.CatalogEntryId
	where ner.CatalogNodeId in (
		select CatalogNodeId
		from CatalogNode
		where CatalogId in (select CatalogId from @catalogIds)
		union
		select ChildNodeId
		from CatalogNodeRelation
		where CatalogId in (select CatalogId from @catalogIds)
	)
end'
	exec dbo.sp_executesql @sql

	insert into SchemaVersion_CatalogSystem (Major, Minor, Patch, InstallDate)
    values (@major, @minor, @patch, GETDATE())

    print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go



DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 205;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogEntrySearch]
(
	@ApplicationId				uniqueidentifier,
	@SearchSetId				uniqueidentifier,
	@Language 					nvarchar(50),
	@Catalogs 					nvarchar(max),
	@CatalogNodes 				nvarchar(max),
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
	@AdvancedFTSPhrase 			nvarchar(max),
	@OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
	@StartingRec				int,
	@NumRecords					int,
	@JoinType					nvarchar(50),
	@SourceTableName			sysname,
	@TargetQuery				nvarchar(max),
	@SourceJoinKey				sysname,
	@TargetJoinKey				sysname,
	@RecordCount				int OUTPUT,
	@ReturnTotalCount			bit = 1
)
AS
/*
	Last Updated: 
	September 2, 2008
		- corrected order for queries, should be ObjectId, Rank instead of Rank, ObjectId
	April 24, 2008
		- added support for joining tables
		- added language filters for meta fields
	April 8, 2008
		- added support for multiple catalog nodes, so when multiple nodes are specified,
		NodeEntryRelation table is not inner joined since that will produce repetetive entries
	April 2, 2008
		- fixed issue with entry in multiple categories and search done within multiple catalogs
		Now 3 types of queries recognized
		 - when only catalogs are specified, no NodeRelation table is joined and no soring is done
         - when one node filter is specified, sorting is enforced
         - when more than one node filter is specified, sort order is not available and
           noderelation table is not joined
	April 1, 2008 (Happy fools day!)
	    - added support for searching within localized table
	March 31, 2008
		- search couldn''t display results with text type of data due to distinct statement,
		changed it ''*'' to U.[Key], U.[Rank]
	March 20, 2008
		- Added inner join for NodeRelation so we sort by SortOrder by default
	February 5, 2008
		- removed Meta.*, since it caused errors when multiple different meta classes were used
	Known issues:
		if item exists in two nodes and filter is requested for both nodes, the constraints error might happen
*/

BEGIN
	SET NOCOUNT ON
	
	DECLARE @FilterVariables_tmp 		nvarchar(max)
	DECLARE @query_tmp 		nvarchar(max)
	DECLARE @FilterQuery_tmp 		nvarchar(max)
	DECLARE @TableName_tmp sysname
	declare @SelectMetaQuery_tmp nvarchar(max)
	declare @FromQuery_tmp nvarchar(max)
	declare @SelectCountQuery_tmp nvarchar(max)
	declare @FullQuery nvarchar(max)
	DECLARE @JoinQuery_tmp 		nvarchar(max)
	DECLARE @TempTableName_tmp 		sysname
	DECLARE @NameSearchQuery nvarchar(max)

	-- Precalculate length for constant strings
	DECLARE @MetaSQLClauseLength bigint
	DECLARE @FTSPhraseLength bigint
	DECLARE @AdvancedFTSPhraseLength bigint
	SET @MetaSQLClauseLength = LEN(@MetaSQLClause)
	SET @FTSPhraseLength = LEN(@FTSPhrase)
	SET @AdvancedFTSPhraseLength = LEN(@AdvancedFTSPhrase)

	set @RecordCount = -1

	-- ######## CREATE FILTER QUERY
	-- CREATE "JOINS" NEEDED
	-- Create filter query
	set @FilterQuery_tmp = N''''
	--set @FilterQuery_tmp = N'' INNER JOIN Catalog [Catalog] ON [Catalog].CatalogId = CatalogEntry.CatalogId''

	-- Only add NodeEntryRelation table join if one Node filter is specified, if more than one then we can''t inner join it
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' INNER JOIN NodeEntryRelation NodeEntryRelation ON CatalogEntry.CatalogEntryId = NodeEntryRelation.CatalogEntryId''
	end

	-- CREATE "WHERE" NEEDED
	set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE CatalogEntry.ApplicationId = '''''' + cast(@ApplicationId as nvarchar(100)) + '''''' AND ''
	
	-- If nodes specified, no need to filter by catalog since that is done in node filter
	if(Len(@CatalogNodes) = 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogId in (select * from @Catalogs_temp)''
	end

	/*
	-- If node specified, make sure to include items that indirectly belong to the catalogs
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) <= 1)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' OR NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''

	set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	*/

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' CatalogEntry.CatalogEntryId in (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation where ''
	end

	-- Add node filter, have to do this way to not produce multiple entry items
	--set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND CatalogEntry.CatalogEntryId IN (select NodeEntryRelation.CatalogEntryId from NodeEntryRelation NodeEntryRelation INNER JOIN CatalogNode CatalogNode ON NodeEntryRelation.CatalogNodeId = CatalogNode.CatalogNodeId''
	if(Len(@CatalogNodes) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' NodeEntryRelation.CatalogNodeId IN (select CatalogNode.CatalogNodeId from CatalogNode CatalogNode''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + ''''''))) AND NodeEntryRelation.CatalogId in (select * from @Catalogs_temp)''
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
		--set @FilterQuery_tmp = @FilterQuery_tmp; + N'' WHERE (CatalogNode.[Code] in (select Item from ecf_splitlist('''''' + @CatalogNodes + '''''')))''
	end

	-- Different filter if more than one category is specified
	if(Len(@CatalogNodes) != 0 and (select count(Item) from ecf_splitlist(@CatalogNodes)) > 1)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'')''
	end

	--set @FilterQuery_tmp = @FilterQuery_tmp + N'')''

	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
	begin
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''
	end

	-- 1. Cycle through all the available product meta classes
	--print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
		WHERE C.Namespace like @Namespace + ''%'' AND (C.[Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		--print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(@FTSPhraseLength>0 OR @AdvancedFTSPhraseLength>0)
				EXEC [dbo].[ecf_CreateFTSQuery] @Language, @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end
		else
		begin 
			IF(@FTSPhraseLength>0)
				-- Search by Name in CatalogEntry
				SET @Query_tmp = ''SELECT META.ObjectId AS ''''Key'''', 100 AS ''''Rank'''' FROM '' + @TableName_tmp + '' META JOIN CatalogEntry ON CatalogEntry.CatalogEntryId = META.ObjectId WHERE CatalogEntry.Name LIKE N''''%'' + @FTSPhrase + ''%''''''
			ELSE
				set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
		end

		--print ''@Query_tmp: '' + @Query_tmp

		-- Add meta Where clause
		if(@MetaSQLClauseLength>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	--print @SelectMetaQuery_tmp
		IF(@FTSPhraseLength>0)
			SET @NameSearchQuery = N'' UNION SELECT CatalogEntry.CatalogEntryId AS ''''Key'''', 100 AS ''''Rank'''' FROM CatalogEntry WHERE CatalogEntry.Name LIKE N''''%'' + @FTSPhrase + ''%'''' '';			
			ELSE
			SET @NameSearchQuery = N'''';
	-- Create from command
	SET @FromQuery_tmp = N''FROM [CatalogEntry] CatalogEntry'' + N'' INNER JOIN (select distinct U.[KEY], MIN(U.Rank) AS Rank from ('' + @SelectMetaQuery_tmp + @NameSearchQuery + N'') U GROUP BY U.[KEY]) META ON CatalogEntry.[CatalogEntryId] = META.[KEY] ''

	-- attach inner join if needed
	if(@JoinType is not null and Len(@JoinType) > 0)
	begin
		set @Query_tmp = ''''
		EXEC [ecf_CreateTableJoinQuery] @SourceTableName, @TargetQuery, @SourceJoinKey, @TargetJoinKey, @JoinType, @Query_tmp OUT
		print(@Query_tmp)
		set @FromQuery_tmp = @FromQuery_tmp + N'' '' + @Query_tmp
	end
	--print(@FromQuery_tmp)
	
	-- order by statement here
	if(Len(@OrderBy) = 0 and Len(@CatalogNodes) != 0 and CHARINDEX('','', @CatalogNodes) = 0)
	begin
		set @OrderBy = ''NodeEntryRelation.SortOrder''
	end
	else if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''CatalogEntry.CatalogEntryId''
	end

	--print(@FilterQuery_tmp)
	-- add catalogs temp variable that will be used to filter out catalogs
	set @FilterVariables_tmp = ''declare @Catalogs_temp table (CatalogId int);''
	set @FilterVariables_tmp = @FilterVariables_tmp + ''INSERT INTO @Catalogs_temp select CatalogId from Catalog''
	if(Len(RTrim(LTrim(@Catalogs)))>0)
		set @FilterVariables_tmp = @FilterVariables_tmp + '' WHERE ([Catalog].[Name] in (select Item from ecf_splitlist('''''' + @Catalogs + '''''')))''
	set @FilterVariables_tmp = @FilterVariables_tmp + '';''

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		begin
			set @FullQuery = N''SELECT count([CatalogEntry].CatalogEntryId) OVER() TotalRecords, [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			-- use temp table variable
			set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, ObjectId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			set @FullQuery = @FilterVariables_tmp + ''declare @Page_temp table (TotalRecords int,ObjectId int,SortOrder int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', ObjectId, SortOrder from @Page_temp;''
			exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT
			
			--print @FullQuery
			--exec(@FullQuery)			
		end
	else
		begin
			-- simplified query with no TotalRecords, should give some performance gain
			set @FullQuery = N''SELECT [CatalogEntry].CatalogEntryId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp
			
			set @FullQuery = @FilterVariables_tmp + N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO CatalogEntrySearchResults (SearchSetId, CatalogEntryId, SortOrder) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', CatalogEntryId, RowNumber FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
			--print(@FullQuery)
			--select * from CatalogEntrySearchResults
			exec(@FullQuery)
		end

	--print(@FullQuery)
	SET NOCOUNT OFF
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CreateTableJoinQuery]
(
	@SourceTableName   	sysname,	
	@TargetQuery 		nvarchar(max),
	@SourceJoinKey		sysname, 
	@TargetJoinKey		sysname,
	@JoinType			nvarchar(50),
	@JoinQuery 			nvarchar(max) OUTPUT
)
AS
BEGIN

	SET @SourceTableName = LTRIM(RTRIM(@SourceTableName))

	IF (SUBSTRING(@SourceTableName, 1, 1) <> N''['' OR SUBSTRING(@SourceTableName, LEN(@SourceTableName),1) <> N'']'')
	BEGIN
		SET @SourceTableName=N''[''+@SourceTableName+N'']''
	END
	
	SET @TargetQuery = LTRIM(RTRIM(@TargetQuery))
/*
	IF (SUBSTRING(@TargetTableName, 1, 1) <> N''['' OR SUBSTRING(@TargetTableName, LEN(@TargetTableName),1) <> N'']'')
	BEGIN
		SET @TargetTableName=N''[''+@TargetTableName+N'']''
	END
*/
	--set @JoinQuery = @JoinType + N'' '' + @TargetTableName + N'' '' + @TargetTableName + N'' ON '' + @SourceTableName + N''.['' + @SourceJoinKey + N''] = '' + @TargetTableName + N''.['' + @TargetJoinKey + N'']''
	set @JoinQuery = @JoinType + N'' '' + @TargetQuery + N'' ON '' + @SourceTableName + N''.['' + @SourceJoinKey + N''] = '' + @TargetJoinKey
END

' 
 
--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

-----August 2013--------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 206;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_UriSegment]
	@ApplicationId uniqueidentifier,
	@UriSegment nvarchar(255),
	@CatalogEntryId int,
	@ReturnInactive bit = 0
AS
BEGIN
	SELECT COUNT(*) from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		S.ApplicationId = @ApplicationId AND
		S.UriSegment = @UriSegment AND
		S.CatalogEntryId <> @CatalogEntryId AND
		((N.IsActive = 1) or @ReturnInactive = 1)
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-----September 2013--------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 207;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)

BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_CatalogNodesList]
(
	@CatalogId int,
	@CatalogNodeId int,
	@EntryMetaSQLClause nvarchar(max),
	@OrderClause nvarchar(100),
	@StartingRec int,
	@NumRecords int,
	@ReturnInactive bit = 0,
	@ReturnTotalCount bit = 1
)
AS

BEGIN
	SET NOCOUNT ON

	declare @execStmtString nvarchar(max)
	declare @selectStmtString nvarchar(max)
	declare @query_tmp nvarchar(max)
	declare @EntryMetaSQLClauseLength bigint
	declare @TableName_tmp sysname
	declare @SelectEntryMetaQuery_tmp nvarchar(max)
	set @EntryMetaSQLClauseLength = LEN(@EntryMetaSQLClause)

	set @execStmtString=N''''

	-- assign ORDER BY statement if it is empty
	if(Len(RTrim(LTrim(@OrderClause))) = 0)
		set @OrderClause = N''ID ASC''

    -- Construct meta class joins for CatalogEntry table if a WHERE clause has been specified for Entry Meta data
    IF(@EntryMetaSQLClauseLength>0)
    BEGIN
    	-- If there is a meta SQL clause provided, cycle through all the available product meta classes
    	--print ''Iterating through entry meta classes''
    	-- Similar to [ecf_CatalogEntrySearch], but simpler due to fewer variations, i.e.:
    	--   No @Classes parameter
    	--   No @FTSPhrase or @AdvancedFTSPhrase
    	--   No @Namespace
    	-- Left in the commented out localization join for future reference
    	DECLARE MetaClassCursor CURSOR READ_ONLY
    	FOR SELECT C.TableName FROM MetaClass C INNER JOIN MetaClass C2 ON C.ParentClassId = C2.MetaClassId
    		WHERE C.IsSystem = 0 and C2.[Name] = ''CatalogEntry''
    
    	OPEN MetaClassCursor
    	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
    	WHILE (@@fetch_status = 0)
    	BEGIN 
    		--print ''Metaclass Table: '' + @TableName_tmp
            set @Query_tmp = ''select META.ObjectId as ''''Key'''', 100 as ''''Rank'''' from '' + @TableName_tmp + '' META'' -- INNER JOIN '' + @TableName_tmp + ''_Localization LOC ON META.ObjectId = LOC.Id''
    		set @query_tmp = @query_tmp + '' WHERE '' + @EntryMetaSQLClause
    		--print ''@Query_tmp: '' + @Query_tmp
    
    		-- Add meta Where clause
    
    		if(@SelectEntryMetaQuery_tmp is null)
    			set @SelectEntryMetaQuery_tmp = @Query_tmp;
    		else
    			set @SelectEntryMetaQuery_tmp = @SelectEntryMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;
    
    	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
    	END
    	CLOSE MetaClassCursor
	    DEALLOCATE MetaClassCursor

		set @SelectEntryMetaQuery_tmp = N'' INNER JOIN (select distinct U.[KEY], MIN(U.Rank) AS Rank from ('' + @SelectEntryMetaQuery_tmp + N'') U GROUP BY U.[KEY]) META ON CE.[CatalogEntryId] = META.[KEY] ''
    END
    ELSE
    BEGIN
        set @SelectEntryMetaQuery_tmp = N''''
    END

	if (COALESCE(@CatalogNodeId, 0)=0)
	begin
		-- if @CatalogNodeId=0
		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
				from
				(
					-- select Catalog Nodes
					SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
						FROM [CatalogNode] CN 
							JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
						WHERE CatalogNodeId IN
						(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
							LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
							WHERE
							(
								(N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId)
								OR
								(NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)
							)
							AND
							((N.IsActive = 1) or @ReturnInactive = 1)
						)

					UNION

					-- select Catalog Entries
					SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], 0, OG.[NAME] as Owner
						FROM [CatalogEntry] CE
							JOIN Catalog C ON (CE.CatalogId = C.CatalogId)''
							+ @SelectEntryMetaQuery_tmp
							+ N''
                            LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE
						CE.CatalogId = @CatalogId AND
						NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and CE.CatalogEntryId = R.CatalogEntryId) AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
				) SEL''
	end
	else
	begin
		-- if @CatalogNodeId!=0

		-- Get the original catalog id for the given catalog node
		SELECT @CatalogId = [CatalogId] FROM [CatalogNode] WHERE [CatalogNodeId] = @CatalogNodeId

		set @selectStmtString=N''select SEL.*, row_number() over(order by ''+ @OrderClause +N'') as RowNumber
			from
			(
				-- select Catalog Nodes
				SELECT CN.[CatalogNodeId] as ID, CN.[Name], ''''Node'''' as Type, CN.[Code], CN.[StartDate], CN.[EndDate], CN.[IsActive], CN.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogNode] CN 
						JOIN Catalog C ON (CN.CatalogId = C.CatalogId)
						--We actually dont need to join NodeEntryRelation to get the SortOrder because it is always 0
                        --JOIN CatalogEntry CE ON CE.CatalogId = C.CatalogId
						--LEFT JOIN NodeEntryRelation NER ON (NER.CatalogId = CN.CatalogId And NER.CatalogNodeId = CN.CatalogNodeId  AND CE.CatalogEntryId = NER.CatalogEntryId ) 
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
					WHERE CN.CatalogNodeId IN
				(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N
				LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
				WHERE
					((N.CatalogId = @CatalogId AND N.ParentNodeId = @CatalogNodeId) OR (NR.CatalogId = @CatalogId AND NR.ParentNodeId = @CatalogNodeId)) AND
					((N.IsActive = 1) or @ReturnInactive = 1))

				UNION
				
				-- select Catalog Entries
				SELECT CE.[CatalogEntryId] as ID, CE.[Name], CE.ClassTypeId as Type, CE.[Code], CE.[StartDate], CE.[EndDate], CE.[IsActive], R.[SortOrder], OG.[NAME] as Owner
					FROM [CatalogEntry] CE
						JOIN Catalog C ON (CE.CatalogId = C.CatalogId)
						JOIN NodeEntryRelation R ON R.CatalogEntryId = CE.CatalogEntryId''
							+ @SelectEntryMetaQuery_tmp
							+ N''
                        LEFT JOIN cls_Organization OG ON (OG.OrganizationId = C.Owner)
				WHERE
					R.CatalogNodeId = @CatalogNodeId AND
					R.CatalogId = @CatalogId AND
						((CE.IsActive = 1) or @ReturnInactive = 1)
			) SEL''
	end

	if(@ReturnTotalCount = 1) -- Only return count if we requested it
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N''),
			SelNodesCount(TotalCount)
			as
			(
				select count(ID) from SelNodes
			)
			select  TOP '' + cast(@NumRecords as nvarchar(50)) + '' ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber, C.TotalCount as RecordCount
			from SelNodes, SelNodesCount C
			where RowNumber >= '' + cast(@StartingRec as nvarchar(50)) + 
			'' order by ''+ @OrderClause
	else
		set @execStmtString=N''with SelNodes(ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber)
			as
			('' + @selectStmtString +
			N'')
			select  TOP '' + cast(@NumRecords as nvarchar(50)) + '' ID, Name, Type, Code, StartDate, EndDate, IsActive, SortOrder, Owner, RowNumber
			from SelNodes
			where RowNumber >= '' + cast(@StartingRec as nvarchar(50)) +
			'' order by ''+ @OrderClause
	
	declare @ParamDefinition nvarchar(500)
	set @ParamDefinition = N''@CatalogId int,
						@CatalogNodeId int,
						@StartingRec int,
						@NumRecords int,
						@ReturnInactive bit'';
	exec sp_executesql @execStmtString, @ParamDefinition,
			@CatalogId = @CatalogId,
			@CatalogNodeId = @CatalogNodeId,
			@StartingRec = @StartingRec,
			@NumRecords = @NumRecords,
			@ReturnInactive = @ReturnInactive

	/*if(@ReturnTotalCount = 1) -- Only return count if we requested it
			set @RecordCount = (select count(ID) from SelNodes)*/

	SET NOCOUNT OFF
END'

--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- Sept 30, 2013 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 208;

Select @Installed = InstallDate  from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[Warehouse] ALTER COLUMN [Code] [nvarchar](50) NOT NULL'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[Warehouse] ADD CONSTRAINT [IX_Warehouse] UNIQUE NONCLUSTERED 
(
	[ApplicationId] ASC,
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]'


--## END Schema Patch ##
Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


declare @major int = 5, @minor int = 0, @patch int = 209
if not exists (select 1 from SchemaVersion_CatalogSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @sql nvarchar(4000)
    declare constraint_drops cursor local for
        select 'alter table [' + s.name + '].[' + t.name + '] drop constraint [' + REPLACE(df.name, ']', ']]') + ']'
        from sys.schemas s
        join sys.tables t on t.schema_id = s.schema_id
        join sys.columns c on c.object_id = t.object_id
        join sys.default_constraints df on df.parent_object_id = c.object_id and df.parent_column_id = c.column_id
        where s.name = 'dbo' and t.name = 'Warehouse' and c.name in ('Created', 'Modified')
    open constraint_drops
    while 1=1
    begin
        fetch next from constraint_drops into @sql
        if @@FETCH_STATUS != 0 break

        exec dbo.sp_executesql @sql
    end
    close constraint_drops

    exec dbo.sp_executesql N'alter table dbo.Warehouse add constraint DF_Warehouse_Created default (GETUTCDATE()) for Created'
    exec dbo.sp_executesql N'alter table dbo.Warehouse add constraint DF_Warehouse_Modified default (GETUTCDATE()) for Modified'

    if OBJECT_ID('dbo.ecf_CatalogEntry_SearchInsertList', 'P') is not null exec dbo.sp_executesql N'drop procedure dbo.ecf_CatalogEntry_SearchInsertList'

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_SearchInsertList]
	@SearchSetId uniqueidentifier,
	@List nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [CatalogEntrySearchResults]
           ([SearchSetId]
           ,[CatalogEntryId]
           ,[Created]
           ,[SortOrder])
     select @SearchSetId, L.Item, GETUTCDATE(), L.RowId
     from ecf_splitlist_with_rowid(@List) L
     inner join CatalogEntry E ON E.CatalogEntryId = L.Item
     ORDER BY L.RowId

	SET NOCOUNT OFF;
END'

    insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(varchar(2),@major) + '.' + CONVERT(varchar(2),@minor) + '.' +  CONVERT(varchar(3),@patch) + ' was applied successfully '
end
go


declare @major int = 5, @minor int = 0, @patch int = 210
if not exists (select 1 from SchemaVersion_CatalogSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
	if OBJECT_ID('[dbo].[ecf_Catalog_GetAllChildEntries]', 'P') is not null exec dbo.sp_executesql N'drop procedure [dbo].[ecf_Catalog_GetAllChildEntries]'
	exec dbo.sp_executesql N'create procedure dbo.ecf_Catalog_GetAllChildEntries
	@catalogIds udttCatalogList readonly
as
begin
	select distinct ce.CatalogEntryId, ce.ApplicationId, ce.Code
	from CatalogEntry ce
	join NodeEntryRelation ner on ce.CatalogEntryId = ner.CatalogEntryId
	where ner.CatalogNodeId in (
		select CatalogNodeId
		from CatalogNode
		where CatalogId in (select CatalogId from @catalogIds)
		union
		select ChildNodeId
		from CatalogNodeRelation
		where CatalogId in (select CatalogId from @catalogIds)
	)
end'

	if OBJECT_ID('[dbo].[ecf_CatalogNode_GetAllChildEntries]', 'P') is not null exec dbo.sp_executesql N'drop procedure [dbo].[ecf_CatalogNode_GetAllChildEntries]'
	exec dbo.sp_executesql N'create procedure ecf_CatalogNode_GetAllChildEntries
    @catalogNodeIds udttCatalogNodeList readonly
as
begin
    with all_node_relations as 
    (
        select ParentNodeId, CatalogNodeId as ChildNodeId from CatalogNode
        union
        select ParentNodeId, ChildNodeId from CatalogNodeRelation
    ),
    hierarchy as
    (
        select 
            n.CatalogNodeId,
            ''|'' + CAST(n.CatalogNodeId as nvarchar(4000)) + ''|'' as CyclePrevention
        from @catalogNodeIds n
        union all
        select
            children.ChildNodeId as CatalogNodeId,
            parent.CyclePrevention + CAST(children.ChildNodeId as nvarchar(4000)) + ''|'' as CyclePrevention
        from hierarchy parent
        join all_node_relations children on parent.CatalogNodeId = children.ParentNodeId
        where CHARINDEX(''|'' + CAST(children.ChildNodeId as nvarchar(4000)) + ''|'', parent.CyclePrevention) = 0
    )
    select distinct ce.CatalogEntryId, ce.ApplicationId, ce.Code
    from CatalogEntry ce
    join NodeEntryRelation ner on ce.CatalogEntryId = ner.CatalogEntryId
    where ner.CatalogNodeId in (select CatalogNodeId from hierarchy)
end'

	insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(varchar(2),@major) + '.' + CONVERT(varchar(2),@minor) + '.' +  CONVERT(varchar(3),@patch) + ' was applied successfully '
end
go
