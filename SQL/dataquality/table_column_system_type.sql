SELECT OBJECT_SCHEMA_NAME(T.object_id) AS schema__name
    , T.name AS table__name
    , C.name AS column__name
    , C.is_identity
    , Y.name AS data__type
    , C.is_nullable
    , C.max_length
    , C.precision
    , C.scale
    , C.collation_name
    , Y.is_user_defined        
    , C.is_ansi_padded
    , C.is_rowguidcol
    , C.is_computed    
FROM sys.tables T 
    INNER JOIN sys.columns C 
        ON T.object_id = C.object_id
    INNER JOIN sys.types Y 
        ON C.system_type_id = Y.system_type_id 
            AND C.user_type_id = Y.user_type_id
--WHERE --T.name = ''
ORDER BY C.column_id;