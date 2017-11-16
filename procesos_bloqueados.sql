USE [master]
GO

/****** Object:  Table [dbo].[PROCESOS_BLOQUEADOS]    Script Date: 11/16/2017 09:46:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PROCESOS_BLOQUEADOS](
	[Id_Tabla] [int] IDENTITY(1,1) NOT NULL,
	[Blocked spid_1] [smallint] NOT NULL,
	[inicioBloqueo_1] [datetime] NOT NULL,
	[TiempoDeBloqueo_2] [datetime] NOT NULL,
	[Blocked By_2] [smallint] NOT NULL,
	[Owner] [nchar](128) NOT NULL,
	[SQL Text] [nvarchar](4000) NULL,
	[SQLText_GeneraBloqueo] [nvarchar](4000) NULL,
	[cpu] [int] NOT NULL,
	[physical_io] [bigint] NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[program_name] [nchar](128) NOT NULL,
	[hostname] [nchar](128) NOT NULL,
	[status] [nchar](30) NOT NULL,
	[cmd] [nchar](16) NOT NULL,
	[ecid] [smallint] NOT NULL
) ON [PRIMARY]

GO


