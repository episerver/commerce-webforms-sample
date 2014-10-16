declare @ApplicationId uniqueidentifier
set @ApplicationId = newid()

INSERT INTO [Application]
  ([ApplicationId], [Name], [IsActive])
VALUES
  (@ApplicationId, N'$(EcfApplicationName)', 1);

INSERT INTO [CommonSettings]
  ([ApplicationId], [Name], [Value])
VALUES
  (@ApplicationId, N'DefaultLanguage', N'en');
  
INSERT INTO [CommonSettings]
  ([ApplicationId], [Name], [Value])
VALUES
  (@ApplicationId, N'DefaultCurrency', N'USD');
  
INSERT INTO [CommonSettings]
  ([ApplicationId], [Name], [Value])
VALUES
  (@ApplicationId, N'DefaultLength', N'FT');
  
INSERT INTO [CommonSettings]
  ([ApplicationId], [Name], [Value])
VALUES
  (@ApplicationId, N'DefaultWeight', N'LBS');

--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 0;

WHILE( @Patch <= 9) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from [SchemaVersion_ApplicationSystem] where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into [SchemaVersion_ApplicationSystem](Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO