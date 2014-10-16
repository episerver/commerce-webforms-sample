
--|--------------------------------------------------------------------------------
--| [MetaDataType] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
BEGIN TRANSACTION

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(0, 'BigInt', 'bigint', 'MSSQL Common Type', 8, 'bigint', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(1, 'Binary', 'binary', 'MSSQL Common Type', 8000, 'binary', 1, 0, 1, '');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(2, 'Bit', 'bit', 'MSSQL Common Type', 1, 'bit', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(3, 'Char', 'char', 'MSSQL Common Type', 8000, 'char', 1, 0, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(4, 'DateTime', 'datetime', 'MSSQL Common Type', 8, 'datetime', 1, 0, 1, 'getdate()');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(5, 'Decimal', 'decimal', 'MSSQL Common Type', 17, 'decimal', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(6, 'Float', 'float', 'MSSQL Common Type', 8, 'float', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(7, 'Image', 'image', 'MSSQL Common Type', 16, 'image', 1, 0, 1, '');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(8, 'Int', 'int', 'MSSQL Common Type', 4, 'int', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(9, 'Money', 'money', 'MSSQL Common Type', 8, 'money', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(10, 'NChar', 'nchar', 'MSSQL Common Type', 8000, 'nchar', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(11, 'NText', 'ntext', 'MSSQL Common Type', 16, 'ntext', 1, 0, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(12, 'NVarChar', 'nvarchar', 'MSSQL Common Type', 8000, 'nvarchar', 1, 1, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(13, 'Real', 'real', 'MSSQL Common Type', 4, 'real', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(14, 'UniqueIdentifier', 'uniqueidentifier', 'MSSQL Common Type', 16, 'uniqueidentifier', 1, 0, 1, 'newid()');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(15, 'SmallDateTime', 'smalldatetime', 'MSSQL Common Type', 4, 'smalldatetime', 1, 0, 1, 'getdate()');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(16, 'SmallInt', 'smallint', 'MSSQL Common Type', 2, 'smallint', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(17, 'SmallMoney', 'smallmoney', 'MSSQL Common Type', 4, 'smallmoney', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(18, 'Text', 'text', 'MSSQL Common Type', 16, 'text', 1, 0, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(19, 'Timestamp', 'timestamp', 'MSSQL Common Type', 8, 'timestamp', 0, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(20, 'TinyInt', 'tinyint', 'MSSQL Common Type', 1, 'tinyint', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(21, 'VarBinary', 'varbinary', 'MSSQL Common Type', 8000, 'varbinary', 1, 1, 1, '');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(22, 'VarChar', 'varchar', 'MSSQL Common Type', 8000, 'varchar', 1, 1, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(23, 'Variant', 'sql_variant', 'MSSQL Common Type', 8016, 'sql_variant', 1, 0, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(24, 'Numeric', 'numeric', 'MSSQL Common Type', 17, 'numeric', 1, 0, 1, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(25, 'Sysname', 'sysname', 'MSSQL Common Type', 256, 'sysname', 0, 1, 1, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(26, 'Integer', 'Integer', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(27, 'Boolean', 'Boolean', 'Meta Data Type', 1, 'bit', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(28, 'Date', 'Date', 'Meta Data Type', 8, 'datetime', 1, 0, 0, 'getdate()');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(29, 'Email', 'Email', 'Meta Data Type', 256, 'varchar', 1, 1, 0, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(30, 'URL', 'URL', 'Meta Data Type', 512, 'varchar', 1, 1, 0, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(31, 'ShortString', 'Short String', 'Meta Data Type', 512, 'nvarchar', 1, 1, 0, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(32, 'LongString', 'Long String', 'Meta Data Type', 16, 'ntext', 1, 0, 0, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(33, 'LongHtmlString', 'Long Html String', 'Meta Data Type', 16, 'ntext', 1, 0, 0, '''''');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(34, 'DictionarySingleValue', 'Dictionary Single Value', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(35, 'DictionaryMultiValue', 'Dictionary Multi Value', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(36, 'EnumSingleValue', 'Enum Single Value', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(37, 'EnumMultiValue', 'Enum Multi Value', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(38, 'StringDictionary', 'String Dictionary', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(39, 'File', 'File', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(40, 'ImageFile', 'Image File', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	INSERT INTO [MetaDataType]
	([DataTypeId], [Name], [FriendlyName], [Description], [Length], [SqlName], [AllowNulls], [Variable], [IsSQLCommonType], [DefaultValue])
	VALUES
	(41, 'MetaObject', 'Meta Object', 'Meta Data Type', 4, 'int', 1, 0, 0, '0');

	-- Create keys
	EXEC dbo.sp_executesql @statement = N'IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = N''##MS_DatabaseMasterKey##'')
		CREATE MASTER KEY ENCRYPTION BY PASSWORD = ''5F18E937-6F17-4EED-8265-D2CBC9FEA553'''

	EXEC dbo.sp_executesql @statement = N'IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = N''Mediachase_ECF50_MDP'')
		CREATE CERTIFICATE Mediachase_ECF50_MDP WITH SUBJECT = ''Mediachase Certificate'''
	
	EXEC dbo.sp_executesql @statement = N'IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = N''Mediachase_ECF50_MDP_Key'')
		CREATE SYMMETRIC KEY Mediachase_ECF50_MDP_Key WITH ALGORITHM = AES_128 ENCRYPTION BY CERTIFICATE Mediachase_ECF50_MDP'

IF @@ERROR <> 0 ROLLBACK TRANSACTION;
ELSE COMMIT TRANSACTION;
GO


------------------------- Bring the SchemaVersion up to the current level -----------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 2;
Set @Patch = 0;

WHILE( @Patch <= 16) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion_MetaDataSystem where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion_MetaDataSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO
