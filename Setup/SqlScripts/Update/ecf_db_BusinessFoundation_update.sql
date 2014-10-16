/********************************************************************
             Pre Release Upgrade Script
*********************************************************************/

----February 22, 2011------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate  from SchemaVersion_BusinessFoundation where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

DECLARE @ContactMetaClassId int, @pars nvarchar(256)
SET @Pars = '@MetaClassId int'

SELECT @ContactMetaClassId = MetaClassId FROM [dbo].[mcmd_MetaClass] WHERE [Name] = 'Contact' AND [Owner] = 'System' AND [AccessLevel] = 1

IF NOT @ContactMetaClassId IS NULL AND
	NOT EXISTS(SELECT MetaFieldId FROM [dbo].[mcmd_MetaField] WHERE [MetaClassId] = @ContactMetaClassId AND [Name] = N'PreferredBillingAddress')
BEGIN
	EXEC dbo.sp_executesql N'INSERT INTO [dbo].[mcmd_MetaField] ([Name], [MetaClassId], [FriendlyName], [TypeName], [Nullable], [DefaultValue], [ReadOnly], [XSDataSource], [XSAttributes], [Owner], [AccessLevel]) 
	VALUES (N''PreferredBillingAddress'', @MetaClassId, N''{Customer:Contact_mf_PreferredBillingAddress}'', N''ReferencedField'', 0, N'''', 1, N''<?xml version="1.0"?>
	<MetaFieldDataSource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	  <Table>cls_Address</Table>
	  <InPrimaryKey>false</InPrimaryKey>
	  <Columns>
		<string>Name</string>
	  </Columns>
	  <Type>Reference</Type>
	</MetaFieldDataSource>'', N''<?xml version="1.0"?>
	<AttributeCollection>
	  <Attr>
		<Name>MetaClassName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>Address</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>MetaFieldName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>Name</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>RefName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>PreferredBillingAddressId</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>Description</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>{Customer:Contact_mf_PreferredBillingAddress_Description}</string>
		</Value>
	  </Attr>
	</AttributeCollection>'', N''System'', 1)', @Pars, @MetaClassId = @ContactMetaClassId

	EXEC dbo.sp_executesql N'INSERT INTO [dbo].[mcmd_MetaField] ([Name], [MetaClassId], [FriendlyName], [TypeName], [Nullable], [DefaultValue], [ReadOnly], [XSDataSource], [XSAttributes], [Owner], [AccessLevel]) 
	VALUES (N''PreferredBillingAddressId'', @MetaClassId, N''{Customer:Contact_mf_PreferredBillingAddress}'', N''Reference'', 1, N'''', 0, N''<?xml version="1.0"?>
	<MetaFieldDataSource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	  <Table>cls_Contact</Table>
	  <InPrimaryKey>false</InPrimaryKey>
	  <Columns>
		<string>PreferredBillingAddressId</string>
	  </Columns>
	  <Type>Table</Type>
	</MetaFieldDataSource>'', N''<?xml version="1.0"?>
	<AttributeCollection>
	  <Attr>
		<Name>MetaClassName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>Address</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>Description</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>{Customer:Contact_mf_PreferredBillingAddressId_Description}</string>
		</Value>
	  </Attr>
	</AttributeCollection>'', N''System'', 1)', @Pars, @MetaClassId = @ContactMetaClassId

	EXEC dbo.sp_executesql N'INSERT INTO [dbo].[mcmd_MetaField] ([Name], [MetaClassId], [FriendlyName], [TypeName], [Nullable], [DefaultValue], [ReadOnly], [XSDataSource], [XSAttributes], [Owner], [AccessLevel]) 
	VALUES (N''PreferredShippingAddress'', @MetaClassId, N''{Customer:Contact_mf_PreferredShippingAddress}'', N''ReferencedField'', 0, N'''', 1, N''<?xml version="1.0"?>
	<MetaFieldDataSource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	  <Table>cls_Address</Table>
	  <InPrimaryKey>false</InPrimaryKey>
	  <Columns>
		<string>Name</string>
	  </Columns>
	  <Type>Reference</Type>
	</MetaFieldDataSource>'', N''<?xml version="1.0"?>
	<AttributeCollection>
	  <Attr>
		<Name>MetaClassName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>Address</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>MetaFieldName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>Name</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>RefName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>PreferredShippingAddressId</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>Description</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>{Customer:Contact_mf_PreferredShippingAddress_Description}</string>
		</Value>
	  </Attr>
	</AttributeCollection>'', N''System'', 1)', @Pars, @MetaClassId = @ContactMetaClassId

	EXEC dbo.sp_executesql N'INSERT INTO [dbo].[mcmd_MetaField] ([Name], [MetaClassId], [FriendlyName], [TypeName], [Nullable], [DefaultValue], [ReadOnly], [XSDataSource], [XSAttributes], [Owner], [AccessLevel])
	 VALUES (N''PreferredShippingAddressId'', @MetaClassId, N''{Customer:Contact_mf_PreferredShippingAddress}'', N''Reference'', 1, N'''', 0, N''<?xml version="1.0"?>
	<MetaFieldDataSource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	  <Table>cls_Contact</Table>
	  <InPrimaryKey>false</InPrimaryKey>
	  <Columns>
		<string>PreferredShippingAddressId</string>
	  </Columns>
	  <Type>Table</Type>
	</MetaFieldDataSource>'', N''<?xml version="1.0"?>
	<AttributeCollection>
	  <Attr>
		<Name>MetaClassName</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>Address</string>
		</Value>
	  </Attr>
	  <Attr>
		<Name>Description</Name>
		<Type>System.String, mscorlib</Type>
		<Value>
		  <string>{Customer:Contact_mf_PreferredShippingAddressId_Description}</string>
		</Value>
	  </Attr>
	</AttributeCollection>'', N''System'', 1)', @Pars, @MetaClassId = @ContactMetaClassId

	EXEC dbo.sp_executesql N'ALTER TABLE [dbo].[cls_Contact] ADD
		[PreferredShippingAddressId] [uniqueidentifier] NULL,
		[PreferredBillingAddressId] [uniqueidentifier] NULL'

	EXEC dbo.sp_executesql N'ALTER TABLE [dbo].[cls_Contact]  WITH CHECK ADD FOREIGN KEY([PreferredShippingAddressId])
	REFERENCES [dbo].[cls_Address] ([AddressId])'

	EXEC dbo.sp_executesql N'ALTER TABLE [dbo].[cls_Contact]  WITH CHECK ADD FOREIGN KEY([PreferredBillingAddressId])
	REFERENCES [dbo].[cls_Address] ([AddressId])'

	EXEC dbo.sp_executesql N'ALTER PROCEDURE [dbo].[mc_cls_ContactInsert]
	@ContactId AS UniqueIdentifier,
	@Created AS DateTime,
	@Modified AS DateTime,
	@CreatorId AS UniqueIdentifier,
	@ModifierId AS UniqueIdentifier,
	@FullName AS NVarChar(4000),
	@LastName AS NVarChar(4000),
	@FirstName AS NVarChar(4000),
	@MiddleName AS NVarChar(4000),
	@Email AS NVarChar(4000),
	@BirthDate AS DateTime,
	@LastOrder AS DateTime,
	@CustomerGroup AS Int,
	@Code AS NVarChar(4000),
	@PreferredLanguage AS NVarChar(4000),
	@PreferredCurrency AS NVarChar(4000),
	@RegistrationSource AS NVarChar(4000),
	@OwnerId AS UniqueIdentifier,
	@PreferredShippingAddressId AS UniqueIdentifier,
	@PreferredBillingAddressId AS UniqueIdentifier
	AS
	BEGIN
	SET NOCOUNT ON;
	INSERT INTO [cls_Contact]
	(
	[ContactId],
	[Created],
	[Modified],
	[CreatorId],
	[ModifierId],
	[FullName],
	[LastName],
	[FirstName],
	[MiddleName],
	[Email],
	[BirthDate],
	[LastOrder],
	[CustomerGroup],
	[Code],
	[PreferredLanguage],
	[PreferredCurrency],
	[RegistrationSource],
	[OwnerId],
	[PreferredShippingAddressId],
	[PreferredBillingAddressId])
	VALUES(
	@ContactId,
	@Created,
	@Modified,
	@CreatorId,
	@ModifierId,
	@FullName,
	@LastName,
	@FirstName,
	@MiddleName,
	@Email,
	@BirthDate,
	@LastOrder,
	@CustomerGroup,
	@Code,
	@PreferredLanguage,
	@PreferredCurrency,
	@RegistrationSource,
	@OwnerId,
	@PreferredShippingAddressId,
	@PreferredBillingAddressId)
	END'

	EXEC dbo.sp_executesql N'ALTER PROCEDURE [dbo].[mc_cls_ContactSelect]
	@ContactId AS UniqueIdentifier
	AS
	BEGIN
	SET NOCOUNT ON;
	SELECT [t01].[ContactId] AS [ContactId], [t01].[Created] AS [Created], [t01].[Modified] AS [Modified], [t01].[CreatorId] AS [CreatorId], [t01].[ModifierId] AS [ModifierId], [t01].[FullName] AS [FullName], [t01].[LastName] AS [LastName], [t01].[FirstName] AS [FirstName], [t01].[MiddleName] AS [MiddleName], [t01].[Email] AS [Email], [t01].[BirthDate] AS [BirthDate], [t01].[LastOrder] AS [LastOrder], [t01].[CustomerGroup] AS [CustomerGroup], [t01].[Code] AS [Code], [t01].[PreferredLanguage] AS [PreferredLanguage], [t01].[PreferredCurrency] AS [PreferredCurrency], [t01].[RegistrationSource] AS [RegistrationSource], [t01].[OwnerId] AS [OwnerId], [t01].[PreferredShippingAddressId] AS [PreferredShippingAddressId], [t01].[PreferredBillingAddressId] AS [PreferredBillingAddressId], [t02].[Name] AS [Owner], [t04].[Name] AS [PreferredShippingAddress], [t06].[Name] AS [PreferredBillingAddress]
	FROM [cls_Contact] AS [t01]
	LEFT JOIN [cls_Organization] AS [t02] ON [t01].[OwnerId] = [t02].[OrganizationId]
	LEFT JOIN [cls_Address] AS [t04] ON [t01].[PreferredShippingAddressId] = [t04].[AddressId]
	LEFT JOIN [cls_Address] AS [t06] ON [t01].[PreferredBillingAddressId] = [t06].[AddressId]
	WHERE ([t01].[ContactId]=@ContactId)
	END'

	EXEC dbo.sp_executesql N'ALTER PROCEDURE [dbo].[mc_cls_ContactUpdate]
	@Created AS DateTime,
	@Modified AS DateTime,
	@CreatorId AS UniqueIdentifier,
	@ModifierId AS UniqueIdentifier,
	@FullName AS NVarChar(4000),
	@LastName AS NVarChar(4000),
	@FirstName AS NVarChar(4000),
	@MiddleName AS NVarChar(4000),
	@Email AS NVarChar(4000),
	@BirthDate AS DateTime,
	@LastOrder AS DateTime,
	@CustomerGroup AS Int,
	@Code AS NVarChar(4000),
	@PreferredLanguage AS NVarChar(4000),
	@PreferredCurrency AS NVarChar(4000),
	@RegistrationSource AS NVarChar(4000),
	@OwnerId AS UniqueIdentifier,
	@PreferredShippingAddressId AS UniqueIdentifier,
	@PreferredBillingAddressId AS UniqueIdentifier,
	@ContactId AS UniqueIdentifier
	AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE [cls_Contact] SET
	[Created] = @Created,
	[Modified] = @Modified,
	[CreatorId] = @CreatorId,
	[ModifierId] = @ModifierId,
	[FullName] = @FullName,
	[LastName] = @LastName,
	[FirstName] = @FirstName,
	[MiddleName] = @MiddleName,
	[Email] = @Email,
	[BirthDate] = @BirthDate,
	[LastOrder] = @LastOrder,
	[CustomerGroup] = @CustomerGroup,
	[Code] = @Code,
	[PreferredLanguage] = @PreferredLanguage,
	[PreferredCurrency] = @PreferredCurrency,
	[RegistrationSource] = @RegistrationSource,
	[OwnerId] = @OwnerId,
	[PreferredShippingAddressId] = @PreferredShippingAddressId,
	[PreferredBillingAddressId] = @PreferredBillingAddressId WHERE
	[ContactId] = @ContactId
	END'
