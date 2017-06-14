use AdventureWorks2012 
go
select s.name as esquema,o.name as "Nombre de Objetos",parent_object_id,o.type as Tipo,type_desc as "Tipo de Objeto",create_date as creado,modify_date as modificacion from sys.all_objects o join sys.schemas s on o.schema_id=s.schema_id where o.modify_date > DATEADD(day,-1,GETDATE())

----Query para ver los indices asociados a una tabla
USE <database_name>;
GO
SELECT i.name AS index_name
    ,i.type_desc
    ,is_unique
    ,ds.type_desc AS filegroup_or_partition_scheme
    ,ds.name AS filegroup_or_partition_scheme_name
    ,ignore_dup_key
    ,is_primary_key
    ,is_unique_constraint
    ,fill_factor
    ,is_padded
    ,is_disabled
    ,allow_row_locks
    ,allow_page_locks
FROM sys.indexes AS i
INNER JOIN sys.data_spaces AS ds ON i.data_space_id = ds.data_space_id
WHERE is_hypothetical = 0 AND i.index_id <> 0 
AND i.object_id = OBJECT_ID('<schema_name.table_name>');
GO

--query para saber las tablas de mayor tamaño
use AdventureWorks2012
go
SELECT OBJECT_NAME(OBJECT_ID) TableName, st.row_count
FROM sys.dm_db_partition_stats st
WHERE index_id < 2
ORDER BY st.row_count DESC

--Usuarios creados ultimamente
select loginname, createdate, updatedate, sysadmin, dbname from sys.syslogins order by createdate desc;
select * from sys.sysusers order by createdate desc;

--Usuarios con el rol sysadmin
select loginname, createdate, updatedate, sysadmin, dbname from sys.syslogins where sysadmin=1;

--ver querys ejecutados
SELECT deqs.last_execution_time AS [Time], dest.TEXT AS [Query]
FROM sys.dm_exec_query_stats AS deqs
CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
ORDER BY deqs.last_execution_time DESC


-- ver caracteristicas de sesion actual
SELECT 
    c.session_id, c.net_transport, c.encrypt_option, 
    c.auth_scheme, s.host_name, s.program_name, 
    s.client_interface_name, s.login_name, s.nt_domain, 
    s.nt_user_name, s.original_login_name, c.connect_time, 
    s.login_time 
FROM sys.dm_exec_connections AS c
JOIN sys.dm_exec_sessions AS s
    ON c.session_id = s.session_id
WHERE c.session_id = @@SPID;

--- ver ultimos cambios en la BD
SELECT [Current LSN],
  [Operation],
  [Transaction Name],
  [Transaction ID],
  [Transaction SID],
  [SPID],
  [Begin Time]
FROM fn_dblog(null,null) where Operation in ('LOP_UPDATE_ROWS')

------ Database Mail -------
SELECT items.subject,
    items.last_mod_date
    ,l.description FROM dbo.sysmail_allitems  as items
INNER JOIN dbo.sysmail_event_log AS l
    ON items.mailitem_id = l.mailitem_id
    
EXEC msdb.dbo.sysmail_help_configure_sp;
EXEC msdb.dbo.sysmail_help_account_sp;
EXEC msdb.dbo.sysmail_help_profile_sp;
EXEC msdb.dbo.sysmail_help_profileaccount_sp;
EXEC msdb.dbo.sysmail_help_principalprofile_sp;


-----ver espacio libre en datafiles
SELECT 
    [TYPE] = A.TYPE_DESC
    ,[FILE_Name] = A.name
    ,[FILEGROUP_NAME] = fg.name
    ,[File_Location] = A.PHYSICAL_NAME
    ,[FILESIZE_MB] = CONVERT(DECIMAL(10,2),A.SIZE/128.0)
    ,[USEDSPACE_MB] = CONVERT(DECIMAL(10,2),A.SIZE/128.0 - ((SIZE/128.0) - CAST(FILEPROPERTY(A.NAME, 'SPACEUSED') AS INT)/128.0))
    ,[FREESPACE_MB] = CONVERT(DECIMAL(10,2),A.SIZE/128.0 - CAST(FILEPROPERTY(A.NAME, 'SPACEUSED') AS INT)/128.0)
    ,[FREESPACE_%] = CONVERT(DECIMAL(10,2),((A.SIZE/128.0 - CAST(FILEPROPERTY(A.NAME, 'SPACEUSED') AS INT)/128.0)/(A.SIZE/128.0))*100)
    ,[AutoGrow] = 'By ' + CASE is_percent_growth WHEN 0 THEN CAST(growth/128 AS VARCHAR(10)) + ' MB -' 
        WHEN 1 THEN CAST(growth AS VARCHAR(10)) + '% -' ELSE '' END 
        + CASE max_size WHEN 0 THEN 'DISABLED' WHEN -1 THEN ' Unrestricted' 
            ELSE ' Restricted to ' + CAST(max_size/(128*1024) AS VARCHAR(10)) + ' GB' END 
        + CASE is_percent_growth WHEN 1 THEN ' [autogrowth by percent, BAD setting!]' ELSE '' END
