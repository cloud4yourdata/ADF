DECLARE @daysCount INT = 100;
DECLARE @endDate DATETIME2 = SYSDATETIME();
DECLARE @startDate DATETIME = DATEADD(DAY, - @daysCount, @endDate);

IF (
		SELECT COUNT(*)
		FROM dbo.Table1
		) = 0
BEGIN
	INSERT INTO dbo.Table1 (
		[Value]
		,InsertedOn
		)
	SELECT Number AS [Value]
		,DATEADD(SECOND, number, @startDate) AS InsertedOn
	FROM dbo.Numbers
	WHERE DATEADD(SECOND, number, @startDate) < @endDate
END
GO