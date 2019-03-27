CREATE PROCEDURE [dbo].[usp_GetConfigurationDateRange] @sourceId INT 
AS
BEGIN
	DECLARE @currentDate DATETIME2 = SYSDATETIME();
	DECLARE @endDate VARCHAR(30) = '''' + CONVERT(VARCHAR, @currentDate, 121) + '''';

	SELECT c.Id AS ConfigurationId, @currentDate AS EndDate
		,REPLACE(REPLACE(c.SqlIngestQuery, '@StartDate', '''' + CONVERT(VARCHAR, le.PartitionEndTime, 121) + ''''), '@EndDate', @endDate) AS SqlIngestQuery
		,[Name]+'_'+REPLACE(REPLACE(@endDate,':','_'),' ','_')+'.csv' AS DestName
	FROM dbo.SqlConfigurations AS c
	JOIN dbo.vw_LastExecutionByDateRange AS le ON le.SqlConfigurationId = c.Id
	WHERE c.PartitionTypeId = 1
		AND SourceId = 1;
END
