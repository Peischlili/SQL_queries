USE [WideWorldImporters]
GO


CREATE OR ALTER FUNCTION fn_ReportCustomerTurnover(
	@choice int = 1,  -- default choice = 1
	@invoiceYear int = 2013)
RETURNS nvarchar(max)
AS
BEGIN

------------------------ Query when Choice = 1 => total monthly turnover for the year

	Declare @strQuery1_head nvarchar(max);
	DECLARE @strQuery1_tail nvarchar(max);
	DECLARE @strQuery1_body nvarchar(max);
	DECLARE @strQuery1_body12 nvarchar(max); -- per month and multiply by 12 months
	DECLARE @strFinalQuery1 nvarchar(max);
	DECLARE @loop int;

	-- Here come the components of the 1st main query
	SET @strQuery1_head = ' SELECT C.CustomerName ';
	SET @strQuery1_tail = '	FROM Sales.Customers as C ORDER BY C.CustomerName ASC ';
	SET @strQuery1_body = ' 
		, ISNULL((
		SELECT SUM(InvoiceLineSum)
		FROM (
			SELECT C.CustomerName
				, I.InvoiceID
				, IL.InvoiceLineID
				, IL.Quantity
				, IL.UnitPrice
				, IL.Quantity * IL.UnitPrice as InvoiceLineSum
				, MONTH(I.InvoiceDate) as InvoiceMonth
				, YEAR(I.InvoiceDate) as InvoiceYear
			FROM Sales.Customers as C
				, Sales.Invoices as I
				, Sales.InvoiceLines as IL
			WHERE IL.InvoiceID = I.InvoiceID
				And I.CustomerID = C.CustomerID
				And YEAR(I.InvoiceDate) = <invoiceYear>
		) AS Synthesis
		WHERE Synthesis.CustomerName = C.CustomerName
			And Synthesis.InvoiceMonth = <month>
		), 0) as <monthColumn> 
	';

	-- Assembly of the main query by multiplying the body query 12 times to get 12 months of a year
	SET @strQuery1_body12 = ' '
	SET @loop = 1; 

	-- The while loop does the multiplication
	WHILE @loop <= 12
	BEGIN
		SET @strQuery1_body12 = CASE 
			WHEN @loop = 1 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Jan'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 2 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Feb'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 3 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Mar'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 4 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Apr'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 5 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'May'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 6 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Jui'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 7 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Jul'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 8 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Aug'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 9 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Sep'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 10 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Oct'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 11 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Nov'), '<invoiceYear>', @invoiceYear)
			WHEN @loop = 12 THEN @strQuery1_body12 + replace(replace((replace(@strQuery1_body, '<month>', @loop)), '<monthColumn>', 'Dec'), '<invoiceYear>', @invoiceYear)
			END

		SET @loop = @loop + 1
	END;

	-- Final assembly of all parts
	SET @strFinalQuery1 = @strQuery1_head + @strQuery1_body12 + @strQuery1_tail;

----------------------- *** End the the 1st query where choice == 1 *** ---------------------------------------------

----------------------- Query when Choice = 2 => total quarterly turnover for the year
	DECLARE @strFinalQuery2 nvarchar(max);
	SET @strFinalQuery2 = ' 
			SELECT C.CustomerName
			-- When the value is null, return 0 instead
			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And YEAR(I.InvoiceDate) = <invoiceYear>
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And (Synthesis.InvoiceMonth = 1
				OR Synthesis.InvoiceMonth = 2
				OR Synthesis.InvoiceMonth = 3)
				--Months
			), 0) as Q1  -- Column Quarter1
	
			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And YEAR(I.InvoiceDate) = <invoiceYear>
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And (Synthesis.InvoiceMonth = 4
				OR Synthesis.InvoiceMonth = 5
				OR Synthesis.InvoiceMonth = 6)--Months
			), 0) AS Q2 -- Column Quarter2

			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And YEAR(I.InvoiceDate) = <invoiceYear>
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And (Synthesis.InvoiceMonth = 7
				OR Synthesis.InvoiceMonth = 8
				OR Synthesis.InvoiceMonth = 9)--Months
			), 0) AS Q3 -- Column Quarter3

			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And YEAR(I.InvoiceDate) = <invoiceYear>
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And (Synthesis.InvoiceMonth = 10
				OR Synthesis.InvoiceMonth = 11
				OR Synthesis.InvoiceMonth = 12)--Months
			), 0) AS Q4 -- Column Quarter4

		FROM Sales.Customers as C

		ORDER BY C.CustomerName ASC 
	';

	-- replace the <invoiceYear> in the query by @invoiceYear
	SET @strFinalQuery2 = replace(@strFinalQuery2, '<invoiceYear>', @invoiceYear);

----------------------- *** End the the 2nd query where choice == 2 *** ---------------------------------------------

----------------------- Query when Choice = 3 => total yearly turnover of years 2013 - 2016
	DECLARE @strFinalQuery3 nvarchar(max);
	SET @strFinalQuery3 = '
			SELECT C.CustomerName
			-- When the value is null, return 0 instead
			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And (YEAR(I.InvoiceDate) = 2013
					OR YEAR(I.InvoiceDate) = 2014
					OR YEAR(I.InvoiceDate) = 2015
					OR YEAR(I.InvoiceDate) = 2016)
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And Synthesis.InvoiceYear = 2013 --Month
			), 0) as Invoices2013  -- Column 2013
	
			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And (YEAR(I.InvoiceDate) = 2013
					OR YEAR(I.InvoiceDate) = 2014
					OR YEAR(I.InvoiceDate) = 2015
					OR YEAR(I.InvoiceDate) = 2016)
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And Synthesis.InvoiceYear = 2014 --Year
			), 0) as Invoices2014  -- Column 2014

			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And (YEAR(I.InvoiceDate) = 2013
					OR YEAR(I.InvoiceDate) = 2014
					OR YEAR(I.InvoiceDate) = 2015
					OR YEAR(I.InvoiceDate) = 2016)
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And Synthesis.InvoiceYear = 2015 --Year
			), 0) as Invoices2015  -- Column 2015

			, ISNULL((
			SELECT SUM(InvoiceLineSum)
			FROM (
				SELECT C.CustomerName
					, I.InvoiceID
					, IL.InvoiceLineID
					, IL.Quantity
					, IL.UnitPrice
					, IL.Quantity * IL.UnitPrice as InvoiceLineSum
					, MONTH(I.InvoiceDate) as InvoiceMonth
					, YEAR(I.InvoiceDate) as InvoiceYear
				FROM Sales.Customers as C
					, Sales.Invoices as I
					, Sales.InvoiceLines as IL
				WHERE IL.InvoiceID = I.InvoiceID
					And I.CustomerID = C.CustomerID
					And (YEAR(I.InvoiceDate) = 2013
					OR YEAR(I.InvoiceDate) = 2014
					OR YEAR(I.InvoiceDate) = 2015
					OR YEAR(I.InvoiceDate) = 2016)
			) AS Synthesis
			WHERE Synthesis.CustomerName = C.CustomerName
				And Synthesis.InvoiceYear = 2016 --Year
			), 0) as Invoices2016  -- Column 2016

		FROM Sales.Customers as C

		ORDER BY C.CustomerName ASC 
	';
----------------------- *** End the the 3rd query where choice == 2 *** ---------------------------------------------
	
-- Here comes the logic of the choices 1, 2 and 3, store the correspondant query in the @finalQuery to be executed
	DECLARE @finalQuery nvarchar(max);

	IF @choice = 1 SET @finalQuery = @strFinalQuery1
	ELSE 
		IF @choice = 2 SET @finalQuery = @strFinalQuery2
		ELSE
			IF @choice = 3 SET @finalQuery = @strFinalQuery3
			ELSE SET @finalQuery = 'SELECT 0';		
	
	RETURN @finalQuery;

END