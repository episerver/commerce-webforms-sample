/****** Object:  StoredProcedure [dbo].[GetCatalogSchemaVersionNumber]    Script Date: 07/21/2009 17:24:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCatalogSchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCatalogSchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Catalog]    Script Date: 07/21/2009 17:24:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Catalog]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog_GetAllChildEntries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Catalog_GetAllChildEntries]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Catalog_Permissions]    Script Date: 07/21/2009 17:24:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog_Permissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Catalog_Permissions]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Catalog_Update]    Script Date: 07/21/2009 17:24:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Catalog_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CreateTableJoinQuery]    Script Date: 07/21/2009 17:24:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CreateTableJoinQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CreateTableJoinQuery]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CreateFTSQuery]    Script Date: 07/21/2009 17:24:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CreateFTSQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CreateFTSQuery]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation]    Script Date: 07/21/2009 17:24:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogAssociation]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_CatalogEntryCode]    Script Date: 07/21/2009 17:24:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_CatalogEntryCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_CatalogEntryId]    Script Date: 07/21/2009 17:24:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_CatalogEntryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_Delete]    Script Date: 07/21/2009 17:24:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogAssociation_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociationByName]    Script Date: 07/21/2009 17:24:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociationByName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogAssociationByName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry]    Script Date: 07/21/2009 17:24:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Asset]    Script Date: 07/21/2009 17:24:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Asset]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_Asset]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_AssetKey]    Script Date: 07/21/2009 17:24:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_AssetKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_AssetKey]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Associated]    Script Date: 07/21/2009 17:24:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Associated]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_Associated]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_AssociatedByCode]    Script Date: 07/21/2009 17:24:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_AssociatedByCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Association]    Script Date: 07/21/2009 17:24:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Association]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_Association]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogId]    Script Date: 07/21/2009 17:24:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_CatalogId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogName]    Script Date: 07/21/2009 17:24:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_CatalogName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]    Script Date: 07/21/2009 17:24:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]    Script Date: 07/21/2009 17:24:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogNodeId]    Script Date: 07/21/2009 17:24:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogNodeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNodeId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Inventory]    Script Date: 07/21/2009 17:24:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Inventory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_Inventory]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Name]    Script Date: 07/21/2009 17:24:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Name]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_Name]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_ParentEntryId]    Script Date: 07/21/2009 17:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_ParentEntryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_ParentEntryId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_UriLanguage]    Script Date: 07/21/2009 17:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_UriLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_UriLanguage]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_UriSegment]    Script Date: 07/21/2009 17:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_UriSegment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_UriSegment]
GO


/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Variation]    Script Date: 07/21/2009 17:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Variation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_Variation]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntryByCode]    Script Date: 07/21/2009 17:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntryByCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntryByCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntrySearch]    Script Date: 07/21/2009 17:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntrySearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntrySearch]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntrySearch_Init]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntrySearch_Init]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntrySearch_Results]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntrySearch_GetResults]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode]    Script Date: 07/21/2009 17:24:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_Asset]    Script Date: 07/21/2009 17:24:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_Asset]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_Asset]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogId]    Script Date: 07/21/2009 17:24:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_CatalogId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogName]    Script Date: 07/21/2009 17:24:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_CatalogName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogParentNode]    Script Date: 07/21/2009 17:24:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogParentNode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogParentNodeCode]    Script Date: 07/21/2009 17:24:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogParentNodeCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNodeCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_Code]    Script Date: 07/21/2009 17:24:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_Code]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_Code]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_GetAllChildEntries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_GetAllChildEntries]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_SiteId]    Script Date: 07/21/2009 17:24:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_SiteId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_SiteId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_UriLanguage]    Script Date: 07/21/2009 17:24:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_UriLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNode_UriLanguage]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNodeSearch]    Script Date: 07/21/2009 17:24:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNodeSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNodeSearch]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNodesList]    Script Date: 07/21/2009 17:24:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNodesList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogNodesList]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogRelation]    Script Date: 07/21/2009 17:24:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogRelation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogRelation]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Warehouse]    Script Date: 07/21/2009 17:24:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Warehouse]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Warehouse]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Warehouse_WarehouseId]    Script Date: 07/21/2009 17:24:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Warehouse_WarehouseId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Warehouse_WarehouseId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_CatalogEntry]    Script Date: 07/21/2009 17:24:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_CatalogEntry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_CatalogEntry]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_CatalogNode]    Script Date: 07/21/2009 17:24:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_CatalogNode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_CatalogNode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_SiteCatalog_Insert]    Script Date: 07/21/2009 17:24:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_SiteCatalog_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_SiteCatalog_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_CatalogId]    Script Date: 07/21/2009 17:24:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_CatalogId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_SearchInsertList]    Script Date: 07/21/2009 17:24:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_SearchInsertList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogEntry_SearchInsertList]
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogLog]    Script Date: 07/21/2009 17:24:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogLog]
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory]    Script Date: 07/21/2009 17:24:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_TaxCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_TaxCategory]
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory_TaxCategoryId]    Script Date: 07/21/2009 17:24:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_TaxCategory_TaxCategoryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_TaxCategory_TaxCategoryId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory_Name]    Script Date: 07/21/2009 17:24:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_TaxCategory_Name]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_TaxCategory_Name]
GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist]    Script Date: 07/21/2009 17:24:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ecf_splitlist]
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory_Name]    Script Date: 07/21/2009 17:24:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogRelationByChildEntryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_CatalogRelationByChildEntryId]
GO

if exists (select 1 from sys.types t join sys.schemas s on t.schema_id = s.schema_id where s.name = 'dbo' and t.name = 'udttEntityList')
drop type dbo.udttEntityList
go

if exists (select 1 from sys.types t join sys.schemas s on t.schema_id = s.schema_id where s.name = 'dbo' and t.name = 'udttCatalogNodeList')
drop type dbo.udttCatalogList
go

if exists (select 1 from sys.types t join sys.schemas s on t.schema_id = s.schema_id where s.name = 'dbo' and t.name = 'udttCatalogNodeList')
drop type dbo.udttCatalogNodeList
go

create type dbo.udttEntityList as table (EntityId int, SortOrder int)
go

create type dbo.udttCatalogList as table (CatalogId int)
go

create type dbo.udttCatalogNodeList as table (CatalogNodeId int)
go

/****** Object:  StoredProcedure [dbo].[GetCatalogSchemaVersionNumber]    Script Date: 07/21/2009 17:24:35 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCatalogSchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCatalogSchemaVersionNumber]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Catalog]    Script Date: 07/21/2009 17:24:35 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Catalog]
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
END
GO

create procedure dbo.ecf_Catalog_GetAllChildEntries
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
end
go

/****** Object:  StoredProcedure [dbo].[ecf_Catalog_Permissions]    Script Date: 07/21/2009 17:24:35 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog_Permissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Catalog_Permissions]
(
	@ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier,
	@CatalogId int = null
)
AS
BEGIN
/*
	SELECT DISTINCT
		-1,
		S.SID,
		S.Scope,
		S.AllowMask,
		S.DenyMask
	FROM
		SiteSecurity S
		INNER JOIN SiteCatalog SC on SC.SiteId = S.SiteId
		INNER JOIN ApplicationSite AP ON AP.SiteId = S.SiteId
	WHERE 
		AP.ApplicationId = @ApplicationId AND
		AP.SiteId = @SiteId AND
		SC.CatalogId = COALESCE(@CatalogId, SC.CatalogId)

	UNION
*/
	-- Return catalog permissions
	SELECT
		C.CatalogId,
		C.SID,
		C.Scope,
		C.AllowMask,
		C.DenyMask
	FROM
		CatalogSecurity C
		INNER JOIN SiteCatalog SC ON SC.CatalogId = C.CatalogId
		INNER JOIN ApplicationSite AP ON AP.SiteId = SC.SiteId
	WHERE 
		AP.ApplicationId = @ApplicationId AND
		AP.SiteId = @SiteId AND
		C.CatalogId = COALESCE(@CatalogId, C.CatalogId)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Catalog_Update]    Script Date: 07/21/2009 17:24:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Catalog_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Catalog_Update]
