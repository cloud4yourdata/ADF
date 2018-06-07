DECLARE @startDate DATETIME2 = DATEADD(DAY, - 1, SYSDATETIME());
DECLARE @endDate DATETIME = SYSDATETIME();

INSERT INTO dbo.Table2 (
	[Value]
	,InsertedOn
	)
SELECT TOP 100 Number AS [Value]
	,DATEADD(SECOND, number, @startDate) AS InsertedOn
FROM dbo.Numbers
ORDER BY Number ASC
