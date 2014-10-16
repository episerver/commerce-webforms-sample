BEGIN TRY
    DECLARE @initialTranCount INT = @@TRANCOUNT
    IF @initialTranCount = 0 BEGIN TRANSACTION
    
    -- There is only one default Inventory at the moment to copy from. Not needed at present since Catalog import works, but
	--  a similar query may yet be needed in the future.
	--insert into WarehouseInventory
	--(WarehouseId, CatalogEntryCode, InStockQuantity, ReservedQuantity, 
	-- ReorderMinQuantity, PreorderQuantity, BackorderQuantity, AllowPreorder, 
	-- AllowBackorder, InventoryStatus, PreorderAvailabilityDate, BackorderAvailabilityDate, ApplicationId)
	--(select 1, Inventory.SkuId, Inventory.InStockQuantity, Inventory.ReservedQuantity, 
	-- Inventory.ReorderMinQuantity, Inventory.PreorderQuantity, Inventory.BackorderQuantity, Inventory.AllowPreorder, 
	-- Inventory.AllowBackorder, Inventory.InventoryStatus, Inventory.PreorderAvailabilityDate, Inventory.BackorderAvailabilityDate, Inventory.ApplicationId
	-- from Inventory)

    IF @initialTranCount = 0 COMMIT TRANSACTION
END TRY
BEGIN CATCH
    DECLARE @msg NVARCHAR(4000), @severity INT, @state INT
    SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    IF @initialTranCount = 0 ROLLBACK TRANSACTION   
    RAISERROR(@msg, @severity, @state)
END CATCH
GO