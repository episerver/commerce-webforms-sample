IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'WarehouseInventory') EXEC dbo.sp_executesql N'DROP TABLE dbo.WarehouseInventory'
GO

CREATE TABLE [dbo].[WarehouseInventory]
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
)
GO
