CREATE TABLE [dbo].[HistoryByPKeyRange]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[SqlConfigurationId] INT NOT NULL,
	[PartitionStartId] INT NOT NULL,
	[PartitionEndId] INT NOT NULL,
	CONSTRAINT [PK_HistoryByPKeyRange] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_HistoryByPKeyRange_Loads] FOREIGN KEY ([SqlConfigurationId]) REFERENCES [dbo].[SqlConfigurations] ([Id])
)
