if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Market_GetAll') exec sp_executesql N'drop procedure dbo.ecf_Market_GetAll'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Market_Get') exec sp_executesql N'drop procedure dbo.ecf_Market_Get'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Market_Create') exec sp_executesql N'drop procedure dbo.ecf_Market_Create'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Market_Update') exec sp_executesql N'drop procedure dbo.ecf_Market_Update'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Market_Delete') exec sp_executesql N'drop procedure dbo.ecf_Market_Delete'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_GetAll') exec sp_executesql N'drop procedure dbo.ecf_Currency_GetAll'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_Get') exec sp_executesql N'drop procedure dbo.ecf_Currency_Get'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_Create') exec sp_executesql N'drop procedure dbo.ecf_Currency_Create'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_Update') exec sp_executesql N'drop procedure dbo.ecf_Currency_Update'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_Delete') exec sp_executesql N'drop procedure dbo.ecf_Currency_Delete'
if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCurrencyCode') exec dbo.sp_executesql N'drop type dbo.udttCurrencyCode'
if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttLanguageCode') exec dbo.sp_executesql N'drop type dbo.udttLanguageCode'
if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCountryCode') exec dbo.sp_executesql N'drop type dbo.udttCountryCode'

create type dbo.udttCurrencyCode as table (
    CurrencyCode nvarchar(8)
)
go

create type dbo.udttLanguageCode as table (
    LanguageCode nvarchar(84)
)
go

create type dbo.udttCountryCode as table (
    CountryCode nvarchar(8)
)
go

create procedure dbo.ecf_Currency_GetAll
as
begin
    select CurrencyCode, CurrencyName
    from dbo.Currency
end
go

create procedure dbo.ecf_Currency_Get
    @CurrencyCode nvarchar(8)
as
begin
    select CurrencyCode, CurrencyName
    from dbo.Currency
    where CurrencyCode = @CurrencyCode
end
go

create procedure dbo.ecf_Currency_Create
    @CurrencyCode nvarchar(8),
    @CurrencyName nvarchar(50)
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction
        
        if (select COUNT(*) from Application) != 1 raiserror('Multiple applications are not supported.', 10, 0)
        
        insert into dbo.Currency (CurrencyCode, Created, Modified, CurrencyName, CompatApplicationId)
        select @CurrencyCode, GETUTCDATE(), GETUTCDATE(), @CurrencyName, a.ApplicationId
        from Application a

        if @initialTranCount = 0 commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @severity int, @state int
        select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()
        if @initialTranCount = 0 rollback transaction
        raiserror(@msg, @severity, @state)
    end catch
end
go

create procedure dbo.ecf_Currency_Update
    @CurrencyCode nvarchar(8),
    @CurrencyName nvarchar(50)
as
begin
    update dbo.Currency
    set Modified = GETUTCDATE(), CurrencyName = @CurrencyName
    where CurrencyCode = @CurrencyCode
end
go

create procedure dbo.ecf_Currency_Delete
    @CurrencyCode nvarchar(8)
as
begin
    delete from dbo.Currency
    where CurrencyCode = @CurrencyCode
end
go

create procedure dbo.ecf_Market_GetAll
as
begin
    select MarketId, Created, Modified, IsEnabled, MarketName, MarketDescription, DefaultCurrencyCode, DefaultLanguageCode
    from dbo.Market
    
    select MarketId, CurrencyCode
    from dbo.MarketCurrencies
    
    select MarketId, LanguageCode
    from dbo.MarketLanguages

    select MarketId, CountryCode
    from dbo.MarketCountries
end
go

create procedure dbo.ecf_Market_Get
    @MarketId nvarchar(8)
as
begin
    select
        m.MarketId,
        m.Created,
        m.Modified,
        m.IsEnabled,
        m.MarketName,
        m.MarketDescription,
        m.DefaultCurrencyCode,
        m.DefaultLanguageCode
    from dbo.Market m
    where m.MarketId = @MarketId
    
    select MarketId, CurrencyCode
    from dbo.MarketCurrencies
    where MarketId = @MarketId
    
    select MarketId, LanguageCode
    from dbo.MarketLanguages
    where MarketId = @MarketId

    select MarketId, CountryCode
    from dbo.MarketCountries
    where MarketId = @MarketId
end
go

