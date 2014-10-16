/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist]    Script Date: 07/21/2009 17:24:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ecf_splitlist]
GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist_with_rowid]    Script Date: 23/11/2010 18:13:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist_with_rowid]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ecf_splitlist_with_rowid]
GO

/****** Object:  UserDefinedFunction [dbo].[cms_splitlist]    Script Date: 07/21/2009 17:24:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[cms_splitlist]
GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist]    Script Date: 07/21/2009 17:24:50 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ecf_splitlist]
(
	@List nvarchar(max)
)
RETURNS 
@ParsedList table
(
	Item nvarchar(100)
)
AS
BEGIN
	DECLARE @Item nvarchar(100), @Pos int

	SET @List = LTRIM(RTRIM(@List))+ '',''
	SET @Pos = CHARINDEX('','', @List, 1)

	IF REPLACE(@List, '','', '''') <> ''''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @Item = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
			IF @Item <> ''''
			BEGIN
				INSERT INTO @ParsedList (Item) 
				VALUES (CAST(@Item AS nvarchar(100))) --Use Appropriate conversion
			END
			SET @List = RIGHT(@List, LEN(@List) - @Pos)
			SET @Pos = CHARINDEX('','', @List, 1)

		END
	END	
	RETURN
END' 
END

GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist_with_rowid]    Script Date: 23/11/2010 18:13:26 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist_with_rowid]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ecf_splitlist_with_rowid]
(
	@List nvarchar(max)
)
RETURNS 
@ParsedList table
(
	Item nvarchar(100),
	RowId int
)
AS
BEGIN
	DECLARE @Item nvarchar(100), @Pos int, @RowId int
	SET @RowId = 0

	SET @List = LTRIM(RTRIM(@List))+ '',''
	SET @Pos = CHARINDEX('','', @List, 1)

	IF REPLACE(@List, '','', '''') <> ''''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @Item = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
			IF @Item <> ''''
			BEGIN
				SET @RowId = @RowId + 1
				INSERT INTO @ParsedList (Item, RowId) 
				VALUES (CAST(@Item AS nvarchar(100)), @RowId) --Use Appropriate conversion
			END
			SET @List = RIGHT(@List, LEN(@List) - @Pos)
			SET @Pos = CHARINDEX('','', @List, 1)
		END
	END	
	RETURN
END' 
END

GO

/****** Object:  UserDefinedFunction [dbo].[cms_splitlist]    Script Date: 07/21/2009 17:24:50 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[cms_splitlist]
(
	@List nvarchar(max)
)
RETURNS 
@ParsedList table
(
	Item nvarchar(100)
)
AS
BEGIN
	DECLARE @Item nvarchar(100), @Pos int

	SET @List = LTRIM(RTRIM(@List))+ '',''
	SET @Pos = CHARINDEX('','', @List, 1)

	IF REPLACE(@List, '','', '''') <> ''''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @Item = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
			IF @Item <> ''''
			BEGIN
				INSERT INTO @ParsedList (Item) 
				VALUES (CAST(@Item AS nvarchar(100))) --Use Appropriate conversion
			END
			SET @List = RIGHT(@List, LEN(@List) - @Pos)
			SET @Pos = CHARINDEX('','', @List, 1)

		END
	END	
	RETURN
END' 
END

GO