END	

--## END Schema Patch ##
Insert into SchemaVersion_BusinessFoundation(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

declare @major int = 5, @minor int = 0, @patch int = 2
if not exists (select 1 from SchemaVersion_BusinessFoundation where Major=@major and Minor=@minor and Patch=@patch)
begin
    declare @sql nvarchar(4000)
    select @sql = 'alter table dbo.mcmd_TmpMetaFile drop constraint [' + REPLACE(df.name, ']', ']]') + ']'
    from sys.columns c
    join sys.default_constraints df on df.parent_object_id = c.object_id and df.parent_column_id = c.column_id
    where c.object_id = OBJECT_ID('dbo.mcmd_TmpMetaFile', 'U') and c.name = 'Created'

    if @sql is not null exec dbo.sp_executesql @sql

    exec dbo.sp_executesql N'alter table dbo.mcmd_TmpMetaFile add constraint DF_mcmd_TmpMetaFile_Created default (GETUTCDATE()) for Created'


    if OBJECT_ID('dbo.mc_blob_BlobStorageRemoveExpired', 'P') is not null exec dbo.sp_executesql N'drop procedure dbo.mc_blob_BlobStorageRemoveExpired'

    exec dbo.sp_executesql N'CREATE PROCEDURE [dbo].[mc_blob_BlobStorageRemoveExpired] 
	@PeriodInMin as int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM McBlobStorage 
    WHERE DateDiff(minute, [created], GETUTCDATE()) >= @PeriodInMin AND [isTemporary] = 1
END'

    insert into SchemaVersion_BusinessFoundation(Major, Minor, Patch, InstallDate) values (@major, @minor, @patch, GETDATE())
    print 'Schema Patch v' + CONVERT(varchar(2),@major) + '.' + CONVERT(varchar(2),@minor) + '.' +  CONVERT(varchar(3),@patch) + ' was applied successfully '
end
go
