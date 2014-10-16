/********************************************************************
             Pre Release Upgrade Script
*********************************************************************/

----November 27, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItemDiscount]') AND name = N'IX_LineItemDiscount_LineItem')
  BEGIN
	exec sp_ExecuteSQL N'CREATE NONCLUSTERED INDEX [IX_LineItemDiscount_LineItem] ON [dbo].[LineItemDiscount] 
	(
		[LineItemId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'
  END
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------- March 31, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 2;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

--Drop the procedure first
/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_PaymentMethodId]    Script Date: 07/16/2007  ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_PaymentMethodId]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ecf_PaymentMethod_PaymentMethodId]

exec sp_ExecuteSQL N'CREATE PROCEDURE [dbo].[ecf_PaymentMethod_PaymentMethodId]
	@ApplicationId uniqueidentifier,
	@PaymentMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
		where [PaymentMethodId] = @PaymentMethodId and 
			[ApplicationId] = @ApplicationId and (([IsActive] = 1) or @ReturnInactive = 1)

	if @@rowcount > 0
		select * from [PaymentMethodParameter] 
			where [PaymentMethodId] = @PaymentMethodId
	else
		-- select nothing
		select * from [PaymentMethodParameter] where 1=0
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_PaymentMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption]
	select * from [ShippingOptionParameter]
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
END'

--Drop the procedure first
exec sp_ExecuteSQL N'IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N''[dbo].[ecf_ShippingOption_ShippingOptionId]'') AND OBJECTPROPERTY(id,N''IsProcedure'') = 1)
  DROP PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]'

exec sp_ExecuteSQL N'CREATE PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ShippingOptionId] = @ShippingOptionId
	select * from [ShippingOptionParameter] where [ShippingOptionId] = @ShippingOptionId
	select * from [ShippingMethod] where [ShippingOptionId] = @ShippingOptionId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in 
		(select ShippingMethodId from ShippingMethod 
			where [ShippingOptionId] = @ShippingOptionId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in 
		(select ShippingMethodId from ShippingMethod 
			where [ShippingOptionId] = @ShippingOptionId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


------- April 1, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 3;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ord_CreateFTSQuery]
(
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				nvarchar(50),	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx_Localization, *, N''plasma'') FTS
			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.* /*, LOC.**/ FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS '' +
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END
' 

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

------- April 3, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 4;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ord_CreateFTSQuery]
(
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				nvarchar(50),	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction			nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.* /*, LOC.**/ FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END
' 


--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- April 4, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 5;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ShippingOptionId] = @ShippingOptionId

	select * from [ShippingOptionParameter] where [ShippingOptionId] = @ShippingOptionId

	select SM.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId

	select * from [ShippingMethodParameter] 
		where ShippingMethodId in (select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)

	select * from [ShippingRegion] where ShippingMethodId in 
		(select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)
END'


--Drop the procedure first
/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_ShippingMethodId]    Script Date: 07/16/2007  ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_ShippingMethodId]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]


exec sp_ExecuteSQL N'CREATE PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- April 7, 2007------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 6;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingCountry]') AND type in (N'U'))
BEGIN
	exec sp_ExecuteSQL N'CREATE TABLE [dbo].[ShippingCountry](
		[ShippingCountryId] [int] IDENTITY(1,1) NOT NULL,
		[ShippingMethodId] [uniqueidentifier] NOT NULL,
		[CountryId] [int] NULL,
	 CONSTRAINT [PK_ShippingCountry] PRIMARY KEY CLUSTERED 
	(
		[ShippingCountryId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]'
END

exec sp_ExecuteSQL N'IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_ShippingCountry_Country]'') AND parent_object_id = OBJECT_ID(N''[dbo].[ShippingCountry]''))
ALTER TABLE [dbo].[ShippingCountry]  WITH CHECK ADD  CONSTRAINT [FK_ShippingCountry_Country] FOREIGN KEY([CountryId]) REFERENCES [dbo].[Country] ([CountryId])'

exec sp_ExecuteSQL N'ALTER TABLE [dbo].[ShippingCountry] CHECK CONSTRAINT [FK_ShippingCountry_Country]'

exec sp_ExecuteSQL N'IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_ShippingCountry_ShippingMethod]'') AND parent_object_id = OBJECT_ID(N''[dbo].[ShippingCountry]''))
ALTER TABLE [dbo].[ShippingCountry]  WITH CHECK ADD  CONSTRAINT [FK_ShippingCountry_ShippingMethod] FOREIGN KEY([ShippingMethodId])
REFERENCES [dbo].[ShippingMethod] ([ShippingMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE'

exec sp_ExecuteSQL N'ALTER TABLE [dbo].[ShippingCountry] CHECK CONSTRAINT [FK_ShippingCountry_ShippingMethod]'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier, 
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption]
	select * from [ShippingOptionParameter]
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SC.* from [ShippingCountry] SC
		inner join [ShippingMethod] SM on SC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ShippingOptionId] = @ShippingOptionId

	select * from [ShippingOptionParameter] where [ShippingOptionId] = @ShippingOptionId

	select SM.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId

	select * from [ShippingMethodParameter] 
		where ShippingMethodId in (select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)

	select * from [ShippingCountry] where ShippingMethodId in 
		(select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)

	select * from [ShippingRegion] where ShippingMethodId in 
		(select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- April 09, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 7;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
/****** Object:  Table [dbo].[ShippingPaymentRestriction]    Script Date: 7/16/2007 11:08:13 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingPaymentRestriction]') AND type in (N'U'))
 BEGIN
	exec sp_ExecuteSQL N'CREATE TABLE [dbo].[ShippingPaymentRestriction](
		[ShippingPaymentRestrictionId] [int] IDENTITY(1,1) NOT NULL,
		[ShippingMethodId] [uniqueidentifier] NOT NULL,
		[PaymentMethodId] [uniqueidentifier] NOT NULL,
		[RestrictShippingMethods] [bit] NOT NULL CONSTRAINT [DF_ShippingPaymentRestriction_RestrictShippingMethods]  DEFAULT ((0)),
	 CONSTRAINT [PK_ShippingPaymentRestriction] PRIMARY KEY CLUSTERED 
	(
		[ShippingPaymentRestrictionId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]'

	exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'False, if PaymentMethods are restricted based on ShippingMethods; true if vice versa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ShippingPaymentRestriction', @level2type=N'COLUMN',@level2name=N'RestrictShippingMethods'

  END

exec sp_ExecuteSQL N'IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_ShippingPaymentRestriction_PaymentMethod]'') AND parent_object_id = OBJECT_ID(N''[dbo].[ShippingPaymentRestriction]''))
ALTER TABLE [dbo].[ShippingPaymentRestriction]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPaymentRestriction_PaymentMethod] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[PaymentMethod] ([PaymentMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE'

exec sp_ExecuteSQL N'ALTER TABLE [dbo].[ShippingPaymentRestriction] CHECK CONSTRAINT [FK_ShippingPaymentRestriction_PaymentMethod]'

exec sp_ExecuteSQL N'IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_ShippingPaymentRestriction_ShippingMethod]'') AND parent_object_id = OBJECT_ID(N''[dbo].[ShippingPaymentRestriction]''))
ALTER TABLE [dbo].[ShippingPaymentRestriction]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPaymentRestriction_ShippingMethod] FOREIGN KEY([ShippingMethodId])
REFERENCES [dbo].[ShippingMethod] ([ShippingMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE'

exec sp_ExecuteSQL N'ALTER TABLE [dbo].[ShippingPaymentRestriction] CHECK CONSTRAINT [FK_ShippingPaymentRestriction_ShippingMethod]'

 -- update stored procedures
 
exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_PaymentMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=1
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_PaymentMethod_PaymentMethodId]
	@ApplicationId uniqueidentifier,
	@PaymentMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
		where [PaymentMethodId] = @PaymentMethodId and 
			[ApplicationId] = @ApplicationId and (([IsActive] = 1) or @ReturnInactive = 1)

	if @@rowcount > 0 begin
		select * from [PaymentMethodParameter] 
			where [PaymentMethodId] = @PaymentMethodId

		select * from [ShippingPaymentRestriction] 
			where [PaymentMethodId] = @PaymentMethodId and [RestrictShippingMethods] = 1
	end
	else begin
		-- select nothing
		select * from [PaymentMethodParameter] where 1=0
		select * from [ShippingPaymentRestriction] where 1=0
	end
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption]
	select * from [ShippingOptionParameter]
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SC.* from [ShippingCountry] SC
		inner join [ShippingMethod] SM on SC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SPR.* from [ShippingPaymentRestriction] SPR
		inner join [ShippingMethod] SM on SPR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId and SPR.[RestrictShippingMethods] = 0
END'

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ShippingOptionId] = @ShippingOptionId

	select * from [ShippingOptionParameter] where [ShippingOptionId] = @ShippingOptionId

	select SM.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId

	select * from [ShippingMethodParameter] 
		where ShippingMethodId in (select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)

	select * from [ShippingCountry] where ShippingMethodId in 
		(select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)

	select * from [ShippingRegion] where ShippingMethodId in 
		(select SM.[ShippingMethodId] from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId)

	select * from [ShippingPaymentRestriction] 
		where ( ShippingMethodId in (select SM.[ShippingMethodId] from [ShippingOption] SO
				inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
				where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId) 
			  ) and 
			  ( [RestrictShippingMethods] = 0 )
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- May 1, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 8;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @SearchSetId uniqueidentifier
AS
BEGIN
    -- Return GroupIds.
    SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId

	-- Return Order Form Collection
	SELECT ''OrderForm'' TableName, * FROM [OrderFormEx] OE INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Collection
	/* the following sql is faster that the previously used one */
	SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  INNER JOIN [OrderSearchResults] R ON O.[OrderGroupId] = R.[OrderGroupId] WHERE R.[SearchSetId] = @SearchSetId
	--SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId WHERE [O].[OrdergroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Collection
	SELECT ''Shipment'' TableName, * FROM [ShipmentEx] SE INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId WHERE [S].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Collection
	SELECT ''LineItem'' TableName, * FROM [LineItemEx] LE INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId WHERE [L].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Payment Collection

		-- Credit Cards
		SELECT ''OrderFormPayment_CreditCard'' TableName, * FROM [OrderFormPayment_CreditCard] OC INNER JOIN OrderFormPayment O ON O.PaymentId = OC.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)
	
		-- Cash Cards	
		SELECT ''OrderFormPayment_CashCard'' TableName, * FROM [OrderFormPayment_CashCard] OC INNER JOIN OrderFormPayment O ON O.PaymentId = OC.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

		-- Gift Cards	
		SELECT ''OrderFormPayment_GiftCard'' TableName, * FROM [OrderFormPayment_GiftCard] OC INNER JOIN OrderFormPayment O ON O.PaymentId = OC.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

		-- Invoices
		SELECT ''OrderFormPayment_Invoice'' TableName, * FROM [OrderFormPayment_Invoice] OC INNER JOIN OrderFormPayment O ON O.PaymentId = OC.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

		-- Other
		SELECT ''OrderFormPayment_Other'' TableName, * FROM [OrderFormPayment_Other] OC INNER JOIN OrderFormPayment O ON O.PaymentId = OC.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Discount Collection
	SELECT ''OrderFormDiscount'' TableName, * FROM [OrderFormDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Discount Collection
	SELECT ''LineItemDiscount'' TableName, * FROM [LineItemDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Discount Collection
	SELECT ''ShipmentDiscount'' TableName, * FROM [ShipmentDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

END
'
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- May 8, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 9;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderSearch]
(
	@ApplicationId				uniqueidentifier,
	@SearchSetId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(250) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT TableName FROM MetaClass 
		WHERE Namespace like @Namespace + ''%'' AND ([Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and IsSystem = 0

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM [OrderGroup] OrderGroup'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON OrderGroup.[OrderGroupId] = META.[KEY] ''

	set @FilterQuery_tmp = N'' WHERE ApplicationId = '''''' + CAST(@ApplicationId as nvarchar(36)) + ''''''''
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''[OrderGroup].OrderGroupId''
	end

	set @FullQuery = N''SELECT count([OrderGroup].OrderGroupId) OVER() TotalRecords, [OrderGroup].OrderGroupId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, OrderGroupId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, OrderGroupId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, OrderGroupId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', OrderGroupId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END'
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


---- June 5, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 10;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
-- Remove Constraints first
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItem] DROP CONSTRAINT [FK_LineItem_OrderForm]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[Shipment] DROP CONSTRAINT [FK_Shipment_OrderForm]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormPayment] DROP CONSTRAINT [FK_OrderFormPayment_OrderForm]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormDiscount] DROP CONSTRAINT [FK_OrderFormDiscount_OrderForm]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItemDiscount] DROP CONSTRAINT [FK_LineItemDiscount_LineItem]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[ShipmentDiscount] DROP CONSTRAINT [FK_ShipmentDiscount_Shipment]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderGroupAddress] DROP CONSTRAINT [FK_OrderGroupAddress_OrderGroup]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderSearchResults] DROP CONSTRAINT [FK_OrderSearchResults_OrderGroup]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderForm] DROP CONSTRAINT [FK_OrderForm_OrderGroup]'

-- Recreate constraints
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItem]  WITH CHECK ADD  CONSTRAINT [FK_LineItem_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [dbo].[OrderForm] ([OrderFormId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItem] CHECK CONSTRAINT [FK_LineItem_OrderForm]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[Shipment]  WITH NOCHECK ADD  CONSTRAINT [FK_Shipment_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [dbo].[OrderForm] ([OrderFormId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[Shipment] CHECK CONSTRAINT [FK_Shipment_OrderForm]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormPayment]  WITH CHECK ADD  CONSTRAINT [FK_OrderFormPayment_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [dbo].[OrderForm] ([OrderFormId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormPayment] CHECK CONSTRAINT [FK_OrderFormPayment_OrderForm]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormDiscount]  WITH CHECK ADD  CONSTRAINT [FK_OrderFormDiscount_OrderForm] FOREIGN KEY([OrderFormId])
REFERENCES [dbo].[OrderForm] ([OrderFormId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormDiscount] CHECK CONSTRAINT [FK_OrderFormDiscount_OrderForm]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItemDiscount]  WITH CHECK ADD  CONSTRAINT [FK_LineItemDiscount_LineItem] FOREIGN KEY([LineItemId])
REFERENCES [dbo].[LineItem] ([LineItemId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItemDiscount] CHECK CONSTRAINT [FK_LineItemDiscount_LineItem]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[ShipmentDiscount]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentDiscount_Shipment] FOREIGN KEY([ShipmentId])
REFERENCES [dbo].[Shipment] ([ShipmentId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[ShipmentDiscount] CHECK CONSTRAINT [FK_ShipmentDiscount_Shipment]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderGroupAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrderGroupAddress_OrderGroup] FOREIGN KEY([OrderGroupId])
REFERENCES [dbo].[OrderGroup] ([OrderGroupId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderGroupAddress] CHECK CONSTRAINT [FK_OrderGroupAddress_OrderGroup]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderSearchResults]  WITH CHECK ADD  CONSTRAINT [FK_OrderSearchResults_OrderGroup] FOREIGN KEY([OrderGroupId])
REFERENCES [dbo].[OrderGroup] ([OrderGroupId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderSearchResults] CHECK CONSTRAINT [FK_OrderSearchResults_OrderGroup]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderForm]  WITH CHECK ADD  CONSTRAINT [FK_OrderForm_OrderGroup] FOREIGN KEY([OrderGroupId])
REFERENCES [dbo].[OrderGroup] ([OrderGroupId])'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderForm] CHECK CONSTRAINT [FK_OrderForm_OrderGroup]'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Delete]
(
	@OrderGroupId int
)
AS
BEGIN
	SET NOCOUNT OFF
	DECLARE @Err int	
	DECLARE @TempObjectId int	

	DELETE FROM [LineItemDiscount] where OrderGroupId = @OrderGroupId

	select @TempObjectId = LineItemId FROM [LineItem] where OrderGroupId = @OrderGroupId
	DELETE FROM [LineItem] where OrderGroupId = @OrderGroupId
	DELETE FROM [LineItemEx] where ObjectId = @TempObjectId

	-- Delete payments
	select @TempObjectId = PaymentId FROM [OrderFormPayment] where OrderGroupId = @OrderGroupId
	DELETE FROM [OrderFormPayment] where OrderGroupId = @OrderGroupId
	DELETE FROM [OrderFormPayment_CreditCard] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_CashCard] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_GiftCard] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_Invoice] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_Other] WHERE ObjectId = @TempObjectId

	DELETE FROM [OrderFormDiscount] where OrderGroupId = @OrderGroupId
	DELETE FROM [ShipmentDiscount] where OrderGroupId = @OrderGroupId

	select @TempObjectId = ShipmentId FROM [Shipment] where OrderGroupId = @OrderGroupId
	DELETE FROM [Shipment] where OrderGroupId = @OrderGroupId
	DELETE FROM [ShipmentEx] WHERE ObjectId = @TempObjectId

	select @TempObjectId = OrderGroupAddressId FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	DELETE FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	DELETE FROM [OrderGroupAddressEx] WHERE ObjectId = @TempObjectId

	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	DELETE FROM [OrderForm] where OrderGroupId = @OrderGroupId
	DELETE FROM [OrderFormEx] WHERE ObjectId = @TempObjectId

	DELETE FROM [OrderGroup] where OrderGroupId = @OrderGroupId
	SET @Err = @@Error
	RETURN @Err
END'

-- Update index
EXEC dbo.sp_executesql @statement = N'DROP INDEX [IX_OrderGroup_CustomerIdName] ON [dbo].[OrderGroup] WITH ( ONLINE = OFF )'
EXEC dbo.sp_executesql @statement = N'CREATE NONCLUSTERED INDEX [IX_OrderGroup_CustomerIdName] ON [dbo].[OrderGroup] 
(
	[CustomerId] ASC,
	[Name] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

---- June 20, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 11;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ShippingOptionId] = @ShippingOptionId
	select * from [ShippingOptionParameter] where [ShippingOptionId] = @ShippingOptionId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- July 10, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 12;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxCategory]') AND type in (N'U'))
BEGIN
	exec sp_ExecuteSQL N'CREATE TABLE [dbo].[TaxCategory](
		[TaxCategoryId] [int] IDENTITY(1,1) NOT NULL,
		[Name] [nvarchar](50) NOT NULL,
		[ApplicationId] [uniqueidentifier] NOT NULL,
	 CONSTRAINT [TaxCategory_PK] PRIMARY KEY CLUSTERED 
	(
		[TaxCategoryId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]'
END
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- July 22, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 13;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Shipment_Delete]
(
	@ShipmentId int
)
AS
	SET NOCOUNT ON

	DELETE FROM [ShipmentDiscount] where ShipmentId = @ShipmentId
	DELETE FROM [Shipment] WHERE  [ShipmentId] = @ShipmentId	

	RETURN @@Error' 

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- July 29, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 14;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[Package](
	[PackageId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](600) NULL,
	[Width] [float] NULL,
	[Height] [float] NULL,
	[Length] [float] NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Package_PK] PRIMARY KEY CLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[ShippingPackage](
	[ShippingPackageId] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [int] NOT NULL,
	[ShippingOptionId] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](100) NOT NULL,
 CONSTRAINT [ShippingPackage_PK] PRIMARY KEY CLUSTERED 
(
	[ShippingPackageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingPackage]
	@ApplicationId uniqueidentifier
AS
	select * from [Package] P where P.[ApplicationId] = @ApplicationId'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption]
	select * from [ShippingOptionParameter]
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package]
	select * from [ShippingPackage]
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ShippingOptionId] = @ShippingOptionId
	select * from [ShippingOptionParameter] where [ShippingOptionId] = @ShippingOptionId
	select * from [Package] P
		inner join [ShippingPackage] SP on P.[PackageId]=SP.[PackageId]
			where SP.[ShippingOptionId] = @ShippingOptionId and P.[ApplicationId]=@ApplicationId
	select * from [ShippingPackage] where [ShippingOptionId] = @ShippingOptionId
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SC.* from [ShippingCountry] SC
		inner join [ShippingMethod] SM on SC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SPR.* from [ShippingPaymentRestriction] SPR
		inner join [ShippingMethod] SM on SPR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId and SPR.[RestrictShippingMethods] = 0

	select P.* from [Package] P
		inner join [ShippingPackage] SP on SP.[PackageId]=P.[PackageId]
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SP.* from [ShippingPackage] SP
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId
END'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[ShippingPackage]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPackage_Package] FOREIGN KEY([PackageId])
REFERENCES [dbo].[Package] ([PackageId])
ON UPDATE CASCADE
ON DELETE CASCADE'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[ShippingPackage]  WITH CHECK ADD  CONSTRAINT [FK_ShippingPackage_ShippingOption] FOREIGN KEY([ShippingOptionId])
REFERENCES [dbo].[ShippingOption] ([ShippingOptionId])
ON UPDATE CASCADE
ON DELETE CASCADE'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- August 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 15;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetOrderSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_OrderSystem]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_OrderSystem])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 15, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 16;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

