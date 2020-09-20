UPDATE Sales.InvoiceLines
SET UnitPrice = UnitPrice + 20
WHERE InvoiceLineID = (
	SELECT TOP(1) IL.InvoiceLineID
	FROM Sales.InvoiceLines as IL
	WHERE IL.InvoiceID = (
		SELECT TOP(1) I.InvoiceID
		FROM Sales.Invoices as I
		WHERE I.CustomerID = 1060
		ORDER BY I.InvoiceID ASC
	)
	ORDER BY IL.InvoiceLineID ASC
)