-- mcmd_MetaModelVersionId
INSERT INTO mcmd_MetaModelVersionId ([VersionId]) VALUES (NEWID())

-- mcmd_MetaFieldType
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Guid', '{GlobalMetaInfo:Guid}', 2)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('DateTime', '{GlobalMetaInfo:DateTime}', 1)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Date', '{GlobalMetaInfo:Date}', 1)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Integer', '{GlobalMetaInfo:Integer}', 0)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Float', '{GlobalMetaInfo:Float}', 3)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Currency', '{GlobalMetaInfo:Currency}', 4)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('CheckboxBoolean', '{GlobalMetaInfo:CheckboxBoolean}', 5)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('DropDownBoolean', '{GlobalMetaInfo:DropDownBoolean}', 5)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Text', '{GlobalMetaInfo:Text}', 6)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('EMail', '{GlobalMetaInfo:EMail}', 6)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Url', '{GlobalMetaInfo:Url}', 6)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('LongText', '{GlobalMetaInfo:LongText}', 6)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Html', '{GlobalMetaInfo:Html}', 6)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('File', '{GlobalMetaInfo:File}', 7)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Image', '{GlobalMetaInfo:Image}', 7)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Reference', '{GlobalMetaInfo:Reference}', 9)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('ReferencedField', '{GlobalMetaInfo:ReferencedField}', 10)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('BackReference', '{GlobalMetaInfo:BackReference}', 11)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Card', 'Card', 12)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Link', '{GlobalMetaInfo:Link}', 14)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Aggregation', '{GlobalMetaInfo:Aggregation}', 15)

INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('IntegerPercent', '{GlobalMetaInfo:IntegerPercent}', 0)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('FloatPercent', '{GlobalMetaInfo:FloatPercent}', 3)
INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Duration', '{GlobalMetaInfo:Duration}', 0)

-- From Mediachase.Ibn.Data.Services
--INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('Role', '{GlobalMetaInfo:Role}', 16)
--INSERT INTO mcmd_MetaFieldType ([Name], [FriendlyName], [McDataType]) VALUES ('RoleMultiValue', '{GlobalMetaInfo:RoleMultiValue}', 16)



--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 0;

WHILE( @Patch <= 2) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion_BusinessFoundation where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion_BusinessFoundation(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO

