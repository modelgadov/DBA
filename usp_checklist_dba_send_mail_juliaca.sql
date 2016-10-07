USE [master]
GO

/****** Object:  StoredProcedure [dbo].[usp_checklist_dba_send_mail]    Script Date: 06/10/2016 11:58:38 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[usp_checklist_dba_send_mail]
AS
DECLARE @Fecha varchar(10)
SET @Fecha=RIGHT('00'+CONVERT(VARCHAR(2),DAY(GETDATE())),2)+'-'+RIGHT('00'+CONVERT(VARCHAR(2),MONTH(GETDATE())),2)+'-'+CONVERT(VARCHAR(4),YEAR(GETDATE()))
DECLARE @BODY VARCHAR (MAX)

SET @BODY='GYM - Checklist SQL Server de la instancia '+@@SERVERNAME+' fecha: '+@Fecha+':'+N'<br></br>'

set @BODY=@BODY+		

                   N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>Version</th>' +    
					N'</tr>'+       
					CAST ((select td= @@VERSION,''
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'

SET @BODY=@BODY+N'<br></br>'+'Configuración de tarjeta ethernet '

declare @ipconfig table(
resultado varchar(1000))
insert 	@ipconfig (resultado) 
EXEC xp_cmdshell 'ipconfig'

set @BODY=@BODY+		

                   N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>Ipconfig</th>' +    
					N'</tr>'+       
					CAST ((select td= resultado,''
					from @ipconfig where resultado is not null   
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'

SET @BODY=@BODY+N'<br></br>'+'Conexiones Entrantes y Salientes:'

declare @netstat table(
resultado varchar(1000))
insert 	@netstat (resultado) 
EXEC xp_cmdshell 'netstat -a'

set @BODY=@BODY+		

                   N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>netstat -a</th>' +    
					N'</tr>'+       
					CAST ((select td= resultado,''
					from @netstat where resultado is not null     
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'	

SET @BODY=@BODY+N'<br></br>'+'Conexión a Sevidor de Aplicaciones:'

declare @ayacucho table(
resultado varchar(1000))
insert 	@ayacucho (resultado) 
EXEC xp_cmdshell 'ping ayacucho.gym.com.pe'

set @BODY=@BODY+		

                   N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>ping ayacucho.gym.com.pe</th>' +    
					N'</tr>'+       
					CAST ((select td= resultado,''
					from @ayacucho where resultado is not null     
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'	

SET @BODY=@BODY+N'<br></br>'+'Conexión a Sevidor de Reportes:'

declare @amazonas table(
resultado varchar(1000))
insert 	@amazonas (resultado) 
EXEC xp_cmdshell 'ping amazonas.gym.com.pe'

set @BODY=@BODY+		

                   N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>ping amazonas.gym.com.pe</th>' +    
					N'</tr>'+       
					CAST ((select td= resultado,''
					from @amazonas where resultado is not null     
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'														

SET @BODY=@BODY+N'<br></br>'+'A continuación el estado de los servicios: '
SET NOCOUNT ON
/************************** Estado de los servicios ********************************/
--SELECT '***** A continuación se da a conocer el cheklist de la instancia '+@@SERVERNAME+', para el día de hoy '+@Fecha+':'
DECLARE @stat_service table(
servic varchar (100), 
stat varchar (20))

INSERT @stat_service (stat)
exec xp_servicecontrol N'querystate',N'MSSQLServer'

UPDATE @stat_service SET servic='Servicio SQL Server' WHERE servic is null

INSERT @stat_service (stat)
exec xp_servicecontrol N'querystate',N'SQLServerAGENT'

UPDATE @stat_service SET servic='Servicio SQL Server Agent' WHERE servic is null

INSERT @stat_service (stat)
exec xp_servicecontrol N'querystate',N'sqlbrowser'

UPDATE @stat_service SET servic='Servicio SQL Server BROWSER' WHERE servic is null

