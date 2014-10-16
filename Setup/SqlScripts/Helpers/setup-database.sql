Print 'Installing Shared Schema'
Print 'Running ecf_db_functions.sql'
:r ..\ecf_db_functions.sql

Print 'Done'

Print 'Installing Application Schema'
Print 'Running ecf_db_ApplicationSystem_schema.sql'
:r ..\ecf_db_ApplicationSystem_schema.sql
Print 'Running ecf_db_ApplicationSystem_storedprocedures.sql'
:r ..\ecf_db_ApplicationSystem_storedprocedures.sql
Print 'Running ecf_db_ApplicationSystem_dataload.sql'
:r ..\ecf_db_ApplicationSystem_dataload.sql
Print 'Running ecf_db_ApplicationSystem_diagram.sql'
:r ..\ecf_db_ApplicationSystem_diagram.sql

Print 'Done'

Print 'Installing CMS Schema'
Print 'Running cms_db_schema.sql'
:r ..\cms_db_schema.sql
Print 'Running cms_db_storedprocedures.sql'
:r ..\cms_db_storedprocedures.sql
Print 'Running cms_db_dataload.sql'
:r ..\cms_db_dataload.sql
-- Print 'Running cms_db_diagram.sql'
-- :r ..\cms_db_diagram.sql

Print 'Done'

Print 'Installing EPiServer Commerce Common'
Print 'Running Common_Schema.sql'
:r ..\Common_Schema.sql
Print 'Running Common_Routines.sql'
:r ..\Common_Routines.sql
Print 'Running Common_InitializeData.sql'
:r ..\Common_InitializeData.sql


Print 'Done'

Print 'Installing Order Schema'
Print 'Running ecf_db_OrderSystem_schema.sql'
:r ..\ecf_db_OrderSystem_schema.sql
Print 'Running ecf_db_OrderSystem_storedprocedures.sql'
:r ..\ecf_db_OrderSystem_storedprocedures.sql
Print 'Running ecf_db_OrderSystem_diagram.sql'
:r ..\ecf_db_OrderSystem_diagram.sql


Print 'Done'

Print 'Installing Catalog Schema'
Print 'Running ecf_db_CatalogSystem_schema.sql'
:r ..\ecf_db_CatalogSystem_schema.sql
Print 'Running ecf_db_CatalogSystem_storedprocedures.sql'
:r ..\ecf_db_CatalogSystem_storedprocedures.sql
Print 'Running ecf_db_CatalogSystem_DataLoad.sql'
:r ..\ecf_db_CatalogSystem_DataLoad.sql
Print 'Running ecf_db_CatalogSystem_diagram.sql'
:r ..\ecf_db_CatalogSystem_diagram.sql

Print 'Done'

Print 'Installing Backwards Compatibility Layer'
:r ..\Common_Compat.sql

Print 'Done'

Print 'Installing Marketing Schema'
Print 'Running ecf_db_MarketingSystem_schema.sql'
:r ..\ecf_db_MarketingSystem_schema.sql
Print 'Running ecf_db_MarketingSystem_storedprocedures.sql'
:r ..\ecf_db_MarketingSystem_storedprocedures.sql
Print 'Running ecf_db_MarketingSystem_DataLoad.sql'
:r ..\ecf_db_MarketingSystem_DataLoad.sql
Print 'Running ecf_db_MarketingSystem_diagram.sql'
:r ..\ecf_db_MarketingSystem_diagram.sql

Print 'Done'

Print 'Running ecf_db_OrderSystem_DataLoad.sql'
:r ..\ecf_db_OrderSystem_DataLoad.sql

Print 'Done'

Print 'Installing Security Schema'
Print 'Running ecf_db_SecuritySystem_schema.sql'
:r ..\ecf_db_SecuritySystem_schema.sql
Print 'Running ecf_db_SecuritySystem_storedprocedures.sql'
:r ..\ecf_db_SecuritySystem_storedprocedures.sql
Print 'Running ecf_db_SecuritySystem_DataLoad.sql'
:r ..\ecf_db_SecuritySystem_DataLoad.sql
-- Print 'Running ecf_db_SecuritySystem_diagram.sql'
-- :r ..\ecf_db_SecuritySystem_diagram.sql

Print 'Done'

Print 'Installing Reporting Schema'
Print 'Running ecf_db_Reporting_schema.sql'
:r ..\ecf_db_Reporting_schema.sql
Print 'Running ecf_db_Reporting_storedprocedures.sql'
:r ..\ecf_db_Reporting_storedprocedures.sql
Print 'Running ecf_db_Reporting_DataLoad.sql'
:r ..\ecf_db_Reporting_DataLoad.sql

Print 'Done'

Print 'Installing MetaData Schema'
Print 'Running MetaData_schema.sql'
:r ..\MetaData_schema.sql
Print 'Running MetaData_storedprocedures.sql'
:r ..\MetaData_storedprocedures.sql
Print 'Running MetaData_DataLoad.sql'
:r ..\MetaData_DataLoad.sql
Print 'Running MetaData_FullTextSearchEnable.sql'
:r ..\MetaData_FullTextSearchEnable.sql

Print 'Done'

Print 'Installing BusinessFoundation Schema'
Print 'Running ecf_db_BusinessFoundation_schema.sql'
:r ..\ecf_db_BusinessFoundation_schema.sql
Print 'Running ecf_db_BusinessFoundation_storedprocedures.sql'
:r ..\ecf_db_BusinessFoundation_storedprocedures.sql
Print 'Running ecf_db_BusinessFoundation_DataLoad.sql'
:r ..\ecf_db_BusinessFoundation_DataLoad.sql

Print 'Done'

Print 'Updating BusinessFoundation'
Print 'Running ecf_db_BusinessFoundation_update.sql'
:r ..\Update\ecf_db_BusinessFoundation_update.sql

Print 'Done'

Print 'Installing Pricing Database Provider'
Print 'Running Pricing_Schema.sql'
:r ..\Pricing_Schema.sql
Print 'Running Pricing_Routines.sql'
:r ..\Pricing_Routines.sql
Print 'Running Pricing_InitializeData.sql'
:r ..\Pricing_InitializeData.sql

Print 'Done'

Print 'Installing Warehouse Inventory Database Provider'
Print 'Running WarehouseInventory_Schema.sql'
:r ..\WarehouseInventory_Schema.sql
Print 'Running WarehouseInventory_Routines.sql'
:r ..\WarehouseInventory_Routines.sql
Print 'Running WarehouseInventory_InitializeData.sql'
:r ..\WarehouseInventory_InitializeData.sql

Print 'Done'
