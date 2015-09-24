CREATE TABLE [dbo].[season]
(
[Code] [varchar] (50) COLLATE Latin1_General_100_CI_AI NOT NULL,
[Name (en-CA)] [nvarchar] (255) COLLATE Latin1_General_100_CI_AI NULL,
[Name (fr-CA)] [nvarchar] (255) COLLATE Latin1_General_100_CI_AI NULL,
[Groups] [varchar] (max) COLLATE Latin1_General_100_CI_AI NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[season] ADD CONSTRAINT [PK_season] PRIMARY KEY CLUSTERED  ([Code]) ON [PRIMARY]
GO
