/********************************************************************
             Pre Release Upgrade Script
*********************************************************************/

----March 17, 2008------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[SegmentCondition] DROP CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[SegmentCondition] DROP CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment]'
EXEC dbo.sp_executesql @statement = N'DROP TABLE [dbo].[SegmentCondition]'


EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[SegmentCondition](
	[PrincipalGroupConditionId] [int] IDENTITY(1,1) NOT NULL,
	[SegmentId] [int] NOT NULL,
	[ExpressionId] [int] NOT NULL,
 CONSTRAINT [PK_ecf_mktg-SegmentCondition] PRIMARY KEY CLUSTERED 
(
	[PrincipalGroupConditionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[SegmentCondition]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression] FOREIGN KEY([ExpressionId])
	REFERENCES [dbo].[Expression] ([ExpressionId])
	ON UPDATE CASCADE
	ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[SegmentCondition] CHECK CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Expression]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[SegmentCondition]  WITH CHECK ADD  CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment] FOREIGN KEY([SegmentId])
REFERENCES [dbo].[Segment] ([SegmentId])
ON UPDATE CASCADE
ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[SegmentCondition] CHECK CONSTRAINT [FK_ecf_mktg-SegmentCondition_ecf_mktg-Segment]'

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----May 29, 2008------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 2;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'IF ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.Columns 
								           WHERE TABLE_NAME = ''Promotion'' AND COLUMN_NAME=''PromotionType'') = 0)
										     ALTER TABLE dbo.Promotion ADD PromotionType nvarchar(50) NULL'
EXEC dbo.sp_executesql @statement = N'IF ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.Columns 
								           WHERE TABLE_NAME = ''Promotion'' AND COLUMN_NAME=''PerOrderLimit'') = 0)
											 ALTER TABLE dbo.Promotion ADD PerOrderLimit int NULL'
EXEC dbo.sp_executesql @statement = N'IF ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.Columns 
								           WHERE TABLE_NAME = ''Promotion'' AND COLUMN_NAME=''ApplicationLimit'') = 0)
											ALTER TABLE dbo.Promotion ADD ApplicationLimit int NULL'
EXEC dbo.sp_executesql @statement = N'IF ((SELECT COUNT(*) FROM INFORMATION_SCHEMA.Columns 
								           WHERE TABLE_NAME = ''Promotion'' AND COLUMN_NAME=''Params'') = 0)
										     ALTER TABLE dbo.Promotion ADD Params varbinary(max) NULL'
