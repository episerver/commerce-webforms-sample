IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'SchemaVersion_WarehouseInventorySystem')
    EXEC dbo.sp_executesql N'create table dbo.SchemaVersion_WarehouseInventorySystem (
    Major int not null,
    Minor int not null,
    Patch int not null,
    InstallDate datetime not null,
    constraint PK_SchemaVersion_WarehouseInventorySystem primary key clustered (Major, Minor, Patch)
)'
GO


DECLARE @Major INT = 7, @Minor INT = 0, @Patch INT, @Installed DATETIME
SET @Patch = 0
SELECT @Installed = InstallDate
FROM dbo.SchemaVersion_WarehouseInventorySystem
WHERE Major=@Major AND Minor=@Minor AND Patch=@Patch

IF (@Installed IS NULL)
BEGIN
    DECLARE @sql NVARCHAR(4000)

	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_GetAllInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_GetAllInventories'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_GetInventory') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_GetInventory'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_GetWarehouseInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_GetWarehouseInventories'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_GetCatalogEntryInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_GetCatalogEntryInventories'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_GetCatalogEntryInventoryTotals') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_GetCatalogEntryInventoryTotals'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_DeleteAllInventory') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_DeleteAllInventory'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_DeleteInventory') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_DeleteInventory'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_DeleteCatalogEntryInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_DeleteCatalogEntryInventories'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_DeleteWarehouseInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_DeleteWarehouseInventories'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_Warehouse_List') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_Warehouse_List'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_Warehouse_Get') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_Warehouse_Get'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_Warehouse_GetById') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_Warehouse_GetById'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_Warehouse_GetByCode') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_Warehouse_GetByCode'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_Warehouse_Save') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_Warehouse_Save'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_Warehouse_Delete') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_Warehouse_Delete'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_SaveInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_SaveInventories'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_WarehouseInventory_GetInventories') EXEC dbo.sp_executesql N'DROP PROCEDURE dbo.ecf_WarehouseInventory_GetInventories'
	
	IF EXISTS (SELECT 1 FROM sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttWarehouseInventory') EXEC dbo.sp_executesql N'DROP TYPE dbo.udttWarehouseInventory'
	IF EXISTS (SELECT 1 FROM sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttWarehouse') EXEC dbo.sp_executesql N'DROP TYPE dbo.udttWarehouse'
	IF EXISTS (SELECT 1 FROM sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttWarehouseCode') EXEC dbo.sp_executesql N'DROP TYPE dbo.udttWarehouseCode'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'WarehouseInventory') EXEC dbo.sp_executesql N'DROP TABLE dbo.WarehouseInventory'
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'WarehouseContactInformation') EXEC dbo.sp_executesql N'DROP TABLE dbo.WarehouseContactInformation'

	SET @sql = N'CREATE TABLE [WarehouseInventory]
(
WarehouseCode NVARCHAR(50),
CatalogEntryCode NVARCHAR(100) NOT NULL,
InStockQuantity DECIMAL NOT NULL,
ReservedQuantity DECIMAL NOT NULL,
ReorderMinQuantity DECIMAL NOT NULL,
PreorderQuantity DECIMAL NOT NULL,
BackorderQuantity DECIMAL NOT NULL,
AllowPreorder BIT NOT NULL,
AllowBackorder BIT NOT NULL,
InventoryStatus INT NOT NULL,
PreorderAvailabilityDate DATETIME NOT NULL,
BackorderAvailabilityDate DATETIME NOT NULL,
ApplicationId UNIQUEIDENTIFIER NOT NULL,
CONSTRAINT PK_WarehouseInventory PRIMARY KEY CLUSTERED (WarehouseCode, CatalogEntryCode, ApplicationId),
CONSTRAINT FK_WarehouseInventory_Warehouse FOREIGN KEY (ApplicationId, WarehouseCode) REFERENCES Warehouse(ApplicationId, Code) ON DELETE CASCADE
)'
	EXEC dbo.sp_executesql @sql
	
	SET @sql = N'CREATE TYPE [udttWarehouseInventory] AS TABLE
(
WarehouseCode NVARCHAR(50),
CatalogEntryCode NVARCHAR(100) NOT NULL,
InStockQuantity DECIMAL NOT NULL,
ReservedQuantity DECIMAL NOT NULL,
ReorderMinQuantity DECIMAL NOT NULL,
PreorderQuantity DECIMAL NOT NULL,
BackorderQuantity DECIMAL NOT NULL,
AllowPreorder BIT NOT NULL,
AllowBackorder BIT NOT NULL,
InventoryStatus INT NOT NULL,
PreorderAvailabilityDate DATETIME NOT NULL,
BackorderAvailabilityDate DATETIME NOT NULL,
ApplicationId UNIQUEIDENTIFIER NOT NULL
)'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE TABLE [WarehouseContactInformation]
(
FirstName NVARCHAR(64),
--MiddleName NVARCHAR (64) NOT NULL,
LastName NVARCHAR(64),
--FullName NVARCHAR (64) NOT NULL,
Organization NVARCHAR(64),
Line1 NVARCHAR(80),
Line2 NVARCHAR(80),
City NVARCHAR(64),
[State] NVARCHAR(64),
CountryCode NVARCHAR(50),
CountryName NVARCHAR(50),
PostalCode NVARCHAR(20),
RegionCode NVARCHAR(50),
RegionName NVARCHAR(64),
DaytimePhoneNumber NVARCHAR(32),
EveningPhoneNumber NVARCHAR(32),
FaxNumber NVARCHAR(32),
Email NVARCHAR(64)
)'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE TYPE udttWarehouse AS TABLE
(
WarehouseId INT NULL,
ApplicationId UNIQUEIDENTIFIER NOT NULL,
Name NVARCHAR(255) NOT NULL,
CreatorId NVARCHAR(100) NOT NULL,
Created DATETIME NOT NULL,
ModifierId NVARCHAR(100) NOT NULL,
Modified DATETIME NOT NULL,
IsActive BIT NOT NULL,
IsPrimary BIT NOT NULL,
SortOrder INT NOT NULL,
Code NVARCHAR(50) NOT NULL,
IsFulfillmentCenter BIT NOT NULL,
IsPickupLocation BIT NOT NULL,
IsDeliveryLocation BIT NOT NULL,
FirstName NVARCHAR(64),
LastName NVARCHAR(64),
Organization NVARCHAR(80),
Line1 NVARCHAR(80),
Line2 NVARCHAR(64),
City NVARCHAR(64),
[State] NVARCHAR(64),
CountryCode NVARCHAR(50),
CountryName NVARCHAR(50),
PostalCode NVARCHAR(20),
RegionCode NVARCHAR(50),
RegionName NVARCHAR(64),
DaytimePhoneNumber NVARCHAR(32),
EveningPhoneNumber NVARCHAR(32),
FaxNumber NVARCHAR(32),
Email NVARCHAR(64)
)'
	EXEC dbo.sp_executesql @sql
	
	SET @sql = N'CREATE TYPE [dbo].[udttWarehouseCode] AS TABLE(
	[WarehouseCode] NVARCHAR(50) NOT NULL
)'

	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_GetAllInventories
	@ApplicationId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT WI.WarehouseCode,
		WI.CatalogEntryCode,
		WI.InStockQuantity,
		WI.ReservedQuantity,
		WI.ReorderMinQuantity,
		WI.PreorderQuantity,
		WI.BackorderQuantity,
		WI.AllowPreorder,
		WI.AllowBackorder,
		WI.InventoryStatus,
		WI.PreorderAvailabilityDate,
		WI.BackorderAvailabilityDate,
		WI.ApplicationId
	FROM [WarehouseInventory] AS WI
	JOIN [Warehouse] AS W ON WI.WarehouseCode = W.Code
	WHERE WI.ApplicationId = @ApplicationId
	ORDER BY W.SortOrder
	
END
'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_GetInventory
	@CatalogKeys udttCatalogKey READONLY,
	@WarehouseCode NVARCHAR(50)
AS
BEGIN
	SELECT WI.WarehouseCode,
		WI.CatalogEntryCode,
		WI.InStockQuantity,
		WI.ReservedQuantity,
		WI.ReorderMinQuantity,
		WI.PreorderQuantity,
		WI.BackorderQuantity,
		WI.AllowPreorder,
		WI.AllowBackorder,
		WI.InventoryStatus,
		WI.PreorderAvailabilityDate,
		WI.BackorderAvailabilityDate,
		WI.ApplicationId
	FROM @CatalogKeys AS ck
	JOIN [WarehouseInventory] AS WI ON ck.ApplicationId = WI.ApplicationId AND ck.CatalogEntryCode = WI.CatalogEntryCode
	JOIN [Warehouse] AS W ON WI.WarehouseCode = W.Code
	WHERE WI.WarehouseCode = @WarehouseCode
	ORDER BY W.SortOrder
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_GetWarehouseInventories
	@ApplicationId UNIQUEIDENTIFIER,
	@WarehouseCode NVARCHAR(50)
AS
BEGIN
	SELECT WI.WarehouseCode,
		WI.CatalogEntryCode,
		WI.InStockQuantity,
		WI.ReservedQuantity,
		WI.ReorderMinQuantity,
		WI.PreorderQuantity,
		WI.BackorderQuantity,
		WI.AllowPreorder,
		WI.AllowBackorder,
		WI.InventoryStatus,
		WI.PreorderAvailabilityDate,
		WI.BackorderAvailabilityDate,
		WI.ApplicationId
	FROM [WarehouseInventory] AS WI
	JOIN [Warehouse] AS W ON WI.WarehouseCode = W.Code
	WHERE WI.ApplicationId = @ApplicationId
	AND WI.WarehouseCode = @WarehouseCode
	ORDER BY W.SortOrder
	
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_GetCatalogEntryInventories
	@CatalogKeys udttCatalogKey READONLY
AS
BEGIN
	SELECT WI.WarehouseCode,
		WI.CatalogEntryCode,
		WI.InStockQuantity,
		WI.ReservedQuantity,
		WI.ReorderMinQuantity,
		WI.PreorderQuantity,
		WI.BackorderQuantity,
		WI.AllowPreorder,
		WI.AllowBackorder,
		WI.InventoryStatus,
		WI.PreorderAvailabilityDate,
		WI.BackorderAvailabilityDate,
		WI.ApplicationId
	FROM @CatalogKeys AS ck
	JOIN [WarehouseInventory] AS WI ON ck.ApplicationId = WI.ApplicationId AND ck.CatalogEntryCode = WI.CatalogEntryCode
	JOIN [Warehouse] AS W ON WI.WarehouseCode = W.Code AND W.ApplicationId = WI.ApplicationId
	ORDER BY W.SortOrder
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_SaveInventories
	@Inventories udttWarehouseInventory READONLY
AS
BEGIN
	BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    DELETE WI
	FROM WarehouseInventory AS WI
	JOIN @Inventories arg ON 
			arg.ApplicationId = WI.ApplicationId 
		AND arg.CatalogEntryCode = WI.CatalogEntryCode 
		AND arg.WarehouseCode = WI.WarehouseCode

	INSERT INTO dbo.WarehouseInventory 
	(WarehouseCode, CatalogEntryCode, InStockQuantity, ReservedQuantity, 
	 ReorderMinQuantity, PreorderQuantity, BackorderQuantity, AllowPreorder, 
	 AllowBackorder, InventoryStatus, PreorderAvailabilityDate, BackorderAvailabilityDate, ApplicationId)
	SELECT arg.WarehouseCode, arg.CatalogEntryCode, arg.InStockQuantity, arg.ReservedQuantity, 
	 arg.ReorderMinQuantity, arg.PreorderQuantity, arg.BackorderQuantity, arg.AllowPreorder, 
	 arg.AllowBackorder, arg.InventoryStatus, arg.PreorderAvailabilityDate, arg.BackorderAvailabilityDate, arg.ApplicationId
	FROM @Inventories AS arg
    
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_DeleteAllInventory
	@ApplicationId UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    DELETE FROM WarehouseInventory
    WHERE ApplicationId = @ApplicationId
    
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_DeleteInventory
	@CatalogKeys udttCatalogKey READONLY,
	@WarehouseCode NVARCHAR(50)
AS
BEGIN
	BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    DELETE WI
    FROM @CatalogKeys AS ck
    JOIN dbo.WarehouseInventory WI ON ck.ApplicationId = WI.ApplicationId AND ck.CatalogEntryCode = WI.CatalogEntryCode
    WHERE WI.WarehouseCode = @WarehouseCode
    
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_DeleteCatalogEntryInventories
	@CatalogKeys udttCatalogKey READONLY
AS
BEGIN
	BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    DELETE WI
    FROM @CatalogKeys AS ck
    JOIN dbo.WarehouseInventory WI ON ck.ApplicationId = WI.ApplicationId AND ck.CatalogEntryCode = WI.CatalogEntryCode
    
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_WarehouseInventory_DeleteWarehouseInventories
	@ApplicationId UNIQUEIDENTIFIER,
	@WarehouseCode NVARCHAR(50)
AS
BEGIN
	BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    DELETE FROM dbo.WarehouseInventory
    WHERE ApplicationId = @ApplicationId AND WarehouseCode = @WarehouseCode
    
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_Warehouse_List
	@ApplicationId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT * FROM Warehouse
	WHERE ApplicationId = @ApplicationId
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_Warehouse_GetById
	@ApplicationId UNIQUEIDENTIFIER,
	@WarehouseId INT
AS
BEGIN
	SELECT * FROM Warehouse
	WHERE ApplicationId = @ApplicationId AND WarehouseId = @WarehouseId
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_Warehouse_GetByCode
	@ApplicationId UNIQUEIDENTIFIER,
	@Code NVARCHAR(50)
AS
BEGIN
	SELECT * FROM Warehouse
	WHERE ApplicationId = @ApplicationId AND Code = @Code
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_Warehouse_Save
	@Warehouse udttWarehouse READONLY
AS
BEGIN
	BEGIN TRY
	DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION

    IF (SELECT arg.WarehouseId FROM @Warehouse arg) IS NULL
		BEGIN 
			SET IDENTITY_INSERT dbo.Warehouse OFF
			INSERT INTO dbo.Warehouse
			(ApplicationId, Name, CreatorId, Created, ModifierId, Modified, IsActive, IsPrimary, SortOrder, Code,
			 IsFulfillmentCenter, IsPickupLocation, IsDeliveryLocation,
			 FirstName, LastName, Organization, Line1, Line2, City, [State], CountryCode, CountryName,
			 PostalCode, RegionCode, RegionName, DaytimePhoneNumber, EveningPhoneNumber, FaxNumber, Email)
			SELECT arg.ApplicationId, arg.Name, arg.CreatorId, arg.Created, arg.ModifierId, arg.Modified,
				arg.IsActive, arg.IsPrimary, arg.SortOrder, arg.Code, arg.IsFulfillmentCenter, arg.IsPickupLocation, arg.IsDeliveryLocation, 
				arg.FirstName, arg.LastName, arg.Organization, arg.Line1, arg.Line2, arg.City, arg.[State], arg.CountryCode, arg.CountryName,
				arg.PostalCode, arg.RegionCode, arg.RegionName, arg.DaytimePhoneNumber, arg.EveningPhoneNumber,
				arg.FaxNumber, arg.Email
			FROM @Warehouse AS arg
		END
    ELSE
		BEGIN    
			UPDATE [dbo].[Warehouse]
			SET Name = arg.Name, Code = arg.Code, ModifierId = arg.ModifierId, Modified = arg.Modified,
			SortOrder = arg.SortOrder, IsActive = arg.IsActive, IsPrimary = arg.IsPrimary,
			IsFulfillmentCenter = arg.IsFulfillmentCenter, IsPickupLocation = arg.IsPickupLocation, IsDeliveryLocation = arg.IsDeliveryLocation, 
			FirstName = arg.FirstName, LastName = arg.LastName, Organization = arg.Organization, Line1 = arg.Line1, Line2 = arg.Line2, City = arg.City,
			[State] = arg.[State], CountryCode = arg.CountryCode, CountryName = arg.CountryName,
			PostalCode = arg.PostalCode, RegionCode = arg.RegionCode, RegionName = arg.RegionName,
			DaytimePhoneNumber = arg.DaytimePhoneNumber, EveningPhoneNumber = arg.EveningPhoneNumber,
			FaxNumber = arg.FaxNumber, Email = arg.Email
			FROM @Warehouse arg
			INNER JOIN dbo.Warehouse w
			ON w.WarehouseId = arg.WarehouseId
		END
		
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

	SET @sql = N'CREATE PROCEDURE dbo.ecf_Warehouse_Delete
	@ApplicationId UNIQUEIDENTIFIER,
	@WarehouseId INT
AS
BEGIN
	BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    DELETE FROM dbo.Warehouse
    WHERE ApplicationId = @ApplicationId AND WarehouseId = @WarehouseId
    
    IF @initialTranCount = 0 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
	END CATCH
END'
	EXEC dbo.sp_executesql @sql

SET @sql = N'CREATE PROCEDURE [dbo].[ecf_WarehouseInventory_GetInventories]
	@ApplicationId UNIQUEIDENTIFIER,
	@CatalogKeys udttCatalogKey READONLY,
	@WarehouseCodes udttWarehouseCode READONLY
AS
BEGIN

    DECLARE
		@filterCatalogKeys BIT = CASE WHEN EXISTS (SELECT 1 FROM @CatalogKeys) THEN 1 ELSE 0 END,
		@filterWarehouseCodes BIT = CASE WHEN EXISTS (SELECT 1 FROM @WarehouseCodes) THEN 1 ELSE 0 END

	SELECT 
		WI.WarehouseCode,
		WI.CatalogEntryCode,
		WI.InStockQuantity,
		WI.ReservedQuantity,
		WI.ReorderMinQuantity,
		WI.PreorderQuantity,
		WI.BackorderQuantity,
		WI.AllowPreorder,
		WI.AllowBackorder,
		WI.InventoryStatus,
		WI.PreorderAvailabilityDate,
		WI.BackorderAvailabilityDate,
		WI.ApplicationId
	FROM [WarehouseInventory] AS WI
	JOIN [Warehouse] AS W ON WI.WarehouseCode = W.Code
	WHERE WI.ApplicationId = @ApplicationId
	AND (@filterCatalogKeys = 0 OR WI.CatalogEntryCode IN (SELECT CatalogEntryCode FROM @CatalogKeys))
	AND (@filterWarehouseCodes = 0 OR WI.WarehouseCode IN (SELECT WarehouseCode FROM @WarehouseCodes))
	ORDER BY W.SortOrder, WI.CatalogEntryCode
END'
	EXEC dbo.sp_executesql @sql


	INSERT INTO dbo.SchemaVersion_WarehouseInventorySystem(Major, Minor, Patch, InstallDate) VALUES (@Major, @Minor, @Patch, GETDATE())
    PRINT 'Schema Patch v' + CONVERT(VARCHAR(2),@Major) + '.' + CONVERT(VARCHAR(2),@Minor) + '.' + CONVERT(VARCHAR(3),@Patch) + ' was applied successfully '
END
GO
