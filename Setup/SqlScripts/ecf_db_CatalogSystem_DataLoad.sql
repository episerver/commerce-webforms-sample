--Create a default warehouse for Commerce core site
declare @ApplicationId uniqueidentifier
select @ApplicationId = ApplicationId from [Application] where [Name] = N'$(EcfApplicationName)'

INSERT [dbo].[Warehouse] ([ApplicationId], [Name], [CreatorId], [Created], [ModifierId], [Modified], [IsActive], 
	[IsPrimary], [SortOrder], [Code], [IsFulfillmentCenter], [IsPickupLocation], [IsDeliveryLocation], [FirstName], [LastName], [Organization], [Line1], [Line2], [City], [State], [CountryCode], [CountryName], [PostalCode], [RegionCode], [RegionName], [DaytimePhoneNumber], [EveningPhoneNumber], [FaxNumber], [Email]) 
VALUES ( @ApplicationId , N'Default Warehouse', N'', GetDate(), N'', GetDate(), 1, 1, 0, N'default', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 0;

WHILE( @Patch <= 210) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion_CatalogSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO
