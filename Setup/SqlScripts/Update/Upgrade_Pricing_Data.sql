-- if 1, SalePrice values are imported
declare @UseSalePrice bit = 1
-- if 1, Variation list price values are imported
declare @UseVariations bit = 1
-- if not null, overrides the DefaultCurrency values in CommonSettings for Variation list prices.
declare @VariationCurrency nvarchar(8) = null
-- used as the market for all imported prices
declare @MarketId nvarchar(8) = 'DEFAULT' 
-- the number of date range/quantity range matrices to optimize at once.
declare @BatchSize int = 100 
    
set nocount on

begin try
    begin transaction

    if exists(select 1 from Price) raiserror('Please remove all data from the Price table before importing.', 18, 0);

    set ansi_warnings off
    if (@VariationCurrency is null and @UseVariations = 1 and exists (
        select 1
        from (  select distinct ce.ApplicationId, sp.Currency
                from SalePrice sp
                join CatalogEntry ce on sp.ItemCode = ce.Code) app_currencies
        join Application app on app_currencies.ApplicationId = app.ApplicationId
        left outer join CommonSettings cs
            on cs.Name = 'DefaultCurrency'
            and app_currencies.ApplicationId = cs.ApplicationId
            and app_currencies.Currency = cs.Value
        group by app_currencies.ApplicationId
        having COUNT(cs.Value) = 0))
    begin
        print 'The default currency does not appear to be correctly configured.'
        print 'Either set @VariationCurrency to override the default currency'
        print 'for variation prices, or set @UseVariations to 0 to exclude them.'

        raiserror('The default currency appears to be improperly set.', 18, 0)
    end
    set ansi_warnings on
    
    declare @datetimemin datetime = '1753-01-01 00:00:00.000'
    declare @datetimemax datetime = '9999-12-31 23:59:59.997'
    declare @decimalmax decimal(38,9) = 99999999999999999999999999999.999999999

    declare @batches table
    (
        BatchId int not null,
        CatalogEntryCode nvarchar(100) not null
    )

    declare @price_values table
    (
        MarketId nvarchar(8) not null,
        ApplicationId uniqueidentifier not null,
        CatalogEntryCode nvarchar(100) not null,
        CurrencyCode nvarchar(8) not null,
        ValidFrom datetime not null,
        ValidUntil datetime not null, 
        MinQuantity decimal(38,9) not null,
        PriceTypeId int not null,
        PriceCode nvarchar(256) not null,
        SelectorId int not null,
        UnitPrice money not null
    )

    declare @values table 
    (
        SelectorId int not null,
        ValidFrom datetime not null, 
        ValidUntil datetime null, 
        MinQuantity decimal(38,9) not null, 
        MaxQuantity decimal(38,9) null, 
        UnitPrice money null
    )

    declare @mergeops table
    (
        SelectorId int not null,
        ValidFrom datetime not null,
        MinQuantity decimal(38,9) not null,
        NewValidUntil datetime null,
        NewMaxQuantity decimal(38,9) null        
    )

    insert into @batches (BatchId, CatalogEntryCode)
    select (ROW_NUMBER() over (order by CatalogEntryCode) - 1) / @batchSize as BatchId, CatalogEntryCode
    from (
        select ItemCode as CatalogEntryCode
        from SalePrice
        where @UseSalePrice = 1
        union
        select ce.Code
        from Variation v
        join CatalogEntry ce on v.CatalogEntryId = ce.CatalogEntryId
        where @UseVariations = 1 and ListPrice is not null
    ) q

    declare @batchId int
    declare batchCursor cursor local for 
        select distinct BatchId from @batches order by BatchId
    open batchCursor
    while 1=1
    begin
        fetch next from batchCursor into @batchId
        if @@FETCH_STATUS != 0 break
        
        delete from @price_values
        delete from @values
        
        insert into @price_values (MarketId, ApplicationId, CatalogEntryCode, CurrencyCode, ValidFrom, ValidUntil, MinQuantity, PriceTypeId, PriceCode, SelectorId, UnitPrice)
        select
            @MarketId,
            ce.ApplicationId,
            sp.ItemCode as CatalogEntryCode,
            cast(sp.Currency as nvarchar(8)) as CurrencyCode,
            sp.StartDate as ValidFrom,
            isnull(sp.EndDate, @datetimemax) as ValidUntil,
            cast(sp.MinQuantity as decimal(38,9)) as MinQuantity,
            sp.SaleType as PriceTypeId,
            cast(sp.SaleCode as nvarchar(256)) as PriceCode,
            -1,
            sp.UnitPrice
        from SalePrice sp
        join CatalogEntry ce on sp.ItemCode = ce.Code
        join @batches b on sp.ItemCode = b.CatalogEntryCode
        where @UseSalePrice = 1 and b.BatchId = @batchId
        union all
        select
            @MarketId,
            ce.ApplicationId,
            ce.Code as CatalogEntryCode,
            isnull(@VariationCurrency, default_currency.Value),
            @datetimemin as ValidFrom,
            @datetimemax as ValidUntil,
            isnull(cast(v.MinQuantity as decimal(38,9)), 0) as MinQuantity,
            0 as PriceTypeId,
            '' as PriceCode,
            -1,
            v.ListPrice as UnitPrice
        from Variation v
        join CatalogEntry ce on v.CatalogEntryId = ce.CatalogEntryId
        join @batches b on ce.Code = b.CatalogEntryCode
        left outer join CommonSettings default_currency
            on ce.ApplicationId = default_currency.ApplicationId
            and default_currency.Name = 'DefaultCurrency'
        where @UseSalePrice = 1 and v.ListPrice is not null and b.BatchId = @batchId

        update tgt
        set SelectorId = src.SelectorId
        from @price_values tgt
        join (  select 
                    MarketId,
                    ApplicationId,
                    CatalogEntryCode,
                    CurrencyCode,
                    PriceTypeId,
                    PriceCode,
                    ROW_NUMBER() over (order by MarketId, ApplicationId, CatalogEntryCode, CurrencyCode, PriceTypeId, PriceCode) as SelectorId
                from (select distinct MarketId, ApplicationId, CatalogEntryCode, CurrencyCode, PriceTypeId, PriceCode from @price_values) q
            ) src
            on tgt.MarketId = src.MarketId 
            and tgt.ApplicationId = src.ApplicationId 
            and tgt.CatalogEntryCode = src.CatalogEntryCode 
            and tgt.CurrencyCode = src.CurrencyCode 
            and tgt.PriceTypeId = src.PriceTypeId 
            and tgt.PriceCode = src.PriceCode
        
        -- break the current price values matching the parameter into a full date-by-quantity matrix, with values for every configured price.
        ;with date_endpoints as 
        (
            select
                SelectorId,
                ROW_NUMBER() over (partition by SelectorId order by DateEndpoint) as ROWID,
                DateEndpoint
            from (
                select SelectorId, ValidFrom as DateEndpoint from @price_values
                union select SelectorId, ValidUntil as DateEndpoint from @price_values) q
        ),
        quantity_endpoints as (
            select
                SelectorId,
                ROW_NUMBER() over (partition by SelectorId order by QuantityEndpoint) as ROWID,
                QuantityEndpoint
            from (
                select SelectorId, MinQuantity as QuantityEndpoint from @price_values
                union select SelectorId, @decimalmax as QuantityEndpoint from @price_values) q
        ),
        date_ranges as (
            select lo.SelectorId, lo.DateEndpoint as ValidFrom, hi.DateEndpoint as ValidUntil
            from date_endpoints lo
            join date_endpoints hi on lo.SelectorId = hi.SelectorId and lo.ROWID + 1 = hi.ROWID
        ),
        quantity_ranges as (
            select lo.SelectorId, lo.QuantityEndpoint as MinQuantity, hi.QuantityEndpoint as MaxQuantity
            from quantity_endpoints lo
            join quantity_endpoints hi on lo.SelectorId = hi.SelectorId and lo.ROWID + 1 = hi.ROWID
        )
        insert into @values (SelectorId, ValidFrom, ValidUntil, MinQuantity, MaxQuantity, UnitPrice)
        select d.SelectorId, d.ValidFrom, d.ValidUntil, q.MinQuantity, q.MaxQuantity, MIN(p.UnitPrice)
        from date_ranges d
        join quantity_ranges q on d.SelectorId = q.SelectorId
        join @price_values p on p.SelectorId = d.SelectorId
            and p.ValidFrom <= d.ValidFrom and d.ValidUntil <= p.ValidUntil
            and p.MinQuantity <= q.MinQuantity
        group by d.SelectorId, d.ValidFrom, d.ValidUntil, q.MinQuantity, q.MaxQuantity


        -- optimize
        while 1=1
        begin
            delete from @mergeops
            
            -- find groups of cells that all have the same date ranges and prices, and neighboring quantity ranges.
            ;with quantity_groups as (
                select
                    less.SelectorId,
                    MIN(less.MinQuantity) as GroupMinQuantity,
                    less.ValidFrom,
                    less.ValidUntil,
                    less.UnitPrice,
                    MIN(less.MinQuantity) as CellMinQuantity,
                    MIN(less.MaxQuantity) as CellMaxQuantity
                from @values less
                where exists (select 1
                    from @values more
                    where less.SelectorId = more.SelectorId
                        and less.ValidFrom = more.ValidFrom
                        and less.ValidUntil = more.ValidUntil
                        and less.UnitPrice = more.UnitPrice
                        and less.MaxQuantity = more.MinQuantity)
                group by less.SelectorId, less.ValidFrom, less.ValidUntil, less.UnitPrice
                union all
                select
                    cte.SelectorId,
                    cte.GroupMinQuantity,
                    cte.ValidFrom,
                    cte.ValidUntil,
                    cte.UnitPrice,
                    more.MinQuantity as CellMinQuantity,
                    more.MaxQuantity as CellMaxQuantity
                from quantity_groups cte
                join @values more
                    on cte.SelectorId = more.SelectorId
                    and cte.ValidFrom = more.ValidFrom
                    and cte.ValidUntil = more.ValidUntil
                    and cte.UnitPrice = more.UnitPrice
                    and cte.CellMaxQuantity = more.MinQuantity
            )
            insert into @mergeops (SelectorId, ValidFrom, MinQuantity, NewMaxQuantity)
            select
                SelectorId,
                ValidFrom,
                CellMinQuantity,
                case when CellMinQuantity = GroupMinQuantity
                    then MAX(CellMaxQuantity) over (partition by SelectorId, ValidFrom, GroupMinQuantity)
                    else null end as NewValidUntil
            from quantity_groups
            
            if (@@ROWCOUNT = 0)
            begin
                -- find groups of cells that all have the same quantities and prices, and neighboring date ranges.
                ;with date_groups as (
                    select
                        older.SelectorId,
                        MIN(older.ValidFrom) as GroupValidFrom,
                        older.MinQuantity,
                        older.MaxQuantity,
                        older.UnitPrice,
                        MIN(older.ValidFrom) as CellValidFrom,
                        MIN(older.ValidUntil) as CellValidUntil
                    from @values older
                    where exists (select 1
                        from @values newer
                        where older.SelectorId = newer.SelectorId
                          and older.MinQuantity = newer.MinQuantity
                          and older.MaxQuantity = newer.MaxQuantity
                          and older.UnitPrice = newer.UnitPrice
                          and older.ValidUntil = newer.ValidFrom)
                    group by older.SelectorId, older.MinQuantity, older.MaxQuantity, older.UnitPrice
                    union all
                    select
                        cte.SelectorId,
                        cte.GroupValidFrom,
                        cte.MinQuantity,
                        cte.MaxQuantity,
                        cte.UnitPrice,
                        newer.ValidFrom as CellValidFrom,
                        newer.ValidUntil as CellValidUntil
                    from date_groups cte
                    join @values newer
                        on cte.SelectorId = newer.SelectorId
                        and cte.MinQuantity = newer.MinQuantity
                        and cte.MaxQuantity = newer.MaxQuantity
                        and cte.UnitPrice = newer.UnitPrice
                        and cte.CellValidUntil = newer.ValidFrom
                )         
                insert into @mergeops (SelectorId, ValidFrom, MinQuantity, NewValidUntil)
                select
                    SelectorId,
                    CellValidFrom,
                    MinQuantity,
                    case when CellValidFrom = GroupValidFrom 
                        then MAX(CellValidUntil) over (partition by SelectorId, GroupValidFrom, MinQuantity)
                        else null end as NewValidUntil
                from date_groups
            end                
            
            if exists (select 1 from @mergeops)
            begin
                delete v
                from @values v
                join @mergeops m
                    on v.SelectorId = m.SelectorId 
                    and v.ValidFrom = m.ValidFrom 
                    and v.MinQuantity = m.MinQuantity
                where m.NewValidUntil is null
                  and m.NewMaxQuantity is null
                
                update v
                set
                    MaxQuantity = isnull(m.NewMaxQuantity, v.MaxQuantity),
                    ValidUntil = isnull(m.NewValidUntil, v.ValidUntil)
                from @values v
                join @mergeops m
                    on v.SelectorId = m.SelectorId
                    and v.ValidFrom = m.ValidFrom
                    and v.MinQuantity = m.MinQuantity
            end
            else break
        end
                    
        insert into Price (MarketId, ApplicationId, CatalogEntryCode, CurrencyCode, ValidFrom, ValidUntil, MinQuantity, InternalMaxQuantity, PriceTypeId, PriceCode, UnitPrice)
        select
            s.MarketId,
            s.ApplicationId,
            s.CatalogEntryCode,
            s.CurrencyCode,
            v.ValidFrom,
            case when v.ValidUntil = @datetimemax then null else v.ValidUntil end,
            v.MinQuantity,
            v.MaxQuantity,
            s.PriceTypeId,
            s.PriceCode,
            v.UnitPrice
        from @values v
        join (select distinct SelectorId, MarketId, ApplicationId, CatalogEntryCode, CurrencyCode, PriceTypeId, PriceCode from @price_values) s
            on v.SelectorId = s.SelectorId
    end

    commit transaction
end try
begin catch
    declare @msg nvarchar(4000), @severity int, @state int
    select @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE()

    rollback transaction

    raiserror(@msg, @severity, @state)
end catch