create procedure dbo.ecf_Market_Create
    @MarketId nvarchar(8),
    @IsEnabled bit,
    @MarketName nvarchar(50),
    @MarketDescription nvarchar(4000),
    @DefaultCurrencyCode nvarchar(8),
    @DefaultLanguageCode nvarchar(84),
    @CurrencyCodes udttCurrencyCode readonly,
    @LanguageCodes udttLanguageCode readonly,
    @CountryCodes udttCountryCode readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction

        if not exists (select 1 from @CurrencyCodes where CurrencyCode = @DefaultCurrencyCode) raiserror('Default currency must be included in the currency list.', 10, 0)
        if not exists (select 1 from @LanguageCodes where LanguageCode = @DefaultLanguageCode) raiserror('Default language must be included in the language list.', 10, 0)            

        insert into dbo.Market (MarketId, Created, Modified, IsEnabled, MarketName, MarketDescription, DefaultCurrencyCode, DefaultLanguageCode)
        values (@MarketId, GETUTCDATE(), GETUTCDATE(), @IsEnabled, @MarketName, @MarketDescription, @DefaultCurrencyCode, @DefaultLanguageCode)
        
        insert into dbo.MarketCurrencies (MarketId, CurrencyCode)
        select distinct @MarketId, CurrencyCode
        from @CurrencyCodes
        
        insert into dbo.MarketLanguages (MarketId, LanguageCode)
        select distinct @MarketId, LanguageCode
        from @LanguageCodes
        
        insert into dbo.MarketCountries (MarketId, CountryCode)
        select distinct @MarketId, CountryCode
        from @CountryCodes

        if @initialTranCount = 0 commit transaction ecf_Market_Create
    end try
    begin catch
        declare @msg nvarchar(4000), @severity int, @state int
        select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()
        if @initialTranCount = 0 rollback transaction
        raiserror(@msg, @severity, @state)
    end catch
end
go

create procedure dbo.ecf_Market_Update
    @MarketId nvarchar(8),
    @IsEnabled bit,
    @MarketName nvarchar(50),
    @MarketDescription nvarchar(4000),
    @DefaultCurrencyCode nvarchar(8),
    @DefaultLanguageCode nvarchar(84),
    @CurrencyCodes udttCurrencyCode readonly,
    @LanguageCodes udttLanguageCode readonly,
    @CountryCodes udttCountryCode readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction

        if not exists (select 1 from @CurrencyCodes where CurrencyCode = @DefaultCurrencyCode) raiserror('Default currency must be included in the currency list.', 10, 0)
        if not exists (select 1 from @LanguageCodes where LanguageCode = @DefaultLanguageCode) raiserror('Default language must be included in the language list.', 10, 0)            

        update dbo.Market
        set Modified = GETUTCDATE(), IsEnabled = @IsEnabled, MarketName = @MarketName, MarketDescription = @MarketDescription, DefaultCurrencyCode = @DefaultCurrencyCode, DefaultLanguageCode = @DefaultLanguageCode
        where MarketId = @MarketId
        
        delete mc
        from dbo.MarketCurrencies mc
        where mc.MarketId = @MarketId
          and not exists (select 1 from @CurrencyCodes cc where mc.CurrencyCode = cc.CurrencyCode)
        
        insert into dbo.MarketCurrencies (MarketId, CurrencyCode)
        select @MarketId, CurrencyCode
        from @CurrencyCodes cc
        where not exists (select 1 from dbo.MarketCurrencies mc where mc.MarketId = @MarketId and mc.CurrencyCode = cc.CurrencyCode)
        
        delete ml
        from dbo.MarketLanguages ml
        where ml.MarketId = @MarketId
          and not exists (select 1 from @LanguageCodes cc where ml.LanguageCode = cc.LanguageCode)
        
        insert into dbo.MarketLanguages (MarketId, LanguageCode)
        select @MarketId, LanguageCode
        from @LanguageCodes lc
        where not exists (select 1 from dbo.MarketLanguages ml where ml.MarketId = @MarketId and ml.LanguageCode = lc.LanguageCode)

        delete mc
        from dbo.MarketCountries mc
        where mc.MarketId = @MarketId
          and not exists (select 1 from @CountryCodes cc where mc.CountryCode = cc.CountryCode)

        insert into dbo.MarketCountries (MarketId, CountryCode)
        select @MarketId, CountryCode
        from @CountryCodes cc
        where not exists (select 1 from dbo.MarketCountries mc where mc.MarketId = @MarketId and mc.CountryCode = cc.CountryCode)

        if @initialTranCount = 0 commit transaction ecf_Market_Update
    end try
    begin catch
        declare @msg nvarchar(4000), @severity int, @state int
        select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()
        if @initialTranCount = 0 rollback transaction
        raiserror(@msg, @severity, @state)
    end catch
end
go

create procedure dbo.ecf_Market_Delete
    @MarketId nvarchar(8)
as
begin
    delete from dbo.Market
    where MarketId = @MarketId
end
go
