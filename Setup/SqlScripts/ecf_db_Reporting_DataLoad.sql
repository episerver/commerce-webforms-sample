DECLARE @Date DATETIME
 SET @Date = '1/1/2009'     

 WHILE @Date < '1/1/2015'
 BEGIN
     INSERT INTO ReportingDates
     (
         DateKey, DateFull, FullYear,
         QuarterNumber, WeekNumber, WeekDayName,
         MonthDay, MonthName, YearDay,
         DateDefinition,
                CharacterDate,
                WeekDay,
                MonthNumber
     )
     SELECT
         CONVERT(VARCHAR(8), @Date, 112), @Date, YEAR(@Date),
         DATEPART(qq, @Date), DATEPART(ww, @Date), DATENAME(dw, @Date),
         DATEPART(dd, @Date), DATENAME(mm, @Date), DATEPART(dy,@Date),
               DATENAME(mm, @Date) + ' ' + CAST(DATEPART(dd, @Date) AS CHAR(2)) + ',   
           ' + CAST(DATEPART(yy, @Date) AS CHAR(4)),
           CONVERT(VARCHAR(10), @Date, 101),
           DATEPART(dw, @Date),
           DATEPART(mm, @Date)
    
     SET @Date = DATEADD(dd, 1, @Date)
 END

GO

--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 0;

WHILE( @Patch <= 15) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO
