CREATE PROCEDURE [dbo].[drop_database] @servidor_in varchar(max), @tipo_con_in varchar(max) ,@database_name varchar(max)
AS
declare @servidor varchar(max)
set @servidor=convert(varchar(max),(@@SERVERNAME));/*validando instancia*/

declare @tipo_con varchar(max)
set @tipo_con=(SELECT c.net_transport FROM sys.dm_exec_connections AS c JOIN sys.dm_exec_sessions AS s ON c.session_id = s.session_id WHERE c.session_id = @@SPID);/*validando tipo de conexion*/

if @servidor=@servidor_in and @tipo_con=@tipo_con_in
     begin
       declare @drop varchar(max)=(select CONCAT('drop database ', @database_name))
        exec (@drop)
        PRINT 'Base de datos eliminada'
      end  
     else
       begin
        PRINT 'No puedes eliminar la BD, valida los datos que ingresaste, es una conexión remota'
     end
       ;
GO

 

  Use master
   go
  exec drop_database '<nombre de instancia>','Shared Memory','<nombre de BD>'
