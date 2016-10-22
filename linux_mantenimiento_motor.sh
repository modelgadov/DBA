export ORACLE_SID=DESA
export ORACLE_HOME=/du05/ebsR12desa/db/tech_st/11.2.0
export PATH=$ORACLE_HOME/bin:$PATH
export NOMBRE_LOG_ANTES_TRACE=/tmp/DBA_logs_DESA/borrado_antes_trace_$ORACLE_SID-$(hostname)_$(date +%Y%m%d_%Hh_%Mm).log
export NOMBRE_LOG_ANTES_ALERT=/tmp/DBA_logs_DESA/borrado_antes_alert_$ORACLE_SID-$(hostname)_$(date +%Y%m%d_%Hh_%Mm).log
export NOMBRE_LOG_DESPUES_TRACE=/tmp/DBA_logs_DESA/borrado_despues_trace_$ORACLE_SID-$(hostname)_$(date +%Y%m%d_%Hh_%Mm).log
export NOMBRE_LOG_DESPUES_ALERT=/tmp/DBA_logs_DESA/borrado_despues__$ORACLE_SID-$(hostname)_$(date +%Y%m%d_%Hh_%Mm).log

ls -ltr /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/trace/ | tee -a $NOMBRE_LOG_ANTES_TRACE
ls -ltr /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/alert/ | tee -a $NOMBRE_LOG_ANTES_ALERT 

find /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/trace/*.trc -mtime +7 -exec rm {} \;
find /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/trace/*.trm -mtime +7 -exec rm {} \;
find /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/alert/*_xml -mtime +7 -exec rm {} \;

ls -ltr /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/trace/ | tee -a $NOMBRE_LOG_DESPUES_TRACE
ls -ltr /du05/ebsR12desa/db/tech_st/11.2.0/admin/DESA_gmporc21/diag/rdbms/desa/DESA/alert/ | tee -a $NOMBRE_LOG_DESPUES_ALERT 
