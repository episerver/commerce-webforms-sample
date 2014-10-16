/********************************************************************
             Reporting System Upgrade Script
*********************************************************************/

-------------------- June 25, 2010 ------------------------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 1;

Select @Installed = InstallDate from SchemaVersion_CatalogSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'ALTER TABLE dbo.ReportingDates ADD CONSTRAINT
	IX_ReportingDates UNIQUE NONCLUSTERED 
	(
	DateFull
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME
AS

BEGIN

	with periodQuery
	as
	(
		SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), D.DateFull, 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, D.Datefull) + '', '' + CAST(YEAR(D.Datefull) AS VARCHAR(20))) 
							ElSE CAST(YEAR(D.Datefull) AS VARCHAR(20))  
							End) AS Period 
		FROM ReportingDates D
		WHERE D.Datefull BETWEEN @startdate AND @enddate
	)
	, lineItemsQuery as
	(
		select count(LineItemId) ItemsOrdered, OrderGroupId from LineItem L 
				group by OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OrderGroupId from OrderFormPayment 
				group by OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(20), PO.Created, 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, PO.Created) + '', '' + CAST(YEAR(PO.Created) AS VARCHAR(20)) )
							ElSE CAST(YEAR(PO.Created) AS VARCHAR(20)) End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			LEFT JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate)
		GROUP BY (Case WHEN @interval = ''Day''
					THEN CONVERT(VARCHAR(20), PO.Created, 101)
					WHEN @interval = ''Month''
					THEN (DATENAME(MM, PO.Created) + '', '' + CAST(YEAR(PO.Created) AS VARCHAR(20))  )
					ElSE CAST(YEAR(PO.Created) AS VARCHAR(20))   
				END) 
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 
END'

--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- August 22, 2011 ------------------------------------
-- various 5.1sp1 distributions contain inconsistent versions of these stored procedures.
-- this patch ensures that they are correct.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 2;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select count(LineItemId) ItemsOrdered, OrderGroupId from LineItem L 
				group by OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OrderGroupId from OrderFormPayment 
				group by OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			LEFT JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate)
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END'


EXEC dbo.sp_executesql @statement = N'ALTER PROCEDURE [dbo].[ecf_reporting_Shipping] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	SELECT	x.Period,  
			ISNULL(y.ShippingMethod, ''NONE'') AS ShippingMethod,
			ISNULL(y.NumberofOrders, 0) AS NumberOfOrders,
			ISNULL(y.Shipping, 0) AS TotalShipping
			
	FROM 
	(
		SELECT	DISTINCT (CASE WHEN @interval = ''Day''
							
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 
		FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
		WHERE D.Datefull BETWEEN  DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)

	) AS x

	LEFT JOIN

	(
		SELECT DISTINCT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20)) )
							ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   End) AS Period, 
				COUNT(S.ShipmentID) AS NumberofOrders, 
				SUM(S.ShipmentTotal) AS Shipping, 
				S.ShippingMethodName AS ShippingMethod
		FROM Shipment AS S INNER JOIN
		OrderForm AS F ON S.OrderFormId = F.OrderFormId INNER JOIN
			OrderFormEx AS FEX ON FEX.ObjectId = F.OrderFormId
		WHERE (FEX.Created BETWEEN @startdate AND @enddate)
		AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
		GROUP BY (Case WHEN @interval = ''Day''
					THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
					WHEN @interval = ''Month''
					THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))  )
					ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   
				END), S.ShippingMethodName
	) AS y

	ON x.Period = y.Period
	ORDER BY CONVERT(datetime, x.Period, 101)

END'

--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO


-------------------- January 23, 2012 ------------------------------------
-- Sales report counts returns as sales as well, resulting in a report that shows a greater total than what was actually sold.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 3;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/23/2012>
-- Description:		<Fixed bug counting duplicate line items after creating a return (ECF ver. 5.2.571)>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select count(LineItemId) ItemsOrdered, L.OrderGroupId from LineItem L 
				inner join OrderForm as OF1 on L.OrderFormId = OF1.OrderFormId
				where OF1.Name <> ''Return''
				group by L.OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OrderGroupId from OrderFormPayment 
				group by OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			LEFT JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate)
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END'



--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- January 25, 2012 ------------------------------------
-- Sales report counts returns as sales as well, resulting in a report that shows a greater total than what was actually sold. Items Ordered count was
-- fixed in the last patch. This patch skips Credits, which are payments happening from a return.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 4;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/23/2012>
-- Description:		<Fixed bug counting duplicate line items after creating a return (ECF ver. 5.2.571)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/25/2012>
-- Description:		<Fixed bug counting credits as payments after creating a return (ECF ver. 5.2.573)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/30/2012>
-- Description:		<Fixed bug counting payments other than Capture and Sale as valid payments (ECF ver. 5.2.578)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/14/2012>
-- Description:		<Fixed bug counting exchanges (ECF ver. 5.2.593)>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select count(LineItemId) ItemsOrdered, L.OrderGroupId from LineItem L 
				inner join OrderForm as OF1 on L.OrderFormId = OF1.OrderFormId
				where OF1.Name <> ''Return''
				group by L.OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OFP.OrderGroupId from OrderFormPayment as OFP
				where OFP.TransactionType = ''Capture'' OR OFP.TransactionType = ''Sale''
				group by OFP.OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			LEFT JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate) AND OG.Name <> ''Exchange''
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END'



--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 14, 2012 ------------------------------------
-- Sales report counts returns as sales as well, resulting in a report that shows a greater total than what was actually sold. Items Ordered count was
-- fixed in the last patch. This patch skips Credits, which are payments happening from a return.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 5;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Jooeun Lee>
-- Create date: <2/14/2012>
-- Description:	<Fixed bug which included returns in best seller report>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_ProductBestSellers] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME
AS

BEGIN

	SELECT	z.Period, 
			z.ProductName, 
			z.Price, 
			z.Ordered,
			z.Code
	FROM
	(
		SELECT	x.Period as Period,  
				ISNULL(y.ProductName, ''NONE'') AS ProductName,
				ISNULL(y.Price,0) AS Price,
				ISNULL(y.ItemsOrdered, 0) AS Ordered,
				RANK() OVER (PARTITION BY x.Period
						ORDER BY y.price) AS PriceRank,
				y.Code
		FROM 
		(
			SELECT	DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(10), D.DateFull, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, D.Datefull) + '', '' + CAST(YEAR(D.Datefull) AS VARCHAR(20))) 
								ElSE CAST(YEAR(D.Datefull) AS VARCHAR(20))  
								End) AS Period 
			FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
			WHERE CONVERT(VARCHAR(20), D.Datefull, 101) >=  @startdate AND CONVERT(VARCHAR(20), D.Datefull, 101) < @enddate +1
		) AS x

		LEFT JOIN

		(
			SELECT  DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(20), FEX.Created, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
								ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   End) as period, 
					
				 L.DisplayName AS ProductName,
					L.ListPrice AS Price,
					SUM(L.Quantity) AS ItemsOrdered,
					RANK() OVER (PARTITION BY (CASE WHEN @interval = ''Day''
													THEN CONVERT(VARCHAR(20), FEX.Created, 101)
													WHEN @interval = ''Month''
													THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
													ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
												END) 
								ORDER BY SUM(L.Quantity) DESC) AS PeriodRank,
					E.Code
			FROM 
				LineItem AS L INNER JOIN OrderFormEx AS FEX ON L.OrderFormId = Fex.ObjectId 
				INNER JOIN OrderForm AS F ON L.OrderFormID = F.OrderFormID
				INNER JOIN CatalogEntry E ON L.CatalogEntryID = E.Code
			WHERE CONVERT(VARCHAR(20), Fex.Created, 101) >=  @startdate AND CONVERT(VARCHAR(20), Fex.Created, 101) < @enddate +1 
				AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
				AND (FEX.RMANumber = '''' OR FEX.RMANumber IS NULL)
			GROUP BY (Case WHEN @interval = ''Day''
						THEN CONVERT(VARCHAR(20), FEX.Created, 101)
						WHEN @interval = ''Month''
						THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20))  )
						ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
					END) ,L.DisplayName, L.ListPrice, E.Code
				
		
					
		) AS y

ON x.Period = y.Period
WHERE y.PeriodRank IS NULL 
OR y.PeriodRank = 1



	)AS z

WHERE z.PriceRank = 1
ORDER BY CONVERT(datetime, z.Period, 101)
END

'



--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 15, 2012 ------------------------------------
-- Items Ordered column for sales report should count the quantity of line items, not the number of line item rows in the data base.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 6;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/23/2012>
-- Description:		<Fixed bug counting duplicate line items after creating a return (ECF ver. 5.2.571)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/25/2012>
-- Description:		<Fixed bug counting credits as payments after creating a return (ECF ver. 5.2.573)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/30/2012>
-- Description:		<Fixed bug counting payments other than Capture and Sale as valid payments (ECF ver. 5.2.578)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/14/2012>
-- Description:		<Fixed bug counting exchanges (ECF ver. 5.2.593)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/15/2012>
-- Description:		<Fixed bug counting line items instead of summing their quantities (ECF ver. 5.2.594)>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select sum(Quantity) ItemsOrdered, L.OrderGroupId from LineItem L 
				inner join OrderForm as OF1 on L.OrderFormId = OF1.OrderFormId
				where OF1.Name <> ''Return''
				group by L.OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OFP.OrderGroupId from OrderFormPayment as OFP
				where OFP.TransactionType = ''Capture'' OR OFP.TransactionType = ''Sale''
				group by OFP.OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			LEFT JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate) AND OG.Name <> ''Exchange''
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END'

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Jooeun Lee>
-- Create date: <2/14/2012>
-- Description:	<Fixed bug which included returns in best seller report (ECF ver. 5.2.593)>
-- =============================================
-- Author:		<Jooeun Lee>
-- Create date: <2/15/2012>
-- Description:	<Fixed bug which included exchanges in best seller report (ECF ver. 5.2.594)>
-- =============================================
-- Author:		<Tim Blanchard>
-- Create date: <2/20/2012>
-- Description:	<Fixed bug which included orders that were not complete in best seller report (ECF ver. 5.2.599)>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_ProductBestSellers] 
	@ApplicationID uniqueidentifier,
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME
AS

BEGIN

	SELECT	z.Period, 
			z.ProductName, 
			z.Price, 
			z.Ordered,
			z.Code
	FROM
	(
		SELECT	x.Period as Period,  
				ISNULL(y.ProductName, ''NONE'') AS ProductName,
				ISNULL(y.Price,0) AS Price,
				ISNULL(y.ItemsOrdered, 0) AS Ordered,
				RANK() OVER (PARTITION BY x.Period
						ORDER BY y.price) AS PriceRank,
				y.Code
		FROM 
		(
			SELECT	DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(10), D.DateFull, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, D.Datefull) + '', '' + CAST(YEAR(D.Datefull) AS VARCHAR(20))) 
								ElSE CAST(YEAR(D.Datefull) AS VARCHAR(20))  
								End) AS Period 
			FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
			WHERE CONVERT(VARCHAR(20), D.Datefull, 101) >=  @startdate AND CONVERT(VARCHAR(20), D.Datefull, 101) < @enddate +1
		) AS x

		LEFT JOIN

		(
			SELECT  DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(20), FEX.Created, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
								ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   End) as period, 
					
				 L.DisplayName AS ProductName,
					L.ListPrice AS Price,
					SUM(L.Quantity) AS ItemsOrdered,
					RANK() OVER (PARTITION BY (CASE WHEN @interval = ''Day''
													THEN CONVERT(VARCHAR(20), FEX.Created, 101)
													WHEN @interval = ''Month''
													THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
													ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
												END) 
								ORDER BY SUM(L.Quantity) DESC) AS PeriodRank,
					E.Code
			FROM 
				LineItem AS L INNER JOIN OrderFormEx AS FEX ON L.OrderFormId = Fex.ObjectId 
				INNER JOIN OrderForm AS F ON L.OrderFormID = F.OrderFormID
				INNER JOIN CatalogEntry E ON L.CatalogEntryID = E.Code
				INNER JOIN OrderGroup AS OG ON F.OrderGroupId = OG.OrderGroupId AND isnull (OG.Status, '''') = ''Completed''
			WHERE CONVERT(VARCHAR(20), Fex.Created, 101) >=  @startdate AND CONVERT(VARCHAR(20), Fex.Created, 101) < @enddate +1 
				AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
				AND (FEX.RMANumber = '''' OR FEX.RMANumber IS NULL)
				AND OG.Name <> ''Exchange''
			GROUP BY (Case WHEN @interval = ''Day''
						THEN CONVERT(VARCHAR(20), FEX.Created, 101)
						WHEN @interval = ''Month''
						THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20))  )
						ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
					END) ,L.DisplayName, L.ListPrice, E.Code
				
		
					
		) AS y

ON x.Period = y.Period
WHERE y.PeriodRank IS NULL 
OR y.PeriodRank = 1



	)AS z

WHERE z.PriceRank = 1
ORDER BY CONVERT(datetime, z.Period, 101)
END

'


--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- July 13, 2012 ------------------------------------
-- Items Ordered column for sales report should count the quantity of line items, not the number of line item rows in the data base.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 7;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/23/2012>
-- Description:		<Fixed bug counting duplicate line items after creating a return (ECF ver. 5.2.571)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/25/2012>
-- Description:		<Fixed bug counting credits as payments after creating a return (ECF ver. 5.2.573)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/30/2012>
-- Description:		<Fixed bug counting payments other than Capture and Sale as valid payments (ECF ver. 5.2.578)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/14/2012>
-- Description:		<Fixed bug counting exchanges (ECF ver. 5.2.593)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/15/2012>
-- Description:		<Fixed bug counting line items instead of summing their quantities (ECF ver. 5.2.594)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<7/13/2012>
-- Description:		<Added filters for Market ID and Currency>
-- =============================================

ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	--@MarketId nvarchar(8),
	--@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select sum(Quantity) ItemsOrdered, L.OrderGroupId from LineItem L 
				inner join OrderForm as OF1 on L.OrderFormId = OF1.OrderFormId
				where OF1.Name <> ''Return''
				group by L.OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OFP.OrderGroupId from OrderFormPayment as OFP
				where OFP.TransactionType = ''Capture'' OR OFP.TransactionType = ''Sale''
				group by OFP.OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			INNER JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate) AND 
				OG.Name <> ''Exchange'' --AND
				--OG.BillingCurrency = @CurrencyCode --AND
				--(LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END' 
--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 09, 2012 ------------------------------------
-- Added Market and Currency filters to Best Sellers and Shipping Reports. Added a stored procedure for Low Stock report.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 8;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_reporting_LowStock]') AND type in (N'P', N'PC'))
EXEC dbo.sp_executesql @statement = 
N'-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date:	<8/08/2012>
-- Description:		<Added filters for Market ID and Currency>
-- =============================================
CREATE PROCEDURE [dbo].[ecf_reporting_LowStock] 
	@ApplicationID uniqueidentifier
As

BEGIN

	SELECT E.[Name], I.* from [Inventory] I 
	INNER JOIN [CatalogEntry] E ON E.Code = I.SkuId INNER JOIN Catalog C ON C.CatalogId = E.CatalogId 
	WHERE (I.InstockQuantity - I.ReservedQuantity) < 20 AND I.InventoryStatus <> 0 
	AND C.ApplicationId = @ApplicationID

END
'

EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Jooeun Lee>
-- Create date: <2/14/2012>
-- Description:	<Fixed bug which included returns in best seller report (ECF ver. 5.2.593)>
-- =============================================
-- Author:		<Jooeun Lee>
-- Create date: <2/15/2012>
-- Description:	<Fixed bug which included exchanges in best seller report (ECF ver. 5.2.594)>
-- =============================================
-- Author:		<Tim Blanchard>
-- Create date: <2/20/2012>
-- Description:	<Fixed bug which included orders that were not complete in best seller report (ECF ver. 5.2.599)>
-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date:	<8/08/2012>
-- Description:		<Added filters for Market ID and Currency>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_ProductBestSellers] 
	@ApplicationID uniqueidentifier,
	--@MarketId nvarchar(8),
	--@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME
AS

BEGIN

	SELECT	z.Period, 
			z.ProductName, 
			z.Price, 
			z.Ordered,
			z.Code
	FROM
	(
		SELECT	x.Period as Period,  
				ISNULL(y.ProductName, ''NONE'') AS ProductName,
				ISNULL(y.Price,0) AS Price,
				ISNULL(y.ItemsOrdered, 0) AS Ordered,
				RANK() OVER (PARTITION BY x.Period
						ORDER BY y.price) AS PriceRank,
				y.Code
		FROM 
		(
			SELECT	DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(10), D.DateFull, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, D.Datefull) + '', '' + CAST(YEAR(D.Datefull) AS VARCHAR(20))) 
								ElSE CAST(YEAR(D.Datefull) AS VARCHAR(20))  
								End) AS Period 
			FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
			WHERE CONVERT(VARCHAR(20), D.Datefull, 101) >=  @startdate AND CONVERT(VARCHAR(20), D.Datefull, 101) < @enddate +1
		) AS x

		LEFT JOIN

		(
			SELECT  DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(20), FEX.Created, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
								ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   End) as period, 
					
				 L.DisplayName AS ProductName,
					L.ListPrice AS Price,
					SUM(L.Quantity) AS ItemsOrdered,
					RANK() OVER (PARTITION BY (CASE WHEN @interval = ''Day''
													THEN CONVERT(VARCHAR(20), FEX.Created, 101)
													WHEN @interval = ''Month''
													THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
													ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
												END) 
								ORDER BY SUM(L.Quantity) DESC) AS PeriodRank,
					E.Code
			FROM 
				LineItem AS L INNER JOIN OrderFormEx AS FEX ON L.OrderFormId = Fex.ObjectId 
				INNER JOIN OrderForm AS F ON L.OrderFormID = F.OrderFormID
				INNER JOIN CatalogEntry E ON L.CatalogEntryID = E.Code
				INNER JOIN OrderGroup AS OG ON F.OrderGroupId = OG.OrderGroupId AND isnull (OG.Status, '''') = ''Completed''
			WHERE CONVERT(VARCHAR(20), Fex.Created, 101) >=  @startdate AND CONVERT(VARCHAR(20), Fex.Created, 101) < @enddate +1 
				AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
				AND (FEX.RMANumber = '''' OR FEX.RMANumber IS NULL)
				AND OG.Name <> ''Exchange''
				--AND OG.BillingCurrency = @CurrencyCode 
				--AND (LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
			GROUP BY (Case WHEN @interval = ''Day''
						THEN CONVERT(VARCHAR(20), FEX.Created, 101)
						WHEN @interval = ''Month''
						THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20))  )
						ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
					END) ,L.DisplayName, L.ListPrice, E.Code
				
		
					
		) AS y

ON x.Period = y.Period
WHERE y.PeriodRank IS NULL 
OR y.PeriodRank = 1



	)AS z

WHERE z.PriceRank = 1
ORDER BY CONVERT(datetime, z.Period, 101)
END

' 

EXEC dbo.sp_executesql @statement = 
N'-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date:	<8/08/2012>
-- Description:		<Added filters for Market ID and Currency>
-- =============================================
ALTER PROCEDURE [dbo].[ecf_reporting_Shipping] 
	@ApplicationID uniqueidentifier,
	--@MarketId nvarchar(8),
	--@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	SELECT	x.Period,  
			ISNULL(y.ShippingMethod, ''NONE'') AS ShippingMethod,
			ISNULL(y.NumberofOrders, 0) AS NumberOfOrders,
			ISNULL(y.Shipping, 0) AS TotalShipping
			
	FROM 
	(
		SELECT	DISTINCT (CASE WHEN @interval = ''Day''
							
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 
		FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
		WHERE D.Datefull BETWEEN  DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)

	) AS x

	LEFT JOIN

	(
		SELECT DISTINCT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20)) )
							ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   End) AS Period, 
				COUNT(S.ShipmentID) AS NumberofOrders, 
				SUM(S.ShipmentTotal) AS Shipping, 
				S.ShippingMethodName AS ShippingMethod
		FROM Shipment AS S INNER JOIN
		OrderForm AS F ON S.OrderFormId = F.OrderFormId INNER JOIN
			OrderFormEx AS FEX ON FEX.ObjectId = F.OrderFormId INNER JOIN
			OrderGroup AS OG ON OG.OrderGroupId = F.OrderGroupId
		WHERE (FEX.Created BETWEEN @startdate AND @enddate)
		AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
		--AND OG.BillingCurrency = @CurrencyCode 
		--AND (LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
		GROUP BY (Case WHEN @interval = ''Day''
					THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
					WHEN @interval = ''Month''
					THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))  )
					ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   
				END), S.ShippingMethodName
	) AS y

	ON x.Period = y.Period
	ORDER BY CONVERT(datetime, x.Period, 101)

END
' 
--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- September 25, 2012 ------------------------------------
-- Modified shipping report to display the shipping method display name.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 9;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = 
N'-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date:	<8/08/2012>
-- Description:		<Added filters for Market ID and Currency>
-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date:	<9/25/2012>
-- Description:		<Modified shipping report to display the shipping method display name>
-- =============================================

ALTER PROCEDURE [dbo].[ecf_reporting_Shipping] 
	@ApplicationID uniqueidentifier,
	--@MarketId nvarchar(8),
	--@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	SELECT	x.Period,  
			ISNULL(y.ShippingMethodDisplayName, ''NONE'') AS ShippingMethodDisplayName,
			ISNULL(y.NumberofOrders, 0) AS NumberOfOrders,
			ISNULL(y.Shipping, 0) AS TotalShipping
			
	FROM 
	(
		SELECT	DISTINCT (CASE WHEN @interval = ''Day''
							
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 
		FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
		WHERE D.Datefull BETWEEN  DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)

	) AS x

	LEFT JOIN

	(
		SELECT DISTINCT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20)) )
							ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   End) AS Period, 
				COUNT(S.ShipmentID) AS NumberofOrders, 
				SUM(S.ShipmentTotal) AS Shipping, 
				SM.DisplayName AS ShippingMethodDisplayName
		FROM Shipment AS S INNER JOIN
		ShippingMethod AS SM ON S.ShippingMethodId = SM.ShippingMethodId INNER JOIN
			OrderForm AS F ON S.OrderFormId = F.OrderFormId INNER JOIN
			OrderFormEx AS FEX ON FEX.ObjectId = F.OrderFormId INNER JOIN
			OrderGroup AS OG ON OG.OrderGroupId = F.OrderGroupId
		WHERE (FEX.Created BETWEEN @startdate AND @enddate)
		AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
		--AND OG.BillingCurrency = @CurrencyCode 
		--AND (LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
		GROUP BY (Case WHEN @interval = ''Day''
					THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
					WHEN @interval = ''Month''
					THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))  )
					ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   
				END), SM.DisplayName
	) AS y

	ON x.Period = y.Period
	ORDER BY CONVERT(datetime, x.Period, 101)

END
' 


--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO
-------------------- January 14, 2013 ------------------------------------
-- Do not count 'Cancelled' order.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 10;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Anne Burgess>
-- Create date: <9/17/2008>
-- Description:	<Store Procedure for ECF50 Sale Report v1>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/23/2012>
-- Description:		<Fixed bug counting duplicate line items after creating a return (ECF ver. 5.2.571)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/25/2012>
-- Description:		<Fixed bug counting credits as payments after creating a return (ECF ver. 5.2.573)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<1/30/2012>
-- Description:		<Fixed bug counting payments other than Capture and Sale as valid payments (ECF ver. 5.2.578)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/14/2012>
-- Description:		<Fixed bug counting exchanges (ECF ver. 5.2.593)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<2/15/2012>
-- Description:		<Fixed bug counting line items instead of summing their quantities (ECF ver. 5.2.594)>
-- =============================================
-- Modifier:		<Jooeun Lee>
-- Modified date:	<7/13/2012>
-- Description:		<Added filters for Market ID and Currency>
-- =============================================
-- Modifier:		<Phuoc Dung Le>
-- Modified date:	<01/14/2013>
-- Description:		<Do not count cancelled order>
-- =============================================

ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@MarketId nvarchar(8),
	@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select sum(Quantity) ItemsOrdered, L.OrderGroupId from LineItem L 
				inner join OrderForm as OF1 on L.OrderFormId = OF1.OrderFormId
				where OF1.Name <> ''Return''
				group by L.OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OFP.OrderGroupId from OrderFormPayment as OFP
				where OFP.TransactionType = ''Capture'' OR OFP.TransactionType = ''Sale''
				group by OFP.OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			INNER JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate) AND 
				OG.Name <> ''Exchange'' AND 
				OG.[Status] <> ''Cancelled'' AND
				OG.BillingCurrency = @CurrencyCode AND
				(LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, O.NumberofOrders as NumberofOrders
			, O.ItemsOrdered
			, O.Subtotal
			, O.Tax
			, O.Shipping
			, O.Discounts
			, O.Total
			, O.Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END' 
--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 01, 2013 ------------------------------------
-- Correct the Best Sellers Report: 
-- This report is used to determine which products sold the most in terms of quantity and total revenue over a period of time
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 11;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_reporting_ProductBestSellers] 
	@ApplicationID uniqueidentifier,
	@MarketId nvarchar(8),
	@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME
AS

BEGIN

	SELECT	z.Period, 
			z.ProductName, 
			z.Price, 
			z.Ordered,
			z.Code
	FROM
	(
		SELECT	x.Period as Period,  
				ISNULL(y.ProductName, ''NONE'') AS ProductName,
				ISNULL(y.Price,0) AS Price,
				ISNULL(y.ItemsOrdered, 0) AS Ordered,
				RANK() OVER (PARTITION BY x.Period
						ORDER BY y.price DESC) AS PriceRank,
				y.Code
		FROM 
		(
			SELECT	DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(10), D.DateFull, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, D.Datefull) + '', '' + CAST(YEAR(D.Datefull) AS VARCHAR(20))) 
								ElSE CAST(YEAR(D.Datefull) AS VARCHAR(20))  
								End) AS Period 
			FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
			WHERE CONVERT(VARCHAR(20), D.Datefull, 101) >=  @startdate AND CONVERT(VARCHAR(20), D.Datefull, 101) < @enddate +1
		) AS x

		LEFT JOIN

		(
			SELECT  DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(20), FEX.Created, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
								ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   End) as period, 
					
				 L.DisplayName AS ProductName,
					L.ListPrice AS Price,
					SUM(L.Quantity) AS ItemsOrdered,
					RANK() OVER (PARTITION BY (CASE WHEN @interval = ''Day''
													THEN CONVERT(VARCHAR(20), FEX.Created, 101)
													WHEN @interval = ''Month''
													THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
													ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
												END) 
								ORDER BY SUM(L.Quantity) DESC) AS PeriodRank,
					E.Code
			FROM 
				LineItem AS L INNER JOIN OrderFormEx AS FEX ON L.OrderFormId = Fex.ObjectId 
				INNER JOIN OrderForm AS F ON L.OrderFormID = F.OrderFormID
				INNER JOIN CatalogEntry E ON L.CatalogEntryID = E.Code
				INNER JOIN OrderGroup AS OG ON F.OrderGroupId = OG.OrderGroupId AND isnull (OG.Status, '''') = ''Completed''
			WHERE CONVERT(VARCHAR(20), Fex.Created, 101) >=  @startdate AND CONVERT(VARCHAR(20), Fex.Created, 101) < @enddate +1 
				AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
				AND (FEX.RMANumber = '''' OR FEX.RMANumber IS NULL)
				AND OG.Name <> ''Exchange''
				AND OG.BillingCurrency = @CurrencyCode 
				AND (LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
			GROUP BY (Case WHEN @interval = ''Day''
						THEN CONVERT(VARCHAR(20), FEX.Created, 101)
						WHEN @interval = ''Month''
						THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20))  )
						ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
					END) ,L.DisplayName, L.ListPrice, E.Code
				
		
					
		) AS y

ON x.Period = y.Period
WHERE y.PeriodRank IS NULL 
OR y.PeriodRank = 1



	)AS z

WHERE z.PriceRank = 1
ORDER BY CONVERT(datetime, z.Period, 101)
END
' 

--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- February 18, 2013 ------------------------------------
-- Show the summary row when there is no data is not displayed in Sales Report.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 12;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_reporting_SaleReport] 
	@ApplicationID uniqueidentifier,
	@MarketId nvarchar(8),
	@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	with periodQuery as
	(
	SELECT DISTINCT	(CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '','' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 

		FROM ReportingDates D
		WHERE D.Datefull BETWEEN DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)
	)
	, lineItemsQuery as
	(
		select sum(Quantity) ItemsOrdered, L.OrderGroupId from LineItem L 
				inner join OrderForm as OF1 on L.OrderFormId = OF1.OrderFormId
				where OF1.Name <> ''Return''
				group by L.OrderGroupId
	)
	, orderFormQuery as
	(
		select sum(DiscountAmount) Discounts, OrderGroupId from OrderForm 
				group by OrderGroupId
	)
	, paymentQuery as
	(
		select sum(Amount) TotalPayment, OFP.OrderGroupId from OrderFormPayment as OFP
				where OFP.TransactionType = ''Capture'' OR OFP.TransactionType = ''Sale''
				group by OFP.OrderGroupId
	)
	, orderQuery as 
	(
		SELECT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End) AS Period, 
				COALESCE(COUNT(OG.OrderGroupId), 0) AS NumberofOrders
				, SUM(L1.ItemsOrdered) AS ItemsOrdered
				, SUM(OG.SubTotal) AS SubTotal
				, SUM(OG.TaxTotal) AS Tax
				, SUM(OG.ShippingTotal) AS Shipping 
				, SUM(OF1.Discounts) AS Discounts
				, SUM(OG.Total) AS Total
				, SUM(P.TotalPayment) AS Invoiced
		FROM OrderGroup AS OG 
			INNER JOIN OrderGroup_PurchaseOrder AS PO ON PO.ObjectId = OG.OrderGroupId
			INNER JOIN orderFormQuery OF1 on OF1.OrderGroupId = OG.OrderGroupId
			LEFT JOIN paymentQuery AS P ON P.OrderGroupId = OG.OrderGroupId 
			LEFT JOIN lineItemsQuery L1 on L1.OrderGroupId = OG.OrderGroupId
		WHERE (PO.Created BETWEEN @startdate AND @enddate) AND 
				OG.Name <> ''Exchange'' AND 
				OG.[Status] <> ''Cancelled'' AND
				OG.BillingCurrency = @CurrencyCode AND
				(LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
		GROUP BY  (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, PO.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, PO.Created)) + '','' + CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, PO.Created)) AS VARCHAR(20))  
							End)
	)
	
	SELECT	P.Period
			, ISNULL(O.NumberofOrders, 0) as NumberofOrders
			, ISNULL(O.ItemsOrdered, 0) as ItemsOrdered
			, ISNULL(O.Subtotal, 0) as Subtotal
			, ISNULL(O.Tax , 0) as Tax
			, ISNULL(O.Shipping , 0) as Shipping
			, ISNULL(O.Discounts , 0) as Discounts
			, ISNULL(O.Total , 0) as Total
			, ISNULL(O.Invoiced, 0) as Invoiced
	FROM periodQuery P
	LEFT JOIN orderQuery O on P.Period = O.Period
	ORDER BY CONVERT(datetime, P.Period, 101) 

END' 
--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- April 22th, 2013 ------------------------------------
-- Update ecf_reporting_LowStock with new WarehouseInventory table 
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 13;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
ALTER PROCEDURE [dbo].[ecf_reporting_LowStock] 
	@ApplicationID uniqueidentifier
As

BEGIN

	SELECT E.[Name], E.Code as SkuId, I.*, W.Name as WarehouseName from [WarehouseInventory] I
	INNER JOIN [CatalogEntry] E ON E.Code = I.CatalogEntryCode 
	INNER JOIN Catalog C ON C.CatalogId = E.CatalogId
	INNER JOIN [Warehouse] W ON I.WarehouseCode = W.Code
	WHERE (I.InstockQuantity - I.ReservedQuantity) < I.ReorderMinQuantity AND I.InventoryStatus <> 0 
	AND C.ApplicationId = @ApplicationID

END' 
--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO

-------------------- August 19th, 2013 ------------------------------------
-- Update ecf_reporting_Shipping: do not count Cancelled shipment to report.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 14;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##

EXEC dbo.sp_executesql @statement = 
N'ALTER PROCEDURE [dbo].[ecf_reporting_Shipping] 
	@ApplicationID uniqueidentifier,
	@MarketId nvarchar(8),
	@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME,
	@offset INT
AS

BEGIN

	SELECT	x.Period,  
			ISNULL(y.ShippingMethodDisplayName, ''NONE'') AS ShippingMethodDisplayName,
			ISNULL(y.NumberofOrders, 0) AS NumberOfOrders,
			ISNULL(y.Shipping, 0) AS TotalShipping
			
	FROM 
	(
		SELECT	DISTINCT (CASE WHEN @interval = ''Day''
							
							THEN CONVERT(VARCHAR(10), DATEADD(HH, @offset, D.Datefull), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, D.Datefull)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))) 
							ElSE CAST(YEAR(DATEADD(HH, @offset, D.Datefull)) AS VARCHAR(20))  
							End) AS Period 
		FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
		WHERE D.Datefull BETWEEN  DATEADD(HH, @offset, @startdate) AND DATEADD(HH, @offset, @enddate)

	) AS x

	LEFT JOIN

	(
		SELECT DISTINCT (CASE WHEN @interval = ''Day''
							THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
							WHEN @interval = ''Month''
							THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20)) )
							ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   End) AS Period, 
				COUNT(S.ShipmentID) AS NumberofOrders, 
				SUM(S.ShipmentTotal) AS Shipping, 
				SM.DisplayName AS ShippingMethodDisplayName
		FROM Shipment AS S INNER JOIN
		ShippingMethod AS SM ON S.ShippingMethodId = SM.ShippingMethodId INNER JOIN
			OrderForm AS F ON S.OrderFormId = F.OrderFormId INNER JOIN
			OrderFormEx AS FEX ON FEX.ObjectId = F.OrderFormId INNER JOIN
			OrderGroup AS OG ON OG.OrderGroupId = F.OrderGroupId
		WHERE (FEX.Created BETWEEN @startdate AND @enddate)
		AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
		AND OG.BillingCurrency = @CurrencyCode 
		AND (LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
		AND S.Status <> ''Cancelled''
		GROUP BY (Case WHEN @interval = ''Day''
					THEN CONVERT(VARCHAR(20), DATEADD(HH, @offset, FEX.Created), 101)
					WHEN @interval = ''Month''
					THEN (DATENAME(MM, DATEADD(HH, @offset, FEX.Created)) + '', '' + CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))  )
					ElSE CAST(YEAR(DATEADD(HH, @offset, FEX.Created)) AS VARCHAR(20))   
				END), SM.DisplayName
	) AS y

	ON x.Period = y.Period
	ORDER BY CONVERT(datetime, x.Period, 101)

END'

--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO
-------------------- August 26th, 2013 ------------------------------------
-- Update ecf_reporting_ProductBestSellers: grouping by Name avoid possible missmatches between.
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 15;

Select @Installed = InstallDate from SchemaVersion_ReportingSystem where Major=@Major and Minor=@Minor and Patch=@Patch

If(@Installed is null)
BEGIN
--## Schema Patch ##
EXEC dbo.sp_executesql @statement = N'
	ALTER PROCEDURE [dbo].[ecf_reporting_ProductBestSellers]
	@ApplicationID uniqueidentifier,
	@MarketId nvarchar(8),
	@CurrencyCode NVARCHAR(8),
	@interval VARCHAR(20),
	@startdate DATETIME,
	@enddate DATETIME
AS

BEGIN

	SELECT	z.Period, 
			z.ProductName, 
			z.Price, 
			z.Ordered,
			z.Code
	FROM
	(
		SELECT	x.Period as Period,  
				ISNULL(y.ProductName, ''NONE'') AS ProductName,
				ISNULL(y.Price,0) AS Price,
				ISNULL(y.ItemsOrdered, 0) AS Ordered,
				RANK() OVER (PARTITION BY x.Period
						ORDER BY y.price DESC) AS PriceRank,
				y.Code
		FROM 
		(
			SELECT	DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(10), D.DateFull, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, D.Datefull) + '', '' + CAST(YEAR(D.Datefull) AS VARCHAR(20))) 
								ElSE CAST(YEAR(D.Datefull) AS VARCHAR(20))  
								End) AS Period 
			FROM ReportingDates D LEFT OUTER JOIN OrderFormEx FEX ON D.Datefull = FEX.Created
			WHERE CONVERT(VARCHAR(20), D.Datefull, 101) >=  @startdate AND CONVERT(VARCHAR(20), D.Datefull, 101) < @enddate +1
		) AS x

		LEFT JOIN

		(
			SELECT  DISTINCT (CASE WHEN @interval = ''Day''
								THEN CONVERT(VARCHAR(20), FEX.Created, 101)
								WHEN @interval = ''Month''
								THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
								ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   End) as period, 
					
				 E.Name AS ProductName,
					L.ListPrice AS Price,
					SUM(L.Quantity) AS ItemsOrdered,
					RANK() OVER (PARTITION BY (CASE WHEN @interval = ''Day''
													THEN CONVERT(VARCHAR(20), FEX.Created, 101)
													WHEN @interval = ''Month''
													THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20)) )
													ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
												END) 
								ORDER BY SUM(L.Quantity) DESC) AS PeriodRank,
					E.Code
			FROM 
				LineItem AS L INNER JOIN OrderFormEx AS FEX ON L.OrderFormId = Fex.ObjectId 
				INNER JOIN OrderForm AS F ON L.OrderFormID = F.OrderFormID
				INNER JOIN CatalogEntry E ON L.CatalogEntryID = E.Code
				INNER JOIN OrderGroup AS OG ON F.OrderGroupId = OG.OrderGroupId AND isnull (OG.Status, '''') = ''Completed''
			WHERE CONVERT(VARCHAR(20), Fex.Created, 101) >=  @startdate AND CONVERT(VARCHAR(20), Fex.Created, 101) < @enddate +1 
				AND @applicationid = (SELECT  ApplicationID FROM OrderGroup  WHERE OrderGroupID = F.OrderGroupID)
				AND (FEX.RMANumber = '''' OR FEX.RMANumber IS NULL)
				AND OG.Name <> ''Exchange''
				AND OG.BillingCurrency = @CurrencyCode 
				AND (LEN(@MarketId) = 0 OR OG.MarketId = @MarketId)
			GROUP BY (Case WHEN @interval = ''Day''
						THEN CONVERT(VARCHAR(20), FEX.Created, 101)
						WHEN @interval = ''Month''
						THEN (DATENAME(MM, FEX.Created) + '', '' + CAST(YEAR(FEX.Created) AS VARCHAR(20))  )
						ElSE CAST(YEAR(FEX.Created) AS VARCHAR(20))   
					END) ,E.Name, L.ListPrice, E.Code
				
		
					
		) AS y

ON x.Period = y.Period
WHERE y.PeriodRank IS NULL 
OR y.PeriodRank = 1



	)AS z

WHERE z.PriceRank = 1
ORDER BY CONVERT(datetime, z.Period, 101)
END
'


--## END Schema Patch ##
Insert into SchemaVersion_ReportingSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())

Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '

END
GO
