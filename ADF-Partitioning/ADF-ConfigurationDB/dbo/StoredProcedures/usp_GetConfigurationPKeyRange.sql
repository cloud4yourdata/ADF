CREATE PROCEDURE [dbo].[usp_GetConfigurationPKeyRange] @sourceId INT
AS
BEGIN
	DECLARE @currentDate DATETIME2 = SYSDATETIME();
	DECLARE @endDate VARCHAR(30) = CONVERT(VARCHAR, @currentDate, 121);

	SELECT c.Id AS ConfigurationId
		,REPLACE(c.SqlIngestQuery, '@StartId',CONVERT(VARCHAR, le.PartitionEndId)) AS SqlIngestQuery
		,c.SqlMaxIdQuery AS SqlMaxIdQuery
		,[Name]+'_'+CONVERT(VARCHAR, le.PartitionEndId)+'_'+REPLACE(REPLACE(@endDate,':','_'),' ','_')+'.csv' AS DestName
	FROM dbo.SqlConfigurations AS c
	JOIN dbo.vw_LastExecutionByPKeyRange AS le ON le.SqlConfigurationId = c.Id
	WHERE c.PartitionTypeId = 2
		AND SourceId = @sourceId
		AND c.SqlMaxIdQuery IS NOT NULL;
END
