begin try
    declare @initialTranCount int = @@TRANCOUNT
    if @initialTranCount = 0 begin transaction

    -- Currencies
    exec dbo.ecf_Currency_Create 'AUD', 'Australian dollar'
	exec dbo.ecf_Currency_Create 'AED', 'United Arab Emirates'
    exec dbo.ecf_Currency_Create 'CAD', 'Canadian dollar'
    exec dbo.ecf_Currency_Create 'CHF', 'Swiss franc'
    exec dbo.ecf_Currency_Create 'CZK', 'Czech koruna'
    exec dbo.ecf_Currency_Create 'DKK', 'Danish krone'
    exec dbo.ecf_Currency_Create 'EEK', 'Estonian kroon'
    exec dbo.ecf_Currency_Create 'EUR', 'Euro'
    exec dbo.ecf_Currency_Create 'GBP', 'Pound sterling'
    exec dbo.ecf_Currency_Create 'HUF', 'Hungarian forint'
    exec dbo.ecf_Currency_Create 'ISK', 'Iceland krona'
    exec dbo.ecf_Currency_Create 'JPY', 'Japanese yen'
    exec dbo.ecf_Currency_Create 'KRW', 'South Korean won'
    exec dbo.ecf_Currency_Create 'LTL', 'Lithuanian litas'
    exec dbo.ecf_Currency_Create 'LVL', 'Latvian lats'
    exec dbo.ecf_Currency_Create 'NOK', 'Norwegian krone'
    exec dbo.ecf_Currency_Create 'NZD', 'New Zeland dollar'
    exec dbo.ecf_Currency_Create 'PLN', 'Polish zloty'
    exec dbo.ecf_Currency_Create 'RON', 'Romanian leu'
    exec dbo.ecf_Currency_Create 'RUB', 'Ruble'
    exec dbo.ecf_Currency_Create 'SEK', 'Swedish krona'
    exec dbo.ecf_Currency_Create 'SKK', 'Slovak koruna'
    exec dbo.ecf_Currency_Create 'TRY', 'Turkish lira'
    exec dbo.ecf_Currency_Create 'USD', 'US dollar'
    exec dbo.ecf_Currency_Create 'ZAR', 'South African rand'

    -- Default Market
    declare @CurrencyCodes udttCurrencyCode
    insert into @CurrencyCodes (CurrencyCode) values ('USD')

    declare @LanguageCodes udttLanguageCode    
    insert into @LanguageCodes (LanguageCode) values ('en')

	declare @CountryCodes udttCountryCode
	insert into @CountryCodes (CountryCode) values ('USA')

    exec dbo.ecf_Market_Create 'DEFAULT', 1, 'Default Market', 'Default Market', 'USD', 'en', @CurrencyCodes, @LanguageCodes, @CountryCodes
    
    if @initialTranCount = 0 commit transaction
end try
begin catch
    declare @msg nvarchar(4000), @severity int, @state int
    select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    if @initialTranCount = 0 rollback transaction    
    raiserror(@msg, @severity, @state)
end catch
go