SET @BODY=@BODY+
				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>Services</th><th>Status</th>' +    
					N'</tr>'+       
					CAST ((select td= servic,'',td=stat,''
					from @stat_service     
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'


--SELECT servic as [Services], stat [Status] FROM @stat_service

/************************** Estado de los discos ********************************/
SET @BODY=@BODY+N'<br></br>'+'A continuación el espacio en los discos:'


--SELECT '***** A continuación esl espacio en los discos'
DECLARE @table_disk table(
drive char (1),
Free decimal (10,2),
Size decimal (10,2))

INSERT INTO @table_disk (drive, free)
EXEC MASTER..xp_fixeddrives

Update @table_disk set Size= 70 where drive ='C'
Update @table_disk set Size= 30 where drive ='D'
Update @table_disk set Size= 25 where drive ='E'
Update @table_disk set Size= 279 where drive ='F'
Update @table_disk set Size= 50 where drive ='G'
Update @table_disk set Size= 50 where drive ='T'

Update @table_disk set Free=Free/1024

SET @BODY=@BODY+
				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>Drive</th><th>Size (GB)</th><th>Free (GB)</th><th>Perc Free (GB)</th><th>Comment</th>' +    
					N'</tr>'+       
					CAST ((
					
					SELECT	td=Drive,'',td=Size ,'',td=Free,'',td=convert(varchar(10),(convert(decimal(10,2), Free/Size*100)))+' %','',
							td=(CASE WHEN Free/Size <= 0.1 THEN 'Revisar!!' ELSE 'OK' END),''
					FROM @table_disk
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'

--SELECT Drive,Size as [Size (GB)],Free as [Free (GB)],convert(varchar(10),(convert(decimal(10,2), Free/Size*100)))+' %' [Perc Free],
--(CASE WHEN Free/Size <= 0.1 THEN 'Revisar!!' ELSE 'OK' END) as Comment FROM @table_disk

/************************** Estado de los Log y Data Files ********************************/
SET @BODY=@BODY+N'<br></br>'+'A continuación el tamaño de los logfile, datafiles y BD'
--SELECT ' ***** A continuación el tamaño de los logfile, datafiles y BD'
DECLARE @Size_BDS table(
name_bd varchar (25),
name_file varchar (60),
ruta varchar(max),
[size (MB)] decimal(10,2))

DECLARE @namebd varchar (60)
DECLARE @TSQL varchar (max)
DECLARE TBL_BD CURSOR FOR
	select name from sys.databases 
	OPEN TBL_BD
	FETCH TBL_BD INTO @namebd
	WHILE @@FETCH_STATUS=0
	BEGIN

		SET @TSQL=(
		'select '''+@namebd+''' as dbname,
		name,filename, 
		sum(convert(decimal(17,2),convert(decimal(17,2),size)/128))  
		from '+@namebd+'.dbo.sysfiles
		group by name,filename')

		INSERT INTO @Size_BDS
		EXEC (@TSQL)

	FETCH TBL_BD INTO @namebd
	END
CLOSE TBL_BD
DEALLOCATE TBL_BD


SET @BODY=@BODY+				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>name_bd</th><th>name_file</th><th>Ruta</th><th>[size (MB)]</th>' +    
					N'</tr>'+       
					CAST ((
					
					SELECT	td=name_bd,'',td=name_file ,'',td=ruta ,'',td=[size (MB)],''
					FROM @Size_BDS
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'

SET @BODY=@BODY+N'<br></br>'+'Ultimos Backups Ejecutados:'

declare @backups table(
databasename varchar(1000),
backup_inicio varchar(100),
backup_fin varchar(100),
server_name varchar(100),
login_name varchar(1000),
dispositivo varchar(1000)

)
insert 	@backups  
SELECT top(60)
    [bs].[database_name],     [bs].[backup_start_date], [bs].[backup_finish_date], [bs].Server_name,[bs].user_name AS [BackupCreator] ,    [bmf].physical_device_name
FROM msdb..backupset bs  
INNER JOIN msdb..backupmediafamily bmf ON [bs].[media_set_id] = [bmf].[media_set_id] 
ORDER BY [bs].[backup_start_date] DESC
set @BODY=@BODY+		

                   N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>database</th><th>backup_inicio</th><th>backup_fin</th><th>server</th><th>login</th><th>dispositivo</th>' +    
					N'</tr>'+       
					CAST ((
					select td= databasename,'',td=backup_inicio,'',td=backup_fin,'',td=server_name,'',td=login_name,'',td=dispositivo,''
					FROM @backups    
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'					

--SELECT * FROM @Size_BDS

/************************** Porcentaje de uso de los LogFiles ********************************/

--SELECT ' ***** A continuación el tamaño y el porcentaje de uso de los logs por BD'
--DBCC SQLPERF (logspace) WITH NO_INFOMSGS


/************************** Estado de los bloqueos ********************************/

SET @BODY=@BODY+N'<br></br>'+'A continuación el estado de bloqueos:'
/*Declaramos la tabla que almacena el sp_who*/
DECLARE @who TABLE
(SPID INT,Estado VARCHAR(1000) NULL,
Usuario SYSNAME NULL,NombreEquipo SYSNAME NULL,BloqueadoPor SYSNAME NULL, BaseDeDatos SYSNAME NULL,Comando VARCHAR(1000) NULL,CPUTime INT NULL,DiskIO INT NULL,UltimaEjecucion VARCHAR(1000) NULL,NombrePrograma VARCHAR(1000) NULL, SPID2 INT,  REQUESTID INT)


/*Declaramos la tabla bloqueos*/
DECLARE @bloqueos TABLE
(SPID INT,Estado VARCHAR(1000) NULL,
Usuario SYSNAME NULL,NombreEquipo SYSNAME NULL,BloqueadoPor SYSNAME NULL, BaseDeDatos SYSNAME NULL,Comando VARCHAR(1000) NULL,CPUTime INT NULL,DiskIO INT NULL,UltimaEjecucion VARCHAR(1000) NULL,NombrePrograma VARCHAR(1000) NULL, SPID2 INT,  REQUESTID INT)


	
DECLARE @procesos TABLE
	(spid int , loginame varchar (100), 
	blocked int, cpu int, 
	physical_io int, login_time datetime, 
	last_batch datetime, hostname varchar (100), 
	program_name varchar (150), nt_domain varchar (100), 
	nt_username varchar (100), net_address varchar (100), 
	databasename varchar (100), t_sql varchar (max))

DECLARE @cont int

INSERT INTO @who (SPID, Estado, Usuario, NombreEquipo, BloqueadoPor, BaseDeDatos, Comando, CPUTime, DiskIO, UltimaEjecucion, NombrePrograma, SPID2, REQUESTID)
EXEC sp_who2  

INSERT INTO @bloqueos
	SELECT *  
	FROM @who  
	WHERE BloqueadoPor<>'  .'
	ORDER BY SPID

SELECT @cont=COUNT(*) from @bloqueos

INSERT INTO @procesos
SELECT spid,loginame,
blocked,cpu,
physical_io,login_time,
last_batch,hostname,
program_name,nt_domain,
nt_username,net_address,
DB_NAME(dbid) AS databasename,
(SELECT text FROM sys.dm_exec_sql_text(sql_handle)) AS tsql
FROM master.dbo.sysprocesses (NOLOCK)

IF (@cont)>0 
BEGIN
--	SELECT '**** A continuación el estado de Bloqueos'

SET @BODY=@BODY+				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>databasename</th><th>hostname</th><th>nt_domain</th><th>loginame</th><th>program_name</th><th>physical_io</th><th>cpu</th><th>last_batch</th><th>t_sql</th>' +    
					N'</tr>'+       
					CAST ((
					SELECT	td=pr.databasename,'', td=pr.hostname,'',td=pr.nt_domain,'',td=pr.loginame,'',td=pr.program_name,'',td=pr.physical_io,'',td=pr.cpu,'',td=last_batch,'',td=t_sql,''
					FROM @bloqueos bl JOIN @procesos pr ON bl.SPID=pr.spid
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'

	--SELECT pr.databasename, pr.hostname, pr.nt_domain, pr.loginame, pr.program_name, pr.physical_io, pr.cpu, last_batch, t_sql
	--FROM @bloqueos bl JOIN @procesos pr ON bl.SPID=pr.spid
END
ELSE BEGIN

SET @BODY=@BODY+N'<br></br>'+'No hay bloqueos'
--SELECT 'No hay bloqueos' as [**** A continuacion el estado Bloqueos]
END

/************************** Estado de paginas corruptas ********************************/

SET @BODY=@BODY+N'<br></br>'+'A continuación el estado de Páginas Sospechosas'
DECLARE @cont_ps int
SELECT @cont_ps=COUNT(*) FROM MSDB..suspect_pages
IF @cont_ps=0
	BEGIN 
	--SELECT '**** A continuación el estado de Páginas Sospechosas'
	SET @BODY=@BODY+N'<br></br>'+'No se encontraron páginas sospechosas'
	--SELECT 'No se encontraron páginas sospechosas'
	END
	ELSE BEGIN
	--SELECT '**** A continuación el estado de Páginas Sospechosas'
	
	SET @BODY=@BODY+				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>database_id</th><th>file_id</th><th>page_id</th><th>event_type</th><th>error_count</th><th>last_update_date</th>' +    
					N'</tr>'+       
					CAST ((
					SELECT	td=database_id,'', td=file_id,'',td=page_id,'',td=event_type,'',td=error_count,'',td=last_update_date,''
					FROM MSDB..suspect_pages
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'
	
	--SELECT * FROM MSDB..suspect_pages
	END

/************************** Estado de Jobs ********************************/
--SELECT  '**** A continuación el estado de ejecución de los Jobs'
	SET @BODY=@BODY+N'<br></br>'+'A continuación el estado de ejecución de los Jobs'

DECLARE @date_job varchar(8), @cnt_job int
--SET @date_job=CONVERT(VARCHAR(2),RIGHT('00'+DAY(GETDATE()),2))+'-'+CONVERT(VARCHAR(2),RIGHT('00'+MONTH(GETDATE()),2))+'-'+CONVERT(VARCHAR(4),YEAR(GETDATE()))
SET @date_job = RIGHT('00'+CONVERT(VARCHAR(2),DAY(GETDATE())),2)+RIGHT('00'+CONVERT(VARCHAR(2),MONTH(GETDATE())),2)+CONVERT(VARCHAR(4),YEAR(GETDATE()))

select @cnt_job = count(*)
from msdb..sysjobhistory sjh 
 JOIN msdb..sysjobs sjo on sjh.job_id=sjo.job_id 
 WHERE convert(varchar(8),sjh.run_date)=@Fecha and sjh.run_status=0

 IF @cnt_job=0 
	BEGIN 
		--SELECT 'No se encuentran Jobs con ejecuciones de tipo Failed' 
		SET @BODY=@BODY+N'<br></br>'+'No se encuentran Jobs con ejecuciones de tipo Failed'
	END 
	ELSE BEGIN
		SET @BODY=@BODY+				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>name</th><th>step_name</th><th>run_date</th><th>run_time</th><th>run_duration</th><th>run_status</th>' +    
					N'</tr>'+       
					CAST ((
					select distinct td=sjo.name,'', td=sjh.step_name,'', td=sjh.run_date,'',td=sjh.run_time,'',td=sjh.run_duration,'', 
					td=(CASE WHEN sjh.run_status<>0 THEN 'OK' ELSE 'FAILED REVIEW!!' END),'' 
					from msdb..sysjobhistory sjh 
					JOIN msdb..sysjobs sjo on sjh.job_id=sjo.job_id 
					WHERE sjh.run_date=@Fecha and sjh.run_status=0
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'
					
					
		--select distinct sjo.name, sjh.step_name, sjh.run_date,sjh.run_time,sjh.run_duration, 
		--(CASE WHEN sjh.run_status<>0 THEN 'OK' ELSE 'FAILED' END) Comment, 'Review!!' 
		--from msdb..sysjobhistory sjh 
		--JOIN msdb..sysjobs sjo on sjh.job_id=sjo.job_id 
		--WHERE sjh.run_date=@Fecha and sjh.run_status=0
	END

/****************************** Revision de alta disponibilidad ****************/
SET @BODY=@BODY+N'<br></br>'+'A continuación el estado alta disponibilidad:'
DECLARE @count1 int
DECLARE @tbl_stat_repl table (status varchar (15), publisher varchar (50), suscriber varchar (50), publication varchar (100), lastsync datetime, message varchar (max))
DECLARE @CONTEO INT
DECLARE @serv_dist varchar(15)
DECLARE @exec_repl varchar(max)
DECLARE @node varchar (50)
DECLARE @stat_clust table (iscluster int, node varchar (50))

INSERT INTO @stat_clust 
SELECT CONVERT (INT, SERVERPROPERTY('IsClustered')),CONVERT(VARCHAR(50),SERVERPROPERTY('ComputerNamePhysicalNetBIOS')) 

SELECT @CONTEO=COUNT(*) FROM @stat_clust WHERE iscluster=1

IF @CONTEO=0
BEGIN 
	SET @BODY=@BODY+N'<br></br>'+'* El Servidor NO ESTA configurado como CLUSTER'
	--PRINT 'El Servidor NO ESTA configurado como CLUSTER' 
END 
ELSE 
	BEGIN 
	SELECT @node=node FROM @stat_clust WHERE iscluster=1
	SET @BODY=@BODY+N'<br></br>'+'* El servidor SI ESTA configurado como CLUSTER y se encuentra actualmente en el nodo '+@node END
	--PRINT 'El servidor SI ESTA configurado como CLUSTER y se encuentra actualmente en el nodo '+@node END
	

SELECT @CONTEO=COUNT(name) from master..sysdatabases where name like 'distribu%'
IF @CONTEO<>0
BEGIN
	SET @BODY=@BODY+N'<br></br>'+'* El servidor SI ESTA configurado para REPLICACIONES'
	--PRINT 'El servidor SI ESTA configurado para REPLICACIONES'
	INSERT INTO @tbl_stat_repl
	SELECT  (
			CASE       
			WHEN mdh.runstatus =  '1' THEN 'Start - '+cast(mdh.runstatus as varchar)     
			WHEN mdh.runstatus =  '2' THEN 'Succeed - ' + cast(mdh.runstatus as varchar)     
			WHEN mdh.runstatus =  '3' THEN 'InProgress - ' + cast(mdh.runstatus as varchar)     
			WHEN mdh.runstatus =  '4' THEN 'Idle - '+cast(mdh.runstatus as varchar)     
			WHEN mdh.runstatus =  '5'THEN 'Retry - '+cast(mdh.runstatus as varchar)     
			WHEN mdh.runstatus =  '6' THEN 'Fail - '+cast(mdh.runstatus as varchar)     
			ELSE CAST(mdh.runstatus AS VARCHAR) END) [Run_Status],  
			mda.publisher_db,
			mda.subscriber_db [Subscriber_DB],  
			mpub.publication,
			CONVERT(VARCHAR(25),mdh.[time]) [LastSynchronized], 
			mdh.comments [Messages]--,  
			FROM distribution.dbo.MSdistribution_agents mda  
			LEFT JOIN distribution.dbo.MSdistribution_history mdh ON mdh.agent_id = mda.id  
			JOIN      (SELECT s.agent_id, MaxAgentValue.[time], SUM(CASE WHEN xact_seqno > MaxAgentValue.maxseq THEN 1 ELSE 0 END) AS UndelivCmdsInDistDB      
						FROM distribution.dbo.MSrepl_commands t (NOLOCK)       
						JOIN distribution.dbo.MSsubscriptions AS s (NOLOCK) ON (t.article_id = s.article_id AND t.publisher_database_id=s.publisher_database_id )      
			JOIN      (SELECT hist.agent_id, MAX(hist.[time]) AS [time], h.maxseq           
						FROM distribution.dbo.MSdistribution_history hist (NOLOCK)          
						JOIN (SELECT agent_id,ISNULL(MAX(xact_seqno),0x0) AS maxseq          
								FROM distribution.dbo.MSdistribution_history (NOLOCK)           
								GROUP BY agent_id) AS h           
			ON (hist.agent_id=h.agent_id AND h.maxseq=hist.xact_seqno)          
			GROUP BY hist.agent_id, h.maxseq          ) AS MaxAgentValue      
			ON MaxAgentValue.agent_id = s.agent_id      
			GROUP BY s.agent_id, MaxAgentValue.[time]      ) und  
			ON mda.id = und.agent_id AND und.[time] = mdh.[time]  
			JOIN distribution.dbo.MSpublications mpub on mpub.publisher_db=mda.publisher_db 
			
			where mda.subscriber_db<>'virtual' 
			AND mdh.runstatus IN ('5','6')
			order by mdh.[time] 

	SELECT @count1=COUNT (*) FROM @tbl_stat_repl		
	IF @count1 ='0'
	BEGIN 
		SET @BODY=@BODY+N'<br></br>'+'	No existen problemas en las replicaciones'
		--PRINT 'No existen problemas en las replicaciones' 
	END
	ELSE 
		BEGIN
			SET @BODY=@BODY+N'<br></br>'+'	Existen problemas con las replicaciones, favor de revisar las siguientes publicaciones'
			--PRINT 'Existen problemas con las replicaciones, favor de revisar las siguientes publicaciones'
			SELECT * FROM @tbl_stat_repl
			
			SET @BODY=@BODY+				
					N'<html><head><style>      
					td { border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}      
					 th {color:black;border: 1px solid black;padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;font-size:10pt;font-family:"Calibri"}    
					</style></head>'+
					N'<H3 style="font-size:11pt;color:black;font-family:''Calibri''">   </H3>' +    
					N'<table cellpadding=0 cellspacing=0 border=0>' +        
					N'<tr bgcolor=#F7FE2E > <th>status</th><th>publisher</th><th>suscriber</th><th>publication</th><th>lastsync</th><th>message</th>' +    
					N'</tr>'+       
					CAST ((
					select distinct td=status,'', td=publisher,'', td=suscriber,'',td=publication,'',td=lastsync,'', 
					td=message,'' 
					FROM @tbl_stat_repl
					FOR XML PATH('tr'), TYPE         
					) AS NVARCHAR(MAX) ) +        
					N'</table></html>'
	END
END
ELSE 
	BEGIN
	SET @BODY=@BODY+N'<br></br>'+'*	El servidor NO esta configurado para replicaciones'
	--PRINT 'El servidor NO esta configurado para replicaciones'
ENd

/******************************* Envio de correo *****************/


SET NOCOUNT OFF
SET @BODY=@BODY+N'<br></br>'+'--------------------'
SET @BODY=@BODY+N'<br></br>'+'Atentamente.'
SET @BODY=@BODY+N'<br></br>'+'Equipo DBAGYM - GMD'

/*Envio del correo al grupo*/
DECLARE @mailprofile varchar (20)
SELECT TOP 1 @mailprofile=name FROM MSDB.DBO.sysmail_profile

DECLARE @subject_temp VARCHAR(100)      
		  SET @subject_temp='GYM - Checklist SQL Server - '+@@SERVERNAME+'-'+  @Fecha 
		  EXEC msdb.dbo.sp_send_dbmail     
				@recipients='dbagym@gmd.com.pe', 
				@profile_name='DBA-GMD', 
				@subject = @subject_temp,        
				@body = @BODY,        
				@body_format = 'HTML'   
GO


