if OBJECT_ID('[dbo].[ecf_Pricing_GetPrices]', 'P') is not null drop procedure [dbo].[ecf_Pricing_GetPrices]
if OBJECT_ID('[dbo].[ecf_Pricing_GetCatalogEntryPrices]', 'P') is not null drop procedure [dbo].[ecf_Pricing_GetCatalogEntryPrices]
if OBJECT_ID('[dbo].[ecf_Pricing_SetCatalogEntryPrices]', 'P') is not null drop procedure [dbo].[ecf_Pricing_SetCatalogEntryPrices]
if OBJECT_ID('[dbo].[ecf_Pricing_EnsurePriceTypes]', 'P') is not null drop procedure [dbo].[ecf_Pricing_EnsurePriceTypes]
if OBJECT_ID('[dbo].[ecf_PriceDetail_Get]', 'P') is not null drop procedure [dbo].[ecf_PriceDetail_Get]
if OBJECT_ID('[dbo].[ecf_PriceDetail_List]', 'P') is not null drop procedure [dbo].[ecf_PriceDetail_List]
if TYPE_ID('[dbo].[udttCatalogKey]') is not null drop type [dbo].[udttCatalogKey]
if TYPE_ID('[dbo].[udttCatalogKeyAndQuantity]') is not null drop type [dbo].[udttCatalogKeyAndQuantity]
if TYPE_ID('[dbo].[udttCustomerPricing]') is not null drop type [dbo].[udttCustomerPricing]
if TYPE_ID('[dbo].[udttCatalogEntryPrice]') is not null drop type [dbo].[udttCatalogEntryPrice]
if TYPE_ID('[dbo].[udttPriceType]') is not null drop type [dbo].[udttPriceType]
if TYPE_ID('[dbo].[udttPriceDetail]') is not null drop type [dbo].[udttPriceDetail]
go

create type [dbo].udttCatalogKey as table
(
    ApplicationId uniqueidentifier not null,
    CatalogEntryCode nvarchar(100) not null
)
go

create type [dbo].udttCatalogKeyAndQuantity as table
(
    ApplicationId uniqueidentifier not null,
    CatalogEntryCode nvarchar(100) not null,
    Quantity decimal(38,9) not null
)
go

create type [dbo].udttCustomerPricing as table
(
    PriceTypeId int not null,
    PriceCode nvarchar(256) not null
)
go

create type [dbo].udttCatalogEntryPrice as table
(
    ApplicationId uniqueidentifier not null,
    CatalogEntryCode nvarchar(100) not null,
    MarketId nvarchar(8) not null,
    CurrencyCode nvarchar(8) not null,
    PriceTypeId int not null,
    PriceCode nvarchar(256) not null,
    ValidFrom datetime not null,
    ValidUntil datetime null,
    MinQuantity decimal(38,9) not null,
    MaxQuantity decimal(38,9) null,
    UnitPrice money not null
)
go

CREATE TYPE [dbo].[udttPriceType] AS TABLE(
    [PriceTypeId] [int] NOT NULL,
    [PriceTypeName] [nvarchar](256) NOT NULL
)
go

create type [dbo].[udttPriceDetail] as table (
    PriceValueId bigint not null,
    ApplicationId uniqueidentifier,
    CatalogEntryCode nvarchar(100),
    MarketId nvarchar(8),
    CurrencyCode nvarchar(8),
    PriceTypeId int,
    PriceCode nvarchar(256),
    ValidFrom datetime,
    ValidUntil datetime,
    MinQuantity decimal(38,9),
    UnitPrice money
)
go

create procedure dbo.ecf_Pricing_GetPrices
    @MarketId nvarchar(8),
    @ValidOn datetime,
    @CatalogKeysAndQuantities udttCatalogKeyAndQuantity readonly,
    @CurrencyCodes udttCurrencyCode readonly,
    @CustomerPricing udttCustomerPricing readonly,
    @ReturnCustomerPricing bit = 0,
    @ReturnQuantities bit = 0