(
	@CatalogId int,
	@Name nvarchar(150),
	@StartDate datetime,
	@EndDate datetime,
	@DefaultCurrency nvarchar(128),
	@WeightBase nvarchar(128),
	@DefaultLanguage nvarchar(10),
	@IsPrimary bit,
	@IsActive bit,
	@Created datetime,
	@Modified datetime,
	@CreatorId nvarchar(50),
	@ModifierId nvarchar(50),
	@SortOrder int
)
AS
	SET NOCOUNT OFF;
	UPDATE [Catalog]
	SET
		[Name] = @Name,
		[StartDate] = @StartDate,
		[EndDate] = @EndDate,
		[DefaultCurrency] = @DefaultCurrency,
		[WeightBase] = @WeightBase,
		[DefaultLanguage] = @DefaultLanguage,
		[IsPrimary] = @IsPrimary,
		[IsActive] = @IsActive,
		[Created] = @Created,
		[Modified] = @Modified,
		[CreatorId] = @CreatorId,
		[ModifierId] = @ModifierId,
		[SortOrder] = @SortOrder
	WHERE 
		[CatalogId] = @CatalogId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CreateTableJoinQuery]    Script Date: 07/21/2009 17:24:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CreateTableJoinQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CreateTableJoinQuery]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CreateFTSQuery]    Script Date: 07/21/2009 17:24:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CreateFTSQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CreateFTSQuery]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation]    Script Date: 07/21/2009 17:24:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociation]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_CatalogEntryCode]    Script Date: 07/21/2009 17:24:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_CatalogEntryCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryCode]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_CatalogEntryId]    Script Date: 07/21/2009 17:24:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_CatalogEntryId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogEntryId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_Delete]    Script Date: 07/21/2009 17:24:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociation_Delete]
