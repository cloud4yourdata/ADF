CREATE PROCEDURE [dbo].[usp_GetConfigurationPKeyRange] @sourceId INT
AS
BEGIN
	SELECT c.Id AS ConfigurationId
		,REPLACE(c.SqlIngestQuery, '@StartId', CONVERT(VARCHAR, le.PartitionEndId)) AS SqlIngestQuery
		,c.SqlMaxIdQuery AS SqlMaxIdQuery
	FROM dbo.SqlConfigurations AS c
	JOIN dbo.vw_LastExecutionByPKeyRange AS le ON le.SqlConfigurationId = c.Id
	WHERE c.PartitionTypeId = 2
		AND SourceId = @sourceId
		AND c.SqlMaxIdQuery IS NOT NULL;
END
