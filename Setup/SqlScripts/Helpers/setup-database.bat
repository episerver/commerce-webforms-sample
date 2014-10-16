CD %~dp0
@echo off

set dbUser=%1
set dbPass=%2
set dbServer=%3
set dbName=%4
set appName=%5

IF [%appName%]==[] SET appName=eCommerceFramework

IF %2=="" sqlcmd -S %dbServer% -d %dbName% -v EcfApplicationName=%appName% -i "setup-database.sql"
IF %2=="" goto membership
sqlcmd -U %dbUser% -P %dbPass% -S %dbServer% -d %dbName% -v EcfApplicationName=%appName% -i "setup-database.sql"
REM sqlcmd -U %1 -P %2 -S %3 -d %4 -v EcfApplicationName=%appName% -i "update-main.sql"

:membership

IF %2=="" sqlcmd -S %dbServer% -d %dbName% -v EcfApplicationName=%appName% ReplacePlaceHolder=%dbName% -i "membership.sql"
IF %2=="" sqlcmd -S %dbServer% -d %dbName% -v EcfApplicationName=%appName% -i "setup-users.sql"
IF %2=="" goto end
sqlcmd -U %dbUser% -P %dbPass% -S %dbServer% -d %dbName% -v EcfApplicationName=%appName% ReplacePlaceHolder=%dbName% -i "membership.sql"
sqlcmd -U %dbUser% -P %dbPass% -S %dbServer% -d %dbName% -v EcfApplicationName=%appName% -i "setup-users.sql"
:end