/****** Object:  Table [dbo].[Tax]    Script Date: 09/15/2008 18:19:04 ******/
EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[Tax](
	[TaxId] [int] IDENTITY(1,1) NOT NULL,
	[TaxType] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Tax_PK] PRIMARY KEY CLUSTERED 
(
	[TaxId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Tax] UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[JurisdictionGroup](
	[JurisdictionGroupId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[DisplayName] [nvarchar](250) NOT NULL,
	[JurisdictionType] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JurisdictionGroup] PRIMARY KEY CLUSTERED 
(
	[JurisdictionGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[Jurisdiction](
	[JurisdictionId] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[StateProvinceCode] nvarchar(50) NULL,
	[CountryCode] nvarchar(50) NOT NULL,
	[JurisdictionType] [int] NOT NULL,
	[ZipPostalCodeStart] [nvarchar](50) NULL,
	[ZipPostalCodeEnd] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[County] [nvarchar](50) NULL,
	[GeoCode] [nvarchar](255) NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TaxRegion] PRIMARY KEY CLUSTERED 
(
	[JurisdictionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[TaxLanguage](
	[TaxLanguageId] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
	[TaxId] [int] NOT NULL,
 CONSTRAINT [PK_TaxLanguage] PRIMARY KEY CLUSTERED 
(
	[TaxLanguageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[TaxValue](
	[TaxValueId] [int] IDENTITY(1,1) NOT NULL,
	[Percentage] [float] NOT NULL,
	[TaxId] [int] NOT NULL,
	[TaxCategory] [nvarchar](50) NOT NULL,
	[JurisdictionGroupId] [int] NOT NULL,
	[AffectiveDate] [datetime] NOT NULL,
	[SiteId] [uniqueidentifier] NULL,
 CONSTRAINT [TaxValue_PK] PRIMARY KEY CLUSTERED 
(
	[TaxValueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'CREATE TABLE [dbo].[JurisdictionRelation](
	[JurisdictionId] [int] NOT NULL,
	[JurisdictionGroupId] [int] NOT NULL,
 CONSTRAINT [PK_JurisdictionRelation] PRIMARY KEY CLUSTERED 
(
	[JurisdictionId] ASC,
	[JurisdictionGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[JurisdictionRelation]  WITH CHECK ADD  CONSTRAINT [FK_JurisdictionRelation_Jurisdiction] FOREIGN KEY([JurisdictionId])
REFERENCES [dbo].[Jurisdiction] ([JurisdictionId])
ON UPDATE CASCADE
ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[JurisdictionRelation] CHECK CONSTRAINT [FK_JurisdictionRelation_Jurisdiction]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[JurisdictionRelation]  WITH CHECK ADD  CONSTRAINT [FK_JurisdictionRelation_JurisdictionGroup] FOREIGN KEY([JurisdictionGroupId])
REFERENCES [dbo].[JurisdictionGroup] ([JurisdictionGroupId])
ON UPDATE CASCADE
ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[JurisdictionRelation] CHECK CONSTRAINT [FK_JurisdictionRelation_JurisdictionGroup]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[TaxLanguage]  WITH CHECK ADD  CONSTRAINT [FK_TaxLanguage_Tax] FOREIGN KEY([TaxId])
REFERENCES [dbo].[Tax] ([TaxId])
ON UPDATE CASCADE
ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[TaxLanguage] CHECK CONSTRAINT [FK_TaxLanguage_Tax]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[TaxValue]  WITH CHECK ADD  CONSTRAINT [FK_TaxValue_JurisdictionGroup] FOREIGN KEY([JurisdictionGroupId])
REFERENCES [dbo].[JurisdictionGroup] ([JurisdictionGroupId])
ON UPDATE CASCADE
ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[TaxValue] CHECK CONSTRAINT [FK_TaxValue_JurisdictionGroup]'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[TaxValue]  WITH CHECK ADD  CONSTRAINT [Tax_TaxValue_FK1] FOREIGN KEY([TaxId])
REFERENCES [dbo].[Tax] ([TaxId])
ON UPDATE CASCADE
ON DELETE CASCADE'
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[TaxValue] CHECK CONSTRAINT [Tax_TaxValue_FK1]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_GetTaxes]
	@ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier,
	@TaxCategory nvarchar(50),
	@LanguageCode nvarchar(50),
	@CountryCode nvarchar(50),
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
	SELECT V.Percentage, T.TaxType, T.Name, (select L.DisplayName from TaxLanguage L where L.TaxId = V.TaxId and LanguageCode = @LanguageCode) DisplayName from TaxValue V 
		inner join Tax T ON T.TaxId = V.TaxId
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = V.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		V.AffectiveDate < getutcdate() AND 
		V.TaxCategory = @TaxCategory AND
		(COALESCE(V.SiteId, @SiteId) = @SiteId or SiteId is null) AND
		T.ApplicationId = @ApplicationId AND
		JG.ApplicationId = @ApplicationId AND
		J.CountryCode = @CountryCode AND 
		JG.JurisdictionType = 1 /*tax*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null) AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null) AND
		(COALESCE(@District, J.District) = J.District OR J.District is null) AND
		(COALESCE(@County, J.County) = J.County OR J.County is null) AND
		(COALESCE(@City, J.City) = J.City OR J.City is null)'
		
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ShippingMethodCase ADD
	JurisdictionGroupId int NULL,
	StartDate datetime NULL,
	EndDate datetime NULL'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ShippingMethodCase ADD CONSTRAINT
	FK_ShippingMethodCase_JurisdictionGroup FOREIGN KEY
	(
	JurisdictionGroupId
	) REFERENCES dbo.JurisdictionGroup
	(
	JurisdictionGroupId
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE ecf_ShippingMethod_GetCases
	@ShippingMethodId uniqueidentifier,
	@CountryCode nvarchar(50) = null,
	@Total money = null,
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
	SELECT C.Charge, C.Total, C.StartDate, C.EndDate, C.JurisdictionGroupId from ShippingMethodCase C 
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = C.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		(C.StartDate < getutcdate() OR C.StartDate is null) AND 
		(C.EndDate < getutcdate() OR C.EndDate is null) AND 
		C.ShippingMethodId = @ShippingMethodId AND
		(@Total > C.Total OR @Total is null) AND
		(J.CountryCode = @CountryCode OR (@CountryCode is null and J.CountryCode = ''WORLD'')) AND 
		JG.JurisdictionType = 2 /*shipping*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null) AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null) AND
		(COALESCE(@District, J.District) = J.District OR J.District is null) AND
		(COALESCE(@County, J.County) = J.County OR J.County is null) AND
		(COALESCE(@City, J.City) = J.City OR J.City is null)'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 18, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 17;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption]
	select * from [ShippingOptionParameter]
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package]
	select * from [ShippingPackage]
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMC.* from [ShippingMethodCase] SMC
		inner join [ShippingMethod] SM on SMC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SC.* from [ShippingCountry] SC
		inner join [ShippingMethod] SM on SC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SPR.* from [ShippingPaymentRestriction] SPR
		inner join [ShippingMethod] SM on SPR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId and SPR.[RestrictShippingMethods] = 0

	select P.* from [Package] P
		inner join [ShippingPackage] SP on SP.[PackageId]=P.[PackageId]
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SP.* from [ShippingPackage] SP
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction]
	@ApplicationId uniqueidentifier,
	@JurisdictionType int = null
AS
BEGIN
	select * from [Jurisdiction] 
		where [ApplicationId] = @ApplicationId and 
			(COALESCE(@JurisdictionType, [JurisdictionType]) = [JurisdictionType] OR [JurisdictionType] is null)

	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and 
		(COALESCE(@JurisdictionType, [JurisdictionType]) = [JurisdictionType] OR [JurisdictionType] is null)

	select JR.* from [JurisdictionRelation] JR
		inner join [Jurisdiction] J on JR.[JurisdictionId]=J.[JurisdictionId]
		inner join [JurisdictionGroup] JG on JR.[JurisdictionGroupId]=JG.[JurisdictionGroupId]
		where J.[ApplicationId] = @ApplicationId and JG.[ApplicationId] = @ApplicationId and
			(COALESCE(@JurisdictionType, J.[JurisdictionType]) = J.[JurisdictionType] OR J.[JurisdictionType] is null) and
			(COALESCE(@JurisdictionType, JG.[JurisdictionType]) = JG.[JurisdictionType] OR JG.[JurisdictionType] is null)
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionId]
	@ApplicationId uniqueidentifier,
	@JurisdictionId int,
	@ReturnAllGroups bit = 0
AS
BEGIN
	select * from [Jurisdiction] 
		where [ApplicationId] = @ApplicationId and [JurisdictionId] = @JurisdictionId

	IF @ReturnAllGroups=1 BEGIN -- return all jurisdiction groups of the found jurisdiction type
		select * from [JurisdictionGroup] 
			where [JurisdictionType] IN (select [JurisdictionType] from [Jurisdiction] 
											where [ApplicationId] = @ApplicationId and [JurisdictionId] = @JurisdictionId)
	END ELSE BEGIN
		select JG.* from [JurisdictionGroup] JG
			inner join [JurisdictionRelation] JR on JR.[JurisdictionGroupId] = JG.[JurisdictionGroupId]
			where JG.[ApplicationId] = @ApplicationId and JR.[JurisdictionId] = @JurisdictionId
	END

	select JR.* from [JurisdictionRelation] JR
		inner join [Jurisdiction] J on JR.[JurisdictionId]=J.[JurisdictionId]
		where J.[ApplicationId] = @ApplicationId and JR.[JurisdictionId] = @JurisdictionId
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupId]
	@ApplicationId uniqueidentifier,
	@JurisdictionGroupId int
AS
BEGIN
	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and [JurisdictionGroupId] = @JurisdictionGroupId
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroups]
	@ApplicationId uniqueidentifier,
	@JurisdictionType int = null
AS
BEGIN
	select * from [JurisdictionGroup] JG
		where [ApplicationId] = @ApplicationId and 
			(COALESCE(@JurisdictionType, JG.[JurisdictionType]) = JG.[JurisdictionType] OR JG.[JurisdictionType] is null)
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 19, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 18;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderForm_Delete]
(
	@OrderFormId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	select @TempObjectId = LineItemId FROM [LineItem] where OrderFormId = @OrderFormId
	DELETE FROM [LineItem] where OrderFormId = @OrderFormId
	DELETE FROM [LineItemEx] where ObjectId = @TempObjectId

	-- Delete payments
	select @TempObjectId = PaymentId FROM [OrderFormPayment] where OrderFormId = @OrderFormId
	DELETE FROM [OrderFormPayment] where OrderFormId = @OrderFormId
	DELETE FROM [OrderFormPayment_CreditCard] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_CashCard] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_GiftCard] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_Invoice] WHERE ObjectId = @TempObjectId
	DELETE FROM [OrderFormPayment_Other] WHERE ObjectId = @TempObjectId

	DELETE FROM [OrderFormDiscount] where OrderFormId = @OrderFormId

	select @TempObjectId = ShipmentId FROM [Shipment] where OrderFormId = @OrderFormId
	DELETE FROM [Shipment] where OrderFormId = @OrderFormId
	DELETE FROM [ShipmentEx] WHERE ObjectId = @TempObjectId

	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderFormId = @OrderFormId
	DELETE FROM [OrderForm] where OrderFormId = @OrderFormId
	DELETE FROM [OrderFormEx] WHERE ObjectId = @TempObjectId

	DELETE FROM [OrderForm] WHERE [OrderFormId] = @OrderFormId

	RETURN @@Error'


--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 22, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 19;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroupAddress_Delete]
(
	@OrderGroupAddressId int
)
AS
	SET NOCOUNT ON

	EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @OrderGroupAddressId
	DELETE FROM [OrderGroupAddress] WHERE [OrderGroupAddressId] = @OrderGroupAddressId

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderFormPayment_Delete]
(
	@PaymentId int
)
AS
	SET NOCOUNT ON

	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @PaymentId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @PaymentId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @PaymentId	
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @PaymentId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @PaymentId
	DELETE FROM [OrderFormPayment] WHERE [PaymentId] = @PaymentId 

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_LineItem_Delete]
(
	@LineItemId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @LineItemId
	DELETE FROM [LineItemDiscount] WHERE [LineItemId] = @LineItemId
	DELETE FROM [LineItem] WHERE [LineItemId] = @LineItemId

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Shipment_Delete]
(
	@ShipmentId int
)
AS
	SET NOCOUNT ON

	EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @ShipmentId
	DELETE FROM [ShipmentDiscount] where ShipmentId = @ShipmentId
	DELETE FROM [Shipment] WHERE  [ShipmentId] = @ShipmentId	

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Delete]
(
	@OrderGroupId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	DELETE FROM [LineItemDiscount] where OrderGroupId = @OrderGroupId
	
	select @TempObjectId = LineItemId FROM [LineItem] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @TempObjectId
	DELETE FROM [LineItem] where OrderGroupId = @OrderGroupId

	-- Delete payments
	select @TempObjectId = PaymentId FROM [OrderFormPayment] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @TempObjectId	
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @TempObjectId
	DELETE FROM [OrderFormPayment] where OrderGroupId = @OrderGroupId	

	DELETE FROM [OrderFormDiscount] where OrderGroupId = @OrderGroupId
	DELETE FROM [ShipmentDiscount] where OrderGroupId = @OrderGroupId

	select @TempObjectId = ShipmentId FROM [Shipment] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @TempObjectId
	DELETE FROM [Shipment] where OrderGroupId = @OrderGroupId

	select @TempObjectId = OrderGroupAddressId FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @TempObjectId
	DELETE FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId

	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderFormEx_Delete] @TempObjectId
	DELETE FROM [OrderForm] where OrderGroupId = @OrderGroupId

	EXEC [dbo].[mdpsp_avto_OrderGroup_PaymentPlan_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_PurchaseOrder_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_ShoppingCart_Delete] @OrderGroupId
	DELETE FROM [OrderGroup] where OrderGroupId = @OrderGroupId

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderForm_Delete]
(
	@OrderFormId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	-- Delete line items
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT LineItemId FROM [LineItem] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		DELETE FROM [LineItemDiscount] where LineItemId = @TempObjectId
		EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [LineItem] where OrderFormId = @OrderFormId

	-- Delete payments
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT PaymentId FROM [OrderFormPayment] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @TempObjectId	
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [OrderFormPayment] where OrderFormId = @OrderFormId

	-- Delete OrderFormDiscount
	DELETE FROM [OrderFormDiscount] where OrderFormId = @OrderFormId

	-- Delete Shipment
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT ShipmentId FROM [Shipment] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		DELETE FROM [ShipmentDiscount] where ShipmentId = @TempObjectId
		EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [Shipment] where OrderFormId = @OrderFormId

	-- Delete OrderForm
	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderFormId = @OrderFormId
	EXEC [dbo].[mdpsp_avto_OrderFormEx_Delete] @TempObjectId
	DELETE FROM [OrderForm] where OrderFormId = @OrderFormId

	RETURN @@Error'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 24, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 20;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_GetCases]
	@ShippingMethodId uniqueidentifier,
	@CountryCode nvarchar(50) = null,
	@Total money = null,
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
	SELECT C.Charge, C.Total, C.StartDate, C.EndDate, C.JurisdictionGroupId from ShippingMethodCase C 
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = C.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		(C.StartDate < getutcdate() OR C.StartDate is null) AND 
		(C.EndDate > getutcdate() OR C.EndDate is null) AND 
		C.ShippingMethodId = @ShippingMethodId AND
		(@Total > C.Total OR @Total is null) AND
		(J.CountryCode = @CountryCode OR (@CountryCode is null and J.CountryCode = ''WORLD'')) AND 
		JG.JurisdictionType = 2 /*shipping*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null) AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null) AND
		(COALESCE(@District, J.District) = J.District OR J.District is null) AND
		(COALESCE(@County, J.County) = J.County OR J.County is null) AND
		(COALESCE(@City, J.City) = J.City OR J.City is null)'


--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 26, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 21;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupId]
	@ApplicationId uniqueidentifier,
	@JurisdictionGroupId int
AS
BEGIN
	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and [JurisdictionGroupId] = @JurisdictionGroupId

	select JR.* from [JurisdictionRelation] JR
		inner join [JurisdictionGroup] J on JR.[JurisdictionGroupId]=J.[JurisdictionGroupId]
		where J.[ApplicationId] = @ApplicationId and JR.[JurisdictionGroupId] = @JurisdictionGroupId
END'


--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 02, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 22;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Tax]
	@ApplicationId uniqueidentifier,
	@TaxType int = null
AS
BEGIN
	select * from [Tax] 
		where [ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, [TaxType]) = [TaxType] OR [TaxType] is null)

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on TL.[TaxId]=T.[TaxId]
		where T.[ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)

	select TV.* from [TaxValue] TV
		inner join [Tax] T on TV.[TaxId]=T.[TaxId]
		where T.[ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


--------------- October 06, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 23;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Tax_TaxId]
	@TaxId int
AS
BEGIN
	select T.* from [Tax] T 
		where T.[TaxId] = @TaxId

	select TL.* from [TaxLanguage] TL
		where TL.[TaxId] = @TaxId

	select TV.* from [TaxValue] TV
		where TV.[TaxId] = @TaxId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 07, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 24;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Tax]
	@ApplicationId uniqueidentifier,
	@TaxType int = null
AS
BEGIN
	select T.* from [Tax] T 
		where T.[ApplicationId] = @ApplicationId and
			 (COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on TL.[TaxId]=T.[TaxId]
		where T.[ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)

	select TV.* from [TaxValue] TV
		inner join [Tax] T on TV.[TaxId]=T.[TaxId]
		where T.[ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 10, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 25;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.PaymentMethod	DROP CONSTRAINT IX_PaymentMethod'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.PaymentMethod ADD CONSTRAINT
	IX_PaymentMethod UNIQUE NONCLUSTERED 
	(
	ApplicationId,
	LanguageId,
	SystemKeyword
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [ShippingOption] ADD [ApplicationId] uniqueidentifier NULL'

EXEC dbo.sp_executesql @statement = N'UPDATE [ShippingOption] SET [ApplicationId]=(SELECT TOP 1 [ApplicationId] FROM [Application])'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [ShippingOption] ALTER COLUMN [ApplicationId] uniqueidentifier NOT NULL'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ShippingOption DROP CONSTRAINT IX_ShippingOption'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ShippingOption ADD CONSTRAINT
	IX_ShippingOption UNIQUE NONCLUSTERED 
	(
	ApplicationId,
	SystemKeyword
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ApplicationId] = @ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
		where SO.[ApplicationId] = @ApplicationId
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package] where [ApplicationId] = @ApplicationId
	select SP.* from [ShippingPackage] SP 
	inner join [Package] P on SP.[PackageId]=P.[PackageId]
		where P.[ApplicationId] = @ApplicationId
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] 
		where [ShippingOptionId] = @ShippingOptionId and [ApplicationId]=@ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SO.[ShippingOptionId]=SOP.[ShippingOptionId]
		where SO.[ShippingOptionId] = @ShippingOptionId and SO.[ApplicationId]=@ApplicationId
	select * from [Package] P
		inner join [ShippingPackage] SP on P.[PackageId]=SP.[PackageId]
			where SP.[ShippingOptionId] = @ShippingOptionId and P.[ApplicationId]=@ApplicationId
	select * from [ShippingPackage] where [ShippingOptionId] = @ShippingOptionId
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId and SM.[ApplicationId] = @ApplicationId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId and SM.[ApplicationId] = @ApplicationId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMC.* from [ShippingMethodCase] SMC
		inner join [ShippingMethod] SM on SMC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SC.* from [ShippingCountry] SC
		inner join [ShippingMethod] SM on SC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SPR.* from [ShippingPaymentRestriction] SPR
		inner join [ShippingMethod] SM on SPR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId and SPR.[RestrictShippingMethods] = 0

	select P.* from [Package] P
		inner join [ShippingPackage] SP on SP.[PackageId]=P.[PackageId]
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SP.* from [ShippingPackage] SP
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 17, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 26;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ord_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				sysname,	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.* /*, LOC.**/ FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId '' +
			N'' WHERE LOC.Language = '''''' + @Language + N''''''''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderSearch]
(
	@ApplicationId				uniqueidentifier,
	@SearchSetId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount				int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT TableName FROM MetaClass 
		WHERE Namespace like @Namespace + ''%'' AND ([Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and IsSystem = 0

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM [OrderGroup] OrderGroup'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON OrderGroup.[OrderGroupId] = META.[KEY] ''

	set @FilterQuery_tmp = N'' WHERE ApplicationId = '''''' + CAST(@ApplicationId as nvarchar(36)) + ''''''''
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''[OrderGroup].OrderGroupId''
	end

	set @FullQuery = N''SELECT count([OrderGroup].OrderGroupId) OVER() TotalRecords, [OrderGroup].OrderGroupId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, OrderGroupId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, OrderGroupId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, OrderGroupId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId) SELECT '''''' + cast(@SearchSetId as nvarchar(100)) + N'''''', OrderGroupId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @SearchSetId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64) = null
AS
BEGIN
	INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId)
	SELECT @SearchSetId, [OrderGroupId] FROM [OrderGroup_ShoppingCart] PO INNER JOIN OrderGroup OG ON PO.ObjectId = OG.OrderGroupId WHERE ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(10),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ApplicationId] = @ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
		where SO.[ApplicationId] = @ApplicationId
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package] where [ApplicationId] = @ApplicationId
	select SP.* from [ShippingPackage] SP 
	inner join [Package] P on SP.[PackageId]=P.[PackageId]
		where P.[ApplicationId] = @ApplicationId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 28, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 27;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [Country] ADD [ApplicationId] uniqueidentifier NULL'

EXEC dbo.sp_executesql @statement = N'UPDATE [Country] SET ApplicationId = (select top 1 [ApplicationId] from [Application])'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [Country] ALTER COLUMN [ApplicationId] uniqueidentifier NOT NULL'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Country]
	@ApplicationId uniqueidentifier
AS
BEGIN
	select * from [Country] 
		where [ApplicationId] = @ApplicationId
		order by [Ordering]

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId
		order by SP.[Ordering]
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Country_CountryId]
	@ApplicationId uniqueidentifier,
	@CountryId int
AS
BEGIN
	select * from [Country] 
		where [ApplicationId] = @ApplicationId and [CountryId] = @CountryId

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and SP.[CountryId] = @CountryId
		order by SP.[Ordering]
END'

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Country_Code]
	@ApplicationId uniqueidentifier,
	@Code nvarchar(3)
AS
BEGIN
	select * from [Country] 
		where [ApplicationId] = @ApplicationId and [Code] = @Code

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and C.[Code] = @Code
		order by SP.[Ordering]
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- November 10, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 28;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(10) = null,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ApplicationId] = @ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
		where SO.[ApplicationId] = @ApplicationId
	select * from [ShippingMethod] where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package] where [ApplicationId] = @ApplicationId
	select SP.* from [ShippingPackage] SP 
	inner join [Package] P on SP.[PackageId]=P.[PackageId]
		where P.[ApplicationId] = @ApplicationId
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Country]
	@ApplicationId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [Country] C 
		where [ApplicationId] = @ApplicationId and 
			(([Visible] = 1) or @ReturnInactive = 1)
		order by C.[Ordering], C.[Name]

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and 
			((C.[Visible] = 1) or @ReturnInactive = 1) and 
			((SP.[Visible] = 1) or @ReturnInactive = 1)
		order by SP.[Ordering], SP.[Name]
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Country_Code]
	@ApplicationId uniqueidentifier,
	@Code nvarchar(3),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [Country] C 
		where [ApplicationId] = @ApplicationId and [Code] = @Code and
			((C.[Visible] = 1) or @ReturnInactive = 1)

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and C.[Code] = @Code and
			((C.[Visible] = 1) or @ReturnInactive = 1) and 
			((SP.[Visible] = 1) or @ReturnInactive = 1)
		order by SP.[Ordering], SP.[Name]
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Country_CountryId]
	@ApplicationId uniqueidentifier,
	@CountryId int,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [Country] C 
		where [ApplicationId] = @ApplicationId and [CountryId] = @CountryId and 
			((C.[Visible] = 1) or @ReturnInactive = 1)

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and SP.[CountryId] = @CountryId and 
			((C.[Visible] = 1) or @ReturnInactive = 1) and 
			((SP.[Visible] = 1) or @ReturnInactive = 1)
		order by SP.[Ordering], SP.[Name]
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- November 11, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 29;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ShippingMethod
	DROP CONSTRAINT IX_ShippingMethod'
	
EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ShippingMethod ADD CONSTRAINT
	IX_ShippingMethod UNIQUE NONCLUSTERED 
	(
	ApplicationId,
	LanguageId,
	Name
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- December 18, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 30;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @SearchSetId uniqueidentifier
AS
BEGIN
	DECLARE @search_condition nvarchar(max)

    -- Return GroupIds.
    SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId

	-- Return Order Form Collection
	SELECT ''OrderForm'' TableName, * FROM [OrderFormEx] OE INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Collection
	/* the following sql is faster that the previously used one */
	SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  INNER JOIN [OrderSearchResults] R ON O.[OrderGroupId] = R.[OrderGroupId] WHERE R.[SearchSetId] = @SearchSetId
	--SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId WHERE [O].[OrdergroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Collection
	SELECT ''Shipment'' TableName, * FROM [ShipmentEx] SE INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId WHERE [S].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Collection
	SELECT ''LineItem'' TableName, * FROM [LineItemEx] LE INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId WHERE [L].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Payment Collection

		SET @search_condition = N''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''

		-- Credit Cards
		exec mdpsp_avto_OrderFormPayment_CreditCard_Search NULL, ''''''OrderFormPayment_CreditCard'''' TableName, [O].*'', @search_condition

		-- Cash Cards	
		exec mdpsp_avto_OrderFormPayment_CashCard_Search NULL, ''''''OrderFormPayment_CashCard'''' TableName, [O].*'', @search_condition

		-- Gift Cards	
		exec mdpsp_avto_OrderFormPayment_GiftCard_Search NULL, ''''''OrderFormPayment_GiftCard'''' TableName, [O].*'', @search_condition

		-- Invoices
		exec mdpsp_avto_OrderFormPayment_Invoice_Search NULL, ''''''OrderFormPayment_Invoice'''' TableName, [O].*'', @search_condition

		-- Other
		exec mdpsp_avto_OrderFormPayment_Other_Search NULL, ''''''OrderFormPayment_Other'''' TableName, [O].*'', @search_condition

	-- Return Order Form Discount Collection
	SELECT ''OrderFormDiscount'' TableName, * FROM [OrderFormDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Discount Collection
	SELECT ''LineItemDiscount'' TableName, * FROM [LineItemDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Discount Collection
	SELECT ''ShipmentDiscount'' TableName, * FROM [ShipmentDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_PurchaseOrder]
    @SearchSetId uniqueidentifier
AS
BEGIN
	exec [dbo].[ecf_Search_OrderGroup] @SearchSetId

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM OrderSearchResults WHERE @SearchSetId = SearchSetId

END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_ShoppingCart]
    @SearchSetId uniqueidentifier
AS
BEGIN
    exec [dbo].[ecf_Search_OrderGroup] @SearchSetId

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''
	exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM OrderSearchResults WHERE @SearchSetId = SearchSetId

END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_PaymentPlan]
    @SearchSetId uniqueidentifier
AS
BEGIN
	exec [dbo].[ecf_Search_OrderGroup] @SearchSetId

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM OrderSearchResults WHERE @SearchSetId = SearchSetId

END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- December 18, 2008 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 31;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_GetCases]
	@ShippingMethodId uniqueidentifier,
	@CountryCode nvarchar(50) = null,
	@Total money = null,
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
BEGIN
/* First set all empty string variables except ShippingMethodId to NULL */
IF (LTRIM(RTRIM(@CountryCode)) = '''')
  SET @CountryCode = NULL

IF (LTRIM(RTRIM(@StateProvinceCode)) = '''')
  SET @StateProvinceCode = NULL

IF (LTRIM(RTRIM(@ZipPostalCode)) = '''')
  SET @ZipPostalCode = NULL

IF (LTRIM(RTRIM(@District)) = '''')
  SET @District = NULL

IF (LTRIM(RTRIM(@County)) = '''')
  SET @County = NULL

IF (LTRIM(RTRIM(@City )) = '''')
  SET @City = NULL

/* If Jurisdiction values in database are null or an empty string, they will return the same results */
	SELECT C.Charge, C.Total, C.StartDate, C.EndDate, C.JurisdictionGroupId from ShippingMethodCase C 
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = C.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		(C.StartDate < getutcdate() OR C.StartDate is null) AND 
		(C.EndDate > getutcdate() OR C.EndDate is null) AND 
		C.ShippingMethodId = @ShippingMethodId AND
		(@Total > C.Total OR @Total is null) AND
		(J.CountryCode = @CountryCode OR (@CountryCode is null and J.CountryCode = ''WORLD'')) AND 
		JG.JurisdictionType = 2 /*shipping*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null OR RTRIM(LTRIM(J.StateProvinceCode)) = '''') AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null OR RTRIM(LTRIM(J.ZipPostalCodeStart)) = '''') AND
		(COALESCE(@District, J.District) = J.District OR J.District is null OR RTRIM(LTRIM(J.District)) = '''') AND
		(COALESCE(@County, J.County) = J.County OR J.County is null OR RTRIM(LTRIM(J.County)) = '''') AND
		(COALESCE(@City, J.City) = J.City OR J.City is null OR RTRIM(LTRIM(J.City)) = '''')
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- January 27, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 32;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @SearchSetId uniqueidentifier
AS
BEGIN
	DECLARE @search_condition nvarchar(max)

    -- Return GroupIds.
    SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId

	-- Prevent any queries if order group doesn''t exist
	IF(NOT EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)))
		RETURN;

	-- Return Order Form Collection
	SELECT ''OrderForm'' TableName, * FROM [OrderFormEx] OE INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	if(@@ROWCOUNT = 0)
		RETURN;

	-- Return Order Form Collection
	/* the following sql is faster that the previously used one */
	SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  INNER JOIN [OrderSearchResults] R ON O.[OrderGroupId] = R.[OrderGroupId] WHERE R.[SearchSetId] = @SearchSetId
	--SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId WHERE [O].[OrdergroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Collection
	SELECT ''Shipment'' TableName, * FROM [ShipmentEx] SE INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId WHERE [S].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Collection
	SELECT ''LineItem'' TableName, * FROM [LineItemEx] LE INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId WHERE [L].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Payment Collection

		SET @search_condition = N''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''

		-- Credit Cards
		exec mdpsp_avto_OrderFormPayment_CreditCard_Search NULL, ''''''OrderFormPayment_CreditCard'''' TableName, [O].*'', @search_condition

		-- Cash Cards	
		exec mdpsp_avto_OrderFormPayment_CashCard_Search NULL, ''''''OrderFormPayment_CashCard'''' TableName, [O].*'', @search_condition

		-- Gift Cards	
		exec mdpsp_avto_OrderFormPayment_GiftCard_Search NULL, ''''''OrderFormPayment_GiftCard'''' TableName, [O].*'', @search_condition

		-- Invoices
		exec mdpsp_avto_OrderFormPayment_Invoice_Search NULL, ''''''OrderFormPayment_Invoice'''' TableName, [O].*'', @search_condition

		-- Other
		exec mdpsp_avto_OrderFormPayment_Other_Search NULL, ''''''OrderFormPayment_Other'''' TableName, [O].*'', @search_condition

	-- Return Order Form Discount Collection
	SELECT ''OrderFormDiscount'' TableName, * FROM [OrderFormDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Discount Collection
	SELECT ''LineItemDiscount'' TableName, * FROM [LineItemDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Discount Collection
	SELECT ''ShipmentDiscount'' TableName, * FROM [ShipmentDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- assign random local variable to set @@rowcount attribute to 1
	declare @temp as int
	set @temp = 1
END' 

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_ShoppingCart]
    @SearchSetId uniqueidentifier
AS
BEGIN
    exec [dbo].[ecf_Search_OrderGroup] @SearchSetId

	IF(@@ROWCOUNT > 0)
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM OrderSearchResults WHERE @SearchSetId = SearchSetId

END' 

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- February 5, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 33;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_Customer]') AND type in (N'P', N'PC'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_ShoppingCart_Customer]
	@ApplicationId uniqueidentifier,
	@SearchSetId uniqueidentifier,
	@CustomerId uniqueidentifier
AS
BEGIN
	INSERT INTO OrderSearchResults (SearchSetId, OrderGroupId)
	SELECT @SearchSetId, [OrderGroupId] FROM [OrderGroup_ShoppingCart] PO 
	INNER JOIN OrderGroup OG ON PO.ObjectId = OG.OrderGroupId 
	WHERE ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
END'
END

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- February 12, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 34;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupCode]
	@ApplicationId uniqueidentifier,
	@JurisdictionGroupCode nvarchar(50)
AS
BEGIN
	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and [Code] = @JurisdictionGroupCode

	select JR.* from [JurisdictionRelation] JR
		inner join [JurisdictionGroup] J on JR.[JurisdictionGroupId]=J.[JurisdictionGroupId]
		where J.[ApplicationId] = @ApplicationId and J.[Code] = @JurisdictionGroupCode
END'

exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionCode]
	@ApplicationId uniqueidentifier,
	@JurisdictionCode nvarchar(50),
	@ReturnAllGroups bit = 0
AS
BEGIN
	select * from [Jurisdiction] 
		where [ApplicationId] = @ApplicationId and [Code] = @JurisdictionCode

	IF @ReturnAllGroups=1 BEGIN -- return all jurisdiction groups of the found jurisdiction type
		select * from [JurisdictionGroup] 
			where [JurisdictionType] IN (select [JurisdictionType] from [Jurisdiction] 
											where [ApplicationId] = @ApplicationId and [Code] = @JurisdictionCode)
	END ELSE BEGIN
		select JG.* from [JurisdictionGroup] JG
			inner join [JurisdictionRelation] JR on JR.[JurisdictionGroupId] = JG.[JurisdictionGroupId]
			inner join [Jurisdiction] J on JR.[JurisdictionId] = J.[JurisdictionId]
			where JG.[ApplicationId] = @ApplicationId and J.[Code] = @JurisdictionCode
	END

	select JR.* from [JurisdictionRelation] JR
		inner join [Jurisdiction] J on JR.[JurisdictionId]=J.[JurisdictionId]
		where J.[ApplicationId] = @ApplicationId and J.[Code] = @JurisdictionCode
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- February 16, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 35;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Tax_TaxName]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(50)
AS
BEGIN
	select T.* from [Tax] T 
		where T.[Name] = @Name and T.[ApplicationId] = @ApplicationId

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on T.[TaxId] = TL.[TaxId]
			where T.[Name] = @Name and T.[ApplicationId] = @ApplicationId

	select TV.* from [TaxValue] TV
		inner join [Tax] T on T.[TaxId] = TV.[TaxId]
			where T.[Name] = @Name and T.[ApplicationId] = @ApplicationId
END'

exec dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Tax_TaxId]
	@ApplicationId uniqueidentifier,
	@TaxId int	
AS
BEGIN
	select T.* from [Tax] T 
		where T.[TaxId] = @TaxId and T.[ApplicationId] = @ApplicationId

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on T.[TaxId] = TL.[TaxId]
			where TL.[TaxId] = @TaxId and T.[ApplicationId] = @ApplicationId

	select TV.* from [TaxValue] TV
		inner join [Tax] T on T.[TaxId] = TV.[TaxId]
			where TV.[TaxId] = @TaxId and T.[ApplicationId] = @ApplicationId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- February 18, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 36;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingPackage_PackageId]
	@ApplicationId uniqueidentifier,
	@PackageId int
AS
	select * from [Package] P 
		where P.[ApplicationId] = @ApplicationId and P.[PackageId] = @PackageId'
		
exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingPackage_Name]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(100)
AS
	select * from [Package] P 
		where P.[ApplicationId] = @ApplicationId and P.[Name] = @Name'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- March 10, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 37;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec dbo.sp_executesql @statement = N'ALTER TABLE dbo.OrderStatus DROP CONSTRAINT PK_OrderStatus'
		
exec dbo.sp_executesql @statement = N'ALTER TABLE dbo.OrderStatus ADD CONSTRAINT
	PK_OrderStatus PRIMARY KEY CLUSTERED 
	(
	OrderStatusId,
	ApplicationId
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- March 25, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 38;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_PaymentMethod_SystemKeyword]
	@ApplicationId uniqueidentifier,
	@SystemKeyword nvarchar(30),
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		([SystemKeyword] = @SystemKeyword) and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		(PM.[SystemKeyword] = @SystemKeyword) and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		(PM.[SystemKeyword] = @SystemKeyword) and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=1
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- August 12, 2009 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 39;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_ShoppingCart]
    @SearchSetId uniqueidentifier
AS
BEGIN
    exec [dbo].[ecf_Search_OrderGroup] @SearchSetId

	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end

    -- Cleanup the loaded OrderGroupIds from SearchResults.
    DELETE FROM OrderSearchResults WHERE @SearchSetId = SearchSetId

END' 


--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


--------------- October 02, 2009 ------------------------------------

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 40;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'DROP INDEX IX_OrderSearchResults_SearchSetId ON dbo.OrderSearchResults'
EXEC dbo.sp_executesql @statement = N'CREATE CLUSTERED INDEX IX_OrderSearchResults_SearchSetId ON dbo.OrderSearchResults
	(
	SearchSetId
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]' 


--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- March 01, 2010 ------------------------------------
-- Rma, Security, Lock, Comment, SiteId --
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 41;
Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Delete]
(
	@OrderGroupId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	-- Delete OrderForm
	DECLARE _cursorOrderForm CURSOR READ_ONLY FAST_FORWARD FOR 
		SELECT OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	OPEN _cursorOrderForm
	FETCH NEXT FROM _cursorOrderForm INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[ecf_OrderForm_Delete] @TempObjectId
		FETCH NEXT FROM _cursorOrderForm INTO @TempObjectId
	END
	CLOSE _cursorOrderForm
	DEALLOCATE _cursorOrderForm

	-- Delete OrderGroupAddress
	DECLARE _cursor CURSOR READ_ONLY FAST_FORWARD FOR 
		SELECT OrderGroupAddressId FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId

	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderFormEx_Delete] @TempObjectId
	DELETE FROM [OrderForm] where OrderGroupId = @OrderGroupId

	EXEC [dbo].[mdpsp_avto_OrderGroup_PaymentPlan_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_PurchaseOrder_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_ShoppingCart_Delete] @OrderGroupId
	DELETE FROM [OrderGroup] where OrderGroupId = @OrderGroupId

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderForm_Delete]
(
	@OrderFormId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	-- Delete line items
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT LineItemId FROM [LineItem] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		DELETE FROM [LineItemDiscount] where LineItemId = @TempObjectId
		EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [LineItem] where OrderFormId = @OrderFormId

	-- Delete payments
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT PaymentId FROM [OrderFormPayment] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @TempObjectId	
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [OrderFormPayment] where OrderFormId = @OrderFormId

	-- Delete OrderFormDiscount
	DELETE FROM [OrderFormDiscount] where OrderFormId = @OrderFormId

	-- Delete Shipment
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT ShipmentId FROM [Shipment] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		DELETE FROM [ShipmentDiscount] where ShipmentId = @TempObjectId
		EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [Shipment] where OrderFormId = @OrderFormId

	-- Delete OrderForm
	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderFormId = @OrderFormId
	EXEC [dbo].[mdpsp_avto_OrderFormEx_Delete] @TempObjectId
	DELETE FROM [OrderForm] where OrderFormId = @OrderFormId

	RETURN @@Error'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- April 07, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 42;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

PRINT N'Altering [dbo].[LineItem]'
ALTER TABLE [dbo].[LineItem] ADD
[ReturnReason] [nvarchar] (255)  NULL,
[OrigLineItemId] [int] NULL

PRINT N'Altering [dbo].[OrderForm]'
ALTER TABLE [dbo].[OrderForm] ADD
[ReturnComment] [nvarchar] (1024)  NULL,
[ReturnType] [nvarchar] (50)  NULL,
[ReturnAuthCode] [nvarchar] (255)  NULL,
[OrigOrderFormId] [int] NULL,
[ExchangeOrderGroupId] [int] NULL

PRINT N'Altering [dbo].[OrderGroup]'
ALTER TABLE [dbo].[OrderGroup] ADD
[SiteId] [nvarchar] (255)  NULL,
[OwnerOrg] [nvarchar] (255)  NULL,
[Owner] [nvarchar] (255)  NULL

PRINT N'Creating [dbo].[OrderGroupNote]'
CREATE TABLE [dbo].[OrderGroupNote]
(
[OrderNoteId] [int] NOT NULL IDENTITY(1, 1),
[OrderGroupId] [int] NOT NULL,
[CustomerId] [uniqueidentifier] NOT NULL,
[Title] [nvarchar] (255)  NULL,
[Type] [nvarchar] (50)  NULL,
[Detail] [ntext]  NULL,
[Created] [datetime] NOT NULL,
[LineItemId] [int] NULL,
)

PRINT N'Creating primary key [PK_OrderGroupNote] on [dbo].[OrderGroupNote]'
ALTER TABLE [dbo].[OrderGroupNote] ADD CONSTRAINT [PK_OrderGroupNote] PRIMARY KEY CLUSTERED ([OrderNoteId])

EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE mdpsp_sys_RegiterMetaFieldInSystemClass 
-- Add the parameters for the stored procedure here
	@ClassName nvarchar(255), 
	@TableName nvarchar(255),
	@Namespace nvarchar(255)
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ClassId int
	DECLARE @FieldName nvarchar(255)
	DECLARE @FriendlyFieldName nvarchar(255)
	DECLARE @DataTypeId int
	DECLARE @Length int
	DECLARE @Nullable bit
	DECLARE @DUMMY int

    SELECT @ClassId = [MetaClassId] FROM [MetaClass] WHERE [Name] = @ClassName

	DECLARE fieldCursor CURSOR FOR 
		SELECT @Namespace+ N''.'' + @ClassName, SC .[name] as Name , SC .[name] , @ClassId ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0, 0  FROM SYSCOLUMNS AS SC  
			INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.[ID]
			INNER JOIN SYSTYPES ST ON ST.[xtype] = SC.[xtype]
			INNER JOIN MetaDataType MDT ON MDT.[Name] = ST.[name]
		WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname'' and SC .[name] NOT IN (SELECT MF.Name FROM [MetaField] MF WHERE SystemMetaClassId = @ClassId)
		ORDER BY COLORDER 

	OPEN fieldCursor
	FETCH NEXT FROM fieldCursor INTO @Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable, @DUMMY, @DUMMY, @DUMMY, @DUMMY
	WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT ''Registering new MetaField '' + @FieldName 

			INSERT INTO [MetaField] ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls],  [SaveHistory], [MultiLanguageValue], [AllowSearch], [IsEncrypted]) VALUES (@Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable,  0, 0, 0, 0)
			INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
					SELECT MC.[MetaClassId], @@IDENTITY FROM (
						SELECT [MetaClassId] FROM MetaClass WHERE ParentClassId = @ClassId UNION
						SELECT @ClassId
					) MC

			FETCH NEXT FROM fieldCursor INTO @Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable, @DUMMY, @DUMMY, @DUMMY, @DUMMY
		END 
	CLOSE fieldCursor
	DEALLOCATE fieldCursor
END'

EXEC dbo.sp_executesql @statement = N'
  exec mdpsp_sys_RegiterMetaFieldInSystemClass ''OrderGroup'',''OrderGroup'',''Mediachase.Commerce.Orders.System''
  exec mdpsp_sys_RegiterMetaFieldInSystemClass ''OrderForm'',''OrderForm'',''Mediachase.Commerce.Orders.System''
  exec mdpsp_sys_RegiterMetaFieldInSystemClass ''LineItem'',''LineItem'',''Mediachase.Commerce.Orders.System''   '

PRINT N'Creating [dbo].[mc_OrderGroupNoteInsert]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupNoteInsert]
@OrderGroupId AS Int,
@CustomerId AS UniqueIdentifier,
@Title AS NVarChar(4000),
@Type AS NVarChar(4000),
@Detail AS NText,
@Created AS DateTime,
@LineItemId AS Int,
@OrderNoteId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [OrderGroupNote]
(
[OrderGroupId],
[CustomerId],
[Title],
[Type],
[Detail],
[Created],
[LineItemId])
VALUES(
@OrderGroupId,
@CustomerId,
@Title,
@Type,
@Detail,
@Created,
@LineItemId)
SELECT @OrderNoteId = SCOPE_IDENTITY()
END'


PRINT N'Creating [dbo].[mc_OrderGroupNoteUpdate]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupNoteUpdate]
@OrderGroupId AS Int,
@CustomerId AS UniqueIdentifier,
@Title AS NVarChar(4000),
@Type AS NVarChar(4000),
@Detail AS NText,
@Created AS DateTime,
@LineItemId AS Int,
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [OrderGroupNote] SET
[OrderGroupId] = @OrderGroupId,
[CustomerId] = @CustomerId,
[Title] = @Title,
[Type] = @Type,
[Detail] = @Detail,
[Created] = @Created,
[LineItemId] = @LineItemId WHERE
[OrderNoteId] = @OrderNoteId
END'

PRINT N'Creating [dbo].[mc_OrderGroupNoteDelete]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupNoteDelete]
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [OrderGroupNote]
WHERE
[OrderNoteId] = @OrderNoteId
END'


PRINT N'Creating [dbo].[OrderGroupLock]'
CREATE TABLE [dbo].[OrderGroupLock]
(
[OrderLockId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [uniqueidentifier] NOT NULL,
[Created] [datetime] NOT NULL,
[OrderGroupId] [int] NOT NULL
)

PRINT N'Creating primary key [PK_OrderGroupLock] on [dbo].[OrderGroupLock]'
ALTER TABLE [dbo].[OrderGroupLock] ADD CONSTRAINT [PK_OrderGroupLock] PRIMARY KEY CLUSTERED ([OrderLockId])

PRINT N'Creating [dbo].[mc_OrderGroupLockUpdate]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupLockUpdate]
@CustomerId AS UniqueIdentifier,
@Created AS DateTime,
@OrderGroupId AS Int,
@OrderLockId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [OrderGroupLock] SET
[CustomerId] = @CustomerId,
[Created] = @Created,
[OrderGroupId] = @OrderGroupId WHERE
[OrderLockId] = @OrderLockId
END'

PRINT N'Creating [dbo].[mc_OrderGroupLockDelete]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupLockDelete]
@OrderLockId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [OrderGroupLock]
WHERE
[OrderLockId] = @OrderLockId
END'

PRINT N'Creating [dbo].[mc_OrderGroupLockSelect]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupLockSelect]
@OrderLockId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[OrderLockId] AS [OrderLockId], [t01].[CustomerId] AS [CustomerId], [t01].[Created] AS [Created], [t01].[OrderGroupId] AS [OrderGroupId]
FROM [OrderGroupLock] AS [t01]
WHERE ([t01].[OrderLockId]=@OrderLockId)
END'

PRINT N'Altering [dbo].[Security_RoleAssignment]'
ALTER TABLE [dbo].[Security_RoleAssignment] ADD
[IsOnlyForOwner] [bit] NOT NULL CONSTRAINT [DF_Security_RoleAssignment_IsOnlyForOwner] DEFAULT ((0))

PRINT N'Altering [dbo].[mc_Security_RoleAssignmentInsert]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mc_Security_RoleAssignmentInsert]
@SecurityRoleAssignmentId AS UniqueIdentifier,
@RoleParticipant AS UniqueIdentifier,
@Role AS NVarChar(4000),
@Scope AS NText,
@CheckMode AS Int,
@IsOnlyForOwner AS Bit
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [Security_RoleAssignment]
(
[SecurityRoleAssignmentId],
[RoleParticipant],
[Role],
[Scope],
[CheckMode],
[IsOnlyForOwner])
VALUES(
@SecurityRoleAssignmentId,
@RoleParticipant,
@Role,
@Scope,
@CheckMode,
@IsOnlyForOwner)
END'

PRINT N'Altering [dbo].[mc_Security_RoleAssignmentUpdate]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mc_Security_RoleAssignmentUpdate]
@RoleParticipant AS UniqueIdentifier,
@Role AS NVarChar(4000),
@Scope AS NText,
@CheckMode AS Int,
@IsOnlyForOwner AS Bit,
@SecurityRoleAssignmentId AS UniqueIdentifier
AS
BEGIN
SET NOCOUNT ON;

UPDATE [Security_RoleAssignment] SET
[RoleParticipant] = @RoleParticipant,
[Role] = @Role,
[Scope] = @Scope,
[CheckMode] = @CheckMode,
[IsOnlyForOwner] = @IsOnlyForOwner WHERE
[SecurityRoleAssignmentId] = @SecurityRoleAssignmentId
END'

PRINT N'Altering [dbo].[ecf_LineItem_Insert]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_LineItem_Insert]
(
	@LineItemId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(50),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [LineItem]
	(
		[OrderFormId],
		[OrderGroupId],
		[Catalog],
		[CatalogNode],
		[ParentCatalogEntryId],
		[CatalogEntryId],
		[Quantity],
		[PlacedPrice],
		[ListPrice],
		[LineItemDiscountAmount],
		[OrderLevelDiscountAmount],
		[ShippingAddressId],
		[ShippingMethodName],
		[ShippingMethodId],
		[ExtendedPrice],
		[Description],
		[Status],
		[DisplayName],
		[AllowBackordersAndPreorders],
		[InStockQuantity],
		[PreorderQuantity],
		[BackorderQuantity],
		[InventoryStatus],
		[LineItemOrdering],
		[ConfigurationId],
		[MinQuantity],
		[MaxQuantity],
		[ProviderId],
		[ReturnReason],
		[OrigLineItemId]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@Catalog,
		@CatalogNode,
		@ParentCatalogEntryId,
		@CatalogEntryId,
		@Quantity,
		@PlacedPrice,
		@ListPrice,
		@LineItemDiscountAmount,
		@OrderLevelDiscountAmount,
		@ShippingAddressId,
		@ShippingMethodName,
		@ShippingMethodId,
		@ExtendedPrice,
		@Description,
		@Status,
		@DisplayName,
		@AllowBackordersAndPreorders,
		@InStockQuantity,
		@PreorderQuantity,
		@BackorderQuantity,
		@InventoryStatus,
		@LineItemOrdering,
		@ConfigurationId,
		@MinQuantity,
		@MaxQuantity,
		@ProviderId,
		@ReturnReason,
		@OrigLineItemId
	)

	SELECT @LineItemId = SCOPE_IDENTITY()

	RETURN @@Error'

PRINT N'Altering [dbo].[ecf_LineItem_Update]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_LineItem_Update]
(
	@LineItemId int,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(255),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [LineItem]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[Catalog] = @Catalog,
		[CatalogNode] = @CatalogNode,
		[ParentCatalogEntryId] = @ParentCatalogEntryId,
		[CatalogEntryId] = @CatalogEntryId,
		[Quantity] = @Quantity,
		[PlacedPrice] = @PlacedPrice,
		[ListPrice] = @ListPrice,
		[LineItemDiscountAmount] = @LineItemDiscountAmount,
		[OrderLevelDiscountAmount] = @OrderLevelDiscountAmount,
		[ShippingAddressId] = @ShippingAddressId,
		[ShippingMethodName] = @ShippingMethodName,
		[ShippingMethodId] = @ShippingMethodId,
		[ExtendedPrice] = @ExtendedPrice,
		[Description] = @Description,
		[Status] = @Status,
		[DisplayName] = @DisplayName,
		[AllowBackordersAndPreorders] = @AllowBackordersAndPreorders,
		[InStockQuantity] = @InStockQuantity,
		[PreorderQuantity] = @PreorderQuantity,
		[BackorderQuantity] = @BackorderQuantity,
		[InventoryStatus] = @InventoryStatus,
		[LineItemOrdering] = @LineItemOrdering,
		[ConfigurationId] = @ConfigurationId,
		[MinQuantity] = @MinQuantity,
		[MaxQuantity] = @MaxQuantity,
		[ProviderId] = @ProviderId,
		[ReturnReason] = @ReturnReason,
		[OrigLineItemId] = @OrigLineItemId
	WHERE 
		[LineItemId] = @LineItemId

	IF @@ERROR > 0
	BEGIN
		RAISERROR(''Concurrency Error'',16,1)
	END

	RETURN @@Error'

PRINT N'Altering [dbo].[mc_Security_RoleAssignmentSelect]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[mc_Security_RoleAssignmentSelect]
@SecurityRoleAssignmentId AS UniqueIdentifier
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[SecurityRoleAssignmentId] AS [SecurityRoleAssignmentId], [t01].[RoleParticipant] AS [RoleParticipant], [t01].[Role] AS [Role], [t01].[Scope] AS [Scope], [t01].[CheckMode] AS [CheckMode], [t01].[IsOnlyForOwner] AS [IsOnlyForOwner]
FROM [Security_RoleAssignment] AS [t01]
WHERE ([t01].[SecurityRoleAssignmentId]=@SecurityRoleAssignmentId)
END'

PRINT N'Altering [dbo].[ecf_OrderForm_Insert]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderForm_Insert]
(
	@OrderFormId int = NULL OUTPUT,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@BillingAddressId nvarchar(50) = NULL,
	@DiscountAmount money,
	@SubTotal money,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@Total money,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@ReturnComment nvarchar(1024) = NULL,
	@ReturnType nvarchar(50) = NULL,
	@ReturnAuthCode nvarchar(255) = NULL,
	@OrigOrderFormId int = NULL,
	@ExchangeOrderGroupId int  = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderForm]
	(
		[OrderGroupId],
		[Name],
		[BillingAddressId],
		[DiscountAmount],
		[SubTotal],
		[ShippingTotal],
		[HandlingTotal],
		[TaxTotal],
		[Total],
		[Status],
		[ProviderId],
		[ReturnComment],
		[ReturnType],
		[ReturnAuthCode],
		[OrigOrderFormId],
		[ExchangeOrderGroupId]
	)
	VALUES
	(
		@OrderGroupId,
		@Name,
		@BillingAddressId,
		@DiscountAmount,
		@SubTotal,
		@ShippingTotal,
		@HandlingTotal,
		@TaxTotal,
		@Total,
		@Status,
		@ProviderId,
		@ReturnComment,
		@ReturnType,
		@ReturnAuthCode,
		@OrigOrderFormId,
		@ExchangeOrderGroupId
	)

	SELECT @OrderFormId = SCOPE_IDENTITY()

	RETURN @@Error'


PRINT N'Altering [dbo].[ecf_OrderForm_Update]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderForm_Update]
(
	@OrderFormId int,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@BillingAddressId nvarchar(50) = NULL,
	@DiscountAmount money,
	@SubTotal money,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@Total money,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@ReturnComment nvarchar(1024) = NULL,
	@ReturnType nvarchar(50) = NULL,
	@ReturnAuthCode nvarchar(255) = NULL,
	@OrigOrderFormId int = NULL,
	@ExchangeOrderGroupId int = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderForm]
	SET
		[OrderGroupId] = @OrderGroupId,
		[Name] = @Name,
		[BillingAddressId] = @BillingAddressId,
		[DiscountAmount] = @DiscountAmount,
		[SubTotal] = @SubTotal,
		[ShippingTotal] = @ShippingTotal,
		[HandlingTotal] = @HandlingTotal,
		[TaxTotal] = @TaxTotal,
		[Total] = @Total,
		[Status] = @Status,
		[ProviderId] = @ProviderId,
		[ReturnComment] = @ReturnComment,
		[ReturnType] = @ReturnType,
		[ReturnAuthCode] = @ReturnAuthCode,
		[OrigOrderFormId] = @OrigOrderFormId,
		[ExchangeOrderGroupId] = @ExchangeOrderGroupId
	WHERE 
		[OrderFormId] = @OrderFormId

	RETURN @@Error'
	
PRINT N'Altering [dbo].[ecf_OrderGroup_Insert]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Insert]
(
	@OrderGroupId int OUT,
	@InstanceId uniqueidentifier,
	@ApplicationId uniqueidentifier,
	@AffiliateId uniqueidentifier,
	@Name nvarchar(64) = NULL,
	@CustomerId uniqueidentifier,
	@CustomerName nvarchar(64) = NULL,
	@AddressId nvarchar(50) = NULL,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@SubTotal money,
	@Total money,
	@BillingCurrency nvarchar(64) = NULL,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@SiteId nvarchar(255) = NULL,
	@OwnerOrg nvarchar(255) = NULL,
	@Owner nvarchar(255) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	if(@OrderGroupId is null)
	begin
		INSERT
		INTO [OrderGroup]
		(
			[InstanceId],
			[ApplicationId],
			[AffiliateId],
			[Name],
			[CustomerId],
			[CustomerName],
			[AddressId],
			[ShippingTotal],
			[HandlingTotal],
			[TaxTotal],
			[SubTotal],
			[Total],
			[BillingCurrency],
			[Status],
			[ProviderId],
			[SiteId],
			[OwnerOrg],
			[Owner]
		)
		VALUES
		(
			@InstanceId,
			@ApplicationId,
			@AffiliateId,
			@Name,
			@CustomerId,
			@CustomerName,
			@AddressId,
			@ShippingTotal,
			@HandlingTotal,
			@TaxTotal,
			@SubTotal,
			@Total,
			@BillingCurrency,
			@Status,
			@ProviderId,
			@SiteId,
			@OwnerOrg,
			@Owner
		)
		SELECT @OrderGroupId = SCOPE_IDENTITY()
	end

	SET @Err = @@Error

	RETURN @Err
	END'
	
PRINT N'Altering [dbo].[ecf_OrderGroup_Update]'
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Update]
(
	@OrderGroupId int OUT,
	@InstanceId uniqueidentifier,
	@ApplicationId uniqueidentifier,
	@AffiliateId uniqueidentifier,
	@Name nvarchar(64) = NULL,
	@CustomerId uniqueidentifier,
	@CustomerName nvarchar(64) = NULL,
	@AddressId nvarchar(50) = NULL,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@SubTotal money,
	@Total money,
	@BillingCurrency nvarchar(64) = NULL,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@SiteId nvarchar(255) = NULL,
	@OwnerOrg nvarchar(255) = NULL,
	@Owner nvarchar(255) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

		UPDATE [OrderGroup]
		SET
			[InstanceId] = @InstanceId,
			[ApplicationId] = @ApplicationId,
			[AffiliateId] = @AffiliateId,
			[Name] = @Name,
			[CustomerId] = @CustomerId,
			[CustomerName] = @CustomerName,
			[AddressId] = @AddressId,
			[ShippingTotal] = @ShippingTotal,
			[HandlingTotal] = @HandlingTotal,
			[TaxTotal] = @TaxTotal,
			[SubTotal] = @SubTotal,
			[Total] = @Total,
			[BillingCurrency] = @BillingCurrency,
			[Status] = @Status,
			[ProviderId] = @ProviderId,
			[SiteId] = @SiteId,
			[OwnerOrg] = @OwnerOrg,
			[Owner] = @Owner
		WHERE
			[OrderGroupId] = @OrderGroupId

	SET @Err = @@Error

	RETURN @Err
	END'
	
PRINT N'Creating [dbo].[mc_OrderGroupLockInsert]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupLockInsert]
@CustomerId AS UniqueIdentifier,
@Created AS DateTime,
@OrderGroupId AS Int,
@OrderLockId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [OrderGroupLock]
(
[CustomerId],
[Created],
[OrderGroupId])
VALUES(
@CustomerId,
@Created,
@OrderGroupId)
SELECT @OrderLockId = SCOPE_IDENTITY();
END'

PRINT N'Creating [dbo].[mc_OrderGroupNoteSelect]'
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_OrderGroupNoteSelect]
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[OrderNoteId] AS [OrderNoteId], [t01].[OrderGroupId] AS [OrderGroupId], [t01].[CustomerId] AS [CustomerId], [t01].[Title] AS [Title], [t01].[Type] AS [Type], [t01].[Detail] AS [Detail], [t01].[Created] AS [Created], [t01].[LineItemId] AS [LineItemId]
FROM [OrderGroupNote] AS [t01]
WHERE ([t01].[OrderNoteId]=@OrderNoteId)
END'

EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[OrderFormPayment] ADD
[TransactionType] [nvarchar] (255) NULL,
[TransactionID] [nvarchar] (255) NULL'

EXEC dbo.sp_executesql @statement = N'
  exec mdpsp_sys_RegiterMetaFieldInSystemClass ''OrderFormPayment'',''OrderFormPayment'',''Mediachase.Commerce.Orders.System''
   '
   
-- modify SPs
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderFormPayment_Insert]
(
	@PaymentId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@BillingAddressId nvarchar(50) = NULL,
	@PaymentMethodId uniqueidentifier,
	@PaymentMethodName nvarchar(128) = NULL,
	@CustomerName nvarchar(64) = NULL,
	@Amount money,
	@PaymentType int,
	@ValidationCode nvarchar(64) = NULL,
	@AuthorizationCode nvarchar(255) = NULL,
	@TransactionType nvarchar(255) = NULL,
	@TransactionID nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@ImplementationClass nvarchar(255)
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderFormPayment]
	(
		[OrderFormId],
		[OrderGroupId],
		[BillingAddressId],
		[PaymentMethodId],
		[PaymentMethodName],
		[CustomerName],
		[Amount],
		[PaymentType],
		[ValidationCode],
		[AuthorizationCode],
		[TransactionType],
		[TransactionID],
		[Status],
		[ImplementationClass]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@BillingAddressId,
		@PaymentMethodId,
		@PaymentMethodName,
		@CustomerName,
		@Amount,
		@PaymentType,
		@ValidationCode,
		@AuthorizationCode,
		@TransactionType,
		@TransactionID,
		@Status,
		@ImplementationClass
	)

	SELECT @PaymentId = SCOPE_IDENTITY()

	RETURN @@Error'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderFormPayment_Update]
(
	@PaymentId int,
	@OrderFormId int,
	@OrderGroupId int,
	@BillingAddressId nvarchar(50) = NULL,
	@PaymentMethodId uniqueidentifier,
	@PaymentMethodName nvarchar(128) = NULL,
	@CustomerName nvarchar(64) = NULL,
	@Amount money,
	@PaymentType int,
	@ValidationCode nvarchar(64) = NULL,
	@AuthorizationCode nvarchar(255) = NULL,
	@TransactionType nvarchar(255) = NULL,
	@TransactionID nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@ImplementationClass nvarchar(255)
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderFormPayment]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[BillingAddressId] = @BillingAddressId,
		[PaymentMethodId] = @PaymentMethodId,
		[PaymentMethodName] = @PaymentMethodName,
		[CustomerName] = @CustomerName,
		[Amount] = @Amount,
		[PaymentType] = @PaymentType,
		[ValidationCode] = @ValidationCode,
		[AuthorizationCode] = @AuthorizationCode,
		[TransactionType] = @TransactionType,
		[TransactionID] = @TransactionID,
		[Status] = @Status,
		[ImplementationClass] = @ImplementationClass
	WHERE 
		[PaymentId] = @PaymentId

	RETURN @@Error'
	
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[PaymentMethod] ADD
[PaymentImplementationClassName] [nvarchar] (255) NULL'

EXEC dbo.sp_executesql N'UPDATE [dbo].[PaymentMethod] SET PaymentImplementationClassName = ''Mediachase.Commerce.Orders.CreditCardPayment, Mediachase.Commerce'' WHERE SystemKeyword = ''Authorize'' AND PaymentImplementationClassName IS NULL'
EXEC dbo.sp_executesql N'UPDATE [dbo].[PaymentMethod] SET PaymentImplementationClassName = ''Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce'' WHERE SystemKeyword = ''Generic'' AND PaymentImplementationClassName IS NULL'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- April 14, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 43;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

insert into [PaymentMethod] ([PaymentMethodId], [ApplicationId], [Name], [Description], [LanguageId], [SystemKeyword], [PaymentImplementationClassName], [IsActive], [IsDefault], [ClassName], [SupportsRecurring], [Ordering], [Created], [Modified])
select newid(), ApplicationId, 'ExchangePayment', 'Exchange Payment', 'en', 'Exchange', 'Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce', 0, 0, 'Mediachase.Commerce.Plugins.Payment.GenericPaymentGateway, Mediachase.Commerce.Plugins.Payment', 1, 2, '04/20/2010 00:00:00', '04/20/2010 00:00:00'
from Application

EXEC dbo.sp_executesql N'DECLARE @ParentClassId int, @RetVal int
SELECT @ParentClassId = MetaClassId FROM [dbo].[MetaClass] WHERE [Name] = ''OrderFormPayment'' AND IsSystem = 1
EXEC [dbo].[mdpsp_sys_CreateMetaClass] ''Mediachase.Commerce.Orders.System'', ''ExchangePayment'', ''Exchange Payment'', ''OrderFormPayment_Exchange'', @ParentClassId, 0, 0, ''Exchange Payment'', @Retval = @Retval OUTPUT'

-- modify SPs
EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @SearchSetId uniqueidentifier
AS
BEGIN
	DECLARE @search_condition nvarchar(max)

    -- Return GroupIds.
    SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId

	-- Prevent any queries if order group doesn''t exist
	IF(NOT EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)))
		RETURN;

	-- Return Order Form Collection
	SELECT ''OrderForm'' TableName, * FROM [OrderFormEx] OE INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	if(@@ROWCOUNT = 0)
		RETURN;

	-- Return Order Form Collection
	/* the following sql is faster that the previously used one */
	SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  INNER JOIN [OrderSearchResults] R ON O.[OrderGroupId] = R.[OrderGroupId] WHERE R.[SearchSetId] = @SearchSetId
	--SELECT ''OrderGroupAddress'' TableName, * FROM [OrderGroupAddressEx] OE INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId WHERE [O].[OrdergroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Collection
	SELECT ''Shipment'' TableName, * FROM [ShipmentEx] SE INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId WHERE [S].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Collection
	SELECT ''LineItem'' TableName, * FROM [LineItemEx] LE INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId WHERE [L].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Order Form Payment Collection

		SET @search_condition = N''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId WHERE [O].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N'''''')''

		-- Credit Cards
		exec mdpsp_avto_OrderFormPayment_CreditCard_Search NULL, ''''''OrderFormPayment_CreditCard'''' TableName, [O].*'', @search_condition

		-- Cash Cards	
		exec mdpsp_avto_OrderFormPayment_CashCard_Search NULL, ''''''OrderFormPayment_CashCard'''' TableName, [O].*'', @search_condition

		-- Gift Cards	
		exec mdpsp_avto_OrderFormPayment_GiftCard_Search NULL, ''''''OrderFormPayment_GiftCard'''' TableName, [O].*'', @search_condition

		-- Invoices
		exec mdpsp_avto_OrderFormPayment_Invoice_Search NULL, ''''''OrderFormPayment_Invoice'''' TableName, [O].*'', @search_condition

		-- Other
		exec mdpsp_avto_OrderFormPayment_Other_Search NULL, ''''''OrderFormPayment_Other'''' TableName, [O].*'', @search_condition

		-- Exchange
		exec mdpsp_avto_OrderFormPayment_Exchange_Search NULL, ''''''OrderFormPayment_Exchange'''' TableName, [O].*'', @search_condition

	-- Return Order Form Discount Collection
	SELECT ''OrderFormDiscount'' TableName, * FROM [OrderFormDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Line Item Discount Collection
	SELECT ''LineItemDiscount'' TableName, * FROM [LineItemDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- Return Shipment Discount Collection
	SELECT ''ShipmentDiscount'' TableName, * FROM [ShipmentDiscount] D WHERE [D].[OrderGroupId] IN (SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId)

	-- assign random local variable to set @@rowcount attribute to 1
	declare @temp as int
	set @temp = 1
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Delete]
(
	@OrderGroupId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	DELETE FROM [LineItemDiscount] where OrderGroupId = @OrderGroupId
	
	select @TempObjectId = LineItemId FROM [LineItem] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @TempObjectId
	DELETE FROM [LineItem] where OrderGroupId = @OrderGroupId

	-- Delete payments
	select @TempObjectId = PaymentId FROM [OrderFormPayment] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @TempObjectId	
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @TempObjectId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Exchange_Delete] @TempObjectId
	DELETE FROM [OrderFormPayment] where OrderGroupId = @OrderGroupId	

	DELETE FROM [OrderFormDiscount] where OrderGroupId = @OrderGroupId
	DELETE FROM [ShipmentDiscount] where OrderGroupId = @OrderGroupId

	select @TempObjectId = ShipmentId FROM [Shipment] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @TempObjectId
	DELETE FROM [Shipment] where OrderGroupId = @OrderGroupId

	select @TempObjectId = OrderGroupAddressId FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @TempObjectId
	DELETE FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId

	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderFormEx_Delete] @TempObjectId
	DELETE FROM [OrderForm] where OrderGroupId = @OrderGroupId

	EXEC [dbo].[mdpsp_avto_OrderGroup_PaymentPlan_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_PurchaseOrder_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_ShoppingCart_Delete] @OrderGroupId
	DELETE FROM [OrderGroup] where OrderGroupId = @OrderGroupId

	RETURN @@Error'
	
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- April 21, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 44;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'EXEC sp_rename ''mdpsp_sys_RegiterMetaFieldInSystemClass'', ''mdpsp_sys_RegisterMetaFieldInSystemClass'''

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- April 29, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 45;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'ALTER TABLE [dbo].[LineItem] ADD
[ReturnQuantity] [money] NOT NULL default 0'

EXEC dbo.sp_executesql @statement = N'
  exec mdpsp_sys_RegisterMetaFieldInSystemClass ''LineItem'',''LineItem'',''Mediachase.Commerce.Orders.System''   '

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_LineItem_Insert]
(
	@LineItemId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(50),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money
)
AS
	SET NOCOUNT ON

	INSERT INTO [LineItem]
	(
		[OrderFormId],
		[OrderGroupId],
		[Catalog],
		[CatalogNode],
		[ParentCatalogEntryId],
		[CatalogEntryId],
		[Quantity],
		[PlacedPrice],
		[ListPrice],
		[LineItemDiscountAmount],
		[OrderLevelDiscountAmount],
		[ShippingAddressId],
		[ShippingMethodName],
		[ShippingMethodId],
		[ExtendedPrice],
		[Description],
		[Status],
		[DisplayName],
		[AllowBackordersAndPreorders],
		[InStockQuantity],
		[PreorderQuantity],
		[BackorderQuantity],
		[InventoryStatus],
		[LineItemOrdering],
		[ConfigurationId],
		[MinQuantity],
		[MaxQuantity],
		[ProviderId],
		[ReturnReason],
		[OrigLineItemId],
		[ReturnQuantity]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@Catalog,
		@CatalogNode,
		@ParentCatalogEntryId,
		@CatalogEntryId,
		@Quantity,
		@PlacedPrice,
		@ListPrice,
		@LineItemDiscountAmount,
		@OrderLevelDiscountAmount,
		@ShippingAddressId,
		@ShippingMethodName,
		@ShippingMethodId,
		@ExtendedPrice,
		@Description,
		@Status,
		@DisplayName,
		@AllowBackordersAndPreorders,
		@InStockQuantity,
		@PreorderQuantity,
		@BackorderQuantity,
		@InventoryStatus,
		@LineItemOrdering,
		@ConfigurationId,
		@MinQuantity,
		@MaxQuantity,
		@ProviderId,
		@ReturnReason,
		@OrigLineItemId,
		@ReturnQuantity
	)

	SELECT @LineItemId = SCOPE_IDENTITY()

	RETURN @@Error'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_LineItem_Update]
(
	@LineItemId int,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(255),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money
)
AS
	SET NOCOUNT ON
	
	UPDATE [LineItem]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[Catalog] = @Catalog,
		[CatalogNode] = @CatalogNode,
		[ParentCatalogEntryId] = @ParentCatalogEntryId,
		[CatalogEntryId] = @CatalogEntryId,
		[Quantity] = @Quantity,
		[PlacedPrice] = @PlacedPrice,
		[ListPrice] = @ListPrice,
		[LineItemDiscountAmount] = @LineItemDiscountAmount,
		[OrderLevelDiscountAmount] = @OrderLevelDiscountAmount,
		[ShippingAddressId] = @ShippingAddressId,
		[ShippingMethodName] = @ShippingMethodName,
		[ShippingMethodId] = @ShippingMethodId,
		[ExtendedPrice] = @ExtendedPrice,
		[Description] = @Description,
		[Status] = @Status,
		[DisplayName] = @DisplayName,
		[AllowBackordersAndPreorders] = @AllowBackordersAndPreorders,
		[InStockQuantity] = @InStockQuantity,
		[PreorderQuantity] = @PreorderQuantity,
		[BackorderQuantity] = @BackorderQuantity,
		[InventoryStatus] = @InventoryStatus,
		[LineItemOrdering] = @LineItemOrdering,
		[ConfigurationId] = @ConfigurationId,
		[MinQuantity] = @MinQuantity,
		[MaxQuantity] = @MaxQuantity,
		[ProviderId] = @ProviderId,
		[ReturnReason] = @ReturnReason,
		[OrigLineItemId] = @OrigLineItemId,
		[ReturnQuantity] = @ReturnQuantity
	WHERE 
		[LineItemId] = @LineItemId

	IF @@ERROR > 0
	BEGIN
		RAISERROR(''Concurrency Error'',16,1)
	END

	RETURN @@Error'
	
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- June 07, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 46;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec sp_ExecuteSQL N'
declare @metaFieldId int
declare @classId int
declare @metaFieldTypeId int
declare @fieldName nvarchar(50)
declare @fieldType nvarchar(50)
declare @className nvarchar(50)
declare @namespace nvarchar(50)

set @fieldName = N''RMANumber''
set @fieldType = N''ShortString''
set @className = N''OrderFormEx''
set @namespace = N''Mediachase.Commerce.Orders''

select @metaFieldTypeId = [DataTypeId] FROM [dbo].[MetaDataType] WHERE  Name = @fieldType
select @classId = [MetaClassId] FROM [dbo].[MetaClass] WHERE Name=@className

exec mdpsp_sys_AddMetaField 
@Namespace=@namespace,@Name=@fieldName,@FriendlyName=@fieldName,@Description=@fieldName,@DataTypeId=@metaFieldTypeId,@Length=0,@AllowNulls=1,@SaveHistory=0,@MultiLanguageValue=0,@AllowSearch=0,@IsEncrypted=0,@Retval=@metaFieldId output
exec mdpsp_sys_AddMetaAttribute @AttrOwnerId=@metaFieldId,@AttrOwnerType=2,@Key=N''useincomparing'',@Value=N''True''
exec mdpsp_sys_AddMetaAttribute @AttrOwnerId=@metaFieldId,@AttrOwnerType=2,@Key=N''indexstored'',@Value=N''False''
exec mdpsp_sys_AddMetaAttribute @AttrOwnerId=@metaFieldId,@AttrOwnerType=2,@Key=N''indexfield'',@Value=N''tokenized''
exec mdpsp_sys_AddMetaFieldToMetaClass @MetaClassId=@classId, @MetaFieldId=@metaFieldId,@Weight=0'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- June 11, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 47;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN

--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderNoteType]') AND type in (N'U'))
BEGIN
exec sp_ExecuteSQL N'
	CREATE TABLE [dbo].[OrderNoteType](
	[OrderNoteTypeId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderNoteType] PRIMARY KEY CLUSTERED 
(
	[OrderNoteTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] '
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReturnFormStatus]') AND type in (N'U'))
BEGIN
exec sp_ExecuteSQL N'
CREATE TABLE [dbo].[ReturnFormStatus](
	[ReturnFormStatusId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ReturnFormStatus] PRIMARY KEY CLUSTERED 
(
	[ReturnFormStatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderShipmentStatus]') AND type in (N'U'))
BEGIN
exec sp_ExecuteSQL N'
CREATE TABLE [dbo].[OrderShipmentStatus](
	[OrderShipmentStatusId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderShipmentStatus] PRIMARY KEY CLUSTERED 
(
	[OrderShipmentStatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'
END

declare @ApplicationId uniqueidentifier
SELECT TOP 1 @ApplicationId = ApplicationId from [Application]

DELETE FROM [dbo].[OrderStatus]
--|--------------------------------------------------------------------------------
--| [OrderStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(1, 'OnHold', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(2, 'PartiallyShipped', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(3, 'InProgress', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(4, 'Completed', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(5, 'Cancelled', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(6, 'AwaitingExchange', @ApplicationId);
--|--------------------------------------------------------------------------------


DELETE FROM [dbo].[OrderShipmentStatus]
--|--------------------------------------------------------------------------------
--| [OrderShipmentStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(1, 'AwaitingInventory', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(2, 'Cancelled', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(3, 'InventoryAssigned', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(4, 'OnHold', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(5, 'Packing', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(6, 'Released', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(7, 'Shipped', @ApplicationId);

--|--------------------------------------------------------------------------------

DELETE FROM [dbo].[ReturnFormStatus]
--|--------------------------------------------------------------------------------
--| [ReturnFormStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(1, 'Complete', @ApplicationId);

INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(2, 'Canceled', @ApplicationId);

INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(3, 'AwaitingStockReturn', @ApplicationId);

INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(4, 'AwaitingCompletion', @ApplicationId);
--|--------------------------------------------------------------------------------

DELETE FROM [dbo].[OrderNoteType]
--|--------------------------------------------------------------------------------
--| [OrderNoteType] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(1, 'Info', @ApplicationId);

INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(2, 'Shipment', @ApplicationId);

INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(3, 'ReturnsExchange', @ApplicationId);

INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(4, 'Payments', @ApplicationId);

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


--------------- June 25, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 48;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'DECLARE @Retval INT, @MetaClassId INT
IF(EXISTS(SELECT * FROM MetaClass WHERE [Name] = ''ShipmentEx'') AND NOT EXISTS(SELECT * FROM [dbo].[MetaField] WHERE Name = ''PrevStatus''))
BEGIN
	SELECT @MetaClassId = MetaClassId FROM MetaClass WHERE [Name] = ''ShipmentEx''
	EXECUTE [dbo].[mdpsp_sys_AddMetaField]
		@Namespace = N''Mediachase.Commerce.Orders.System'',
		@Name = N''PrevStatus'',
		@FriendlyName = N''Previous status'',
		@Description = N'',
		@DataTypeId = 31,
		@Length = 512,
		@AllowNulls = 1,
		@SaveHistory = 0,
		@MultiLanguageValue = 0,
		@AllowSearch = 0,
		@IsEncrypted = 0,
		@Retval = @Retval OUTPUT
	EXEC [dbo].[mdpsp_sys_AddMetaFieldToMetaClass] @MetaClassId, @Retval, 0		
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- October 20, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 49;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec sp_ExecuteSQL N'
ALTER TABLE [dbo].[LineItem] ADD
[WarehouseCode] [nvarchar](50) NULL

exec mdpsp_sys_RegisterMetaFieldInSystemClass ''LineItem'',''LineItem'',''Mediachase.Commerce.Orders.System''

ALTER TABLE [dbo].[Shipment] ADD
[WarehouseCode] [nvarchar](50) NULL,
[PickListId] [int] NULL

exec mdpsp_sys_RegisterMetaFieldInSystemClass ''Shipment'',''Shipment'',''Mediachase.Commerce.Orders.System''
'

exec sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_LineItem_Insert]
(
	@LineItemId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(50),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money,
	@WarehouseCode nvarchar(50) = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [LineItem]
	(
		[OrderFormId],
		[OrderGroupId],
		[Catalog],
		[CatalogNode],
		[ParentCatalogEntryId],
		[CatalogEntryId],
		[Quantity],
		[PlacedPrice],
		[ListPrice],
		[LineItemDiscountAmount],
		[OrderLevelDiscountAmount],
		[ShippingAddressId],
		[ShippingMethodName],
		[ShippingMethodId],
		[ExtendedPrice],
		[Description],
		[Status],
		[DisplayName],
		[AllowBackordersAndPreorders],
		[InStockQuantity],
		[PreorderQuantity],
		[BackorderQuantity],
		[InventoryStatus],
		[LineItemOrdering],
		[ConfigurationId],
		[MinQuantity],
		[MaxQuantity],
		[ProviderId],
		[ReturnReason],
		[OrigLineItemId],
		[ReturnQuantity],
		[WarehouseCode]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@Catalog,
		@CatalogNode,
		@ParentCatalogEntryId,
		@CatalogEntryId,
		@Quantity,
		@PlacedPrice,
		@ListPrice,
		@LineItemDiscountAmount,
		@OrderLevelDiscountAmount,
		@ShippingAddressId,
		@ShippingMethodName,
		@ShippingMethodId,
		@ExtendedPrice,
		@Description,
		@Status,
		@DisplayName,
		@AllowBackordersAndPreorders,
		@InStockQuantity,
		@PreorderQuantity,
		@BackorderQuantity,
		@InventoryStatus,
		@LineItemOrdering,
		@ConfigurationId,
		@MinQuantity,
		@MaxQuantity,
		@ProviderId,
		@ReturnReason,
		@OrigLineItemId,
		@ReturnQuantity,
		@WarehouseCode
	)

	SELECT @LineItemId = SCOPE_IDENTITY()

	RETURN @@Error
'

exec sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_LineItem_Update]
(
	@LineItemId int,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(255),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money,
	@WarehouseCode nvarchar(50) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [LineItem]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[Catalog] = @Catalog,
		[CatalogNode] = @CatalogNode,
		[ParentCatalogEntryId] = @ParentCatalogEntryId,
		[CatalogEntryId] = @CatalogEntryId,
		[Quantity] = @Quantity,
		[PlacedPrice] = @PlacedPrice,
		[ListPrice] = @ListPrice,
		[LineItemDiscountAmount] = @LineItemDiscountAmount,
		[OrderLevelDiscountAmount] = @OrderLevelDiscountAmount,
		[ShippingAddressId] = @ShippingAddressId,
		[ShippingMethodName] = @ShippingMethodName,
		[ShippingMethodId] = @ShippingMethodId,
		[ExtendedPrice] = @ExtendedPrice,
		[Description] = @Description,
		[Status] = @Status,
		[DisplayName] = @DisplayName,
		[AllowBackordersAndPreorders] = @AllowBackordersAndPreorders,
		[InStockQuantity] = @InStockQuantity,
		[PreorderQuantity] = @PreorderQuantity,
		[BackorderQuantity] = @BackorderQuantity,
		[InventoryStatus] = @InventoryStatus,
		[LineItemOrdering] = @LineItemOrdering,
		[ConfigurationId] = @ConfigurationId,
		[MinQuantity] = @MinQuantity,
		[MaxQuantity] = @MaxQuantity,
		[ProviderId] = @ProviderId,
		[ReturnReason] = @ReturnReason,
		[OrigLineItemId] = @OrigLineItemId,
		[ReturnQuantity] = @ReturnQuantity,
		[WarehouseCode] = @WarehouseCode
	WHERE 
		[LineItemId] = @LineItemId

	IF @@ERROR > 0
	BEGIN
		RAISERROR(''Concurrency Error'',16,1)
	END

	RETURN @@Error
'

exec sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_Shipment_Insert]
(
	@ShipmentId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@ShippingMethodId uniqueidentifier,
	@ShippingAddressId nvarchar(50) = NULL,
	@ShipmentTrackingNumber nvarchar(128) = NULL,
	@ShipmentTotal money,
	@ShippingDiscountAmount money,
	@ShippingMethodName nvarchar(128) = NULL,
	@Status nvarchar(64) = NULL,
	@LineItemIds nvarchar(max) = NULL,
	@WarehouseCode nvarchar(50) = NULL,
	@PickListId int = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [Shipment]
	(
		[OrderFormId],
		[OrderGroupId],
		[ShippingMethodId],
		[ShippingAddressId],
		[ShipmentTrackingNumber],
		[ShipmentTotal],
		[ShippingDiscountAmount],
		[ShippingMethodName],
		[Status],
		[LineItemIds],
		[WarehouseCode],
		[PickListId]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@ShippingMethodId,
		@ShippingAddressId,
		@ShipmentTrackingNumber,
		@ShipmentTotal,
		@ShippingDiscountAmount,
		@ShippingMethodName,
		@Status,
		@LineItemIds,
		@WarehouseCode,
		@PickListId
	)

	SELECT @ShipmentId = SCOPE_IDENTITY()

	RETURN @@Error
'

exec sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_Shipment_Update]
(
	@ShipmentId int,
	@OrderFormId int,
	@OrderGroupId int,
	@ShippingMethodId uniqueidentifier,
	@ShippingAddressId nvarchar(50) = NULL,
	@ShipmentTrackingNumber nvarchar(128) = NULL,
	@ShipmentTotal money,
	@ShippingDiscountAmount money,
	@ShippingMethodName nvarchar(128) = NULL,
	@Status nvarchar(64) = NULL,
	@LineItemIds nvarchar(max) = NULL,
	@WarehouseCode nvarchar(50) = NULL,
	@PickListId int = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [Shipment]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[ShippingMethodId] = @ShippingMethodId,
		[ShippingAddressId] = @ShippingAddressId,
		[ShipmentTrackingNumber] = @ShipmentTrackingNumber,
		[ShipmentTotal] = @ShipmentTotal,
		[ShippingDiscountAmount] = @ShippingDiscountAmount,
		[ShippingMethodName] = @ShippingMethodName,
		[Status] = @Status,
		[LineItemIds] = @LineItemIds,
		[WarehouseCode] = @WarehouseCode,
		[PickListId] = @PickListId
	WHERE 
		[ShipmentId] = @ShipmentId

	RETURN @@Error
'

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PickList]') AND type in (N'U'))
BEGIN
exec sp_ExecuteSQL N'
CREATE TABLE [dbo].[PickList](
	[PickListId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[WarehouseCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_PickList] PRIMARY KEY CLUSTERED 
(
	[PickListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
'
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PickList]') AND name = N'IX_PickList_WarehouseCode')
exec sp_ExecuteSQL N'
CREATE NONCLUSTERED INDEX [IX_PickList_WarehouseCode] ON [dbo].[PickList]
(
	[WarehouseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
'

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PickList]') AND type in (N'P', N'PC'))
BEGIN
EXEC sp_ExecuteSQL N'
CREATE PROCEDURE [dbo].[ecf_PickList]
	@ShipmentPackingStatus AS NVARCHAR(64)
AS
BEGIN
	SELECT PL.*, CAST((SELECT COUNT(*) FROM [Shipment] S WHERE S.[PickListId] = PL.[PickListId] AND S.[Status] = @ShipmentPackingStatus) AS INT) AS [PackingShipments]
	FROM [PickList] PL
	ORDER BY PL.[Name]
END
'
END

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


--------------- October 20, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 50;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_OrderGroup_Delete]
(
	@OrderGroupId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @TempObjectId int

	-- Delete OrderForm
	DECLARE _cursorOrderForm CURSOR READ_ONLY FAST_FORWARD FOR 
		SELECT OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	OPEN _cursorOrderForm
	FETCH NEXT FROM _cursorOrderForm INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[ecf_OrderForm_Delete] @TempObjectId
		FETCH NEXT FROM _cursorOrderForm INTO @TempObjectId
	END
	CLOSE _cursorOrderForm
	DEALLOCATE _cursorOrderForm

	-- Delete OrderGroupAddress
	DECLARE _cursor CURSOR READ_ONLY FAST_FORWARD FOR 
		SELECT OrderGroupAddressId FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
	EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId

	EXEC [dbo].[mdpsp_avto_OrderGroup_PaymentPlan_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_PurchaseOrder_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_ShoppingCart_Delete] @OrderGroupId
	DELETE FROM [OrderGroup] where OrderGroupId = @OrderGroupId

	RETURN @@Error
END
'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 51;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec sp_ExecuteSQL N'
ALTER TABLE [dbo].[OrderForm] ADD
[AuthorizedPaymentTotal] [money] NOT NULL default(0),
[CapturedPaymentTotal] [money] NOT NULL default(0)

exec mdpsp_sys_RegisterMetaFieldInSystemClass ''OrderForm'',''OrderForm'',''Mediachase.Commerce.Orders.System''
'

exec sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_OrderForm_Insert]
(
	@OrderFormId int = NULL OUTPUT,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@BillingAddressId nvarchar(50) = NULL,
	@DiscountAmount money,
	@SubTotal money,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@Total money,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@ReturnComment nvarchar(1024) = NULL,
	@ReturnType nvarchar(50) = NULL,
	@ReturnAuthCode nvarchar(255) = NULL,
	@OrigOrderFormId int = NULL,
	@ExchangeOrderGroupId int  = NULL,
	@AuthorizedPaymentTotal money,
	@CapturedPaymentTotal money
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderForm]
	(
		[OrderGroupId],
		[Name],
		[BillingAddressId],
		[DiscountAmount],
		[SubTotal],
		[ShippingTotal],
		[HandlingTotal],
		[TaxTotal],
		[Total],
		[Status],
		[ProviderId],
		[ReturnComment],
		[ReturnType],
		[ReturnAuthCode],
		[OrigOrderFormId],
		[ExchangeOrderGroupId],
		[AuthorizedPaymentTotal],
		[CapturedPaymentTotal]
	)
	VALUES
	(
		@OrderGroupId,
		@Name,
		@BillingAddressId,
		@DiscountAmount,
		@SubTotal,
		@ShippingTotal,
		@HandlingTotal,
		@TaxTotal,
		@Total,
		@Status,
		@ProviderId,
		@ReturnComment,
		@ReturnType,
		@ReturnAuthCode,
		@OrigOrderFormId,
		@ExchangeOrderGroupId,
		@AuthorizedPaymentTotal,
		@CapturedPaymentTotal
	)

	SELECT @OrderFormId = SCOPE_IDENTITY()

	RETURN @@Error
'

exec sp_ExecuteSQL N'
ALTER PROCEDURE [dbo].[ecf_OrderForm_Update]
(
	@OrderFormId int,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@BillingAddressId nvarchar(50) = NULL,
	@DiscountAmount money,
	@SubTotal money,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@Total money,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@ReturnComment nvarchar(1024) = NULL,
	@ReturnType nvarchar(50) = NULL,
	@ReturnAuthCode nvarchar(255) = NULL,
	@OrigOrderFormId int = NULL,
	@ExchangeOrderGroupId int = NULL,
	@AuthorizedPaymentTotal money,
	@CapturedPaymentTotal money
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderForm]
	SET
		[OrderGroupId] = @OrderGroupId,
		[Name] = @Name,
		[BillingAddressId] = @BillingAddressId,
		[DiscountAmount] = @DiscountAmount,
		[SubTotal] = @SubTotal,
		[ShippingTotal] = @ShippingTotal,
		[HandlingTotal] = @HandlingTotal,
		[TaxTotal] = @TaxTotal,
		[Total] = @Total,
		[Status] = @Status,
		[ProviderId] = @ProviderId,
		[ReturnComment] = @ReturnComment,
		[ReturnType] = @ReturnType,
		[ReturnAuthCode] = @ReturnAuthCode,
		[OrigOrderFormId] = @OrigOrderFormId,
		[ExchangeOrderGroupId] = @ExchangeOrderGroupId,
		[AuthorizedPaymentTotal] = @AuthorizedPaymentTotal,
		[CapturedPaymentTotal] = @CapturedPaymentTotal
	WHERE 
		[OrderFormId] = @OrderFormId

	RETURN @@Error
'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END

GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 52;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec sp_ExecuteSQL N'
ALTER TABLE [dbo].[Shipment] ADD
[SubTotal] [money] NOT NULL default(0)

exec mdpsp_sys_RegisterMetaFieldInSystemClass ''Shipment'',''Shipment'',''Mediachase.Commerce.Orders.System'''

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_Shipment_Insert]
(
	@ShipmentId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@ShippingMethodId uniqueidentifier,
	@ShippingAddressId nvarchar(50) = NULL,
	@ShipmentTrackingNumber nvarchar(128) = NULL,
	@ShipmentTotal money,
	@ShippingDiscountAmount money,
	@ShippingMethodName nvarchar(128) = NULL,
	@Status nvarchar(64) = NULL,
	@LineItemIds nvarchar(max) = NULL,
	@WarehouseCode nvarchar(50) = NULL,
	@PickListId int = NULL,
	@SubTotal money
)
AS
	SET NOCOUNT ON

	INSERT INTO [Shipment]
	(
		[OrderFormId],
		[OrderGroupId],
		[ShippingMethodId],
		[ShippingAddressId],
		[ShipmentTrackingNumber],
		[ShipmentTotal],
		[ShippingDiscountAmount],
		[ShippingMethodName],
		[Status],
		[LineItemIds],
		[WarehouseCode],
		[PickListId],
		[SubTotal]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@ShippingMethodId,
		@ShippingAddressId,
		@ShipmentTrackingNumber,
		@ShipmentTotal,
		@ShippingDiscountAmount,
		@ShippingMethodName,
		@Status,
		@LineItemIds,
		@WarehouseCode,
		@PickListId,
		@SubTotal
	)

	SELECT @ShipmentId = SCOPE_IDENTITY()

	RETURN @@Error'
	
exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_Shipment_Update]
(
	@ShipmentId int,
	@OrderFormId int,
	@OrderGroupId int,
	@ShippingMethodId uniqueidentifier,
	@ShippingAddressId nvarchar(50) = NULL,
	@ShipmentTrackingNumber nvarchar(128) = NULL,
	@ShipmentTotal money,
	@ShippingDiscountAmount money,
	@ShippingMethodName nvarchar(128) = NULL,
	@Status nvarchar(64) = NULL,
	@LineItemIds nvarchar(max) = NULL,
	@WarehouseCode nvarchar(50) = NULL,
	@PickListId int = NULL,
	@SubTotal money
)
AS
	SET NOCOUNT ON
	
	UPDATE [Shipment]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[ShippingMethodId] = @ShippingMethodId,
		[ShippingAddressId] = @ShippingAddressId,
		[ShipmentTrackingNumber] = @ShipmentTrackingNumber,
		[ShipmentTotal] = @ShipmentTotal,
		[ShippingDiscountAmount] = @ShippingDiscountAmount,
		[ShippingMethodName] = @ShippingMethodName,
		[Status] = @Status,
		[LineItemIds] = @LineItemIds,
		[WarehouseCode] = @WarehouseCode,
		[PickListId] = @PickListId,
		[SubTotal] = @SubTotal
	WHERE 
		[ShipmentId] = @ShipmentId

	RETURN @@Error'
	

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END

GO

---------------------- 2011-02-04 -------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 53;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @SearchSetId uniqueidentifier
AS
BEGIN

DECLARE @search_condition nvarchar(max)

-- Return GroupIds.
SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId


-- Prevent any queries if order group doesn''t exist
IF NOT EXISTS(SELECT * from OrderGroup G INNER JOIN OrderSearchResults R ON G.OrderGroupId = R.OrderGroupId WHERE R.SearchSetId = @SearchSetId)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderForm'' TableName, OE.*, O.*
	FROM [OrderFormEx] OE 
		INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId 
		INNER JOIN OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

if(@@ROWCOUNT = 0)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderGroupAddress'' TableName, OE.*, O.*
	FROM [OrderGroupAddressEx] OE 
		INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  
		INNER JOIN OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId 
	WHERE R.[SearchSetId] = @SearchSetId

-- Return Shipment Collection
SELECT ''Shipment'' TableName, SE.*, S.*
	FROM [ShipmentEx] SE 
		INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId 
		INNER JOIN OrderSearchResults R ON S.OrderGroupId = R.OrderGroupId 
	WHERE R.[SearchSetId] = @SearchSetId

-- Return Line Item Collection
SELECT ''LineItem'' TableName, LE.*, L.*
	FROM [LineItemEx] LE 
		INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId 
		INNER JOIN OrderSearchResults R ON L.OrderGroupId = R.OrderGroupId 
	WHERE R.[SearchSetId] = @SearchSetId

-- Return Order Form Payment Collection

SET @search_condition = N''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId INNER JOIN OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId WHERE R.SearchSetId = '''''' + CONVERT(nvarchar(36), @SearchSetId) + N''''''''

-- Credit Cards
exec mdpsp_avto_OrderFormPayment_CreditCard_Search NULL, ''''''OrderFormPayment_CreditCard'''' TableName, [O].*'', @search_condition

-- Cash Cards	
exec mdpsp_avto_OrderFormPayment_CashCard_Search NULL, ''''''OrderFormPayment_CashCard'''' TableName, [O].*'', @search_condition

-- Gift Cards	
exec mdpsp_avto_OrderFormPayment_GiftCard_Search NULL, ''''''OrderFormPayment_GiftCard'''' TableName, [O].*'', @search_condition

-- Invoices
exec mdpsp_avto_OrderFormPayment_Invoice_Search NULL, ''''''OrderFormPayment_Invoice'''' TableName, [O].*'', @search_condition

-- Other
exec mdpsp_avto_OrderFormPayment_Other_Search NULL, ''''''OrderFormPayment_Other'''' TableName, [O].*'', @search_condition

-- Exchange
exec mdpsp_avto_OrderFormPayment_Exchange_Search NULL, ''''''OrderFormPayment_Exchange'''' TableName, [O].*'', @search_condition

-- Return Order Form Discount Collection
SELECT ''OrderFormDiscount'' TableName, D.* 
	FROM [OrderFormDiscount] D 
		INNER JOIN OrderSearchResults R ON D.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

-- Return Line Item Discount Collection
SELECT ''LineItemDiscount'' TableName, D.* 
	FROM [LineItemDiscount] D 
		INNER JOIN OrderSearchResults R ON D.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

-- Return Shipment Discount Collection
SELECT ''ShipmentDiscount'' TableName, D.* 
	FROM [ShipmentDiscount] D 
		INNER JOIN OrderSearchResults R ON D.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

-- assign random local variable to set @@rowcount attribute to 1
declare @temp as int
set @temp = 1

END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' + Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

--------------- May 27, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 54;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

PRINT N'Altering [dbo].[PaymentMethodParameter]'
ALTER TABLE [dbo].[PaymentMethodParameter] ALTER COLUMN [Value] nvarchar(4000) null

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

--------------- May 13, 2011 Return Reasons ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 55;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##


/****** Object:  Table [dbo].[ReturnReasonDictionary]    Script Date: 05/13/2011 23:29:14 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReturnReasonDictionary]') AND type in (N'U'))
exec sp_ExecuteSQL N'
CREATE TABLE [dbo].[ReturnReasonDictionary](
	[ReturnReasonId] [int] IDENTITY(1,1) NOT NULL,
	[ReturnReasonText] [nvarchar](50) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Ordering] [int] NOT NULL,
	[Visible] [bit] NULL,
 CONSTRAINT [PK_ReturnReasonDictionary] PRIMARY KEY CLUSTERED 
(
	[ReturnReasonText] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]'


/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairy]    Script Date: 05/13/2011 23:37:38 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairy]') AND type in (N'P', N'PC'))
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairy]
	@ApplicationId uniqueidentifier,
	@ReturnInactive bit = 0
 AS
	SELECT * FROM dbo.ReturnReasonDictionary RRD
	where ApplicationId = @ApplicationId and
	(([Visible] = 1) or @ReturnInactive = 1)
	order by RRD.[Ordering], RRD.[ReturnReasonText]
'

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairyId]    Script Date: 05/13/2011 23:37:44 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairyId]') AND type in (N'P', N'PC'))
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyId]
	@ApplicationId uniqueidentifier,
	@ReturnReasonId int
 AS
	SELECT [ReturnReasonId]
		  ,[ReturnReasonText]
		  ,[ApplicationId]
		FROM dbo.ReturnReasonDictionary
		where ApplicationId = @ApplicationId and ReturnReasonId = @ReturnReasonId

'

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairyName]    Script Date: 06/02/2011 23:37:50 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairyName]') AND type in (N'P', N'PC'))
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyName]
	@ApplicationId uniqueidentifier,
	@ReturnReasonName nvarchar(50)
 AS
	SELECT [ReturnReasonId]
		  ,[ReturnReasonText]
		  ,[ApplicationId]
		FROM dbo.ReturnReasonDictionary
		where ApplicationId = @ApplicationId and ReturnReasonText = @ReturnReasonName
'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


--------------- July 6, 2011 Remove Default Constraints that arent present in a fresh install --------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 56;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

declare @statement nvarchar(4000)

select @statement = 'alter table [' + tab.name + '] drop constraint [' + df.name + ']'
from sys.default_constraints df
join sys.all_objects tab on df.parent_object_id = tab.object_id
join sys.all_columns col on df.parent_object_id = col.object_id and df.parent_column_id = col.column_id
where tab.name = 'OrderForm' and col.name = 'AuthorizedPaymentTotal'

if @statement is not null execute dbo.sp_executesql @statement

select @statement = 'alter table [' + tab.name + '] drop constraint [' + df.name + ']'
from sys.default_constraints df
join sys.all_objects tab on df.parent_object_id = tab.object_id
join sys.all_columns col on df.parent_object_id = col.object_id and df.parent_column_id = col.column_id
where tab.name = 'OrderForm' and col.name = 'CapturedPaymentTotal'

if @statement is not null execute dbo.sp_executesql @statement

select @statement = 'alter table [' + tab.name + '] drop constraint [' + df.name + ']'
from sys.default_constraints df
join sys.all_objects tab on df.parent_object_id = tab.object_id
join sys.all_columns col on df.parent_object_id = col.object_id and df.parent_column_id = col.column_id
where tab.name = 'Shipment' and col.name = 'SubTotal'

if @statement is not null execute dbo.sp_executesql @statement

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


--------------- July 27, 2011 Fix compound primary keys --------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 57;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
	declare @statement nvarchar(4000)
	
	select @statement = 'alter table [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '] drop constraint [' + CONSTRAINT_NAME + ']'
	from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'OrderShipmentStatus' and CONSTRAINT_TYPE = 'PRIMARY KEY'

	execute sp_executesql @statement	
	alter table dbo.OrderShipmentStatus add constraint PK_OrderShipmentStatus primary key (OrderShipmentStatusId, ApplicationId)

	select @statement = 'alter table [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '] drop constraint [' + CONSTRAINT_NAME + ']'
	from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'OrderNoteType' and CONSTRAINT_TYPE = 'PRIMARY KEY'

	execute sp_executesql @statement	
	alter table dbo.OrderNoteType add constraint PK_OrderNoteType primary key (OrderNoteTypeId, ApplicationId)

	select @statement = 'alter table [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '] drop constraint [' + CONSTRAINT_NAME + ']'
	from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	where TABLE_SCHEMA = 'dbo' and TABLE_NAME = 'ReturnFormStatus' and CONSTRAINT_TYPE = 'PRIMARY KEY'

	execute sp_executesql @statement	
	alter table dbo.ReturnFormStatus add constraint PK_ReturnFormStatus primary key (ReturnFormStatusId, ApplicationId)

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO




--------------- September 9, 2011 Fix missing GO --------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 58;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
	declare @sql nvarchar(4000)

	set @sql = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'mc_OrderGroupNoteSelect')
		then 'alter ' else 'create ' end +
'PROCEDURE [dbo].[mc_OrderGroupNoteSelect]
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[OrderNoteId] AS [OrderNoteId], [t01].[OrderGroupId] AS [OrderGroupId], [t01].[CustomerId] AS [CustomerId], [t01].[Title] AS [Title], [t01].[Type] AS [Type], [t01].[Detail] AS [Detail], [t01].[Created] AS [Created], [t01].[LineItemId] AS [LineItemId]
FROM [OrderGroupNote] AS [t01]
WHERE ([t01].[OrderNoteId]=@OrderNoteId)

END
'
	execute dbo.sp_executesql @sql

	set @sql = case when exists (select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'mc_OrderGroupLockInsert')
		then 'alter ' else 'create ' end +
'PROCEDURE [dbo].[mc_OrderGroupLockInsert]
@CustomerId AS UniqueIdentifier,
@Created AS DateTime,
@OrderGroupId AS Int,
@OrderLockId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [OrderGroupLock]
(
[CustomerId],
[Created],
[OrderGroupId])
VALUES(
@CustomerId,
@Created,
@OrderGroupId)
SELECT @OrderLockId = SCOPE_IDENTITY();

END

'
	execute dbo.sp_executesql @sql
	--## END Schema Patch ##
	Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

	Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO



--------------- October 7, 2011 Fix order search results key --------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 59;

Select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN    
    --## BEGIN Schema Patch ##
    if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where TABLE_NAME = 'OrderSearchResults' and CONSTRAINT_NAME = 'FK_OrderSearchResults_OrderGroup')
    alter table OrderSearchResults drop constraint FK_OrderSearchResults_OrderGroup

    alter table OrderSearchResults add constraint FK_OrderSearchResults_OrderGroup
        foreign key (OrderGroupId) references OrderGroup (OrderGroupId)
        on delete cascade
    --## END Schema Patch ##

	Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

	Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO


--------------- December 12, 2011 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 60;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_ShippingMethod_GetCases]
	@ShippingMethodId uniqueidentifier,
	@CountryCode nvarchar(50) = null,
	@Total money = null,
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
BEGIN
/* First set all empty string variables except ShippingMethodId to NULL */
IF (LTRIM(RTRIM(@CountryCode)) = '''')
  SET @CountryCode = NULL

IF (LTRIM(RTRIM(@StateProvinceCode)) = '''')
  SET @StateProvinceCode = NULL

IF (LTRIM(RTRIM(@ZipPostalCode)) = '''')
  SET @ZipPostalCode = NULL

IF (LTRIM(RTRIM(@District)) = '''')
  SET @District = NULL

IF (LTRIM(RTRIM(@County)) = '''')
  SET @County = NULL

IF (LTRIM(RTRIM(@City )) = '''')
  SET @City = NULL

/* If Jurisdiction values in database are null or an empty string, they will return the same results */
	SELECT C.Charge, C.Total, C.StartDate, C.EndDate, C.JurisdictionGroupId from ShippingMethodCase C 
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = C.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		(C.StartDate < getutcdate() OR C.StartDate is null) AND 
		(C.EndDate > getutcdate() OR C.EndDate is null) AND 
		C.ShippingMethodId = @ShippingMethodId AND
		(@Total >= C.Total OR @Total is null) AND
		(J.CountryCode = @CountryCode OR (@CountryCode is null and J.CountryCode = ''WORLD'')) AND 
		JG.JurisdictionType = 2 /*shipping*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null OR RTRIM(LTRIM(J.StateProvinceCode)) = '''') AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null OR RTRIM(LTRIM(J.ZipPostalCodeStart)) = '''') AND
		(COALESCE(@District, J.District) = J.District OR J.District is null OR RTRIM(LTRIM(J.District)) = '''') AND
		(COALESCE(@County, J.County) = J.County OR J.County is null OR RTRIM(LTRIM(J.County)) = '''') AND
		(COALESCE(@City, J.City) = J.City OR J.City is null OR RTRIM(LTRIM(J.City)) = '''')
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 61;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
	exec dbo.sp_executesql N'alter table OrderGroup add MarketId nvarchar(8) not null constraint DF_OrderGroup_MarketId default ''DEFAULT''';
	exec dbo.mdpsp_sys_RefreshSystemMetaClassInfoAll;
--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 62;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Update]
(
	@OrderGroupId int OUT,
	@InstanceId uniqueidentifier,
	@ApplicationId uniqueidentifier,
	@AffiliateId uniqueidentifier,
	@Name nvarchar(64) = NULL,
	@CustomerId uniqueidentifier,
	@CustomerName nvarchar(64) = NULL,
	@AddressId nvarchar(50) = NULL,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@SubTotal money,
	@Total money,
	@BillingCurrency nvarchar(64) = NULL,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@SiteId nvarchar(255) = NULL,
	@OwnerOrg nvarchar(255) = NULL,
	@Owner nvarchar(255) = NULL,
	@MarketId nvarchar(8)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

		UPDATE [OrderGroup]
		SET
			[InstanceId] = @InstanceId,
			[ApplicationId] = @ApplicationId,
			[AffiliateId] = @AffiliateId,
			[Name] = @Name,
			[CustomerId] = @CustomerId,
			[CustomerName] = @CustomerName,
			[AddressId] = @AddressId,
			[ShippingTotal] = @ShippingTotal,
			[HandlingTotal] = @HandlingTotal,
			[TaxTotal] = @TaxTotal,
			[SubTotal] = @SubTotal,
			[Total] = @Total,
			[BillingCurrency] = @BillingCurrency,
			[Status] = @Status,
			[ProviderId] = @ProviderId,
			[SiteId] = @SiteId,
			[OwnerOrg] = @OwnerOrg,
			[Owner] = @Owner,
			[MarketId] = @MarketId
		WHERE
			[OrderGroupId] = @OrderGroupId

	SET @Err = @@Error

	RETURN @Err
END'

EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_OrderGroup_Insert]
(
	@OrderGroupId int OUT,
	@InstanceId uniqueidentifier,
	@ApplicationId uniqueidentifier,
	@AffiliateId uniqueidentifier,
	@Name nvarchar(64) = NULL,
	@CustomerId uniqueidentifier,
	@CustomerName nvarchar(64) = NULL,
	@AddressId nvarchar(50) = NULL,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@SubTotal money,
	@Total money,
	@BillingCurrency nvarchar(64) = NULL,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@SiteId nvarchar(255) = NULL,
	@OwnerOrg nvarchar(255) = NULL,
	@Owner nvarchar(255) = NULL,
	@MarketId nvarchar(8)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	if(@OrderGroupId is null)
	begin
		INSERT
		INTO [OrderGroup]
		(
			[InstanceId],
			[ApplicationId],
			[AffiliateId],
			[Name],
			[CustomerId],
			[CustomerName],
			[AddressId],
			[ShippingTotal],
			[HandlingTotal],
			[TaxTotal],
			[SubTotal],
			[Total],
			[BillingCurrency],
			[Status],
			[ProviderId],
			[SiteId],
			[OwnerOrg],
			[Owner],
			[MarketId]
		)
		VALUES
		(
			@InstanceId,
			@ApplicationId,
			@AffiliateId,
			@Name,
			@CustomerId,
			@CustomerName,
			@AddressId,
			@ShippingTotal,
			@HandlingTotal,
			@TaxTotal,
			@SubTotal,
			@Total,
			@BillingCurrency,
			@Status,
			@ProviderId,
			@SiteId,
			@OwnerOrg,
			@Owner,
			@MarketId
		)
		SELECT @OrderGroupId = SCOPE_IDENTITY()
	end

	SET @Err = @@Error

	RETURN @Err
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


declare @Major int, @Minor int, @Patch int, @Installed datetime

set @Major = 5;
set @Minor = 0;
set @Patch = 63;

select @Installed = InstallDate from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch
if (@Installed is null)
begin
    exec dbo.sp_executesql N'alter table dbo.ShippingMethodCase alter column Charge money not null'

    insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
end
go

------- October 16, 2012 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 64;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

--Drop the procedure first
/****** Object:  StoredProcedure [dbo].[ecf_Search_OrderGroup]    Script Date: 07/21/2009 17:25:19 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ecf_Search_OrderGroup]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ecf_Search_OrderGroup]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_OrderGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @SearchSetId uniqueidentifier
AS
BEGIN

DECLARE @search_condition nvarchar(max)

-- Return GroupIds.
SELECT [OrderGroupId] FROM [OrderSearchResults] WHERE [SearchSetId] = @SearchSetId


-- Prevent any queries if order group doesn''t exist
IF NOT EXISTS(SELECT * from OrderGroup G INNER JOIN OrderSearchResults R ON G.OrderGroupId = R.OrderGroupId WHERE R.SearchSetId = @SearchSetId)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderForm'' TableName, OE.*, O.*
	FROM [OrderFormEx] OE 
		INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId 
		INNER JOIN OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

if(@@ROWCOUNT = 0)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderGroupAddress'' TableName, OE.*, O.*
	FROM [OrderGroupAddressEx] OE 
		INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  
		INNER JOIN OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId 
	WHERE R.[SearchSetId] = @SearchSetId

-- Return Shipment Collection
SELECT ''Shipment'' TableName, SE.*, S.*
	FROM [ShipmentEx] SE 
		INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId 
		INNER JOIN OrderSearchResults R ON S.OrderGroupId = R.OrderGroupId 
	WHERE R.[SearchSetId] = @SearchSetId

-- Return Line Item Collection
SELECT ''LineItem'' TableName, LE.*, L.*
	FROM [LineItemEx] LE 
		INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId 
		INNER JOIN OrderSearchResults R ON L.OrderGroupId = R.OrderGroupId 
	WHERE R.[SearchSetId] = @SearchSetId

-- Return Order Form Payment Collection

SET @search_condition = N''''''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId INNER JOIN OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId WHERE R.SearchSetId = '' + N'''''''''''' + CONVERT(nvarchar(50), @SearchSetId) + N''''''''''''''''

DECLARE @metaclassid int
DECLARE @parentclassid int
DECLARE @parentmetaclassid int
DECLARE @rowNum int
DECLARE @maxrows int
DECLARE @tablename nvarchar(120)
DECLARE @name nvarchar(120)
DECLARE @procedurefull nvarchar(max)

SET @parentmetaclassid = (SELECT MetaClassId from [Metaclass] WHERE Name = N''orderformpayment'' and TableName = N''orderformpayment'')

SELECT top 1 @metaclassid = MetaClassId, @tablename = TableName, @parentclassid = ParentClassId, @name = Name from [Metaclass]
	SELECT @maxRows = count(*) from [Metaclass]
	SET @rowNum = 0
	WHILE @rowNum < @maxRows
	BEGIN
		SET @rowNum = @rowNum + 1
		IF (@parentclassid = @parentmetaclassid)
		BEGIN
			SET @procedurefull = N''mdpsp_avto_'' + @tablename + N''_Search NULL, '' + N'''''''''''''''' + @tablename + N''''''''''''+  '' TableName, [O].*'''' ,''  + @search_condition
			EXEC (@procedurefull)
		END
		SELECT top 1 @metaclassid = MetaClassId, @tablename = TableName, @parentclassid = ParentClassId, @name = Name from [Metaclass] where MetaClassId > @metaclassid
	END

-- Return Order Form Discount Collection
SELECT ''OrderFormDiscount'' TableName, D.* 
	FROM [OrderFormDiscount] D 
		INNER JOIN OrderSearchResults R ON D.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

-- Return Line Item Discount Collection
SELECT ''LineItemDiscount'' TableName, D.* 
	FROM [LineItemDiscount] D 
		INNER JOIN OrderSearchResults R ON D.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

-- Return Shipment Discount Collection
SELECT ''ShipmentDiscount'' TableName, D.* 
	FROM [ShipmentDiscount] D 
		INNER JOIN OrderSearchResults R ON D.OrderGroupId = R.OrderGroupId 
	WHERE R.SearchSetId = @SearchSetId

-- assign random local variable to set @@rowcount attribute to 1
declare @temp as int
set @temp = 1

END' 

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
END
GO


DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 65;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
    declare @verb nvarchar(4000)
    declare @sql nvarchar(4000)

    if not exists (select 1 from sys.types where name = 'udttOrderGroupId')
    begin
        set @sql = 'create type udttOrderGroupId as table (OrderGroupId int)'
        exec dbo.sp_executesql @sql
    end

    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_OrderSearch') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_OrderSearch]
(
	@ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT TableName FROM MetaClass 
		WHERE Namespace like @Namespace + ''%'' AND ([Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and IsSystem = 0

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM [OrderGroup] OrderGroup'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON OrderGroup.[OrderGroupId] = META.[KEY] ''

	set @FilterQuery_tmp = N'' WHERE ApplicationId = '''''' + CAST(@ApplicationId as nvarchar(36)) + ''''''''
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''[OrderGroup].OrderGroupId''
	end

	set @FullQuery = N''SELECT count([OrderGroup].OrderGroupId) OVER() TotalRecords, [OrderGroup].OrderGroupId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, OrderGroupId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, OrderGroupId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, OrderGroupId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;SELECT OrderGroupId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_OrderGroup') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @results udttOrderGroupId readonly
AS
BEGIN

DECLARE @search_condition nvarchar(max)

-- Return GroupIds.
SELECT [OrderGroupId] FROM @results


-- Prevent any queries if order group doesn''t exist
IF NOT EXISTS(SELECT * from OrderGroup G INNER JOIN @results R ON G.OrderGroupId = R.OrderGroupId)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderForm'' TableName, OE.*, O.*
	FROM [OrderFormEx] OE 
		INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId 
		INNER JOIN @results R ON O.OrderGroupId = R.OrderGroupId 

if(@@ROWCOUNT = 0)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderGroupAddress'' TableName, OE.*, O.*
	FROM [OrderGroupAddressEx] OE 
		INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  
		INNER JOIN @results R ON O.OrderGroupId = R.OrderGroupId 

-- Return Shipment Collection
SELECT ''Shipment'' TableName, SE.*, S.*
	FROM [ShipmentEx] SE 
		INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId 
		INNER JOIN @results R ON S.OrderGroupId = R.OrderGroupId 

-- Return Line Item Collection
SELECT ''LineItem'' TableName, LE.*, L.*
	FROM [LineItemEx] LE 
		INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId 
		INNER JOIN @results R ON L.OrderGroupId = R.OrderGroupId 

-- Return Order Form Payment Collection

select OrderGroupId into #OrderSearchResults from @results
SET @search_condition = N''''''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId INNER JOIN #OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId ''''''

DECLARE @metaclassid int
DECLARE @parentclassid int
DECLARE @parentmetaclassid int
DECLARE @rowNum int
DECLARE @maxrows int
DECLARE @tablename nvarchar(120)
DECLARE @name nvarchar(120)
DECLARE @procedurefull nvarchar(max)

SET @parentmetaclassid = (SELECT MetaClassId from [Metaclass] WHERE Name = N''orderformpayment'' and TableName = N''orderformpayment'')

SELECT top 1 @metaclassid = MetaClassId, @tablename = TableName, @parentclassid = ParentClassId, @name = Name from [Metaclass]
	SELECT @maxRows = count(*) from [Metaclass]
	SET @rowNum = 0
	WHILE @rowNum < @maxRows
	BEGIN
		SET @rowNum = @rowNum + 1
		IF (@parentclassid = @parentmetaclassid)
		BEGIN
			SET @procedurefull = N''mdpsp_avto_'' + @tablename + N''_Search NULL, '' + N'''''''''''''''' + @tablename + N''''''''''''+  '' TableName, [O].*'''' ,''  + @search_condition
			EXEC (@procedurefull)
		END
		SELECT top 1 @metaclassid = MetaClassId, @tablename = TableName, @parentclassid = ParentClassId, @name = Name from [Metaclass] where MetaClassId > @metaclassid
	END

-- Return Order Form Discount Collection
SELECT ''OrderFormDiscount'' TableName, D.* 
	FROM [OrderFormDiscount] D 
		INNER JOIN @results R ON D.OrderGroupId = R.OrderGroupId 

-- Return Line Item Discount Collection
SELECT ''LineItemDiscount'' TableName, D.* 
	FROM [LineItemDiscount] D 
		INNER JOIN @results R ON D.OrderGroupId = R.OrderGroupId 

-- Return Shipment Discount Collection
SELECT ''ShipmentDiscount'' TableName, D.* 
	FROM [ShipmentDiscount] D 
		INNER JOIN @results R ON D.OrderGroupId = R.OrderGroupId 

-- assign random local variable to set @@rowcount attribute to 1
declare @temp as int
set @temp = 1

END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_ShoppingCart') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_ShoppingCart]
    @ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
AS
BEGIN
    declare @results udttOrderGroupId
    insert into @results (OrderGroupId)    
    exec dbo.ecf_OrderSearch
        @ApplicationId, 
        @SQLClause, 
        @MetaSQLClause, 
        @FTSPhrase, 
        @AdvancedFTSPhrase, 
        @OrderBy, 
        @namespace, 
        @Classes, 
        @StartingRec, 
        @NumRecords, 
        @RecordCount output
    
    exec dbo.ecf_Search_OrderGroup @results
    
	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_ShoppingCart_Customer') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_ShoppingCart_Customer]
	@ApplicationId uniqueidentifier,
	@CustomerId uniqueidentifier
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_ShoppingCart] PO 
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
	where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_ShoppingCart_CustomerAndName') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64) = null
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_ShoppingCart] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
	where ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId

    exec dbo.ecf_Search_OrderGroup @results

	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_ShoppingCart_CustomerAndOrderGroupId') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_ShoppingCart] C
	join OrderGroup OG on C.ObjectId = OG.OrderGroupId
	where (C.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PurchaseOrder') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PurchaseOrder]
    @ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
AS
BEGIN
    declare @results udttOrderGroupId
    insert into @results (OrderGroupId)    
    exec dbo.ecf_OrderSearch
        @ApplicationId, 
        @SQLClause, 
        @MetaSQLClause, 
        @FTSPhrase, 
        @AdvancedFTSPhrase, 
        @OrderBy, 
        @namespace, 
        @Classes, 
        @StartingRec, 
        @NumRecords, 
        @RecordCount output
	
	exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PurchaseOrder_Customer') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PurchaseOrder_Customer]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_PurchaseOrder] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
	where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PurchaseOrder_CustomerAndName') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PurchaseOrder_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64)
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId] 
	from [OrderGroup_PurchaseOrder] PO 
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
	where ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition	
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PurchaseOrder_CustomerAndOrderGroupId') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_PurchaseOrder] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
	where (PO.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql



    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PaymentPlan') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PaymentPlan]
    @ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
AS
BEGIN
    declare @results udttOrderGroupId
    insert into @results (OrderGroupId)    
    exec dbo.ecf_OrderSearch
        @ApplicationId, 
        @SQLClause, 
        @MetaSQLClause, 
        @FTSPhrase, 
        @AdvancedFTSPhrase, 
        @OrderBy, 
        @namespace, 
        @Classes, 
        @StartingRec, 
        @NumRecords, 
        @RecordCount output
	
	exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PaymentPlan_Customer') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PaymentPlan_Customer]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)    
    select OrderGroupId 
    from [OrderGroup_PaymentPlan] PO 
    join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
    where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
        
    exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PaymentPlan_CustomerAndName') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64)
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)    
    select OrderGroupId 
    from [OrderGroup_PaymentPlan] PO 
    join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
    where ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId
    
    exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql


    set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Search_PaymentPlan_CustomerAndOrderGroupId') then 'alter ' else 'create ' end
    set @sql = @verb + N'PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)    
    select OrderGroupId 
    from [OrderGroup_PaymentPlan] PO 
    join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
    where (PO.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
            
    exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
    exec dbo.sp_executesql @sql

    Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
    Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
END
GO

----November 15, 2012------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 66;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(4000)
declare @sql nvarchar(4000)
set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_Order_ReturnReasonsDictionairyId') then 'alter ' else 'create ' end
set @sql = @verb + N'PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyId]
                @ApplicationId uniqueidentifier,
                @ReturnReasonId int
		AS
		BEGIN
                SELECT [ReturnReasonId]
                      ,[ReturnReasonText]
                      ,[ApplicationId]
                      ,[Ordering]
                      ,[Visible]
                 FROM dbo.ReturnReasonDictionary
                WHERE ApplicationId = @ApplicationId and ReturnReasonId = @ReturnReasonId
		END'

exec dbo.sp_executesql @sql

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----December 03, 2012------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 67;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(4000)
declare @sql nvarchar(4000)
set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_PaymentMethod_Language') then 'alter ' else 'create ' end
set @sql = @verb + N'PROCEDURE [dbo].[ecf_PaymentMethod_Language]
						@ApplicationId uniqueidentifier,
						@LanguageId nvarchar(128),
						@ReturnInactive bit = 0
					AS
					BEGIN
						select * from [PaymentMethod] 
						where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
							(([IsActive] = 1) or @ReturnInactive = 1) and 
							[ApplicationId] = @ApplicationId order by [Ordering]

						select PMP.* from [PaymentMethodParameter] PMP 
						inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
							where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
							((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
							PM.[ApplicationId] = @ApplicationId

						select SPR.* from [ShippingPaymentRestriction] SPR  
						inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
							where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
							((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
							PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=0
					END'

exec dbo.sp_executesql @sql

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----Jannuary 22, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 68;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @sql nvarchar(4000)
set @sql = N'IF  EXISTS (SELECT * FROM sysobjects WHERE xtype = ''PK'' AND parent_obj = OBJECT_ID(N''[dbo].[ReturnReasonDictionary]''))
			ALTER TABLE [dbo].[ReturnReasonDictionary] DROP CONSTRAINT [PK_ReturnReasonDictionary]			
			ALTER TABLE [dbo].[ReturnReasonDictionary]
			ADD CONSTRAINT [PK_ReturnReasonDictionary] PRIMARY KEY ([ReturnReasonText], [ApplicationId])'

exec dbo.sp_executesql @sql

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

----March 04, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 69;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @sql nvarchar(4000)
set @sql = N'IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketPaymentMethods_PaymentMethod]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketPaymentMethods]''))
ALTER TABLE [dbo].[MarketPaymentMethods] DROP CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketPaymentMethods_Market]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketPaymentMethods]''))
ALTER TABLE [dbo].[MarketPaymentMethods] DROP CONSTRAINT [FK_MarketPaymentMethods_Market]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[MarketPaymentMethods]'') AND type in (N''U''))
DROP TABLE [dbo].[MarketPaymentMethods]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[MarketPaymentMethods]'') AND type in (N''U''))
BEGIN
CREATE TABLE [dbo].[MarketPaymentMethods](
	[MarketId] [nvarchar](8) NOT NULL,
	[PaymentMethodId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_MarketPaymentMethods] PRIMARY KEY CLUSTERED (MarketId, PaymentMethodId)
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketPaymentMethods_PaymentMethod]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketPaymentMethods]''))
ALTER TABLE [dbo].[MarketPaymentMethods]  WITH CHECK ADD  CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod] FOREIGN KEY([PaymentMethodId])
REFERENCES [PaymentMethod] ([PaymentMethodId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketPaymentMethods] CHECK CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod]

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N''[dbo].[FK_MarketPaymentMethods_Market]'') AND parent_object_id = OBJECT_ID(N''[dbo].[MarketPaymentMethods]''))
ALTER TABLE [dbo].[MarketPaymentMethods]  WITH CHECK ADD  CONSTRAINT [FK_MarketPaymentMethods_Market] FOREIGN KEY([MarketId])
REFERENCES [Market] ([MarketId])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[MarketPaymentMethods] CHECK CONSTRAINT [FK_MarketPaymentMethods_PaymentMethod]


INSERT INTO [MarketPaymentMethods] ([PaymentMethodId], [MarketId])
SELECT pm.PaymentMethodId, m.MarketId 
FROM [PaymentMethod] pm 
CROSS JOIN [Market] m
WHERE NOT EXISTS (SELECT * FROM [MarketPaymentMethods] mpm WHERE mpm.PaymentMethodId = pm.PaymentMethodId AND mpm.MarketId = m.MarketId);'

exec dbo.sp_executesql @sql

END
GO


----April 05, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 70;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(4000)
set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_PaymentMethod_SystemKeyword') then 'alter ' else 'create ' end
declare @sql nvarchar(4000)
set @sql = @verb + N'PROCEDURE [dbo].[ecf_PaymentMethod_SystemKeyword]
	@ApplicationId uniqueidentifier,
	@SystemKeyword nvarchar(30),
	@LanguageId nvarchar(128),
	@MarketId nvarchar(8),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		COALESCE (@SystemKeyword, [SystemKeyword]) = [SystemKeyword] and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		(PM.[SystemKeyword] = @SystemKeyword) and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		(PM.[SystemKeyword] = @SystemKeyword) and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=1
	
	select MPM.* from [MarketPaymentMethods] MPM  
	inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		COALESCE (@SystemKeyword, [SystemKeyword]) = [SystemKeyword] and
		COALESCE (@MarketId, [MarketId]) = [MarketId] and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and
		PM.[ApplicationId] = @ApplicationId
	END'

exec dbo.sp_executesql @sql

set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_PaymentMethod_Language') then 'alter ' else 'create ' end
set @sql = @verb + N'PROCEDURE [dbo].[ecf_PaymentMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=0
			
	select MPM.* from [MarketPaymentMethods] MPM  
	inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and
		PM.[ApplicationId] = @ApplicationId
END'

exec dbo.sp_executesql @sql

set @verb = case when exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ecf_PaymentMethod_Market') then 'alter ' else 'create ' end
set @sql = @verb + N'PROCEDURE [dbo].[ecf_PaymentMethod_Market]
	@ApplicationId uniqueidentifier,
	@MarketId nvarchar(8),
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select PM.* from [PaymentMethod] PM
	inner join [MarketPaymentMethods] PMM on PMM.[PaymentMethodId] = PM.[PaymentMethodId]
		where COALESCE(@MarketId, PMM.[MarketId]) = PMM.[MarketId] and
		COALESCE(@LanguageId, PM.[LanguageId]) = PM.[LanguageId] and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and
		PM.[ApplicationId] = @ApplicationId

	select PMP.* from [PaymentMethodParameter] PMP
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
	inner join [MarketPaymentMethods] PMM on PMM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@MarketId, PMM.[MarketId]) = PMM.[MarketId] and 
		COALESCE(@LanguageId, PM.[LanguageId]) = PM.[LanguageId] and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
	inner join [MarketPaymentMethods] PMM on PMM.[PaymentMethodId] = PM.[PaymentMethodId]
		where COALESCE(@MarketId, PMM.[MarketId]) = PMM.[MarketId] and
		COALESCE(@LanguageId, PM.[LanguageId]) = PM.[LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=0

	select MPM.* from [MarketPaymentMethods] MPM  
	inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		MPM.[MarketId] = @MarketId and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

END'

exec dbo.sp_executesql @sql



--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


----April 26, 2013------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 71;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
DECLARE @verb NVARCHAR(4000)
DECLARE @sql NVARCHAR(4000)
DECLARE @ApplicationId UNIQUEIDENTIFIER

SELECT TOP 1 @ApplicationId = ApplicationId from [Application]

-- Insert new shipping method for In Store Pickup
DECLARE @GenericShippingOptionId UNIQUEIDENTIFIER
SELECT @GenericShippingOptionId = [ShippingOptionId] FROM [ShippingOption] WHERE [SystemKeyword] = 'Generic' AND [ApplicationId] = @ApplicationId

DECLARE @NewShippingMethodId UNIQUEIDENTIFIER
SET @NewShippingMethodId = NEWID()

INSERT INTO [ShippingMethod]
([ShippingMethodId], [ShippingOptionId], [ApplicationId], [LanguageId], [IsActive], [Name], [Description], [BasePrice], [Currency], [DisplayName], [IsDefault], [Ordering], [Created], [Modified])
VALUES
(@NewShippingMethodId, @GenericShippingOptionId, @ApplicationId, 'en', 1, 'In Store Pickup', NULL, 0, 'USD', 'In Store Pickup', 0, 0, '2013-04-17 10:11:32', '2013-04-17 10:11:32');

-- Update stored procedure
SET @verb = CASE WHEN EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_ShippingMethod_Language') THEN 'ALTER ' ELSE 'CREATE ' END
SET @sql = @verb + N'PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(10) = null,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ApplicationId] = @ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
		where SO.[ApplicationId] = @ApplicationId
	select distinct SM.* from [ShippingMethod] SM 
	inner join [Warehouse] W on SM.ApplicationId = W.ApplicationId
		where COALESCE(@LanguageId, LanguageId) = LanguageId and ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.ApplicationId = @ApplicationId
			and (SM.Name <> ''In Store Pickup'' or W.IsPickupLocation = 1)
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package] where [ApplicationId] = @ApplicationId
	select SP.* from [ShippingPackage] SP 
	inner join [Package] P on SP.[PackageId]=P.[PackageId]
		where P.[ApplicationId] = @ApplicationId
END' 

EXEC dbo.sp_executesql @sql

-- Add/Update new stored procedure
SET @verb = CASE WHEN EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_ShippingMethod_Market') THEN 'ALTER ' ELSE 'CREATE ' END
SET @sql = @verb + N'PROCEDURE [dbo].[ecf_ShippingMethod_Market]
    @ApplicationId uniqueidentifier,
    @MarketId nvarchar(10) = null,
    @ReturnInactive bit = 0
AS
BEGIN
    declare @_shippingMethodIds as table (ShippingMethodId uniqueidentifier)
    insert into @_shippingMethodIds
    select SM.ShippingMethodId
        from [ShippingMethod] SM
        inner join [MarketLanguages] ML
          on SM.LanguageId = ML.LanguageCode
        inner join [Market] M
          on ML.MarketId = M.MarketId
        inner join [Warehouse] W
          on W.ApplicationId = SM.ApplicationId
        where COALESCE(@MarketId, M.MarketId) = M.MarketId
          and ((SM.[IsActive] = 1) or (@ReturnInactive = 1))
          and SM.ApplicationId = @ApplicationId
          and (SM.Name <> ''In Store Pickup'' or W.IsPickupLocation = 1)

    select * from [ShippingOption] where [ApplicationId] = @ApplicationId
    
    select SOP.* from [ShippingOptionParameter] SOP 
    inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
        where SO.[ApplicationId] = @ApplicationId
        
    select distinct SM.* from [ShippingMethod] SM where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    
    select * from [ShippingPaymentRestriction]
        where 
            ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
            and
            [RestrictShippingMethods] = 0
    select * from [Package] where [ApplicationId] = @ApplicationId

    select SP.* from [ShippingPackage] SP 
    inner join [Package] P on SP.[PackageId]=P.[PackageId]
        where P.[ApplicationId] = @ApplicationId
END' 

EXEC dbo.sp_executesql @sql

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

--------------- September 20, 2013 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 72;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
declare @verb nvarchar(max)
declare @sql nvarchar(max)
SET @verb = CASE WHEN EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'ecf_GetMostRecentOrder') THEN 'ALTER ' ELSE 'CREATE ' END
SET @sql = @verb + N'PROCEDURE [dbo].[ecf_GetMostRecentOrder]
(
	@CustomerId uniqueidentifier, 
	@ApplicationId uniqueidentifier
)
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select top 1 [OrderGroupId]
	from [OrderGroup_PurchaseOrder] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
	where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
	ORDER BY ObjectId DESC

	exec dbo.ecf_Search_OrderGroup @results

	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'

EXEC dbo.sp_executesql @sql

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

declare @major int = 5
declare @minor int = 0
declare @patch int = 73
if not exists (select 1 from SchemaVersion_OrderSystem where Major=@major and Minor=@minor and Patch=@patch)
begin
    if not exists (select 1 from sys.columns where object_id = OBJECT_ID('dbo.LineItem', 'U') and name = 'IsInventoryAllocated')
    begin
        exec dbo.sp_executesql N'alter table dbo.LineItem add IsInventoryAllocated bit not null constraint DF_LineItem_IsInventoryAllocated default 0'
        exec dbo.sp_executesql N'update LineItem set IsInventoryAllocated = 1'
        exec dbo.mdpsp_sys_RefreshSystemMetaClassInfoAll 
    end

    if OBJECT_ID('dbo.ecf_LineItem_Insert', 'P') is not null drop procedure dbo.ecf_LineItem_Insert
    if OBJECT_ID('dbo.ecf_LineItem_Update', 'P') is not null drop procedure dbo.ecf_LineItem_Update

    exec dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_LineItem_Insert]
(
	@LineItemId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(50),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money,
	@WarehouseCode nvarchar(50) = NULL,
    @IsInventoryAllocated bit = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [LineItem]
	(
		[OrderFormId],
		[OrderGroupId],
		[Catalog],
		[CatalogNode],
		[ParentCatalogEntryId],
		[CatalogEntryId],
		[Quantity],
		[PlacedPrice],
		[ListPrice],
		[LineItemDiscountAmount],
		[OrderLevelDiscountAmount],
		[ShippingAddressId],
		[ShippingMethodName],
		[ShippingMethodId],
		[ExtendedPrice],
		[Description],
		[Status],
		[DisplayName],
		[AllowBackordersAndPreorders],
		[InStockQuantity],
		[PreorderQuantity],
		[BackorderQuantity],
		[InventoryStatus],
		[LineItemOrdering],
		[ConfigurationId],
		[MinQuantity],
		[MaxQuantity],
		[ProviderId],
		[ReturnReason],
		[OrigLineItemId],
		[ReturnQuantity],
		[WarehouseCode],
        [IsInventoryAllocated]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@Catalog,
		@CatalogNode,
		@ParentCatalogEntryId,
		@CatalogEntryId,
		@Quantity,
		@PlacedPrice,
		@ListPrice,
		@LineItemDiscountAmount,
		@OrderLevelDiscountAmount,
		@ShippingAddressId,
		@ShippingMethodName,
		@ShippingMethodId,
		@ExtendedPrice,
		@Description,
		@Status,
		@DisplayName,
		@AllowBackordersAndPreorders,
		@InStockQuantity,
		@PreorderQuantity,
		@BackorderQuantity,
		@InventoryStatus,
		@LineItemOrdering,
		@ConfigurationId,
		@MinQuantity,
		@MaxQuantity,
		@ProviderId,
		@ReturnReason,
		@OrigLineItemId,
		@ReturnQuantity,
		@WarehouseCode,
        @IsInventoryAllocated
	)

	SELECT @LineItemId = SCOPE_IDENTITY()

	RETURN @@Error
'

    exec dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_LineItem_Update]
(
	@LineItemId int,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(255),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money,
	@WarehouseCode nvarchar(50) = NULL,
    @IsInventoryAllocated bit = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [LineItem]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[Catalog] = @Catalog,
		[CatalogNode] = @CatalogNode,
		[ParentCatalogEntryId] = @ParentCatalogEntryId,
		[CatalogEntryId] = @CatalogEntryId,
		[Quantity] = @Quantity,
		[PlacedPrice] = @PlacedPrice,
		[ListPrice] = @ListPrice,
		[LineItemDiscountAmount] = @LineItemDiscountAmount,
		[OrderLevelDiscountAmount] = @OrderLevelDiscountAmount,
		[ShippingAddressId] = @ShippingAddressId,
		[ShippingMethodName] = @ShippingMethodName,
		[ShippingMethodId] = @ShippingMethodId,
		[ExtendedPrice] = @ExtendedPrice,
		[Description] = @Description,
		[Status] = @Status,
		[DisplayName] = @DisplayName,
		[AllowBackordersAndPreorders] = @AllowBackordersAndPreorders,
		[InStockQuantity] = @InStockQuantity,
		[PreorderQuantity] = @PreorderQuantity,
		[BackorderQuantity] = @BackorderQuantity,
		[InventoryStatus] = @InventoryStatus,
		[LineItemOrdering] = @LineItemOrdering,
		[ConfigurationId] = @ConfigurationId,
		[MinQuantity] = @MinQuantity,
		[MaxQuantity] = @MaxQuantity,
		[ProviderId] = @ProviderId,
		[ReturnReason] = @ReturnReason,
		[OrigLineItemId] = @OrigLineItemId,
		[ReturnQuantity] = @ReturnQuantity,
		[WarehouseCode] = @WarehouseCode,
        [IsInventoryAllocated] = @IsInventoryAllocated
	WHERE 
		[LineItemId] = @LineItemId

	IF @@ERROR > 0
	BEGIN
		RAISERROR(''Concurrency Error'',16,1)
	END

	RETURN @@Error
'

    insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(Varchar(2), @major) + '.' + CONVERT(Varchar(2), @minor) + '.' +  CONVERT(varchar(3), @patch) + ' was applied successfully '
end
GO

--------------- November 19, 2013 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 74;

Select @Installed = InstallDate  from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

exec sp_ExecuteSQL N'ALTER PROCEDURE [dbo].[ecf_PaymentMethod_PaymentMethodId]
	@ApplicationId uniqueidentifier,
	@PaymentMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
		where [PaymentMethodId] = @PaymentMethodId and 
			[ApplicationId] = @ApplicationId and (([IsActive] = 1) or @ReturnInactive = 1)

	if @@rowcount > 0 begin
		select * from [PaymentMethodParameter] 
			where [PaymentMethodId] = @PaymentMethodId

		select * from [ShippingPaymentRestriction] 
			where [PaymentMethodId] = @PaymentMethodId and [RestrictShippingMethods] = 1
	end
	else begin
		-- select nothing
		select * from [PaymentMethodParameter] where 1=0
		select * from [ShippingPaymentRestriction] where 1=0
	end
		select MPM.* from [MarketPaymentMethods] MPM  
		inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where ((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		MPM.[PaymentMethodId] = @PaymentMethodId and
		PM.[ApplicationId] = @ApplicationId
END'

--## END Schema Patch ##
Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO