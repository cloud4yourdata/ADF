﻿CREATE TABLE [dbo].[Table1]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Value] INT NOT NULL,
	[InsertedOn] DATETIME2 DEFAULT SYSDATETIME() 
)
