/****** Object:  StoredProcedure [dbo].[GetApplicationSchemaVersionNumber]    Script Date: 07/21/2009 17:22:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetApplicationSchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetApplicationSchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Application]    Script Date: 07/21/2009 17:22:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Application]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Application]

/****** Object:  StoredProcedure [dbo].[ecf_ApplicationLog]    Script Date: 07/21/2009 17:22:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ApplicationLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ApplicationLog]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ApplicationLog_LogId]    Script Date: 07/21/2009 17:22:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ApplicationLog_LogId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ApplicationLog_LogId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Site_Permissions]    Script Date: 07/21/2009 17:22:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Site_Permissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Site_Permissions]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Site]    Script Date: 07/21/2009 17:22:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Site]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Site]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Settings]    Script Date: 07/21/2009 17:22:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Settings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Settings]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Setting_SettingId]    Script Date: 07/21/2009 17:22:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Setting_SettingId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Setting_SettingId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Setting_Name]    Script Date: 07/21/2009 17:22:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Setting_Name]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Setting_Name]
GO

/****** Object:  StoredProcedure [dbo].[GetApplicationSchemaVersionNumber]    Script Date: 07/21/2009 17:22:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetApplicationSchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetApplicationSchemaVersionNumber]
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
END
GO

CREATE PROCEDURE [dbo].[ecf_Application]
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
end
GO

/****** Object:  StoredProcedure [dbo].[ecf_ApplicationLog]    Script Date: 07/21/2009 17:22:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ApplicationLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ApplicationLog]
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
				AND COALESCE(@Created, Created) >= Created
	),
	OrderedLogsCount(TotalCount) as
	(
		select count(LogId) from OrderedLogs
	)
	select LogId, Source, Operation, ObjectKey, ObjectType, Username, Created, Succeeded, IPAddress, Notes, ApplicationId, TotalCount from OrderedLogs, OrderedLogsCount
	where RowNumber between @StartingRec and @StartingRec + @NumRecords
	SET NOCOUNT OFF;
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ApplicationLog_LogId]    Script Date: 07/21/2009 17:22:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ApplicationLog_LogId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ApplicationLog_LogId]
	@LogId int
AS
BEGIN
	SELECT AL.* FROM ApplicationLog AL WHERE LogId = @LogId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Site_Permissions]    Script Date: 07/21/2009 17:22:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Site_Permissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Site_Permissions]
(
	@ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier
)
AS
BEGIN
	-- Return site permissions
	SELECT
		C.SiteId,
		C.SID,
		C.Scope,
		C.AllowMask,
		C.DenyMask
	FROM
		SiteSecurity C
		INNER JOIN ApplicationSite AP ON AP.SiteId = C.SiteId
	WHERE 
		AP.ApplicationId = @ApplicationId AND
		C.SiteId = COALESCE(@SiteId, C.SiteId)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Site]    Script Date: 07/21/2009 17:22:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Site]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Site]
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
	WHERE
		G.SiteId = COALESCE(@SiteId, G.SiteId)

	SELECT L.* from [SiteLanguage] L
	WHERE
		L.SiteId = COALESCE(@SiteId, L.SiteId)



/*
	SELECT APPS.* from ApplicationSite APPS
	WHERE
		APPS.ApplicationId = @ApplicationId AND
		APPS.SiteId = COALESCE(@SiteId, APPS.SiteId)

	exec [ecf_Site_Permissions] @ApplicationId, @SiteId
*/

END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Settings]    Script Date: 07/21/2009 17:22:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Settings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Settings]
	@ApplicationId uniqueidentifier
AS
BEGIN
	select * from [CommonSettings] 
		where [ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Setting_SettingId]    Script Date: 07/21/2009 17:22:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Setting_SettingId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Setting_SettingId]
	@ApplicationId uniqueidentifier,
	@SettingId int
AS
BEGIN
	select * from [CommonSettings] 
		where [ApplicationId] = @ApplicationId and [SettingId] = @SettingId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Setting_Name]    Script Date: 07/21/2009 17:22:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Setting_Name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Setting_Name]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(100)
AS
BEGIN
	select * from [CommonSettings] 
		where [ApplicationId] = @ApplicationId and [Name] = @Name
END' 
END
GO