as
begin
    declare @filterCurrencies bit = case when exists (select 1 from @CurrencyCodes) then 1 else 0 end
    declare @filterCustomerPricing bit = case when exists (select 1 from @CustomerPricing) then 1 else 0 end

    select
        pg.ApplicationId,
        pg.CatalogEntryCode,
        pg.MarketId,
        pg.CurrencyCode,
        case when @ReturnCustomerPricing = 1 then pg.PriceTypeId else null end as PriceTypeId,
        case when @ReturnCustomerPricing = 1 then pg.PriceCode else null end as PriceCode,
        pv.ValidFrom,
        pv.ValidUntil,
        pv.MinQuantity,
        min(pv.UnitPrice) as UnitPrice
    from @CatalogKeysAndQuantities ckaq
    join PriceGroup pg on ckaq.ApplicationId = pg.ApplicationId and ckaq.CatalogEntryCode = pg.CatalogEntryCode
    join PriceValue pv on pg.PriceGroupId = pv.PriceGroupId
    where
		(@MarketId = '' or pg.MarketId = @MarketId)
        and (@filterCurrencies = 0 or pg.CurrencyCode in (select CurrencyCode from @CurrencyCodes))
        and (@filterCustomerPricing = 0 or exists (select 1 from @CustomerPricing cp where cp.PriceTypeId = pg.PriceTypeId and cp.PriceCode = pg.PriceCode))
        and pv.ValidFrom <= @ValidOn
        and (pv.ValidUntil is null or @ValidOn < pv.ValidUntil)
        and (@ReturnQuantities = 1 or (pv.MinQuantity <= ckaq.Quantity and ckaq.Quantity < ISNULL(pv.MaxQuantity, ckaq.Quantity+1)))
    group by pg.ApplicationId, pg.CatalogEntryCode, pg.MarketId, pg.CurrencyCode,
        case when @ReturnCustomerPricing = 1 then pg.PriceTypeId else null end,
        case when @ReturnCustomerPricing = 1 then pg.PriceCode else null end,
        pv.ValidFrom, pv.ValidUntil, pv.MinQuantity
end
go


create procedure dbo.ecf_Pricing_GetCatalogEntryPrices
    @CatalogKeys udttCatalogKey readonly
as
begin
    select pg.ApplicationId, pg.CatalogEntryCode, pg.MarketId, pg.CurrencyCode, pg.PriceTypeId, pg.PriceCode, pv.ValidFrom, pv.ValidUntil, pv.MinQuantity, pv.UnitPrice
    from @CatalogKeys ck
    join PriceGroup pg on ck.ApplicationId = pg.ApplicationId and ck.CatalogEntryCode = pg.CatalogEntryCode
    join PriceValue pv on pg.PriceGroupId = pv.PriceGroupId
end
go


create procedure dbo.ecf_Pricing_SetCatalogEntryPrices
    @CatalogKeys udttCatalogKey readonly,
    @PriceValues udttCatalogEntryPrice readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction

        delete pv
        from @CatalogKeys ck
        join dbo.PriceGroup pg on ck.ApplicationId = pg.ApplicationId and ck.CatalogEntryCode = pg.CatalogEntryCode
        join dbo.PriceValue pv on pg.PriceGroupId = pv.PriceGroupId

        merge into dbo.PriceGroup tgt
        using (select distinct ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode from @PriceValues) src
        on (    tgt.ApplicationId = src.ApplicationId
            and tgt.CatalogEntryCode = src.CatalogEntryCode
            and tgt.MarketId = src.MarketId
            and tgt.CurrencyCode = src.CurrencyCode
            and tgt.PriceTypeId = src.PriceTypeId
            and tgt.PriceCode = src.PriceCode)
        when matched then update set Modified = GETUTCDATE()
        when not matched then insert (Created, Modified, ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode)
            values (GETUTCDATE(), GETUTCDATE(), src.ApplicationId, src.CatalogEntryCode, src.MarketId, src.CurrencyCode, src.PriceTypeId, src.PriceCode);

        insert into dbo.PriceValue (PriceGroupId, ValidFrom, ValidUntil, MinQuantity, MaxQuantity, UnitPrice)
        select pg.PriceGroupId, src.ValidFrom, src.ValidUntil, src.MinQuantity, src.MaxQuantity, src.UnitPrice
        from @PriceValues src
        left outer join PriceGroup pg
            on  src.ApplicationId = pg.ApplicationId
            and src.CatalogEntryCode = pg.CatalogEntryCode
            and src.MarketId = pg.MarketId
            and src.CurrencyCode = pg.CurrencyCode
            and src.PriceTypeId = pg.PriceTypeId
            and src.PriceCode = pg.PriceCode

        delete tgt
        from dbo.PriceGroup tgt
        join @CatalogKeys ck on tgt.ApplicationId = ck.ApplicationId and tgt.CatalogEntryCode = ck.CatalogEntryCode
        where not exists (select 1 from dbo.PriceValue pv where pv.PriceGroupId = tgt.PriceGroupId)

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


