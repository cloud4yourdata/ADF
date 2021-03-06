﻿DECLARE @daysCount INT = 100;
DECLARE @endDate DATETIME2 = DATEADD(DAY, - 1, SYSDATETIME());
DECLARE @startDate DATETIME = DATEADD(DAY, - @daysCount, @endDate);

IF (
		SELECT COUNT(*)
		FROM dbo.Table3
		) = 0
BEGIN
	INSERT INTO dbo.Table3 (
		[Value]
		,InsertedOn
		)
	SELECT Number AS [Value]
		,DATEADD(SECOND, number, @startDate) AS InsertedOn
	FROM dbo.Numbers
	WHERE DATEADD(SECOND, number, @startDate) < @endDate
END
