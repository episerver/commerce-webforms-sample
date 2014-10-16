if OBJECT_ID('[dbo].[PriceDetail]', 'U') is not null drop table [dbo].[PriceDetail]
if OBJECT_ID('[dbo].[PriceValue]', 'U') is not null drop table [dbo].[PriceValue]
if OBJECT_ID('[dbo].[PriceGroup]', 'U') is not null drop table [dbo].[PriceGroup]
if OBJECT_ID('[dbo].[PriceType]', 'U') is not null drop table [dbo].[PriceType]
go

create table dbo.SchemaVersion_PricingSystem (
    Major int not null,
    Minor int not null,
    Patch int not null,
    InstallDate datetime not null,
    constraint PK_SchemaVersion_PricingSystem primary key clustered (Major, Minor, Patch)
)
go

create table dbo.PriceType
(
    PriceTypeId int not null,
    PriceTypeName nvarchar(256) not null,
    constraint PK_PriceType primary key clustered (PriceTypeId)
)
go

create table dbo.PriceGroup (
    PriceGroupId int identity(1,1) not null,
    Created datetime not null,
    Modified datetime not null,
    ApplicationId uniqueidentifier not null,
    CatalogEntryCode nvarchar(100) not null,
    MarketId nvarchar(8) not null,
    CurrencyCode nvarchar(8) not null,
    PriceTypeId int not null,
    PriceCode nvarchar(256) not null constraint DF_PriceGroup_PriceCode default '',
    constraint PK_PriceGroup primary key clustered (ApplicationId, CatalogEntryCode, MarketId, CurrencyCode, PriceTypeId, PriceCode),
    constraint AX_PriceGroup_PriceGroupId unique (PriceGroupId),
    constraint FK_PriceGroup_CatalogEntry foreign key (CatalogEntryCode, ApplicationId) references CatalogEntry (Code, ApplicationId) on delete cascade on update cascade,
    constraint FK_PriceGroup_Market foreign key (MarketId) references Market (MarketId) on delete cascade,
    constraint FK_PriceGroup_Currency foreign key (CurrencyCode) references Currency (CurrencyCode) on delete cascade,
    constraint FK_PriceGroup_PriceType foreign key (PriceTypeId) references PriceType (PriceTypeId)
)
go

create table [dbo].PriceValue
(
   PriceGroupId int not null,
   ValidFrom datetime not null,
   ValidUntil datetime null,
   MinQuantity decimal(38,9) not null,
   MaxQuantity decimal(38,9) null,
   UnitPrice money not null,
   constraint PK_PriceValue primary key clustered (PriceGroupId, ValidFrom, MinQuantity),
   constraint FK_PriceValue_PriceGroup foreign key (PriceGroupId) references PriceGroup (PriceGroupId) on delete cascade
)
go

create table [dbo].PriceDetail
(
    PriceValueId bigint identity(1,1) not null,
    Created datetime2 not null,
    Modified datetime2 not null,
    ApplicationId uniqueidentifier not null,
    CatalogEntryCode nvarchar(100) not null,
    MarketId nvarchar(8) not null,
    CurrencyCode nvarchar(8) not null,
    PriceTypeId int not null,
    PriceCode nvarchar(256) not null constraint DF_PriceDetail_PriceCode default '',    
    ValidFrom datetime2 not null,
    ValidUntil datetime2 null,
    MinQuantity decimal(38,9) not null,
    UnitPrice money not null,
    constraint PK_PriceDetail primary key nonclustered (PriceValueId),
    constraint FK_PriceDetail_CatalogEntry foreign key (CatalogEntryCode, ApplicationId) references CatalogEntry (Code, ApplicationId) on delete cascade on update cascade,
    constraint FK_PriceDetail_Market foreign key (MarketId) references Market (MarketId) on delete cascade,
    constraint FK_PriceDetail_Currency foreign key (CurrencyCode) references Currency (CurrencyCode) on delete cascade,
    constraint FK_PriceDetail_PriceType foreign key (PriceTypeId) references PriceType (PriceTypeId)
)
go

create clustered index IX_PriceDetail_CatalogEntry on PriceDetail (CatalogEntryCode, ApplicationId)
go