create procedure [dbo].[ecf_Pricing_EnsurePriceTypes]
    @PriceTypes udttPriceType readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction

        merge into dbo.PriceType tpt
        using (select distinct [PriceTypeId], [PriceTypeName] from @PriceTypes) src
        on (    tpt.PriceTypeId = src.PriceTypeId)
        when matched then update set tpt.PriceTypeName = src.PriceTypeName
        when not matched then insert ([PriceTypeId], [PriceTypeName])
            values (src.[PriceTypeId], src.[PriceTypeName]);

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


create procedure [dbo].[ecf_PriceDetail_Get]
    @priceValueId bigint
as
begin
    select
        pd.PriceValueId,
        pd.Created,
        pd.Modified,
        pd.ApplicationId,
        pd.CatalogEntryCode,
        pd.MarketId,
        pd.CurrencyCode,
        pd.PriceTypeId,
        pd.PriceCode,
        pd.ValidFrom,
        pd.ValidUntil,
        pd.MinQuantity,
        pd.UnitPrice
    from PriceDetail pd
    where pd.PriceValueId = @priceValueId
end
go


create procedure [dbo].[ecf_PriceDetail_List]
    @catalogEntryId int = null,
    @catalogNodeId int = null,
    @MarketId nvarchar(8),
    @CurrencyCodes udttCurrencyCode readonly,
    @CustomerPricing udttCustomerPricing readonly,
    @totalCount int output,
    @pagingOffset int = null,
    @pagingCount int = null
