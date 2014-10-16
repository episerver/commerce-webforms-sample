begin try
    -- Default Market
    declare @CurrencyCodes udttCurrencyCode
    insert into @CurrencyCodes (CurrencyCode) values ('USD')

    declare @LanguageCodes udttLanguageCode    
    insert into @LanguageCodes (LanguageCode) values ('en')

	declare @CountryCodes udttCountryCode
	insert into @CountryCodes (CountryCode) values ('USA')

    exec dbo.ecf_Market_Create 'DEFAULT', 1, 'Default Market', 'Default Market', 'USD', 'en', @CurrencyCodes, @LanguageCodes, @CountryCodes
    
end try
begin catch
    declare @msg nvarchar(4000), @severity int, @state int
    select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
end catch
go

begin try
	--Create a default warehouse
	declare @ApplicationId uniqueidentifier
	select @ApplicationId = ApplicationId from [Application] where [Name] = N'$(EcfApplicationName)'

	INSERT [dbo].[Warehouse] ([ApplicationId], [Name], [CreatorId], [Created], [ModifierId], [Modified], [IsActive], 
		[IsPrimary], [SortOrder], [Code], [IsFulfillmentCenter], [IsPickupLocation], [IsDeliveryLocation], [FirstName], [LastName], [Organization], [Line1], [Line2], [City], [State], [CountryCode], [CountryName], [PostalCode], [RegionCode], [RegionName], [DaytimePhoneNumber], [EveningPhoneNumber], [FaxNumber], [Email]) 
	VALUES ( @ApplicationId , N'Default Warehouse', N'', GetDate(), N'', GetDate(), 1, 1, 0, N'default', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
end try
begin catch
    declare @msg nvarchar(4000), @severity int, @state int
    select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
end catch
go