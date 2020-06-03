SELECT 
    CONCAT ('[', c.name, ']') AS column_name, 
    CONCAT ('[',t.Name ,']')  AS Data_type,

    --c.max_length  AS Max_Length,
	CASE WHEN t.Name = 'int' THEN ''
	WHEN t.Name = 'varchar' THEN CONCAT ('(',  c.max_length, ')')
	WHEN t.Name = 'decimal' THEN CONCAT ('(10,',  c.max_length, ')') END AS Max_Length, 
	CASE WHEN c.is_nullable = 0 THEN 'NOT NULL' ELSE 'NULL' END AS is_nullable 
	
   -- c.precision ,
   -- c.scale ,
    --c.is_nullable,
   -- ISNULL(i.is_primary_key, 0) 'Primary Key'
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE
    c.object_id = OBJECT_ID('lab_mineralogy_glass_count')