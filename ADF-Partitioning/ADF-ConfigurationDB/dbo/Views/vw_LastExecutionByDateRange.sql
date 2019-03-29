CREATE VIEW [dbo].[vw_LastExecutionByDateRange]
AS
SELECT SqlConfigurationId
	,MAX(PartitionEndTime) AS PartitionEndTime
FROM dbo.HistoryByDateRange
GROUP BY SqlConfigurationId
