-- Here comes the 1st subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 1
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 1
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 2nd subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 2
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 2
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 3rd subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 3
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 3
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 4th subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 4
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 4
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 5th subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 5
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 5
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 6th subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 6
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 6
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 7th subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 7
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 7
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)

UNION

-- Here comes the 8th subquery
SELECT resultTable.*
FROM 
(
SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
FROM Sales.OrderLines as OL
	, Sales.Orders as O
	, Sales.Customers as C
	, Sales.CustomerCategories as Cat
WHERE O.OrderID = OL.OrderID
	 AND C.CustomerID = O.CustomerID
	 AND C.CustomerCategoryID = Cat.CustomerCategoryID
	 AND NOT EXISTS(
		SELECT *
		FROM Sales.Invoices AS I
		WHERE I.OrderID = O.OrderID
		)
	AND Cat.CustomerCategoryID = 8
GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
) as resultTable

WHERE resultTable.MaxLoss = ( SELECT MAX(resultTable.MaxLoss) FROM (
	SELECT 
	Cat.CustomerCategoryName 
	, SUM(OL.UnitPrice * OL.Quantity) as MaxLoss
	, C.CustomerName
	, O.CustomerID	
	FROM Sales.OrderLines as OL
		, Sales.Orders as O
		, Sales.Customers as C
		, Sales.CustomerCategories as Cat
	WHERE O.OrderID = OL.OrderID
		 AND C.CustomerID = O.CustomerID
		 AND C.CustomerCategoryID = Cat.CustomerCategoryID
		 AND NOT EXISTS(
			SELECT *
			FROM Sales.Invoices AS I
			WHERE I.OrderID = O.OrderID
			)
		AND Cat.CustomerCategoryID = 8
	GROUP BY O.CustomerID, C.CustomerName, Cat.CustomerCategoryName, Cat.CustomerCategoryID
	) as resultTable
)
ORDER BY MaxLoss DESC