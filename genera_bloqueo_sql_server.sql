USE [master]
GO

/****** Object:  Table [dbo].[GENERA_BLOQUEO]    Script Date: 11/16/2017 09:45:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[GENERA_BLOQUEO](
	[IdBloqueo] [int] IDENTITY(1,1) NOT NULL,
	[FechaConsultaBloqueo] [datetime] NULL,
	[FechaBloqueo] [datetime] NULL,
	[Root blocking spids] [smallint] NOT NULL,
	[Owner] [nchar](128) NOT NULL,
	[SQL Text] [nvarchar](4000) NULL,
	[cpu] [int] NOT NULL,
	[physical_io] [bigint] NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[program_name] [nchar](128) NOT NULL,
	[hostname] [nchar](128) NOT NULL,
	[status] [nchar](30) NOT NULL,
	[cmd] [nchar](16) NOT NULL,
	[blocked] [smallint] NOT NULL,
	[ecid] [smallint] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[GENERA_BLOQUEO] ADD  CONSTRAINT [DF_GENERA_BLOQUEO_FechaConsultaBloqueo]  DEFAULT (getdate()) FOR [FechaConsultaBloqueo]
GO


