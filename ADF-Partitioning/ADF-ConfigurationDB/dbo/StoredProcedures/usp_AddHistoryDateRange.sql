CREATE PROCEDURE [dbo].[usp_AddHistoryDateRange] @configurationId INT
	,@endDate DATETIME2
AS
BEGIN
	INSERT INTO dbo.HistoryByDateRange (
		SqlConfigurationId
		,PartitionStartTime
		,PartitionEndTime
		)
	SELECT SqlConfigurationId
		,PartitionEndTime
		,@endDate
	FROM dbo.vw_LastExecutionByDateRange
	WHERE SqlConfigurationId = @configurationId;
END