EXEC dbo.sp_executesql @statement = N'update dbo.Promotion set PromotionType = ''Custom'''
EXEC dbo.sp_executesql @statement = N'update dbo.Promotion set PerOrderLimit = 0'
EXEC dbo.sp_executesql @statement = N'update dbo.Promotion set ApplicationLimit = 0'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Promotion ALTER COLUMN PromotionType nvarchar(50) NOT NULL'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Promotion ALTER COLUMN PerOrderLimit int NOT NULL'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Promotion ALTER COLUMN ApplicationLimit int NOT NULL'

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----July 7, 2008------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 0;
Set @Patch = 3;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_mktg_Promotion]
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
		P.CouponCode, P.PromotionGroup, P.Priority  DESC

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

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----July 7, 2008------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 0;
Set @Patch = 4;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_mktg_Promotion]
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

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- August 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 0;
Set @Patch = 5;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
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

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 20, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 0;
Set @Patch = 6;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [Promotion] ADD [CustomerLimit] int NULL'
EXEC dbo.sp_executesql @statement = N'UPDATE [Promotion] SET [CustomerLimit]=0'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [Promotion] ALTER COLUMN [CustomerLimit] int NOT NULL'
--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- December 12, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 0;
Set @Patch = 7;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.PromotionLanguage	DROP CONSTRAINT [FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.PromotionLanguage ADD CONSTRAINT
	[FK_ecf_mktg-PromotionLanguage_ecf_mktg-Promotion] FOREIGN KEY
	(
	PromotionId
	) REFERENCES dbo.Promotion
	(
	PromotionId
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE'

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- April 09, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 0;
Set @Patch = 8;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

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

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----June 03, 2009------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 9;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.Segment ADD
	ExpressionFilter varbinary(MAX) NULL'

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


----July 21, 2009------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 10;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[PromotionUsage](
	[PromotionUsageId] [int] IDENTITY(1,1) NOT NULL,
	[OrderGroupId] [int] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[PromotionId] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_PromotionUsage] PRIMARY KEY CLUSTERED 
(
	[PromotionUsageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

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

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_mktg_PromotionUsageStatistics]
	@ApplicationId uniqueidentifier,
	@CustomerId uniqueidentifier = null
AS
BEGIN
	if(@CustomerId is null)
	begin 
		select count(*) TotalUsed, PromotionId from PromotionUsage
		where [Status] != 0 and CustomerId = COALESCE(@CustomerId,CustomerId)
		group by promotionid
	end
	else
	begin 
		select count(*) TotalUsed, PromotionId from PromotionUsage
		where [Status] != 0 and CustomerId = @CustomerId
		group by promotionid, customerid
	end
END' 

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[PromotionUsage]  WITH CHECK ADD  CONSTRAINT [FK_PromotionUsage_Promotion] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[Promotion] ([PromotionId])
ON UPDATE CASCADE
ON DELETE CASCADE'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[PromotionUsage] CHECK CONSTRAINT [FK_PromotionUsage_Promotion]'

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


----July 27, 2009------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 11;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

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

	SELECT U.* from [PromotionUsage] U
	INNER JOIN Promotion P ON U.PromotionId = P.PromotionId
	WHERE
		U.Status = 1 and /*reserved*/
		P.ApplicationId = @ApplicationId and 
		U.LastUpdated < @EXP
END'

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----July 28, 2009------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 12;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_mktg_CancelExpiredPromoReservations]
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

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----July 27, 2012------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 13;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec dbo.sp_executesql N'alter table Promotion add MaxEntryDiscountQuantity decimal';

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----August 23rd, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 14;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec dbo.sp_executesql N'IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketCampaigns_Campaign]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketCampaigns]''))
ALTER TABLE [dbo].[MarketCampaigns] DROP CONSTRAINT [FK_MarketCampaigns_Campaign]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketCampaigns_Market]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketCampaigns]''))
ALTER TABLE [dbo].[MarketCampaigns] DROP CONSTRAINT [FK_MarketCampaigns_Market]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[MarketCampaigns]'') AND type in (N''U''))
DROP TABLE [dbo].[MarketCampaigns]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[MarketCampaigns]'') AND type in (N''U''))
BEGIN
CREATE TABLE [dbo].[MarketCampaigns](
	[MarketId] [nvarchar](8) NOT NULL,
	[CampaignId] [int] NOT NULL,
 CONSTRAINT [PK_MarketCampaigns] PRIMARY KEY CLUSTERED (MarketId, CampaignId)
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketCampaigns_Campaign]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketCampaigns]''))
ALTER TABLE [dbo].[MarketCampaigns]  WITH CHECK ADD  CONSTRAINT [FK_MarketCampaigns_Campaign] FOREIGN KEY([CampaignId])
REFERENCES [Campaign] ([CampaignId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketCampaigns] CHECK CONSTRAINT [FK_MarketCampaigns_Campaign]

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketCampaigns_Market]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketCampaigns]''))
ALTER TABLE [dbo].[MarketCampaigns]  WITH CHECK ADD  CONSTRAINT [FK_MarketCampaigns_Market] FOREIGN KEY([MarketId])
REFERENCES [Market] ([MarketId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketCampaigns] CHECK CONSTRAINT [FK_MarketCampaigns_Market]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[ecf_mktg_Campaign]'') AND type in (N''P'', N''PC''))
BEGIN
EXEC dbo.sp_executesql @statement = N''CREATE PROCEDURE [dbo].[ecf_mktg_Campaign]
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

END''
END

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[ecf_mktg_CampaignMarket]'') AND type in (N''P'', N''PC''))
BEGIN
EXEC dbo.sp_executesql @statement = N''CREATE PROCEDURE [dbo].[ecf_mktg_CampaignMarket]
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

END''
END
';

--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


----October 4, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 15;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_mktg_PromotionUsageStatistics]
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
--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


----November 21, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 16;

Select @Installed = InstallDate  from SchemaVersion_MarketingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_mktg_Campaign]
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
--## END Schema Patch ##
Insert into SchemaVersion_MarketingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

