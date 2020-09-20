SELECT C.CustomerID
	, C.CustomerName
	, COUNT(Distinct O.OrderID) as TotalNBOrders
	, COUNT(Distinct I.InvoiceID) as TotalNBInvoices
	, SUM(OrderSum.OrderLineSum) as OrdersTotalValue
	, SUM(InvoiceSum.InvoiceLineSum) as InvoicesTotalValue
	, ABS(SUM(OrderSum.OrderLineSum) - SUM(InvoiceSum.InvoiceLineSum)) as AbsoluteValueDifference

FROM Sales.Customers as C
	, Sales.Orders as O
	, Sales.Invoices as I
	, (
	SELECT OrderID
			, SUM(Quantity * UnitPrice) as OrderLineSum
	FROM Sales.OrderLines
	GROUP BY OrderID
	) as OrderSum
	, (
	SELECT InvoiceID
			, SUM(Quantity * UnitPrice) as InvoiceLineSum
	FROM Sales.InvoiceLines
	GROUP BY InvoiceID
	) as InvoiceSum

WHERE C.CustomerID = O.CustomerID
	AND O.OrderID = I.OrderID
	AND O.OrderID = OrderSum.OrderID
	AND I.InvoiceID = InvoiceSum.InvoiceID

GROUP BY C.CustomerID, C.CustomerName

ORDER BY TotalNBOrders, C.CustomerName ASC
	, AbsoluteValueDifference DESC

