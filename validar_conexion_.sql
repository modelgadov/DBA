alter PROCEDURE [dbo].[validar_conexion] @servidor_in varchar(max), @database_name varchar(max)
AS
declare @servidor varchar(max)
set @servidor=convert(varchar(max),(@@SERVERNAME));/*validando instancia*/

declare @tipo_con varchar(max)
set @tipo_con=(SELECT c.net_transport FROM sys.dm_exec_connections AS c JOIN sys.dm_exec_sessions AS s ON c.session_id = s.session_id WHERE c.session_id = @@SPID);/*validando tipo de conexion*/
declare @database int
set @database =(select count(name) from sys.databases where name=@database_name);

if @servidor=@servidor_in and @tipo_con='Shared Memory' and @database>0
     begin       
           
        PRINT 'Conexion local sobre el servidor: ' + @servidor

      end  
     else
       if @servidor=@servidor_in and @tipo_con<>'Shared Memory' and @database>0
       begin     
        PRINT 'Conexion remota sobre el servidor: ' + @servidor
     end
       else
            PRINT 'Validar datos ingresados'
       ;
GO

  Ejecución:

exec validar_conexion '<nombre de instancia','<nombre de BD>'
