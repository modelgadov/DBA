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
