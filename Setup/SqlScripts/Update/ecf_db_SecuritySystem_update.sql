---------------------- May 26, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 1;
Set @Patch = 3;

Select @Installed = InstallDate from SchemaVersion_SecuritySystem where Major=@Major and Minor=@Minor and Patch=@Patch

IF (@Installed is null)
BEGIN
--## BEGIN Schema Patch ##

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Security_SsoTickets]') AND type in (N'U'))
exec sp_executesql N'DROP TABLE [dbo].[Security_SsoTickets]'

exec sp_executesql N'CREATE TABLE [dbo].[Security_SsoTickets](
	[SsoTicket] nvarchar(64) NOT NULL,
	[UserName] nvarchar(256) NOT NULL,
	[ApplicationName] nvarchar(200) NULL,
	[ExpirationUtc] datetime NOT NULL,
	[Valid] bit NOT NULL,
	CONSTRAINT [PK_Security_SsoTickets] PRIMARY KEY ([SsoTicket] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
		ON [PRIMARY]
) ON [PRIMARY]'


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
set @sql = @verb + N'  PROCEDURE [dbo].[mc_Security_SsoTicketCheck]
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

--## END Schema Patch ##

set nocount on
insert into SchemaVersion_SecuritySystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---------------------- June 2, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 1;
Set @Patch = 4;

Select @Installed = InstallDate from SchemaVersion_SecuritySystem where Major=@Major and Minor=@Minor and Patch=@Patch

IF (@Installed is null)
BEGIN
--## BEGIN Schema Patch ##

	merge into RolePermission dst
	using (
			select ApplicationId, 'Admins' as RoleName, 'order:mng:change_price' as Permission from Application
			union all select ApplicationId, 'Order Supervisor', 'order:mng:change_price' from Application
		) src
	on dst.ApplicationId = src.ApplicationId and dst.RoleName = src.RoleName and dst.Permission = src.Permission
	when not matched then
	    insert (ApplicationId, RoleName, Permission)
	    values (src.ApplicationId, src.RoleName, src.Permission);

--## END Schema Patch ##

set nocount on
insert into SchemaVersion_SecuritySystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---------------------- November 13, 2013 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime
Set @Major = 5;
Set @Minor = 1;
Set @Patch = 5;

Select @Installed = InstallDate from SchemaVersion_SecuritySystem where Major=@Major and Minor=@Minor and Patch=@Patch

IF (@Installed is null)
BEGIN
--## BEGIN Schema Patch ##

--## Insert missing core:mng:login permissions.
INSERT INTO RolePermission
  SELECT DISTINCT ApplicationId, RoleName, 'core:mng:login' [Permission]
  FROM RolePermission rp
  WHERE not exists (
    SELECT TOP 1 * FROM RolePermission rp2
    WHERE rp2.ApplicationId = rp.ApplicationId
      and rp2.RoleName = rp.RoleName
      and rp2.Permission = 'core:mng:login'
    )

--## Insert missing tabivew permissions.
INSERT INTO RolePermission
  SELECT rp_tabs.ApplicationId, rp_tabs.RoleName, rp_tabs.Permission
  FROM 
    (
    SELECT DISTINCT
      ApplicationId,
      RoleName,
      substring(Permission, 1, charindex(':', Permission)) + 'tabviewpermission' Permission
    FROM RolePermission
    WHERE charindex(':', Permission) <> 0
      and substring(Permission, 1, 4) <> 'core'
    ) rp_tabs
  WHERE not exists (
   SELECT TOP 1 * FROM RolePermission rp2
    WHERE rp2.ApplicationId = rp_tabs.ApplicationId
      and rp2.RoleName = rp_tabs.RoleName
      and rp2.Permission = rp_tabs.Permission
    )
--## END Schema Patch ##

set nocount on
insert into SchemaVersion_SecuritySystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO
