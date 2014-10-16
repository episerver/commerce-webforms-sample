declare @ApplicationName nvarchar(256)
set @ApplicationName = N'$(EcfApplicationName)'
declare @P1 uniqueidentifier
set @P1=newid()
declare @TimeUtc datetime
set @TimeUtc = getutcdate()
exec dbo.aspnet_Membership_CreateUser
	@ApplicationName,
	@UserName = N'admin',
	@Password = N'h7I4zig4aMBSJuMqnfI98uZrof9PWvOs5WBSTUjn++ejyQtei7oiOIawJLmGzHGnEDUzZf7P+aF8ICmXbQ2KPQ==',
	@PasswordSalt = N'yzdvrrY2IljwAxvEjYUgZg==',
	@Email = N'admin@yourcompany.com',
	@PasswordQuestion = NULL,
	@PasswordAnswer = NULL, 
	@IsApproved = 1,
	@UniqueEmail = 1,
	@PasswordFormat = 1, 
	@CurrentTimeUtc = @TimeUtc,
	@UserId = @P1 output

DECLARE @RC int
DECLARE @sql nvarchar(1000)

SET @sql = 'INSERT INTO SECURITY_ROLEASSIGNMENT (RoleParticipant, Role) VALUES (@p, ''Admins'')'
EXECUTE @RC = sp_executesql @sql, N'@p UNIQUEIDENTIFIER', @p = @P1 

SET @sql = 'INSERT INTO SECURITY_ROLEASSIGNMENT (RoleParticipant, Role) VALUES (@p, ''Everyone'')'
EXECUTE @RC = sp_executesql @sql, N'@p UNIQUEIDENTIFIER', @p = @P1 

SET @sql = 'INSERT INTO SECURITY_ROLEASSIGNMENT (RoleParticipant, Role) VALUES (@p, ''Management Users'')'
EXECUTE @RC = sp_executesql @sql, N'@p UNIQUEIDENTIFIER', @p = @P1 

SET @sql = 'INSERT INTO SECURITY_ROLEASSIGNMENT (RoleParticipant, Role) VALUES (@p, ''Registered'')'
EXECUTE @RC = sp_executesql @sql, N'@p UNIQUEIDENTIFIER', @p = @P1 

