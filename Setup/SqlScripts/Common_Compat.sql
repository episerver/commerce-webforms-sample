if exists (select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'FK_CurrencyRate_Currency') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint FK_CurrencyRate_Currency'
if exists (select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'FK_CurrencyRate_Currency1') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint FK_CurrencyRate_Currency1'
if exists (select 1 from INFORMATION_SCHEMA.CHECK_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'CK_CurrencyRate_NoSelfRate') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint CK_CurrencyRate_NoSelfRate'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency') exec sp_executesql N'drop procedure dbo.ecf_Currency'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_Code') exec sp_executesql N'drop procedure dbo.ecf_Currency_Code'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_CurrencyId') exec sp_executesql N'drop procedure dbo.ecf_Currency_CurrencyId'
if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Currency_Modify') exec sp_executesql N'drop procedure dbo.ecf_Currency_Modify'
if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCompatCurrency') exec dbo.sp_executesql N'drop type dbo.udttCompatCurrency'
if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCompatCurrencyRate') exec dbo.sp_executesql N'drop type dbo.udttCompatCurrencyRate'
go

create type dbo.udttCompatCurrency as table (
    Operation char(1),
    CurrencyId int,
    CurrencyCode nvarchar(8),
    Name nvarchar(50),
    ModifiedDate datetime,
    ApplicationId uniqueidentifier
)
go

create type dbo.udttCompatCurrencyRate as table (
    Operation char(1),
    CurrencyRateId int,
    AverageRate float,
    EndOfDayRate float,
    ModifiedDate datetime,
    FromCurrencyId int,
    ToCurrencyId int,
    CurrencyRateDate datetime
)
go

alter table CurrencyRate add constraint FK_CurrencyRate_Currency foreign key (FromCurrencyId) references Currency (CompatCurrencyId)
go

alter table CurrencyRate add constraint FK_CurrencyRate_Currency1 foreign key (ToCurrencyId) references Currency (CompatCurrencyId)
go

alter table CurrencyRate add constraint CK_CurrencyRate_NoSelfRate check (FromCurrencyId != ToCurrencyId)
go

create procedure dbo.ecf_Currency
    @ApplicationId uniqueidentifier
as
begin
    select
        CompatCurrencyId as CurrencyId,
        CurrencyCode,
        CurrencyName as Name,
        Modified as ModifiedDate,
        CompatApplicationId as ApplicationId
    from Currency
    where CompatApplicationId = @ApplicationId
    
    select
        cr.CurrencyRateId,
        cr.AverageRate,
        cr.EndOfDayRate,
        cr.ModifiedDate,
        cr.FromCurrencyId,
        cr.ToCurrencyId,
        cr.CurrencyRateDate
    from CurrencyRate cr
    where exists (select 1 from Currency c where c.CompatCurrencyId = cr.FromCurrencyId and c.CompatApplicationId = @ApplicationId)
      and exists (select 1 from Currency c where c.CompatCurrencyId = cr.ToCurrencyId and c.CompatApplicationId = @ApplicationId)
end
go

create procedure dbo.ecf_Currency_Code
    @ApplicationId uniqueidentifier,
    @CurrencyCode nvarchar(8)
as
begin
    select
        CompatCurrencyId as CurrencyId,
        CurrencyCode,
        CurrencyName as Name,
        Modified as ModifiedDate,
        CompatApplicationId as ApplicationId
    from dbo.Currency
    where CompatApplicationId = @ApplicationId
      and CurrencyCode = @CurrencyCode

    select
        cr.CurrencyRateId,
        cr.AverageRate,
        cr.EndOfDayRate,
        cr.ModifiedDate,
        cr.FromCurrencyId,
        cr.ToCurrencyId,
        cr.CurrencyRateDate
    from dbo.CurrencyRate cr    
    where exists (select 1 from dbo.Currency c where c.CompatCurrencyId = cr.FromCurrencyId and c.CompatApplicationId = @ApplicationId and c.CurrencyCode = @CurrencyCode)
       or exists (select 1 from dbo.Currency c where c.CompatCurrencyId = cr.ToCurrencyId and c.CompatApplicationId = @ApplicationId and c.CurrencyCode = @CurrencyCode)
