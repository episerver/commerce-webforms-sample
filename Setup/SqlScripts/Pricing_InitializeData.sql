begin try
    declare @initialTranCount int = @@TRANCOUNT
    if @initialTranCount = 0 begin transaction

    insert into PriceType (PriceTypeId, PriceTypeName) values (0, 'Default Price')
    insert into PriceType (PriceTypeId, PriceTypeName) values (1, 'Specific Customer')
    insert into PriceType (PriceTypeId, PriceTypeName) values (2, 'Customer Price Group')
    
    if @initialTranCount = 0 commit transaction
end try
begin catch
    declare @msg nvarchar(4000), @severity int, @state int
    select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()    
    if @initialTranCount = 0 rollback transaction    
    raiserror(@msg, @severity, @state)
end catch
go


--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 6;
Set @Minor = 0;
Set @Patch = 0;

WHILE (@Patch <= 1) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (select 1 from SchemaVersion_PricingSystem where Major=@Major and Minor=@Minor and Patch=@Patch)
		insert into SchemaVersion_PricingSystem (Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GETDATE())
	set @Patch = @Patch + 1
END
GO
