DECLARE @Sources AS TABLE (
	Id INT NOT NULL
	,[Name] VARCHAR(50) NOT NULL
	);
DECLARE @PartitionTypes AS TABLE (
	Id INT NOT NULL
	,[Name] VARCHAR(50) NOT NULL
	);

INSERT INTO @Sources (
	Id
	,[Name]
	)
VALUES (
	1
	,'On Premise SQL Server'
	);

INSERT INTO @PartitionTypes (
	Id
	,[Name]
	)
VALUES (
	1
	,'Partitioning by Date Range'
	)
	,(
	2
	,'Partitioning by Primary Key Range'
	);

SET XACT_ABORT ON;

BEGIN TRAN

MERGE dbo.Sources AS trg
USING (
	SELECT Id
		,[Name]
	FROM @Sources
	) AS src
	ON (trg.Id = src.Id)
WHEN MATCHED
	THEN
		UPDATE
		SET [Name] = src.[Name]
WHEN NOT MATCHED
	THEN
		INSERT (
			Id
			,[Name]
			)
		VALUES (
			src.Id
			,src.[Name]
			);

MERGE dbo.PartitionTypes AS trg
USING (
	SELECT Id
		,[Name]
	FROM @PartitionTypes
	) AS src
	ON (trg.Id = src.Id)
WHEN MATCHED
	THEN
		UPDATE
		SET [Name] = src.[Name]
WHEN NOT MATCHED
	THEN
		INSERT (
			Id
			,[Name]
			)
		VALUES (
			src.Id
			,src.[Name]
			);

COMMIT TRAN
GO