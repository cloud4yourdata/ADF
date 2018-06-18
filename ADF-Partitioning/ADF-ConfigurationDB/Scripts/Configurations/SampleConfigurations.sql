DECLARE @configId INT;
DECLARE @sourceId INT = 1;
DECLARE @datePartitionTypeId INT = 1;
DECLARE @confName VARCHAR(50) = 'Table1';
DECLARE @sqlQuery AS VARCHAR(MAX) = N'
SELECT Id
	,[Value]
	,InsertedOn
FROM dbo.Table1
WHERE InsertedOn BETWEEN @StartDate
		AND @EndDate
';

IF NOT EXISTS (
		SELECT 1
		FROM dbo.SqlConfigurations
		)
BEGIN
	SET XACT_ABORT ON;

	INSERT INTO dbo.SqlConfigurations (
		[Name]
		,PartitionTypeId
		,SourceId
		,SqlIngestQuery
		)
	VALUES (
		@confName
		,@datePartitionTypeId
		,@sourceId
		,@sqlQuery
		);

	SELECT @configId = SCOPE_IDENTITY();

	INSERT INTO dbo.HistoryByDateRange (
		PartitionStartTime
		,PartitionEndTime
		,SqlConfigurationId
		)
	VALUES (
		DATEADD(DAY, - 2, SYSDATETIME())
		,DATEADD(DAY, - 1, SYSDATETIME())
		,@configId
		);

	SET @confName = 'Table2';
	SET @sqlQuery = N'
SELECT Id
	,[Value]
	,InsertedOn
FROM dbo.Table2
WHERE InsertedOn BETWEEN @StartDate
		AND @EndDate
';

	INSERT INTO dbo.SqlConfigurations (
		[Name]
		,PartitionTypeId
		,SourceId
		,SqlIngestQuery
		)
	VALUES (
		@confName
		,@datePartitionTypeId
		,@sourceId
		,@sqlQuery
		);

	SELECT @configId = SCOPE_IDENTITY();

	INSERT INTO dbo.HistoryByDateRange (
		PartitionStartTime
		,PartitionEndTime
		,SqlConfigurationId
		)
	VALUES (
		DATEADD(DAY, - 11, SYSDATETIME())
		,DATEADD(DAY, - 10, SYSDATETIME())
		,@configId
		);

	DECLARE @sqlMaxIdQuery VARCHAR(MAX) = N'
	SELECT MAX(Id) AS Id FROM dbo.Table3
	';

	SET @confName = 'Table3';
	SET @datePartitionTypeId = 2;
	SET @sqlQuery = N'
SELECT Id
	,[Value]
	,InsertedOn
FROM dbo.Table3
WHERE Id BETWEEN @StartId
		AND @EndId
';

	INSERT INTO dbo.SqlConfigurations (
		[Name]
		,PartitionTypeId
		,SourceId
		,SqlIngestQuery
		,SqlMaxIdQuery
		)
	VALUES (
		@confName
		,@datePartitionTypeId
		,@sourceId
		,@sqlQuery
		,@sqlMaxIdQuery
		);

	SELECT @configId = SCOPE_IDENTITY();

	INSERT INTO dbo.HistoryByPKeyRange (
		PartitionStartId
		,PartitionEndId
		,SqlConfigurationId
		)
	VALUES (
		1
		,8600000
		,@configId
		);
COMMIT TRAN;
END;


