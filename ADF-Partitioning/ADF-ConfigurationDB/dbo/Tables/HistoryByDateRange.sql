CREATE TABLE [dbo].[HistoryByDateRange]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[SqlConfigurationId] INT NOT NULL,
	[PartitionStartTime] DATETIME2 NOT NULL,
	[PartitionEndTime] DATETIME2 NOT NULL,
	CONSTRAINT [PK_HistoryByDateRange] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_HistoryByDateRange_Loads] FOREIGN KEY ([SqlConfigurationId]) REFERENCES [dbo].[SqlConfigurations] ([Id])
)
