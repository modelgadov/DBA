select * from (select user_seeks * avg_total_user_cost *(avg_user_impact * 0.01) as index_advantage, migs.* from 
sys.dm_db_missing_index_group_stats migs) as migs_adv join sys.dm_db_missing_index_groups as mig on migs_adv.group_handle
= mig.index_group_handle join sys.dm_db_missing_index_details as mid on mig.index_handle =mid.index_handle
order by migs_adv.index_advantage
