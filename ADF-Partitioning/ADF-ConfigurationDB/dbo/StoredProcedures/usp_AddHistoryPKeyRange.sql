CREATE PROCEDURE [dbo].[usp_AddHistoryPKeyRange] @configurationId INT
	,@endId INT
AS
BEGIN
	INSERT INTO dbo.HistoryByPKeyRange (
		SqlConfigurationId
		,PartitionStartId
		,PartitionEndId
		)
	SELECT SqlConfigurationId
		,PartitionEndId
		,@endId
	FROM dbo.vw_LastExecutionByPKeyRange
	WHERE SqlConfigurationId = @configurationId;
END
