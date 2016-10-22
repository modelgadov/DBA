SELECT TOP 30 SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
((CASE qs.statement_end_offset
WHEN -1 THEN DATALENGTH(qt.TEXT)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2)+1) as query,
qs.execution_count,
qs.total_logical_reads, qs.last_logical_reads,
qs.total_logical_writes, qs.last_logical_writes,
qs.total_worker_time,
qs.total_worker_time / execution_count AS avg_worker_time,
qs.last_worker_time,
qs.total_elapsed_time/1000000 total_elapsed_time_in_S,
qs.last_elapsed_time/1000000 last_elapsed_time_in_S,
qs.last_execution_time
--qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
where qt.TEXT is not null
ORDER BY qs.total_logical_reads DESC -- logical reads


declare @DB sysname = 'msdb';
select
    rh.destination_database_name,
    rh.restore_date,
bs.backup_set_uuid,
    rh.user_name,
    bs.name as backup_set_name,
    bs.user_name as backup_set_username,
    bs.backup_start_date,
    bs.backup_finish_date,
    bs.database_name as backup_set_database_name,
    bs.server_name,
    bs.machine_name,
    bmf.physical_device_name,
    bmf.device_type,
    case bmf.device_type
        when 2 then 'Disk'
        when 5 then 'Tape'
        when 7 then 'Virtual Device'
        when 105 then 'Permanent backup device'
        else 'UNKNOWN'
    end as device_type_desc
from 
    msdb.dbo.restorehistory rh
    left outer join msdb.dbo.backupset bs on rh.backup_set_id = bs.backup_set_id
    left outer join msdb.dbo.backupmediafamily bmf on bs.media_set_id = bmf.media_set_id
where
    rh.destination_database_name = @DB; 
 
USE [msdb]
GO 
SELECT 
    [bs].[database_name], 
    [bs].[backup_start_date], 
    [bs].[backup_finish_date], 
    [bs].Server_name,
    [bs].user_name AS [BackupCreator] ,
    [bmf].physical_device_name
FROM msdb..backupset bs  
INNER JOIN msdb..backupmediafamily bmf ON [bs].[media_set_id] = [bmf].[media_set_id] 
ORDER BY [bs].[backup_start_date] DESC 


select * from sys.dm_os_sys_info

SELECT *
FROM sys.traces 
WHERE id = 1
