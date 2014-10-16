--Check whether the existing db schema versions are compatible with the version required for installing CM
DECLARE @Compatible int
-- Check existence of required schema versions
IF		NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion]') AND type IN (N'U'))
	OR	NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_ApplicationSystem]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_BusinessFoundation]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_CatalogSystem]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_MarketingSystem]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_OrderSystem]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_SecuritySystem]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_MetaDataSystem]') AND type IN (N'U'))
	OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_ReportingSystem]') AND type IN (N'U'))
    OR  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SchemaVersion_PricingSystem]') AND type IN (N'U'))
BEGIN
	SET @Compatible = 0
	GOTO quit_phase
END

--Check SchemaVersion_ApplicationSystem 
DECLARE @MajorRequired int, @MinorRequired int, @PatchRequired int
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 9;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_ApplicationSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_BusinessFoundation 
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 2;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_BusinessFoundation)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_CatalogSystem 
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 210;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_CatalogSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_MarketingSystem 
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 16;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_MarketingSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_OrderSystem 
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 73;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_OrderSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_SecuritySystem
SET @MajorRequired = 5;
SET @MinorRequired = 1;
SET @PatchRequired = 5;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_SecuritySystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_MetaDataSystem 
SET @MajorRequired = 5;
SET @MinorRequired = 2;
SET @PatchRequired = 16;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_MetaDataSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_ReportingSystem
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 15;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_ReportingSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion_PricingSystem
SET @MajorRequired = 6;
SET @MinorRequired = 0;
SET @PatchRequired = 1;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion_PricingSystem)

IF (@Compatible = 0) GOTO quit_phase

--Check SchemaVersion
SET @MajorRequired = 5;
SET @MinorRequired = 0;
SET @PatchRequired = 33;

SET @Compatible = (SELECT 
CASE 
WHEN MAX(Major) = @MajorRequired AND MAX(minor) = @MinorRequired AND MAX (Patch) = @PatchRequired THEN 1 ELSE 0 
END
FROM dbo.SchemaVersion)

quit_phase:
select @Compatible