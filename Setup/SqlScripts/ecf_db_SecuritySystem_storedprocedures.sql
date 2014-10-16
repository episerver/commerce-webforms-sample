/****** Object:  StoredProcedure [dbo].[GetSecuritySchemaVersionNumber]    Script Date: 07/21/2009 17:25:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSecuritySchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSecuritySchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[ecf_RolePermission]    Script Date: 07/21/2009 17:25:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_RolePermission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_RolePermission]
GO

/****** Object:  StoredProcedure [dbo].[GetSecuritySchemaVersionNumber]    Script Date: 07/21/2009 17:25:52 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSecuritySchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetSecuritySchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_SecuritySystem]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_SecuritySystem])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]' 
END
GO


/****** Object:  StoredProcedure [dbo].[ecf_RolePermission]    Script Date: 07/21/2009 17:25:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_RolePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_RolePermission]
    @ApplicationId uniqueidentifier,
	@Roles nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	select * from RolePermission where ApplicationId = @ApplicationId and RoleName in (select item from ecf_splitlist(@Roles))
END' 
END
GO


-- Remove SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_RolePermissionInsert]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_RolePermissionUpdate]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_RolePermissionDelete]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_RolePermissionSelect]
GO

-- Create SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_RolePermissionInsert]
GO
CREATE PROCEDURE [dbo].[mc_RolePermissionInsert]
@ApplicationId AS UniqueIdentifier,
@RoleName AS NVarChar(4000),
@Permission AS NVarChar(4000),
@RolePermissionId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [RolePermission]
(
[ApplicationId],
[RoleName],
[Permission])
VALUES(
@ApplicationId,
@RoleName,
@Permission)
SELECT @RolePermissionId = SCOPE_IDENTITY();

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_RolePermissionUpdate]
GO
CREATE PROCEDURE [dbo].[mc_RolePermissionUpdate]
@ApplicationId AS UniqueIdentifier,
@RoleName AS NVarChar(4000),
@Permission AS NVarChar(4000),
@RolePermissionId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [RolePermission] SET
[ApplicationId] = @ApplicationId,
[RoleName] = @RoleName,
[Permission] = @Permission WHERE
[RolePermissionId] = @RolePermissionId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_RolePermissionDelete]
GO
CREATE PROCEDURE [dbo].[mc_RolePermissionDelete]
@RolePermissionId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [RolePermission]
WHERE
[RolePermissionId] = @RolePermissionId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_RolePermissionSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_RolePermissionSelect]
GO
CREATE PROCEDURE [dbo].[mc_RolePermissionSelect]
@RolePermissionId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[RolePermissionId] AS [RolePermissionId], [t01].[ApplicationId] AS [ApplicationId], [t01].[RoleName] AS [RoleName], [t01].[Permission] AS [Permission]
FROM [RolePermission] AS [t01]
WHERE ([t01].[RolePermissionId]=@RolePermissionId)

END
GO
-- End



-- Remove SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentInsert]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentUpdate]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentDelete]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentSelect]
GO

-- Create SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentInsert]
GO
CREATE PROCEDURE [dbo].[mc_Security_RoleAssignmentInsert]
@SecurityRoleAssignmentId AS UniqueIdentifier,
@RoleParticipant AS UniqueIdentifier,
@Role AS NVarChar(4000),
@Scope AS NText,
@CheckMode AS Int,
@IsOnlyForOwner AS Bit
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [Security_RoleAssignment]
(
[SecurityRoleAssignmentId],
[RoleParticipant],
[Role],
[Scope],
[CheckMode],
[IsOnlyForOwner])
VALUES(
@SecurityRoleAssignmentId,
@RoleParticipant,
@Role,
@Scope,
@CheckMode,
@IsOnlyForOwner)

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentUpdate]
GO
CREATE PROCEDURE [dbo].[mc_Security_RoleAssignmentUpdate]
@RoleParticipant AS UniqueIdentifier,
@Role AS NVarChar(4000),
@Scope AS NText,
@CheckMode AS Int,
@IsOnlyForOwner AS Bit,
@SecurityRoleAssignmentId AS UniqueIdentifier
AS
BEGIN
SET NOCOUNT ON;

UPDATE [Security_RoleAssignment] SET
[RoleParticipant] = @RoleParticipant,
[Role] = @Role,
[Scope] = @Scope,
[CheckMode] = @CheckMode,
[IsOnlyForOwner] = @IsOnlyForOwner WHERE
[SecurityRoleAssignmentId] = @SecurityRoleAssignmentId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentDelete]
GO
CREATE PROCEDURE [dbo].[mc_Security_RoleAssignmentDelete]
@SecurityRoleAssignmentId AS UniqueIdentifier
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [Security_RoleAssignment]
WHERE
[SecurityRoleAssignmentId] = @SecurityRoleAssignmentId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_RoleAssignmentSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_Security_RoleAssignmentSelect]
GO
CREATE PROCEDURE [dbo].[mc_Security_RoleAssignmentSelect]
@SecurityRoleAssignmentId AS UniqueIdentifier
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[SecurityRoleAssignmentId] AS [SecurityRoleAssignmentId], [t01].[RoleParticipant] AS [RoleParticipant], [t01].[Role] AS [Role], [t01].[Scope] AS [Scope], [t01].[CheckMode] AS [CheckMode], [t01].[IsOnlyForOwner] AS [IsOnlyForOwner]
FROM [Security_RoleAssignment] AS [t01]
WHERE ([t01].[SecurityRoleAssignmentId]=@SecurityRoleAssignmentId)

END

-- End
GO

/****** Object:  UserDefinedFunction [dbo].[mdpfn_sys_EncryptDecryptString2]    Script Date: 08/25/2009  ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpfn_sys_EncryptDecryptString2]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[mdpfn_sys_EncryptDecryptString2]
(
	
	@input varbinary(4000), 
	@encrypt bit
)
RETURNS varbinary(4000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @RetVal varbinary(4000)

	IF(@input IS NULL)
		RETURN @input

	IF(@encrypt = 1) 
		SELECT @RetVal = EncryptByKey(Key_GUID(''Mediachase_ECF50_MDP_Key''), @input) 
	ELSE
		SELECT @RetVal = DecryptByKey(@input)

	RETURN @RetVal;
END' 
END

GO
-- End



declare @verb nvarchar(10)
declare @sql nvarchar(max)

select @verb = case when exists (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_SsoTicketCreate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	then 'ALTER' else 'CREATE' end
set @sql = @verb + N' PROCEDURE [dbo].[mc_Security_SsoTicketCreate]
	@SsoTicket nvarchar(64),
	@UserName nvarchar(256),
	@ApplicationName nvarchar(200) = null,
	@ExpirationUtc datetime
as
begin
	set nocount on

	begin try
		begin transaction create_ssoticket_transaction
	
		update [Security_SsoTickets]
		set Valid = 0
		where UserName = @UserName and Valid = 1
	
		insert into [Security_SsoTickets] ([SsoTicket], [UserName], [ApplicationName], [ExpirationUtc], [Valid])
		values (@SsoTicket, @UserName, @ApplicationName, @ExpirationUtc, 1)
	
		commit transaction create_ssoticket_transaction
	end try
	begin catch
		rollback transaction create_ssoticket_transaction
	end catch
end'
exec sp_executesql @sql

select @verb = case when exists (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_Security_SsoTicketCheck]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	then 'ALTER' else 'CREATE' end
set @sql = @verb + N' PROCEDURE [dbo].[mc_Security_SsoTicketCheck]
	@SsoTicket nvarchar(64),
	@UserName nvarchar(256),
	@UtcNow datetime = null,
	@PurgeBefore datetime = null
as
begin
	set nocount on
	
	if (@UtcNow is null) set @UtcNow = GETUTCDATE()
	if (@PurgeBefore is null) set @PurgeBefore = DATEADD(day, -2, @UtcNow)

	declare @ApplicationName nvarchar(200)
	declare @Valid bit
	declare @ExpirationUtc datetime
	
	begin try
		begin transaction check_ssoticket_transaction

		select @ApplicationName = [ApplicationName], @Valid = [Valid], @ExpirationUtc = [ExpirationUtc]
		from [Security_SsoTickets]
		with (HOLDLOCK, ROWLOCK)
		where [SsoTicket] = @SsoTicket and [UserName] = @UserName
	  
		update [Security_SsoTickets] set Valid = 0 where [SsoTicket] = @SsoTicket
		
		commit transaction check_ssoticket_transaction
	end try
	begin catch
		rollback transaction check_ssoticket_transaction
	end catch

	begin try	
		delete from [Security_SsoTickets] where [ExpirationUtc] < @PurgeBefore
	end try
	begin catch
	end catch
	
	if @Valid is null set @Valid = 0
	if @Valid = 0 set @ApplicationName = null
	
	select @Valid as Valid, @ApplicationName as ApplicationName
end'
exec sp_executesql @sql

GO