end
go

create procedure dbo.ecf_Currency_CurrencyId
    @ApplicationId uniqueidentifier,
    @CurrencyId int
as
begin
    select
        CompatCurrencyId as CurrencyId,
        CurrencyCode,
        CurrencyName as Name,
        Modified as ModifiedDate,
        CompatApplicationId as ApplicationId
    from dbo.Currency
    where CompatApplicationId = @ApplicationId
      and CompatCurrencyId = @CurrencyId

    select
        cr.CurrencyRateId,
        cr.AverageRate,
        cr.EndOfDayRate,
        cr.ModifiedDate,
        cr.FromCurrencyId,
        cr.ToCurrencyId,
        cr.CurrencyRateDate
    from dbo.CurrencyRate cr        
    where (FromCurrencyId = @CurrencyId or ToCurrencyId = @CurrencyId)
      and exists (select 1 from dbo.Currency c where c.CompatCurrencyId = @CurrencyId and c.CompatApplicationId = @ApplicationId)
end
go

create procedure dbo.ecf_Currency_Modify
    @Currency udttCompatCurrency readonly,
    @CurrencyRate udttCompatCurrencyRate readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction
        
        declare @identitymap table (Placeholder int, Actual int)

        delete from CurrencyRate
        where CurrencyRateId in (select CurrencyRateId from @CurrencyRate where Operation = 'D')

        delete from Currency
        where CompatCurrencyId in (select CurrencyId from @Currency where Operation = 'D')

        update tgt
        set
            Modified = isnull(src.ModifiedDate, GETUTCDATE()),
            CurrencyName = src.Name,
            CompatApplicationId = src.ApplicationId
        from @Currency src
        join Currency tgt on src.CurrencyId = tgt.CompatCurrencyId
        where src.Operation = 'U'

        insert into Currency (CurrencyCode, Created, Modified, CurrencyName, CompatApplicationId)
        select CurrencyCode, isnull(ModifiedDate, GETUTCDATE()), isnull(ModifiedDate, GETUTCDATE()), Name, ApplicationId
        from @Currency
        where Operation = 'I'

        if (@@rowcount > 0)
        begin
            insert into @identitymap (Placeholder, Actual)
            select src.CurrencyId, tgt.CompatCurrencyId
            from @Currency src
            join Currency tgt on src.CurrencyCode = tgt.CurrencyCode
            where Operation = 'I'
        end

        update tgt
        set
            AverageRate = src.AverageRate,
            EndOfDayRate = src.EndOfDayRate,
            ModifiedDate = isnull(src.ModifiedDate, GETUTCDATE()),
            FromCurrencyId = isnull(fromId.Actual, src.FromCurrencyId),
            ToCurrencyId = isnull(toId.Actual, src.ToCurrencyId),
            CurrencyRateDate = src.CurrencyRateDate
        from @CurrencyRate src
        left outer join @identitymap fromId on src.FromCurrencyId = fromId.Placeholder
        left outer join @identitymap toId on src.ToCurrencyId = toId.Placeholder
        join CurrencyRate tgt on src.CurrencyRateId = tgt.CurrencyRateId
        where src.Operation = 'U'

        insert into CurrencyRate (AverageRate, EndOfDayRate, ModifiedDate, FromCurrencyId, ToCurrencyId, CurrencyRateDate)
        select
            src.AverageRate,
            src.EndOfDayRate, 
            isnull(src.ModifiedDate, GETUTCDATE()),
            isnull(fromId.Actual, src.FromCurrencyId), 
            isnull(toId.Actual, src.ToCurrencyId), 
            src.CurrencyRateDate
        from @CurrencyRate src
        left outer join @identitymap fromId on src.FromCurrencyId = fromId.Placeholder
        left outer join @identitymap toId on src.ToCurrencyId = toId.Placeholder
        where src.Operation = 'I'

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
