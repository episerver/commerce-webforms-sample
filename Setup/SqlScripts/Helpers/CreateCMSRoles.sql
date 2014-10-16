declare @ApplicationName nvarchar(256)
declare @ApplicationId uniqueidentifier
declare @TimeUtc datetime
declare @RoleNames nvarchar(256)
declare @UserNames nvarchar(256)

set @ApplicationName = N'CommerceSample'
set @TimeUtc = getutcdate()
SET @UserNames = 'admin'

SELECT @ApplicationId = ApplicationId from [Application] where [Name] = @ApplicationName

/*
	- create role is Administrators
*/
SET @RoleNames = 'Administrators'
EXECUTE [dbo].[aspnet_Roles_CreateRole] @ApplicationName , @RoleNames
EXECUTE [dbo].[aspnet_UsersInRoles_AddUsersToRoles] @ApplicationName,@UserNames, @RoleNames, @TimeUtc

SET @RoleNames = 'WebAdmins'
EXECUTE [dbo].[aspnet_Roles_CreateRole] @ApplicationName , @RoleNames
EXECUTE [dbo].[aspnet_UsersInRoles_AddUsersToRoles] @ApplicationName,@UserNames, @RoleNames, @TimeUtc

SET @RoleNames = 'WebEditors'
EXECUTE [dbo].[aspnet_Roles_CreateRole] @ApplicationName , @RoleNames
EXECUTE [dbo].[aspnet_UsersInRoles_AddUsersToRoles] @ApplicationName,@UserNames, @RoleNames, @TimeUtc

GO
