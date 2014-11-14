osql -S . -E -Q "EXEC msdb.dbo.sp_delete_database_backuphistory N'SampleCmsDb'"
osql -S . -E -Q "ALTER DATABASE [SampleCmsDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE"
osql -S . -E -Q "DROP DATABASE [SampleCmsDb]"
osql -S . -E -Q "EXEC msdb.dbo.sp_delete_database_backuphistory N'SampleCommerceDb'"
osql -S . -E -Q "ALTER DATABASE [SampleCommerceDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE"
osql -S . -E -Q "DROP DATABASE [SampleCommerceDb]"
osql -S . -E -Q "EXEC sp_droplogin @loginame='commercesample'"
osql -S . -E -Q "CREATE DATABASE [SampleCmsDb]"
osql -S . -E -Q "CREATE DATABASE [SampleCommerceDb]"
osql -S . -E -Q "EXEC sp_addlogin @loginame='commercesample', @passwd='password123!', @defdb='SampleCmsDb'"
osql -S . -d SampleCmsDb -E -Q "EXEC sp_adduser @loginame='commercesample'"
osql -S . -d SampleCmsDb -E -Q "EXEC sp_addrolemember N'db_owner', N'commercesample'"
osql -S . -d SampleCommerceDb -E -Q "EXEC sp_adduser @loginame='commercesample'"
osql -S . -d SampleCommerceDb -E -Q "EXEC sp_addrolemember N'db_owner', N'commercesample'"
echo Starting CMS Database Install
osql -S . -d SampleCmsDb -E -b -i "..\packages\EPiServer.CMS.Core.7.16.1\tools\EPiServer.Cms.Core.sql" > setupCmsDb.log
osql -S . -d SampleCmsDb -E -b -i "%windir%\Microsoft.NET\Framework\v3.0\Windows Workflow Foundation\SQL\EN\SqlPersistenceService_Schema.sql"
osql -S . -d SampleCmsDb -E -b -i "%windir%\Microsoft.NET\Framework\v3.0\Windows Workflow Foundation\SQL\EN\SqlPersistenceService_Logic.sql"
echo Finshed CMS Database Install please check setupCmsDb.log for any errors
echo Starting Commerce Database Install
call .\SqlScripts\Helpers\setup-database.bat commercesample password123! . SampleCommerceDb CommerceSample > setupCommerceDb.log
osql -S . -d SampleCommerceDb -E -b -i "CreateCMSRoles.sql"
echo Finshed Commerce Database Install please check setupCommerceDb.log for any errors
Pause