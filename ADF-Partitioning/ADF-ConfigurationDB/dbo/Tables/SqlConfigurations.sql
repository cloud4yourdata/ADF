CREATE TABLE [dbo].[SqlConfigurations]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[SourceId] INT NOT NULL,
	[PartitionTypeId] INT NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	[SqlIngestQuery] VARCHAR(MAX) NOT NULL,
	[SqlMaxIdQuery] VARCHAR(MAX),
	[DestFileName] NVARCHAR(100) NULL DEFAULT '', 
    CONSTRAINT [PK_SqlConfigurations] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_SqlConfigurations_SourceId] FOREIGN KEY ([SourceId]) REFERENCES [dbo].[Sources] ([Id]),
	CONSTRAINT [FK_SqlConfigurations_PartitionTypeId] FOREIGN KEY ([PartitionTypeId]) REFERENCES [dbo].[PartitionTypes] ([Id])
)
GO

CREATE UNIQUE INDEX [IX_U_SqlConfigurations_SourceId_Name] ON [dbo].[SqlConfigurations] ([SourceId],[Name]);