SELECT TempTable.CustomerId
	, TempTable.CustomerName
FROM (
	SELECT C.CustomerId
		, C.CustomerName
		, SUM(Pch.qty) as Quantity
	FROM Customer as C
		, Purchase as Pch
	WHERE Pch.CustomerId = C.CustomerId
		AND NOT EXISTS (
		SELECT *
		FROM Product as P
		WHERE NOT EXISTS (
			SELECT *
			FROM Purchase as Pch
			WHERE Pch.CustomerID = C.CustomerID
				AND Pch.ProductID = P.ProductID
		)
	)
	GROUP BY C.CustomerId, C.CustomerName
	) AS TempTable
WHERE TempTable.Quantity > 50