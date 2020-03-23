DECLARE @cmd NVARCHAR(MAX)=
(
    SELECT STUFF(
    (
            SELECT ' UNION ALL SELECT ''' + c.TABLE_SCHEMA + ''' AS TableSchema '
                 + ',''' + c.TABLE_NAME + ''' AS TableName '
                 + ',''' + c.COLUMN_NAME + ''' AS ColumnName '
                 + ',''' + c.DATA_TYPE + ''' AS ColumnType '
                 + ',CAST(MIN(' + QUOTENAME(c.COLUMN_NAME)+') AS NVARCHAR(MAX)) AS MinValue ' 
                 + ',CAST(MAX(' + QUOTENAME(c.COLUMN_NAME)+') AS NVARCHAR(MAX)) AS MaxValue ' 
                 + ' FROM ' + QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)
                 + ' WHERE ' + QUOTENAME(c.COLUMN_NAME) + ' IS NOT NULL'
            FROM INFORMATION_SCHEMA.COLUMNS AS c
            WHERE  c.TABLE_NAME IN  ('analyte', 'pedon', 'SDA_analysis_procedure', 'SDA_Calculations_Including_Estimates_And_Default_Values', 'SDA_Chemical_Properties', 'SDA_Major_And_Trace_Elements_And_Oxides', 'SDA_method_code',  'SDA_Mineralogy_Glass_Count', 'SDA_Physical_Properties',  'SDA_webmap', 'SDA_XRay_And_Thermal', 'site', 'rosetta', 'combine_nasis_ncss', 'preparation', 'layer'  )
			
			
			 AND c.DATA_TYPE IN('bigint','float','int','datetime', 'decimal' , 'float',   'int', 'numeric',  'nvarchar', 'real', 'smallint', 'tinyint')  --add all types you want to check, be aware of implicit conversions!
            FOR XML PATH(''),TYPE
    ).value('.','nvarchar(max)'),1,10,'')
);
--PRINT @cmd
EXEC(@cmd);