(
	@CatalogAssociationId int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM [CatalogAssociation]
	WHERE  
		[CatalogAssociationId] = @CatalogAssociationId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociationByName]    Script Date: 07/21/2009 17:24:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociationByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociationByName]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry]    Script Date: 07/21/2009 17:24:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry]
    @CatalogEntryId int,
	@ReturnInactive bit = 0
AS
BEGIN

	SELECT N.* from [CatalogEntry] N
	WHERE
		N.CatalogEntryId = @CatalogEntryId AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogEntryId = @CatalogEntryId AND
		((N.IsActive = 1) or @ReturnInactive = 1)	

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Asset]    Script Date: 07/21/2009 17:24:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Asset]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_Asset]
    @CatalogEntryId int
AS
BEGIN
	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogEntryId = @CatalogEntryId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_AssetKey]    Script Date: 07/21/2009 17:24:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_AssetKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_AssetKey]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Associated]    Script Date: 07/21/2009 17:24:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Associated]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_Associated]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_AssociatedByCode]    Script Date: 07/21/2009 17:24:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_AssociatedByCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_AssociatedByCode]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Association]    Script Date: 07/21/2009 17:24:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Association]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_Association]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogId]    Script Date: 07/21/2009 17:24:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_CatalogId]
    @CatalogId int,
	@ReturnInactive bit = 0
