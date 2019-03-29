CREATE VIEW [dbo].[vw_LastExecutionByPKeyRange]
AS
SELECT SqlConfigurationId
	,MAX(PartitionEndId) AS PartitionEndId
FROM dbo.HistoryByPKeyRange
GROUP BY SqlConfigurationId
