select @@SERVERNAME
select @@SERVICENAME
select SERVERPROPERTY('computernamephysicalnetbios')
select HOST_NAME()

select @@VERSION

SELECT CONVERT (varchar, SERVERPROPERTY('collation'));

EXECUTE sp_helpsort;

RESTORE HEADERONLY 
FROM DISK = N'C:\AdventureWorks-FullBackup.bak' 
WITH NOUNLOAD;


RESTORE DATABASE AdventureWorks2012
WITH RECOVERY

USE AdventureWorks2012;  
GO  
EXEC sp_spaceused N'Purchasing.Vendor';  
GO  

use msdb
go
select * from sysmail_sentitems ----- correos enviados database mail


SELECT name AS object_name 
  ,SCHEMA_NAME(schema_id) AS schema_name
  ,type_desc
  ,create_date
  ,modify_date
FROM sys.objects
WHERE modify_date > GETDATE() - 10
ORDER BY modify_date;

-----Status del database mirroring
SELECT
DB_NAME(database_id) As DatabaseName,
CASE WHEN mirroring_guid IS NOT NULL THEN 'Mirroring is On' ELSE 'No mirror configured' END AS IsMirrorOn,
mirroring_state_desc,
CASE WHEN mirroring_safety_level=1 THEN 'High Performance' WHEN mirroring_safety_level=2 THEN 'High Safety' ELSE NULL END AS MirrorSafety,
mirroring_role_desc,
mirroring_partner_instance AS MirrorServer
FROM sys.database_mirroring
