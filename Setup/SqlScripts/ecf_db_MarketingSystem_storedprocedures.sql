/****** Object:  StoredProcedure [dbo].[GetMarketingSchemaVersionNumber]    Script Date: 07/21/2009 17:56:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMarketingSchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMarketingSchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Campaign]    Script Date: 07/21/2009 17:56:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_CancelExpiredPromoReservations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_CancelExpiredPromoReservations]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Campaign]    Script Date: 07/21/2009 17:56:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Campaign]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Campaign]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Expression]    Script Date: 07/21/2009 17:56:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Expression]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Expression]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Expression_Category]    Script Date: 07/21/2009 17:56:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Expression_Category]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Expression_Category]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Expression_Segment]    Script Date: 07/21/2009 17:56:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Expression_Segment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Expression_Segment]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Policy]    Script Date: 07/21/2009 17:56:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Policy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Policy]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Promotion]    Script Date: 07/21/2009 17:56:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Promotion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Promotion]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Segment]    Script Date: 07/21/2009 17:56:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Segment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_Segment]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_PromotionByDate]    Script Date: 07/21/2009 17:56:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_PromotionByDate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_PromotionByDate]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_PromotionUsage]    Script Date: 07/21/2009 17:56:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_PromotionUsage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_PromotionUsage]
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_PromotionUsageStatistics]    Script Date: 07/21/2009 17:56:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_PromotionUsageStatistics]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_mktg_PromotionUsageStatistics]
GO

/****** Object:  StoredProcedure [dbo].[GetMarketingSchemaVersionNumber]    Script Date: 07/21/2009 17:56:11 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMarketingSchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetMarketingSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_MarketingSystem]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_MarketingSystem])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Campaign]    Script Date: 07/21/2009 17:56:12 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Campaign]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_Campaign]
	@ApplicationId uniqueidentifier,
    @CampaignId int
AS
BEGIN
	
	if(@CampaignId = 0)
		set @CampaignId = null

	SELECT C.* from [Campaign] C
	WHERE
		C.ApplicationId = @ApplicationId and 
		C.CampaignId = COALESCE(@CampaignId,C.CampaignId)

	SELECT CS.* from [CampaignSegment] CS
	INNER JOIN [Campaign] C ON C.CampaignId = CS.CampaignId
	WHERE
		C.ApplicationId = @ApplicationId and 
		CS.CampaignId = COALESCE(@CampaignId,CS.CampaignId)

	SELECT MC.* from [MarketCampaigns] MC
	INNER JOIN [Campaign] C on C.CampaignId = MC.CampaignId
	WHERE
		C.ApplicationId = @ApplicationId and
		MC.CampaignId = COALESCE(@CampaignId,MC.CampaignId)

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_CampaignMarket]    Script Date: 07/21/2009 17:56:12 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_CampaignMarket]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_CampaignMarket]
	@ApplicationId uniqueidentifier,
    @MarketId nvarchar(8)
AS
BEGIN

	SELECT C.* from [Campaign] C
	INNER JOIN [MarketCampaigns] MC on C.CampaignId = MC.CampaignId
	WHERE
		C.ApplicationId = @ApplicationId and 
		MC.[MarketId] = COALESCE(@MarketId, MC.[MarketId])

	SELECT CS.* from [CampaignSegment] CS
	INNER JOIN [Campaign] C ON C.CampaignId = CS.CampaignId
	INNER JOIN [MarketCampaigns] MC on MC.[CampaignId] = C.[CampaignId] 
	WHERE
		C.ApplicationId = @ApplicationId and 
		MC.[MarketId] = COALESCE(@MarketId, MC.[MarketId])

	SELECT MC.* from [MarketCampaigns] MC
	INNER JOIN [Campaign] C on C.CampaignId = MC.CampaignId
	WHERE
		C.ApplicationId = @ApplicationId and
		MC.MarketId = @MarketId

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Expression]    Script Date: 07/21/2009 17:56:12 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Expression]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_Expression]
	@ApplicationId uniqueidentifier,
    @ExpressionId int
AS
BEGIN
	
	if(@ExpressionId = 0)
		set @ExpressionId = null

	SELECT E.* from [Expression] E
	WHERE
		E.ApplicationId = @ApplicationId and 
		E.ExpressionId = COALESCE(@ExpressionId,E.ExpressionId)

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Expression_Category]    Script Date: 07/21/2009 17:56:12 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Expression_Category]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_Expression_Category]
	@ApplicationId uniqueidentifier,
    @Category nvarchar(50)
AS
BEGIN
	
	SELECT E.* from [Expression] E
	WHERE
		E.ApplicationId = @ApplicationId and 
		E.Category = @Category

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Expression_Segment]    Script Date: 07/21/2009 17:56:12 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Expression_Segment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_Expression_Segment]
	@ApplicationId uniqueidentifier,
    @SegmentId int
AS
BEGIN
	
	SELECT E.* from [Expression] E
	INNER JOIN SegmentCondition S ON E.ExpressionId = S.ExpressionId
	WHERE
		E.ApplicationId = @ApplicationId and 
		S.SegmentId = @SegmentId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Policy]    Script Date: 07/21/2009 17:56:13 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Policy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_mktg_Policy]
	@ApplicationId uniqueidentifier,
    @PolicyId int
AS
BEGIN

	if(@PolicyId = 0)
		set @PolicyId = null
	
	SELECT P.* from [Policy] P
	WHERE
		P.ApplicationId = @ApplicationId and 
		P.PolicyId = COALESCE(@PolicyId,P.PolicyId)

	SELECT GP.* from [GroupPolicy] GP
	INNER JOIN [Policy] P ON P.PolicyId = GP.PolicyId
	WHERE
		P.ApplicationId = @ApplicationId and 
		GP.PolicyId = COALESCE(@PolicyId,GP.PolicyId)

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Promotion]    Script Date: 07/21/2009 17:56:13 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Promotion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_Promotion]
	@ApplicationId uniqueidentifier,
    @PromotionId int
AS
BEGIN

	if(@PromotionId = 0)
		set @PromotionId = null
	
	SELECT P.* from [Promotion] P
	WHERE
		P.ApplicationId = @ApplicationId and 
		P.PromotionId = COALESCE(@PromotionId,P.PromotionId)
	ORDER BY
		P.CouponCode DESC, P.PromotionGroup, P.Priority  DESC

	SELECT PC.* from [PromotionCondition] PC
	INNER JOIN [Promotion] P ON P.PromotionId = PC.PromotionId
	WHERE
		P.ApplicationId = @ApplicationId and 
		PC.PromotionId = COALESCE(@PromotionId,PC.PromotionId)

	SELECT PG.* from [PromotionLanguage] PG
	INNER JOIN [Promotion] P ON P.PromotionId = PG.PromotionId
	WHERE
		P.ApplicationId = @ApplicationId and 
		PG.PromotionId = COALESCE(@PromotionId,PG.PromotionId)

	SELECT PP.* from [PromotionPolicy] PP
	INNER JOIN [Promotion] P ON P.PromotionId = PP.PromotionId
	WHERE
		P.ApplicationId = @ApplicationId and 
		PP.PromotionId = COALESCE(@PromotionId,PP.PromotionId)

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_Segment]    Script Date: 07/21/2009 17:56:13 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_Segment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_Segment]
	@ApplicationId uniqueidentifier,
    @SegmentId int
AS
BEGIN

	if(@SegmentId = 0)
		set @SegmentId = null
	
	SELECT P.* from [Segment] P
	WHERE
		P.ApplicationId = @ApplicationId and 
		P.SegmentId = COALESCE(@SegmentId,P.SegmentId)

	SELECT SM.* from [SegmentMember] SM
	INNER JOIN [Segment] S ON S.SegmentId = SM.SegmentId
	WHERE
		S.ApplicationId = @ApplicationId and 
		SM.SegmentId = COALESCE(@SegmentId,SM.SegmentId)

	SELECT SC.* from [SegmentCondition] SC
	INNER JOIN [Segment] S ON S.SegmentId = SC.SegmentId
	WHERE
		S.ApplicationId = @ApplicationId and 
		SC.SegmentId = COALESCE(@SegmentId,SC.SegmentId)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_PromotionByDate]    Script Date: 07/21/2009 17:56:13 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_PromotionByDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_PromotionByDate]
	@ApplicationId uniqueidentifier,
    @DateTime datetime
AS
BEGIN
	SELECT P.* from [Promotion] P 
	INNER JOIN Campaign C ON C.CampaignId = P.CampaignId
	WHERE
		P.ApplicationId = @ApplicationId and 
		(@DateTime between P.StartDate and DATEADD(week, 1, P.EndDate))	and
		P.Status = ''active'' and
		(@DateTime between C.StartDate and DATEADD(week, 1, C.EndDate))	and
		C.IsActive = 1		
	ORDER BY
		P.CouponCode DESC, P.PromotionGroup, P.Priority  DESC

	SELECT PC.* from [PromotionCondition] PC
	INNER JOIN [Promotion] P ON P.PromotionId = PC.PromotionId
	INNER JOIN Campaign C ON C.CampaignId = P.CampaignId
	WHERE
		P.ApplicationId = @ApplicationId and 
		(@DateTime between P.StartDate and DATEADD(week, 1, P.EndDate))	and
		P.Status = ''active'' and
		(@DateTime between C.StartDate and DATEADD(week, 1, C.EndDate))	and
		C.IsActive = 1	

	SELECT PG.* from [PromotionLanguage] PG
	INNER JOIN [Promotion] P ON P.PromotionId = PG.PromotionId
	INNER JOIN Campaign C ON C.CampaignId = P.CampaignId
	WHERE
		P.ApplicationId = @ApplicationId and 
		(@DateTime between P.StartDate and DATEADD(week, 1, P.EndDate))	and
		P.Status = ''active'' and
		(@DateTime between C.StartDate and DATEADD(week, 1, C.EndDate))	and
		C.IsActive = 1	

	SELECT PP.* from [PromotionPolicy] PP
	INNER JOIN [Promotion] P ON P.PromotionId = PP.PromotionId
	INNER JOIN Campaign C ON C.CampaignId = P.CampaignId
	WHERE
		P.ApplicationId = @ApplicationId and 
		(@DateTime between P.StartDate and DATEADD(week, 1, P.EndDate))	and
		P.Status = ''active'' and
		(@DateTime between C.StartDate and DATEADD(week, 1, C.EndDate))	and
		C.IsActive = 1	
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_PromotionUsage]    Script Date: 07/21/2009 17:56:14 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_PromotionUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_PromotionUsage]
	@ApplicationId uniqueidentifier,
    @PromotionId int,
	@CustomerId uniqueidentifier = null,
	@OrderGroupId int = null
AS
BEGIN

	if(@PromotionId = 0)
		set @PromotionId = null

	if(@OrderGroupId = 0)
		set @OrderGroupId = null
	
	SELECT U.* from [PromotionUsage] U
	INNER JOIN Promotion P ON U.PromotionId = P.PromotionId
	WHERE
		P.ApplicationId = @ApplicationId and 
		U.PromotionId = COALESCE(@PromotionId,U.PromotionId) and
		U.CustomerId = COALESCE(@CustomerId,U.CustomerId) and
		U.OrderGroupId = COALESCE(@OrderGroupId,U.OrderGroupId)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_mktg_PromotionUsageStatistics]    Script Date: 07/21/2009 17:56:14 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_PromotionUsageStatistics]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_PromotionUsageStatistics]
	@ApplicationId uniqueidentifier,
	@CustomerId uniqueidentifier = null
AS
BEGIN
	if(@CustomerId is null)
	begin 
		select count(*) TotalUsed, PromotionId from PromotionUsage
		where ([Status] != 0 AND [Status] != 3) and CustomerId = COALESCE(@CustomerId,CustomerId)
		group by promotionid
	end
	else
	begin 
		select count(*) TotalUsed, PromotionId from PromotionUsage
		where ([Status] != 0 AND [Status] != 3) and CustomerId = @CustomerId
		group by promotionid, customerid
	end
END' 
END
GO


SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_mktg_CancelExpiredPromoReservations]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_CancelExpiredPromoReservations]
	@ApplicationId uniqueidentifier,
    @Expires int
AS
BEGIN
	if(@Expires <= 0)
		return

	DECLARE @EXP DATETIME
	DECLARE @NOW DATETIME

	set @NOW = GetUTCDate()

	/*sabtract number of minutes from now time*/
	set @EXP = DATEADD(minute, 0-@Expires, @now)

	UPDATE [PromotionUsage]
	SET Status = 0
	FROM [PromotionUsage] U INNER JOIN Promotion P ON U.PromotionId = P.PromotionId
	WHERE
		U.Status = 1 and /*reserved*/
		P.ApplicationId = @ApplicationId and 
		U.LastUpdated < @EXP
END'
END
GO



