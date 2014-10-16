IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_GetChildBySegment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_GetChildBySegment]
GO

CREATE PROCEDURE [dbo].[mdpsp_GetChildBySegment] 
	@parentId int,
	@UriSegment nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
	S.CatalogNodeId as ChildId,
	S.LanguageCode,
	1 as ContentType
	FROM CatalogItemSeo S WITH (NOLOCK) WHERE CatalogNodeId IN

	(SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N WITH (NOLOCK)
		LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
		WHERE
			(N.ParentNodeId = @parentId OR NR.ParentNodeId = @parentId) AND UriSegment = @UriSegment AND N.IsActive = 1)

	UNION

	SELECT
	S.CatalogEntryId as ChildId,
	S.LanguageCode,
	0 as ContentType
	from CatalogItemSeo S WITH (NOLOCK)
	INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
	INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
	WHERE
		R.CatalogNodeId = @parentId AND UriSegment = @UriSegment AND N.IsActive = 1
END
GO