as
begin
    declare @filterCurrencies bit = case when exists (select 1 from @CurrencyCodes) then 1 else 0 end
    declare @filterCustomerPricing bit = case when exists (select 1 from @CustomerPricing) then 1 else 0 end
    if (@pagingOffset is null and @pagingCount is null)
    begin
        set @totalCount = -1

        ;with specified_entries as (
            select @catalogEntryId as CatalogEntryId
            where @catalogEntryId is not null
            union
            select CatalogEntryId
            from NodeEntryRelation
            where CatalogNodeId = @catalogNodeId
        ),
        returned_entries as (
            select ce.CatalogEntryId, ce.ApplicationId, ce.Code
            from specified_entries se
            join CatalogEntry ce on se.CatalogEntryId = ce.CatalogEntryId
            union all
            select ce.CatalogEntryId, ce.ApplicationId, ce.Code
            from specified_entries se
            join CatalogEntryRelation cer
                on se.CatalogEntryId = cer.ParentEntryId
                and cer.RelationTypeId in ('ProductVariation')
            join CatalogEntry ce on cer.ChildEntryId = ce.CatalogEntryId
        )
        select
            pd.PriceValueId,
            pd.Created,
            pd.Modified,
            pd.ApplicationId,
            pd.CatalogEntryCode,
            pd.MarketId,
            pd.CurrencyCode,
            pd.PriceTypeId,
            pd.PriceCode,
            pd.ValidFrom,
            pd.ValidUntil,
            pd.MinQuantity,
            pd.UnitPrice
        from PriceDetail pd
        where exists (select 1 from returned_entries re where pd.ApplicationId = re.ApplicationId and pd.CatalogEntryCode = re.Code)
        and (@MarketId = '' or pd.MarketId = @MarketId)
        and (@filterCurrencies = 0 or pd.CurrencyCode in (select CurrencyCode from @CurrencyCodes))
        and (@filterCustomerPricing = 0 or exists (select 1 from @CustomerPricing cp where cp.PriceTypeId = pd.PriceTypeId and cp.PriceCode = pd.PriceCode))
        order by CatalogEntryCode, ApplicationId
    end
    else
    begin
        declare @ordered_results table (
            ordering int not null,
            PriceValueId bigint not null,
            Created datetime not null,
            Modified datetime not null,
            ApplicationId uniqueidentifier not null,
            CatalogEntryCode nvarchar(100) not null,
            MarketId nvarchar(8) not null,
            CurrencyCode nvarchar(8) not null,
            PriceTypeId int not null,
            PriceCode nvarchar(256) not null,
            ValidFrom datetime not null,
            ValidUntil datetime null,
            MinQuantity decimal(38,9) not null,
            UnitPrice money not null
        )

        ;with specified_entries as (
            select @catalogEntryId as CatalogEntryId
            where @catalogEntryId is not null
            union
            select CatalogEntryId
            from NodeEntryRelation
            where CatalogNodeId = @catalogNodeId
        ),
        returned_entries as (
            select ce.CatalogEntryId, ce.ApplicationId, ce.Code
            from specified_entries se
            join CatalogEntry ce on se.CatalogEntryId = ce.CatalogEntryId
            union all
            select ce.CatalogEntryId, ce.ApplicationId, ce.Code
            from specified_entries se
            join CatalogEntryRelation cer
                on se.CatalogEntryId = cer.ParentEntryId
                and cer.RelationTypeId in ('ProductVariation')
            join CatalogEntry ce on cer.ChildEntryId = ce.CatalogEntryId
        )
        insert into @ordered_results (
            ordering,
            PriceValueId,
            Created,
            Modified,
            ApplicationId,
            CatalogEntryCode,
            MarketId,
            CurrencyCode,
            PriceTypeId,
            PriceCode,
            ValidFrom,
            ValidUntil,
            MinQuantity,
            UnitPrice
        )
        select
            --we order by price code, market id and currency code to make the similar prices near each others.
            ROW_NUMBER() over (ORDER BY pd.CatalogEntryCode, pd.ApplicationId, pd.PriceCode, pd.MarketId, pd.CurrencyCode) - 1, -- arguments are zero-based.
            pd.PriceValueId,
            pd.Created,
            pd.Modified,
            pd.ApplicationId,
            pd.CatalogEntryCode,
            pd.MarketId,
            pd.CurrencyCode,
            pd.PriceTypeId,
            pd.PriceCode,
            pd.ValidFrom,
            pd.ValidUntil,
            pd.MinQuantity,
            pd.UnitPrice
        from PriceDetail pd
        where exists (select 1 from returned_entries re where pd.ApplicationId = re.ApplicationId and pd.CatalogEntryCode = re.Code)
        and (@MarketId = '' or pd.MarketId = @MarketId)
        and (@filterCurrencies = 0 or pd.CurrencyCode in (select CurrencyCode from @CurrencyCodes))
        and (@filterCustomerPricing = 0 or exists (select 1 from @CustomerPricing cp where cp.PriceTypeId = pd.PriceTypeId and cp.PriceCode = pd.PriceCode))
        select @totalCount = count(*) from @ordered_results

        select
            PriceValueId,
            Created,
            Modified,
            ApplicationId,
            CatalogEntryCode,
            MarketId,
            CurrencyCode,
            PriceTypeId,
            PriceCode,
            ValidFrom,
            ValidUntil,
            MinQuantity,
            UnitPrice
        from @ordered_results
        where @pagingOffset <= ordering and ordering < (@pagingOffset + @pagingCount)
        order by ordering
    end
end
go


