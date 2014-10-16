if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'MarketCurrencies') exec dbo.sp_executesql N'drop table dbo.MarketCurrencies'
if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'MarketLanguages') exec dbo.sp_executesql N'drop table dbo.MarketLanguages'
if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'MarketCountries') exec dbo.sp_executesql N'drop table dbo.MarketCountries'
if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'Market') exec dbo.sp_executesql N'drop table dbo.Market'

if exists (select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'FK_CurrencyRate_Currency') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint FK_CurrencyRate_Currency'
if exists (select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'FK_CurrencyRate_Currency1') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint FK_CurrencyRate_Currency1'
if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'Currency') exec dbo.sp_executesql N'drop table dbo.Currency'

create table dbo.Currency (
    CurrencyCode nvarchar(8) not null,
    Created datetime not null,
    Modified datetime not null,
    CurrencyName nvarchar(50) not null,
    CompatCurrencyId int not null identity(1,1),
    CompatApplicationId uniqueidentifier not null,
    constraint PK_Currency primary key (CurrencyCode),
    constraint AX_CompatCurrencyId unique (CompatCurrencyId)
)
go

create table dbo.Market (
    MarketId nvarchar(8) not null,
    Created datetime not null,
    Modified datetime not null,
    IsEnabled bit not null,
    MarketName nvarchar(50) not null,
    MarketDescription nvarchar(4000) not null,
    DefaultCurrencyCode nvarchar(8) not null,
    DefaultLanguageCode nvarchar(84) not null,
    constraint PK_Market primary key (MarketId),
    constraint FK_Market_Currency foreign key (DefaultCurrencyCode) references Currency (CurrencyCode),
    constraint AX_Market_MarketName unique (MarketName)
)
go

create table dbo.MarketCurrencies (
    MarketId nvarchar(8) not null,
    CurrencyCode nvarchar(8) not null,
    constraint PK_MarketCurrencies primary key clustered (MarketId, CurrencyCode),
    constraint FK_MarketCurrencies_Market foreign key (MarketId) references Market (MarketId) on delete cascade
)
go

create table dbo.MarketLanguages (
    MarketId nvarchar(8) not null,
    LanguageCode nvarchar(84) not null,
    constraint PK_MarketLanguages primary key clustered (MarketId, LanguageCode),
    constraint FK_MarketLanguages_Market foreign key (MarketId) references Market (MarketId) on delete cascade
)
go

create table dbo.MarketCountries (
    MarketId nvarchar(8) not null,
	CountryCode nvarchar(8) not null,
	constraint PK_MarketCountries primary key clustered (MarketId, CountryCode),
	constraint FK_MarketCountries_Market foreign key (MarketId) references Market (MarketId) on delete cascade
)
go
