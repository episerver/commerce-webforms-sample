if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'SchemaVersion_PricingSystem')
    exec dbo.sp_executesql N'create table dbo.SchemaVersion_PricingSystem (
    Major int not null,
    Minor int not null,
    Patch int not null,
    InstallDate datetime not null,
    constraint PK_SchemaVersion_PricingSystem primary key clustered (Major, Minor, Patch)
)'
go

-- We skip patch 6.0.0, as this patch already included in R3a, but no patching version was inserted!!!
declare @Major int = 6, @Minor int = 0, @Patch int, @Installed datetime
set @Patch = 0
insert into SchemaVersion_PricingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
go

declare @Major int = 6, @Minor int = 0, @Patch int, @Installed datetime
set @Patch = 0
select @Installed = InstallDate
from SchemaVersion_PricingSystem
where Major=@Major and Minor=@Minor and Patch=@Patch

if (@Installed is null)
begin
    declare @sql nvarchar(4000)

    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Pricing_GetPrices') exec dbo.sp_executesql N'drop procedure dbo.ecf_Pricing_GetPrices'
    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Pricing_GetPricesMultiQuantity') exec dbo.sp_executesql N'drop procedure dbo.ecf_Pricing_GetPricesMultiQuantity'
    if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCatalogKey') exec dbo.sp_executesql N'drop type dbo.udttCatalogKey'
    if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCatalogKeyAndQuantity') exec dbo.sp_executesql N'drop type dbo.udttCatalogKeyAndQuantity'
    if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCurrencyCode') exec dbo.sp_executesql N'drop type dbo.udttCurrencyCode'
    if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttCustomerPricing') exec dbo.sp_executesql N'drop type dbo.udttCustomerPricing'
    if exists (select 1 from sys.schemas s join sys.types t on s.schema_id = t.schema_id and s.name = 'dbo' and t.name = 'udttPriceType') exec dbo.sp_executesql N'drop type dbo.udttPriceType'
    if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'Price') exec dbo.sp_executesql N'drop table dbo.Price'
    if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'Market') exec dbo.sp_executesql N'drop table dbo.Market'
    if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'PriceType') exec dbo.sp_executesql N'drop table dbo.PriceType'    

    set @sql = N'create table Market
    (
        MarketId nvarchar(8) not null,
        constraint PK_Market primary key clustered (MarketId)
    )'
    exec dbo.sp_executesql @sql

    set @sql = N'create table PriceType
    (
        PriceTypeId int not null,
        PriceTypeName nvarchar(256) not null,
        constraint PK_PriceType primary key clustered (PriceTypeId)
    )'
    exec dbo.sp_executesql @sql

    set @sql = N'create table Price
    (
        MarketId nvarchar(8) not null,
        ApplicationId uniqueidentifier not null,
        CatalogEntryCode nvarchar(100) not null,
        CurrencyCode nvarchar(8) not null,
        ValidFrom datetime not null,
        ValidUntil datetime null,
        MinQuantity decimal(38,9) not null,
        InternalMaxQuantity decimal(38,9) not null constraint DF_Price_InternalMaxQuantity default 99999999999999999999999999999.999999999,
        PriceTypeId int not null,
        PriceCode nvarchar(256) not null constraint DF_Price_PriceCode default '''',
        CompatSalePriceId int identity(1,1) not null constraint AX_Price_CompatSalePriceId unique,
        UnitPrice money null,
        constraint PK_Price primary key (MarketId, ApplicationId, CatalogEntryCode, CurrencyCode, ValidFrom, MinQuantity, PriceTypeId, PriceCode),
        constraint FK_Price_Market foreign key (MarketId) references Market (MarketId) on delete cascade,
        constraint FK_Price_Application foreign key (ApplicationId) references Application (ApplicationId) on delete cascade,
        constraint FK_Price_CatalogEntry foreign key (CatalogEntryCode, ApplicationId) references CatalogEntry (Code, ApplicationId) on delete cascade,
        constraint FK_Price_PriceType foreign key (PriceTypeId) references PriceType (PriceTypeId) on delete cascade,
        constraint CK_Price_ValidRange check (ValidUntil is null or ValidFrom < ValidUntil),
        constraint CK_Price_QuantityRange check (MinQuantity < InternalMaxQuantity),
    )'
    exec dbo.sp_executesql @sql
   
    set @sql = N'create type udttCatalogKey as table 
    (
        ApplicationId uniqueidentifier not null,
        CatalogEntryCode nvarchar(100) not null
    )'
    exec dbo.sp_executesql @sql

    set @sql = N'create type udttCatalogKeyAndQuantity as table
    (
        ApplicationId uniqueidentifier not null,
        CatalogEntryCode nvarchar(100) not null,
        Quantity decimal(38,9) not null
    )'
    exec dbo.sp_executesql @sql

    set @sql = N'create type udttCurrencyCode as table
    (
        CurrencyCode nvarchar(8) not null
    )'
    exec dbo.sp_executesql @sql

    set @sql = N'create type udttCustomerPricing as table
    (
        PriceTypeId int not null,
        PriceCode nvarchar(256) not null
    )'
    exec dbo.sp_executesql @sql


    set @sql = 
N'create procedure ecf_Pricing_GetPrices
    @MarketId nvarchar(8),
    @ValidOn datetime,
    @CatalogKeys udttCatalogKeyAndQuantity readonly,
    @CurrencyCodes udttCurrencyCode readonly,
    @Quantity decimal(38,9) = null,
    @CustomerPricing udttCustomerPricing readonly,
    @ReturnCustomerPricing bit = 0
as
begin
    declare @customer_pricing udttCustomerPricing
    insert into @customer_pricing (PriceTypeId, PriceCode) select PriceTypeId, PriceCode from @CustomerPricing
    if @@ROWCOUNT = 0 insert into @customer_pricing (PriceTypeId, PriceCode) values (0, '''')

    if exists (select 1 from @CurrencyCodes)
        select
            p.MarketId,
            p.ApplicationId,
            p.CatalogEntryCode,
            p.CurrencyCode,
            p.ValidFrom,
            p.ValidUntil,
            p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end as PriceTypeId,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end as PriceCode,
            min(p.UnitPrice) as UnitPrice
        from Price p
        join @CatalogKeys ck
            on  p.ApplicationId = ck.ApplicationId
            and p.CatalogEntryCode = ck.CatalogEntryCode
        join @CurrencyCodes cc on p.CurrencyCode = cc.CurrencyCode
        join @customer_pricing cp 
            on  p.PriceTypeId = cp.PriceTypeId
            and p.PriceCode = cp.PriceCode
        where p.MarketId = @MarketId
            and p.ValidFrom <= @ValidOn
            and (p.ValidUntil is null or @ValidOn < p.ValidUntil)
            and (@Quantity is null or (p.MinQuantity <= @Quantity and @Quantity < p.InternalMaxQuantity))
        group by p.MarketId, p.ApplicationId, p.CatalogEntryCode, p.CurrencyCode, p.ValidFrom, p.ValidUntil, p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end
    else -- all currencies
        select
            p.MarketId,
            p.ApplicationId,
            p.CatalogEntryCode,
            p.CurrencyCode,
            p.ValidFrom,
            p.ValidUntil,
            p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end as PriceTypeId,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end as PriceCode,
            min(p.UnitPrice) as UnitPrice
        from Price p
        join @CatalogKeys ck
            on  p.ApplicationId = ck.ApplicationId
            and p.CatalogEntryCode = ck.CatalogEntryCode
        join @customer_pricing cp 
            on  p.PriceTypeId = cp.PriceTypeId
            and p.PriceCode = cp.PriceCode
        where p.MarketId = @MarketId
            and p.ValidFrom <= @ValidOn
            and (p.ValidUntil is null or @ValidOn < p.ValidUntil)
            and (@Quantity is null or (p.MinQuantity <= @Quantity and @Quantity < p.InternalMaxQuantity))
        group by p.MarketId, p.ApplicationId, p.CatalogEntryCode, p.CurrencyCode, p.ValidFrom, p.ValidUntil, p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end
end'
    exec dbo.sp_executesql @sql

    set @sql = 
N'create procedure ecf_Pricing_GetPricesMultiQuantity
    @MarketId nvarchar(8),
    @ValidOn datetime,
    @CatalogKeysAndQuantities udttCatalogKeyAndQuantity readonly,
    @CurrencyCodes udttCurrencyCode readonly,
    @CustomerPricing udttCustomerPricing readonly,
    @ReturnCustomerPricing bit = 0
as
begin
    declare @customer_pricing udttCustomerPricing
    insert into @customer_pricing (PriceTypeId, PriceCode) select PriceTypeId, PriceCode from @CustomerPricing
    if @@ROWCOUNT = 0 insert into @customer_pricing (PriceTypeId, PriceCode) values (0, '''')

    if exists (select 1 from @CurrencyCodes)
        select
            p.MarketId,
            p.ApplicationId,
            p.CatalogEntryCode,
            p.CurrencyCode,
            p.ValidFrom,
            p.ValidUntil,
            p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end as PriceTypeId,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end as PriceCode,
            min(p.UnitPrice) as UnitPrice
        from Price p
        join @CatalogKeysAndQuantities ckq
            on ckq.ApplicationId = p.ApplicationId
            and ckq.CatalogEntryCode = p.CatalogEntryCode
            and p.MinQuantity <= ckq.Quantity
            and ckq.Quantity < p.InternalMaxQuantity
        join @CurrencyCodes cc on p.CurrencyCode = cc.CurrencyCode
        join @customer_pricing cp 
            on  p.PriceTypeId = cp.PriceTypeId
            and p.PriceCode = cp.PriceCode
        where p.MarketId = @MarketId
            and p.ValidFrom <= @ValidOn
            and (p.ValidUntil is null or @ValidOn < p.ValidUntil)
        group by p.MarketId, p.ApplicationId, p.CatalogEntryCode, p.CurrencyCode, p.ValidFrom, p.ValidUntil, p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end
    else -- all currencies
        select
            p.MarketId,
            p.ApplicationId,
            p.CatalogEntryCode,
            p.CurrencyCode,
            p.ValidFrom,
            p.ValidUntil,
            p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end as PriceTypeId,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end as PriceCode,
            min(p.UnitPrice) as UnitPrice
        from Price p
        join @CatalogKeysAndQuantities ckq
            on ckq.ApplicationId = p.ApplicationId
            and ckq.CatalogEntryCode = p.CatalogEntryCode
            and p.MinQuantity <= ckq.Quantity
            and ckq.Quantity < p.InternalMaxQuantity
        join @customer_pricing cp 
            on  p.PriceTypeId = cp.PriceTypeId
            and p.PriceCode = cp.PriceCode
        where p.MarketId = @MarketId
            and p.ValidFrom <= @ValidOn
            and (p.ValidUntil is null or @ValidOn < p.ValidUntil)        
        group by p.MarketId, p.ApplicationId, p.CatalogEntryCode, p.CurrencyCode, p.ValidFrom, p.ValidUntil, p.MinQuantity,
            case when @ReturnCustomerPricing = 1 then p.PriceTypeId else null end,
            case when @ReturnCustomerPricing = 1 then p.PriceCode else null end
end'
    exec dbo.sp_executesql @sql

    insert into Market (MarketId) values ('DEFAULT')

    insert into PriceType (PriceTypeId, PriceTypeName)
    select 0, 'Default Price'
    union select 1, 'Specific Customer'
    union select 2, 'Customer Price Group'

    insert into SchemaVersion_PricingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go


declare @Major int = 6, @Minor int = 0, @Patch int, @Installed datetime
set @Patch = 1
select @Installed = InstallDate
from SchemaVersion_PricingSystem
where Major=@Major and Minor=@Minor and Patch=@Patch

if (@Installed is null)
begin
    declare @sql nvarchar(4000)

    if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Pricing_GetPrices') exec dbo.sp_executesql N'drop procedure dbo.ecf_Pricing_GetPrices'
    set @sql = 
N'Create procedure dbo.ecf_Pricing_GetPrices
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
        (@MarketId = '''' or pg.MarketId = @MarketId)
        and (@filterCurrencies = 0 or pg.CurrencyCode in (select CurrencyCode from @CurrencyCodes))
        and (@filterCustomerPricing = 0 or exists (select 1 from @CustomerPricing cp where cp.PriceTypeId = pg.PriceTypeId and cp.PriceCode = pg.PriceCode))
        and pv.ValidFrom <= @ValidOn
        and (pv.ValidUntil is null or @ValidOn < pv.ValidUntil)
        and (@ReturnQuantities = 1 or (pv.MinQuantity <= ckaq.Quantity and ckaq.Quantity < ISNULL(pv.MaxQuantity, ckaq.Quantity+1)))
    group by pg.ApplicationId, pg.CatalogEntryCode, pg.MarketId, pg.CurrencyCode, 
        case when @ReturnCustomerPricing = 1 then pg.PriceTypeId else null end,
        case when @ReturnCustomerPricing = 1 then pg.PriceCode else null end,
        pv.ValidFrom, pv.ValidUntil, pv.MinQuantity
end'
    exec dbo.sp_executesql @sql

    set @sql = N'CREATE TYPE [dbo].[udttPriceType] AS TABLE(
    [PriceTypeId] [int] NOT NULL,
    [PriceTypeName] [nvarchar](256) NOT NULL
    )'
    exec dbo.sp_executesql @sql


    set @sql =     
N'create procedure [dbo].[ecf_Pricing_EnsurePriceTypes]
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
end'
    exec dbo.sp_executesql @sql      

    insert into SchemaVersion_PricingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go



declare @Major int = 6, @Minor int = 0, @Patch int = 2, @Installed datetime
if not exists (select 1 from SchemaVersion_PricingSystem where Major=@Major and Minor=@Minor and Patch=@Patch)
begin
    declare @sql nvarchar(max)

    if OBJECT_ID('[dbo].[PriceDetail]', 'U') is null
    begin
        set @sql = 'create table PriceDetail
(
    PriceValueId bigint identity(1,1) not null,
    Created datetime2 not null,
    Modified datetime2 not null,
    ApplicationId uniqueidentifier not null,
    CatalogEntryCode nvarchar(100) not null,
    MarketId nvarchar(8) not null,
    CurrencyCode nvarchar(8) not null,
    PriceTypeId int not null,
    PriceCode nvarchar(256) not null constraint DF_PriceDetail_PriceCode default '''',    
    ValidFrom datetime2 not null,
    ValidUntil datetime2 null,
    MinQuantity decimal(38,9) not null,
    UnitPrice money not null,
    constraint PK_PriceDetail primary key nonclustered (PriceValueId),
    constraint FK_PriceDetail_CatalogEntry foreign key (CatalogEntryCode, ApplicationId) references CatalogEntry (Code, ApplicationId) on delete cascade on update cascade,
    constraint FK_PriceDetail_Market foreign key (MarketId) references Market (MarketId) on delete cascade,
    constraint FK_PriceDetail_Currency foreign key (CurrencyCode) references Currency (CurrencyCode) on delete cascade,
    constraint FK_PriceDetail_PriceType foreign key (PriceTypeId) references PriceType (PriceTypeId)
)'
        exec dbo.sp_executesql @sql

        set @sql = 'create clustered index IX_PriceDetail_CatalogEntry on PriceDetail (CatalogEntryCode, ApplicationId)'
        exec dbo.sp_executesql @sql
    end

    if TYPE_ID('[dbo].[udttPriceDetail]') is null
    begin
        set @sql = 'create type [dbo].[udttPriceDetail] as table (
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
)'
        exec dbo.sp_executesql @sql
    end

    set @sql = case when OBJECT_ID('[dbo].[ecf_PriceDetail_Get]', 'P') is null then 'create' else 'alter' end +
' procedure [dbo].[ecf_PriceDetail_Get]
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
end'
    exec dbo.sp_executesql @sql

    set @sql = case when OBJECT_ID('[dbo].[ecf_PriceDetail_List]', 'P') is null then 'create' else 'alter' end +
' procedure [dbo].[ecf_PriceDetail_List]
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
                and cer.RelationTypeId in (''ProductVariation'')
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
    	and (@MarketId = '''' or pd.MarketId = @MarketId)
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
                and cer.RelationTypeId in (''ProductVariation'')
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
        and (@MarketId = '''' or pd.MarketId = @MarketId)
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
end'
    exec dbo.sp_executesql @sql

    set @sql = case when OBJECT_ID('[dbo].[ecf_PriceDetail_Save]', 'P') is null then 'create' else 'alter' end +
' procedure [dbo].[ecf_PriceDetail_Save]
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
end'
    exec dbo.sp_executesql @sql

    set @sql = case when OBJECT_ID('[dbo].[ecf_PriceDetail_ReplacePrices]', 'P') is null then 'create' else 'alter' end +
' procedure [dbo].[ecf_PriceDetail_ReplacePrices]
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
end'
    exec dbo.sp_executesql @sql

    -- import existing price data.
    insert into PriceDetail (Created, Modified, ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode, ValidFrom, ValidUntil, MinQuantity, UnitPrice)
    select Created, Modified, ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode, ValidFrom, ValidUntil, MinQuantity, UnitPrice
    from PriceGroup g 
    join PriceValue v 
    on g.PriceGroupId = v.PriceGroupId

    insert into SchemaVersion_PricingSystem (Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go