create procedure [dbo].[ecf_PriceDetail_Save]
    @priceValues udttPriceDetail readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction

        declare @results table (PriceValueId bigint)
        declare @affectedEntries table (ApplicationId uniqueidentifier, CatalogEntryCode nvarchar(100))

        insert into @affectedEntries (ApplicationId, CatalogEntryCode)
        select distinct ApplicationId, CatalogEntryCode
        from dbo.PriceDetail
        where PriceValueId in (select PriceValueId from @priceValues where ApplicationId is null)

        delete from dbo.PriceDetail
        where PriceValueId in (select PriceValueId from @priceValues where ApplicationId is null)
                
        insert into @results (PriceValueId)
        select dst.PriceValueId
        from dbo.PriceDetail dst
        join @priceValues src on dst.PriceValueId = src.PriceValueId
        where src.PriceValueId > 0

        ;with update_effects as (
            select 
                dst.ApplicationId as ApplicationIdBefore, 
                dst.CatalogEntryCode as CatalogEntryCodeBefore,
                src.ApplicationId as ApplicationIdAfter,
                src.CatalogEntryCode as CatalogEntryCodeAfter
            from dbo.PriceDetail dst
            join @priceValues src on dst.PriceValueId = src.PriceValueId
        )
        insert into @affectedEntries (ApplicationId, CatalogEntryCode)
        select ApplicationIdBefore, CatalogEntryCodeBefore from update_effects
        union
        select ApplicationIdAfter, CatalogEntryCodeAfter from update_effects

        update dst
        set
            Modified = GETUTCDATE(),
            ApplicationId = src.ApplicationId, 
            CatalogEntryCode = src.CatalogEntryCode,
            MarketId = src.MarketId,
            CurrencyCode = src.CurrencyCode,
            PriceTypeId = src.PriceTypeId,
            PriceCode = src.PriceCode,
            ValidFrom = src.ValidFrom,
            ValidUntil = src.ValidUntil,
            MinQuantity = src.MinQuantity,
            UnitPrice = src.UnitPrice
        from dbo.PriceDetail dst
        join @priceValues src on dst.PriceValueId = src.PriceValueId
        where src.PriceValueId > 0

        declare @applicationId uniqueidentifier
        declare @catalogEntryCode nvarchar(100)
        declare @marketId nvarchar(8)
        declare @currencyCode nvarchar(8)
        declare @priceTypeId int
        declare @priceCode nvarchar(256)
        declare @validFrom datetime
        declare @validUntil datetime
        declare @minQuantity decimal(38,9)
        declare @unitPrice money
        declare inserted_prices cursor local for
            select ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode, ValidFrom, ValidUntil, MinQuantity, UnitPrice
            from @priceValues
            where PriceValueId <= 0
        open inserted_prices
        while 1=1
        begin
            fetch next from inserted_prices into @applicationId, @catalogEntryCode, @marketId, @currencyCode, @priceTypeId, @priceCode, @validFrom, @validUntil, @minQuantity, @unitPrice
            if @@FETCH_STATUS != 0 break

            insert into dbo.PriceDetail (Created, Modified, ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode, ValidFrom, ValidUntil, MinQuantity, UnitPrice)
            values (GETUTCDATE(), GETUTCDATE(), @applicationId, @catalogEntryCode, @marketId, @currencyCode, @priceTypeId, @priceCode, @validFrom, @validUntil, @minQuantity, @unitPrice)

            insert into @results (PriceValueId) 
            values (SCOPE_IDENTITY())

            insert into @affectedEntries (ApplicationId, CatalogEntryCode)
            values (@applicationId, @catalogEntryCode)
        end
        close inserted_prices

        select 
            PriceValueId,
            Created,
            Modified,
            ApplicationId,
            CatalogEntryCode,
            MarketId,
            CurrencyCode,
            PriceTypeId,
            PriceCode,
            ValidFrom,
            ValidUntil,
            MinQuantity,
            UnitPrice
        from PriceDetail
        where PriceValueId in (select PriceValueId from @results)

        select
            pd.PriceValueId,
            pd.Created,
            pd.Modified,
            ae.ApplicationId,
            ae.CatalogEntryCode,
            pd.MarketId,
            pd.CurrencyCode,
            pd.PriceTypeId,
            pd.PriceCode,
            pd.ValidFrom,
            pd.ValidUntil,
            pd.MinQuantity,
            pd.UnitPrice
        from (select distinct ApplicationId, CatalogEntryCode from @affectedEntries) ae
        left outer join PriceDetail pd on ae.ApplicationId = pd.ApplicationId and ae.CatalogEntryCode = pd.CatalogEntryCode

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


create procedure [dbo].[ecf_PriceDetail_ReplacePrices]
    @CatalogKeys udttCatalogKey readonly,
    @PriceValues udttCatalogEntryPrice readonly
as
begin
    begin try
        declare @initialTranCount int = @@TRANCOUNT
        if @initialTranCount = 0 begin transaction
    
        delete from PriceDetail
        where exists (select 1 from @CatalogKeys ck where ck.ApplicationId = PriceDetail.ApplicationId and ck.CatalogEntryCode = PriceDetail.CatalogEntryCode)
     
        insert into PriceDetail (Created, Modified, ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode, ValidFrom, ValidUntil, MinQuantity, UnitPrice)
        select GETUTCDATE(), GETUTCDATE(), ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode, ValidFrom, ValidUntil, MinQuantity, UnitPrice
        from @PriceValues
                
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
    