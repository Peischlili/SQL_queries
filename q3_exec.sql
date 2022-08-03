DECLARE @report nvarchar(max);

SET @report = dbo.fn_ReportCustomerTurnover(1, 2014);
--SET @report = dbo.fn_ReportCustomerTurnover(2, 2015);
--SET @report = dbo.fn_ReportCustomerTurnover(3, default);
--SET @report = dbo.fn_ReportCustomerTurnover(default, default);

EXEC sp_executesql @report;


