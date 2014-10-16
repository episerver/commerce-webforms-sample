
-- Setup full text catalog if fulltext is already enabled
DECLARE 	@IsFulltextEnabled INT
DECLARE 	@IsFulltextDBEnabled INT
SELECT @IsFulltextEnabled = FULLTEXTSERVICEPROPERTY( 'IsFullTextInstalled' )
IF @IsFulltextEnabled = 1
BEGIN
	SELECT @IsFulltextDBEnabled = DatabaseProperty (DB_NAME(DB_ID()),  'IsFulltextEnabled' )
END
ELSE
  RETURN

exec mdpsp_sys_FullTextQueriesActivate
  
GO
DECLARE 	@IsFulltextEnabled INT
SELECT @IsFulltextEnabled = FULLTEXTSERVICEPROPERTY( 'IsFullTextInstalled' )
IF @IsFulltextEnabled = 1
BEGIN
	exec [mdpsp_sys_FullTextQueriesAddAllFields]
END

GO