AS
BEGIN

	
	SELECT N.* from [CatalogEntry] N
	WHERE
		N.CatalogId = @CatalogId AND
		NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and N.CatalogEntryId = R.CatalogEntryId) AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	WHERE
		N.CatalogId = @CatalogId AND
		NOT EXISTS(SELECT * FROM NodeEntryRelation R WHERE R.CatalogId = @CatalogId and N.CatalogEntryId = R.CatalogEntryId) AND
		((N.IsActive = 1) or @ReturnInactive = 1)
	

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogName]    Script Date: 07/21/2009 17:24:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_CatalogName]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]    Script Date: 07/21/2009 17:24:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeCode]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]    Script Date: 07/21/2009 17:24:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNameCatalogNodeId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_CatalogNodeId]    Script Date: 07/21/2009 17:24:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_CatalogNodeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_CatalogNodeId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Inventory]    Script Date: 07/21/2009 17:24:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Inventory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_Inventory]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Name]    Script Date: 07/21/2009 17:24:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_Name]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_ParentEntryId]    Script Date: 07/21/2009 17:24:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_ParentEntryId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_ParentEntryId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_UriLanguage]    Script Date: 07/21/2009 17:24:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_UriLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_UriLanguage]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_UriLanguage]    Script Date: 07/21/2009 17:24:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_UriSegment]') AND type in (N'P', N'PC'))
BEGIN
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_Variation]    Script Date: 07/21/2009 17:24:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_Variation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE dbo.ecf_CatalogEntry_Variation
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntryByCode]    Script Date: 07/21/2009 17:24:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntryByCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntryByCode]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntrySearch]    Script Date: 07/21/2009 17:24:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntrySearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntrySearch]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntrySearch_Init]    Script Date: 06/13/2011 18:27:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ecf_CatalogEntrySearch_Init]
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
    if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = ' where Modified between cast(''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + ''' as datetime) and cast('''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + ''' as datetime)'
    else if (@EarliestModifiedDate is not null) set @ModifiedFilter = ' where Modified >= cast(''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + ''' as datetime)'
    else if (@LatestModifiedDate is not null) set @ModifiedFilter = ' where Modified <= cast('''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + ''' as datetime)'
    else set @ModifiedFilter = ''
    
    -- @MetaTableSubquery: find all the metaclass tables, and fetch a union of all their keys, applying the @ModifiedFilter.
    declare metatables_cursor cursor local read_only for
        select childClass.TableName
        from MetaClass parentClass
        join MetaClass childClass on parentClass.MetaClassId = childClass.ParentClassId
        where childClass.IsSystem = 0
          and parentClass.Name = 'CatalogEntry'
    open metatables_cursor
    fetch metatables_cursor into @MetaTableName
    while (@@FETCH_STATUS = 0)
    begin
        set @CatalogEntryIdSubquery = 
            case when @CatalogEntryIdSubquery is null then '' else @CatalogEntryIdSubquery + ' union all ' end +
            'select ObjectId from ' + @MetaTableName + @ModifiedFilter
            
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
        
            if (@EarliestModifiedDate is not null and @LatestModifiedDate is not null) set @ModifiedFilter = ' where Modified between cast(''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + ''' as datetime) and cast('''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + ''' as datetime)'
            else if (@EarliestModifiedDate is not null) set @ModifiedFilter = ' where Modified >= cast(''' + CONVERT(nvarchar(100), @EarliestModifiedDate, 127) + ''' as datetime)'
            else if (@LatestModifiedDate is not null) set @ModifiedFilter = ' where Modified <= cast('''  + CONVERT(nvarchar(100), @LatestModifiedDate, 127) + ''' as datetime)'
            else set @ModifiedFilter = ''    
        end
    
        declare @ApplicationLogCreatedFilter nvarchar(4000)
        set @ApplicationLogCreatedFilter = REPLACE(REPLACE(@ModifiedFilter, ' where ', ' and '), 'Modified', 'Created')
        
        set @CatalogEntryIdSubquery =
            case when @CatalogEntryIdSubquery is null then '' else @CatalogEntryIdSubquery + ' union all ' end +
            'select CatalogEntryId from NodeEntryRelation' + @ModifiedFilter +
            ' union all ' +
            'select cast(ObjectKey as int) as CatalogEntryId from ApplicationLog where [Source] = ''catalog'' and [Operation] = ''Modified'' and [ObjectType] = ''relation''' + @ApplicationLogCreatedFilter
    end
   
    set @query = 
    'insert into CatalogEntrySearchResults_SingleSort (SearchSetId, ResultIndex, CatalogEntryId, ApplicationId) ' +
    'select ''' + cast(@SearchSetId as nvarchar(36)) + ''', ROW_NUMBER() over (order by CatalogEntryId), CatalogEntryId, ApplicationId ' +
    'from CatalogEntry ' +
    'where CatalogEntry.ApplicationId = ''' + cast(@ApplicationId as nvarchar(36)) + ''' ' +
      'and CatalogEntry.CatalogId = ' + cast(@CatalogId as nvarchar) + ' ' +
      'and CatalogEntry.CatalogEntryId in (' + @CatalogEntryIdSubquery + ')'
      
    if @IncludeInactive = 0 set @query = @query + ' and CatalogEntry.IsActive = 1'

    execute dbo.sp_executesql @query
    
    select @@ROWCOUNT
end
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntrySearch_GetResults]    Script Date: 06/13/2011 18:27:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntrySearch_GetResults]') AND type in (N'P', N'PC'))
BEGIN
execute dbo.sp_executesql @statement = N'create procedure [dbo].[ecf_CatalogEntrySearch_GetResults]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode]    Script Date: 07/21/2009 17:24:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode]
    @CatalogNodeId int,
	@ReturnInactive bit = 0
AS
BEGIN
	
	SELECT N.* from [CatalogNode] N
	WHERE
		N.CatalogNodeId = @CatalogNodeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)

	SELECT S.* from CatalogItemSeo S
	INNER JOIN CatalogNode N ON N.CatalogNodeId = S.CatalogNodeId
	WHERE
		N.CatalogNodeId = @CatalogNodeId AND
		((N.IsActive = 1) or @ReturnInactive = 1)	

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_Asset]    Script Date: 07/21/2009 17:24:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_Asset]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_Asset]
    @CatalogNodeId int
AS
BEGIN
	SELECT A.* from [CatalogItemAsset] A
	WHERE
		A.CatalogNodeId = @CatalogNodeId
END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogId]    Script Date: 07/21/2009 17:24:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_CatalogId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogName]    Script Date: 07/21/2009 17:24:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_CatalogName]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogParentNode]    Script Date: 07/21/2009 17:24:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogParentNode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNode]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_CatalogParentNodeCode]    Script Date: 07/21/2009 17:24:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_CatalogParentNodeCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_CatalogParentNodeCode]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_Code]    Script Date: 07/21/2009 17:24:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_Code]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_Code]
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
END
GO

create procedure ecf_CatalogNode_GetAllChildEntries
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
            '|' + CAST(n.CatalogNodeId as nvarchar(4000)) + '|' as CyclePrevention
        from @catalogNodeIds n
        union all
        select
            children.ChildNodeId as CatalogNodeId,
            parent.CyclePrevention + CAST(children.ChildNodeId as nvarchar(4000)) + '|' as CyclePrevention
        from hierarchy parent
        join all_node_relations children on parent.CatalogNodeId = children.ParentNodeId
        where CHARINDEX('|' + CAST(children.ChildNodeId as nvarchar(4000)) + '|', parent.CyclePrevention) = 0
    )
    select distinct ce.CatalogEntryId, ce.ApplicationId, ce.Code
    from CatalogEntry ce
    join NodeEntryRelation ner on ce.CatalogEntryId = ner.CatalogEntryId
    where ner.CatalogNodeId in (select CatalogNodeId from hierarchy)
end
go

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_SiteId]    Script Date: 07/21/2009 17:24:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_SiteId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_SiteId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNode_UriLanguage]    Script Date: 07/21/2009 17:24:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNode_UriLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNode_UriLanguage]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNodeSearch]    Script Date: 07/21/2009 17:24:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNodeSearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogNodeSearch]
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
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogNodesList]    Script Date: 04/02/2011 09:51:00 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogNodesList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_CatalogNodesList]
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
END
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogRelation]    Script Date: 02/03/2011 11:29:00 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogRelation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_CatalogRelation]
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
END
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Warehouse]    Script Date: 07/21/2009 17:24:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Warehouse]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Warehouse]
	@ApplicationId uniqueidentifier
AS
BEGIN
	select * from [Warehouse] 
		where [ApplicationId] = @ApplicationId
		order by [Name]
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Warehouse_WarehouseId]    Script Date: 07/21/2009 17:24:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Warehouse_WarehouseId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Warehouse_WarehouseId]
	@ApplicationId uniqueidentifier,
	@WarehouseId int
AS
BEGIN
	select * from [Warehouse] 
		where [ApplicationId] = @ApplicationId and [WarehouseId] = @WarehouseId
END' 
END
GO

if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'dbo' and ROUTINE_SCHEMA = 'ecf_CatalogEntry_List')
drop procedure dbo.ecf_CatalogEntry_List
go

create procedure dbo.ecf_CatalogEntry_List
    @CatalogEntries dbo.udttEntityList readonly
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
end
go


create procedure dbo.ecf_Search_CatalogEntry
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
end
go


/****** Object:  StoredProcedure [dbo].[ecf_Search_CatalogNode]    Script Date: 07/21/2009 17:24:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_CatalogNode]') AND type in (N'P', N'PC'))
BEGIN
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_SiteCatalog_Insert]    Script Date: 07/21/2009 17:24:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_SiteCatalog_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_SiteCatalog_Insert]
(
	@SiteId uniqueidentifier,
	@CatalogId int
)
AS
	SET NOCOUNT OFF
	INSERT INTO [dbo].[SiteCatalog] ([SiteId], [CatalogId]) VALUES (@SiteId, @CatalogId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogAssociation_CatalogId]    Script Date: 07/21/2009 17:24:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogAssociation_CatalogId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogAssociation_CatalogId]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntry_SearchInsertList]    Script Date: 23/11/2010 18:13:26 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogEntry_SearchInsertList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogEntry_SearchInsertList]
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogLog]    Script Date: 07/21/2009 17:24:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogLog]') AND type in (N'P', N'PC'))
BEGIN
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
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory]    Script Date: 07/21/2009 17:24:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_TaxCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_TaxCategory]
    @ApplicationId uniqueidentifier
AS
BEGIN
	
	SELECT T.* from [TaxCategory] T
	WHERE
		T.ApplicationId = @ApplicationId
	ORDER BY T.[Name]
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory_TaxCategoryId]    Script Date: 07/21/2009 17:24:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_TaxCategory_TaxCategoryId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_TaxCategory_TaxCategoryId]
    @ApplicationId uniqueidentifier,
	@TaxCategoryId int
AS
BEGIN
	
	SELECT T.* from [TaxCategory] T
	WHERE
		T.[ApplicationId] = @ApplicationId and T.[TaxCategoryId] = @TaxCategoryId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_TaxCategory_Name]    Script Date: 07/21/2009 17:24:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_TaxCategory_Name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_TaxCategory_Name]
    @ApplicationId uniqueidentifier,
	@Name nvarchar(50)
AS
BEGIN
	
	SELECT T.* from [TaxCategory] T
	WHERE
		T.[ApplicationId] = @ApplicationId and T.[Name] = @Name
END' 
END
GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist]    Script Date: 07/21/2009 17:24:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ecf_splitlist]
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
END

GO

/****** Object:  StoredProcedure [dbo].[ecf_CatalogRelationByChildEntryId]    Script Date: 12/19/2011 17:24:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_CatalogRelationByChildEntryId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_CatalogRelationByChildEntryId]
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
END
GO

if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'dbo' and ROUTINE_SCHEMA = 'ecf_CatalogRelation_NodeDelete')
drop procedure dbo.ecf_CatalogRelation_NodeDelete
go


create procedure dbo.ecf_CatalogRelation_NodeDelete
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
end
go

if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'dbo' and ROUTINE_SCHEMA = 'ecf_CatalogNode_List')
drop procedure dbo.ecf_CatalogNode_List
go

create procedure dbo.ecf_CatalogNode_List
    @CatalogNodes udttEntityList readonly
as
begin
    select *
    from CatalogNode
    where CatalogNodeId in (select EntityId from @CatalogNodes)
    
    select *
    from CatalogItemSeo
    where CatalogNodeId in (select EntityId from @CatalogNodes)
end
go

if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'dbo' and ROUTINE_SCHEMA = 'ecf_CatalogNode_GetDeleteResults')
drop procedure dbo.ecf_CatalogNode_GetDeleteResults
go

create procedure dbo.ecf_CatalogNode_GetDeleteResults
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
            '|' + CAST(@CatalogNodeId as nvarchar(4000)) + '|' as CurrentNodePath
        from CatalogNode cn
        where cn.CatalogNodeId = @CatalogNodeId
        union all
        select 
            cn.CatalogNodeId,          
            case when cte.IsDelete = 1 and r.IsDelete = 1 then 1 else 0 end,            
            cte.CurrentNodePath + CAST(r.ChildNodeId as nvarchar(4000)) + '|'
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
end
go

/****** Object:  StoredProcedure [dbo].[ecf_CatalogEntryAssocations]    Script Date: 05/03/2013 15:20:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ecf_CatalogEntryAssocations]
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
END
GO
