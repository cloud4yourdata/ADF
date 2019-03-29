IF OBJECT_ID('dbo.Numbers', 'U') IS NOT NULL
BEGIN
	IF NOT EXISTS (
			SELECT 1
			FROM dbo.Numbers
			WHERE Number > 10000
			)
	BEGIN
		DROP TABLE dbo.Numbers;
		SELECT IDENTITY(INT, 1, 1) AS Number
		INTO dbo.Numbers
		FROM sys.objects s1
		CROSS JOIN sys.messages s2;
	END
END
