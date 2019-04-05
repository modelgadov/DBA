SELECT 
    X.[name], 
    REPLACE(CONVERT(varchar, CONVERT(money, X.[rows]), 1), '.00', '') 
        AS [rows], 
    REPLACE(CONVERT(varchar, CONVERT(money, X.[reserved]), 1), '.00', '') 
        AS [reserved], 
    REPLACE(CONVERT(varchar, CONVERT(money, X.[data]), 1), '.00', '') 
        AS [data], 
    REPLACE(CONVERT(varchar, CONVERT(money, X.[index_size]), 1), '.00', '') 
        AS [index_size], 
    REPLACE(CONVERT(varchar, CONVERT(money, X.[unused]), 1), '.00', '') 
        AS [unused] 
FROM 
(SELECT 
    CAST(object_name(id) AS varchar(50)) 
        AS [name], 
    SUM(CASE WHEN indid < 2 THEN CONVERT(bigint, [rows]) END) 
        AS [rows],
    SUM(CONVERT(bigint, reserved)) * 8 
        AS reserved, 
    SUM(CONVERT(bigint, dpages)) * 8 
        AS data, 
    SUM(CONVERT(bigint, used) - CONVERT(bigint, dpages)) * 8 
        AS index_size, 
    SUM(CONVERT(bigint, reserved) - CONVERT(bigint, used)) * 8 
        AS unused 
    FROM sysindexes WITH (NOLOCK) 
    WHERE sysindexes.indid IN (0, 1, 255) 
        AND sysindexes.id > 100 
        AND object_name(sysindexes.id) <> 'dtproperties' 
    GROUP BY sysindexes.id WITH ROLLUP
) AS X
WHERE X.[name] is not null
ORDER BY X.[rows] DESC

        
############################### ver tamaño tablas SQL Server , esquema,numfilas espacio libre y total #####################################
        
        
        SELECT 
        t.NAME AS NombreTabla,
        s.Name AS Esquema,
        p.rows AS NumFilas,
        SUM(a.total_pages) * 8 AS EspacioTotal_KB, 
        SUM(a.used_pages) * 8 AS EspacioUsado_KB, 
        (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS EspacioNoUsado_KB
FROM 
        sys.tables t
INNER JOIN      
        sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
        sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
        sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
        sys.schemas s ON t.schema_id = s.schema_id
WHERE 
        t.NAME NOT LIKE 'dt%' 
        AND t.is_ms_shipped = 0
        AND i.OBJECT_ID > 255 
GROUP BY 
        t.Name, s.Name, p.Rows
ORDER BY 
        EspacioUsado_KB desc 
