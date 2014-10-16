if exists (select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'FK_CurrencyRate_Currency') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint FK_CurrencyRate_Currency'
if exists (select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'dbo' and CONSTRAINT_NAME = 'FK_CurrencyRate_Currency1') exec dbo.sp_executesql N'alter table dbo.CurrencyRate drop constraint FK_CurrencyRate_Currency1'
go

IF EXISTS( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME = 'Currency' AND  COLUMN_NAME = 'CurrencyId') exec dbo.sp_rename 'dbo.Currency.CurrencyId', 'CompatCurrencyId', 'COLUMN'
IF EXISTS( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME = 'Currency' AND  COLUMN_NAME = 'ApplicationId') exec dbo.sp_rename 'dbo.Currency.ApplicationId', 'CompatApplicationId', 'COLUMN'
IF EXISTS( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME = 'Currency' AND  COLUMN_NAME = 'Name') exec dbo.sp_rename 'dbo.Currency.Name', 'CurrencyName', 'COLUMN'
IF EXISTS( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME = 'Currency' AND  COLUMN_NAME = 'ModifiedDate') exec dbo.sp_rename 'dbo.Currency.ModifiedDate', 'Modified', 'COLUMN'
IF EXISTS( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME = 'Currency' AND  COLUMN_NAME = 'CurrencyCode') exec dbo.sp_executesql N'alter table dbo.Currency alter column CurrencyCode nvarchar(8) not null' 
IF NOT EXISTS( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME = 'Currency' AND  COLUMN_NAME = 'Created') exec dbo.sp_executesql N'alter table dbo.Currency add [Created] [datetime] NOT NULL DEFAULT GETDATE()' 
go

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Currency]')) ALTER TABLE [dbo].[Currency] DROP [Currency_PK]
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Currency]') AND name = N'AX_CompatCurrencyId') ALTER TABLE [dbo].[Currency] DROP CONSTRAINT [AX_CompatCurrencyId]
GO

alter table dbo.Currency add constraint PK_Currency primary key (CurrencyCode)
alter table dbo.Currency add constraint AX_CompatCurrencyId unique (CompatCurrencyId)
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
