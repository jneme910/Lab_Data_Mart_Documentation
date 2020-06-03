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
WHERE T.name IN ('analyte', 'pedon', 'lab_analysis_procedure', 'lab_Calculations_Including_Estimates_And_Default_Values', 'lab_Chemical_Properties', 'lab_Major_And_Trace_Elements_And_Oxides', 'lab_method_code',  'lab_Mineralogy_Glass_Count', 'lab_Physical_Properties',  'lab_webmap', 'lab_XRay_And_Thermal', 'site', 'rosetta', 'combine_nasis_ncss', 'preparation', 'layer' )
ORDER BY C.column_id;