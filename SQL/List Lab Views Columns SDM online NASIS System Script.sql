USE sdmONLINE;

SELECT TABLE_CATALOG, TABLE_SCHEMA ,/*,
CONCAT ('WHEN tablab = ', QuoteName (TABLE_NAME, '''') , 'AND collab = ' , QuoteName (COLUMN_NAME, '''') , ' THEN ' , QuoteName ('Yes', ''''))  AS nasis_script,
CONCAT ('WHEN attlabel = ', QuoteName (COLUMN_NAME, '''') , ' AND attlogdattyp != ' , QuoteName (CASE WHEN DATA_TYPE = 'bit' THEN 'Boolean'
 WHEN DATA_TYPE = 'datetime' THEN 'datetime'
 WHEN DATA_TYPE = 'decimal' THEN 'float'
 WHEN DATA_TYPE = 'float' THEN 'float'
WHEN DATA_TYPE = 'geometry' THEN 'esri geometry - point'
 WHEN DATA_TYPE = 'int' THEN 'integer'
 WHEN DATA_TYPE = 'numeric' THEN 'integer'
 WHEN DATA_TYPE = 'nvarchar' THEN 'string'
 WHEN DATA_TYPE = 'real' THEN 'float'
 WHEN DATA_TYPE = 'smallint' THEN 'integer'
 WHEN DATA_TYPE = 'tinyint' THEN 'integer'
 WHEN DATA_TYPE = 'uniqueidentifier' THEN 'unknown'
 WHEN DATA_TYPE = 'varchar' THEN 'string' END


, '''') , ' THEN ' , QuoteName (CASE WHEN DATA_TYPE = 'bit' THEN 'Boolean'
 WHEN DATA_TYPE = 'datetime' THEN 'datetime'
 WHEN DATA_TYPE = 'decimal' THEN 'float'
 WHEN DATA_TYPE = 'float' THEN 'float'
WHEN DATA_TYPE = 'geometry' THEN 'esri geometry - point'
 WHEN DATA_TYPE = 'int' THEN 'integer'
 WHEN DATA_TYPE = 'numeric' THEN 'integer'
 WHEN DATA_TYPE = 'nvarchar' THEN 'string'
 WHEN DATA_TYPE = 'real' THEN 'float'
 WHEN DATA_TYPE = 'smallint' THEN 'integer'
 WHEN DATA_TYPE = 'tinyint' THEN 'integer'
 WHEN DATA_TYPE = 'uniqueidentifier' THEN 'unknown'
 WHEN DATA_TYPE = 'varchar' THEN 'string' END, ''''))  AS nasis_script2,
 CONCAT ('WHEN attlabel = ' , QuoteName (COLUMN_NAME, '''') , ' THEN  "X"' )  AS nasis_script3,*/
 *
FROM sdmONLINE.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME LIKE 'lab%'    ORDER BY COLUMN_NAME ;