FROM sys.database_files A LEFT JOIN sys.filegroups fg ON A.data_space_id = fg.data_space_id 
order by A.TYPE desc, A.NAME;

-------ver acciones realizadas en una BD en un rango de tiempo
SELECT StartTime,endtime,duration,ntusername,applicationname,textdata,loginname,loginsid,spid,hostname,applicationname,
servername,databasename,objectName,
CASE ObjectType
WHEN 8259 THEN 'Check Constraint'
WHEN 8260 THEN 'Default (constraint or standalone)'
WHEN 8262 THEN 'Foreign-key Constraint'
WHEN 8272 THEN 'Stored Procedure'
WHEN 8274 THEN 'Rule'
WHEN 8275 THEN 'System Table'
WHEN 8276 THEN 'Trigger on Server'
WHEN 8277 THEN '(User-defined) Table'
WHEN 8278 THEN 'View'
WHEN 8280 THEN 'Extended Stored Procedure'
WHEN 16724 THEN 'CLR Trigger'
WHEN 16964 THEN 'Database'
WHEN 16975 THEN 'Object'
WHEN 17222 THEN 'FullText Catalog'
WHEN 17232 THEN 'CLR Stored Procedure'
WHEN 17235 THEN 'Schema'
WHEN 17475 THEN 'Credential'
WHEN 17491 THEN 'DDL Event'
WHEN 17741 THEN 'Management Event'
WHEN 17747 THEN 'Security Event'
WHEN 17749 THEN 'User Event'
WHEN 17985 THEN 'CLR Aggregate Function'
WHEN 17993 THEN 'Inline Table-valued SQL Function'
WHEN 18000 THEN 'Partition Function'
WHEN 18002 THEN 'Replication Filter Procedure'
WHEN 18004 THEN 'Table-valued SQL Function'
WHEN 18259 THEN 'Server Role'
WHEN 18263 THEN 'Microsoft Windows Group'
WHEN 19265 THEN 'Asymmetric Key'
WHEN 19277 THEN 'Master Key'
WHEN 19280 THEN 'Primary Key'
WHEN 19283 THEN 'ObfusKey'
WHEN 19521 THEN 'Asymmetric Key Login'
WHEN 19523 THEN 'Certificate Login'
WHEN 19538 THEN 'Role'
WHEN 19539 THEN 'SQL Login'
WHEN 19543 THEN 'Windows Login'
WHEN 20034 THEN 'Remote Service Binding'
WHEN 20036 THEN 'Event Notification on Database'
WHEN 20037 THEN 'Event Notification'
WHEN 20038 THEN 'Scalar SQL Function'
WHEN 20047 THEN 'Event Notification on Object'
WHEN 20051 THEN 'Synonym'
WHEN 20549 THEN 'End Point'
WHEN 20801 THEN 'Adhoc Queries which may be cached'
WHEN 20816 THEN 'Prepared Queries which may be cached'
WHEN 20819 THEN 'Service Broker Service Queue'
WHEN 20821 THEN 'Unique Constraint'
WHEN 21057 THEN 'Application Role'
WHEN 21059 THEN 'Certificate'
WHEN 21075 THEN 'Server'
WHEN 21076 THEN 'Transact-SQL Trigger'
WHEN 21313 THEN 'Assembly'
WHEN 21318 THEN 'CLR Scalar Function'
WHEN 21321 THEN 'Inline scalar SQL Function'
WHEN 21328 THEN 'Partition Scheme'
WHEN 21333 THEN 'User'
WHEN 21571 THEN 'Service Broker Service Contract'
WHEN 21572 THEN 'Trigger on Database'
WHEN 21574 THEN 'CLR Table-valued Function'
WHEN 21577
THEN 'Internal Table (For example, XML Node Table, Queue Table.)'
WHEN 21581 THEN 'Service Broker Message Type'
WHEN 21586 THEN 'Service Broker Route'
WHEN 21587 THEN 'Statistics'
WHEN 21825 THEN 'User'
WHEN 21827 THEN 'User'
WHEN 21831 THEN 'User'
WHEN 21843 THEN 'User'
WHEN 21847 THEN 'User'
WHEN 22099 THEN 'Service Broker Service'
WHEN 22601 THEN 'Index'
WHEN 22604 THEN 'Certificate Login'
WHEN 22611 THEN 'XMLSchema'
WHEN 22868 THEN 'Type'
ELSE 'Hmmm???'
END AS ObjectType,
e.category_id, trace_event_id,eventsequence, cat.name as [CategoryName], 
eventclass,eventsubclass, e.name as EventName,clientprocessid
FROM ::fn_trace_gettable('C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Log\log_80.trc',0)

-- Inner Eventos a Trazear --
INNER JOIN sys.trace_events e 
ON eventclass = trace_event_id 

-- Inner en Categorías -- 
INNER JOIN sys.trace_categories AS cat 
ON e.category_id = cat.category_id

where CONVERT(VARCHAR(10),StartTime,110) >= '06-09-2017' and CONVERT(VARCHAR(10),StartTime,110) <= '06-12-2017'



