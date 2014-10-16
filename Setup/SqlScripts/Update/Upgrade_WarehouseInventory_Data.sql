SET NOCOUNT ON

BEGIN TRY
	BEGIN TRANSACTION

	IF EXISTS (SELECT 1 FROM WarehouseInventory) RAISERROR('Please remove all data from the WarehouseInventory table before importing.', 18, 0);

	DECLARE @defaultWarehouseCode nvarchar(50)

	SET @defaultWarehouseCode = (SELECT TOP 1 Code FROM Warehouse ORDER BY WarehouseId, SortOrder)

	INSERT INTO WarehouseInventory
	(
	    WarehouseCode, CatalogEntryCode, InStockQuantity, ReservedQuantity, 
	    ReorderMinQuantity, PreorderQuantity, BackorderQuantity, AllowPreorder, 
	    AllowBackorder, InventoryStatus, PreorderAvailabilityDate, BackorderAvailabilityDate, ApplicationId
	)
	(
	SELECT
	    @defaultWarehouseCode, ce.Code,
		COALESCE(i.InStockQuantity, 0), COALESCE(i.ReservedQuantity, 0), 
		COALESCE(i.ReorderMinQuantity, 0), COALESCE(i.PreorderQuantity, 0), 
		COALESCE(i.BackorderQuantity, 0), 
		COALESCE(i.AllowPreorder, 0), COALESCE(i.AllowBackorder, 0),
		-- Logic: If we have a good flag on the old Inventory table use it, if not fall back on the Variation table,
		--        and if not turn it off. Customers with custom status numbers will have to review their inventory
		--        table contents and decide accordingly.
        CASE
			WHEN COALESCE(i.InventoryStatus,-1) <> -1 THEN i.InventoryStatus -- Keep current if assigned
	        WHEN COALESCE(v.TrackInventory, 0) = 1 THEN 1 -- Enabled
	        ELSE 0 -- Disabled
	    END InventoryStatus, 
	    i.PreorderAvailabilityDate, i.BackorderAvailabilityDate, 
		i.ApplicationId
	FROM CatalogEntry ce
	LEFT JOIN Inventory i ON ce.Code = i.SkuId
	INNER JOIN Variation v ON ce.CatalogEntryId = v.CatalogEntryId
	)

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()

	ROLLBACK TRANSACTION

	RAISERROR(@msg, @severity, @state)
END CATCH
