DECLARE @lab_table_name VARCHAR(60)
SET @lab_table_name =  'lab_physical_properties';


/*
SELECT --TABLE_CATALOG, TABLE_SCHEMA,

TABLE_NAME, COLUMN_NAME, * --, COLUMN_DEFAULT
FROM sdmONLINE.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @lab_table_name

*/


DECLARE 
    @FullQuery nvarchar(max),
    @Columns nvarchar(max),
    @ObjectName nvarchar(128)

-- Build our SELECT statment and schema+table name
SELECT 
    @Columns = COALESCE(@Columns + ', ', '') + '[' + @lab_table_name + '].' + '[' + c.[Column_Name] + ']'
  
FROM 
sdmONLINE.INFORMATION_SCHEMA.COLUMNS AS c 
WHERE 
    TABLE_NAME = @lab_table_name


-- Put all of the pieces together an execute
SET @FullQuery = 'SELECT ' + @Columns + ' FROM ' + @lab_table_name --+ ' AS s INNER JOIN @b AS b ON b.labsampnum=s.labsampnum'

EXEC(@FullQuery)