DECLARE @results TABLE (
    ID VARCHAR(36)
    ,TableName VARCHAR(250)
    ,ColumnName VARCHAR(250)
    ,DataType VARCHAR(250)
    ,MaxLength INT
    ,Longest INT
    ,Min VARCHAR(250)
    ,Max VARCHAR(250)
    ,NullCount BIGINT
    ,CountDistinct BIGINT
    ,SQLText VARCHAR(MAX)
    )

INSERT INTO @results (
    ID
    ,TableName
    ,ColumnName
    ,DataType
    ,MaxLength
    ,SQLText
    )
SELECT NEWID() AS ID
    ,Object_Name(c.object_id) AS TableName
    ,c.name AS ColumnName
    ,t.name AS DataType
    ,CASE 
        WHEN t.name NOT IN (
                'char'
                ,'varchar'
                ,'nchar'
                ,'nvarchar'
                ,'sysname'
                ,'text'
                )
            THEN c.max_length
        WHEN c.max_length = - 1
            THEN c.max_length
        ELSE CASE 
                WHEN t.name IN (
                        'nchar'
                        ,'nvarchar'
                        ,'sysname'
                        )
                    THEN c.max_length / 2
                ELSE c.max_length
                END
        END AS MaxLength
    ,'SELECT Max(Len(' + CASE t.name
        WHEN 'text'
            THEN 'cast('
        ELSE ''
        END + '[' + c.name + ']' + CASE t.name
        WHEN 'text'
            THEN ' as varchar(max))'
        ELSE ''
        END + ')) AS MaxLength,
        Min(' + CASE t.name
        WHEN 'bit'
            THEN 'CONVERT(int,'
        WHEN 'text'
            THEN 'cast('
        ELSE ''
        END + '[' + c.name + ']' + CASE t.name
        WHEN 'bit'
            THEN ')'
        WHEN 'text'
            THEN ' as varchar(max))'
        ELSE ''
        END + ') AS Min,
        Max(' + CASE t.name
        WHEN 'bit'
            THEN 'CONVERT(int,'
        WHEN 'text'
            THEN 'cast('
        ELSE ''
        END + '[' + c.name + ']' + CASE t.name
        WHEN 'bit'
            THEN ')'
        WHEN 'text'
            THEN ' as varchar(max))'
        ELSE ''
        END + ') AS Max, sum(case when ' + '[' + c.name + ']' + ' is null then 1 else 0 end) AS  NullCount, 
        COUNT_BIG(DISTINCT ' + CASE t.name
        WHEN 'text'
            THEN 'cast('
        ELSE ''
        END + '[' + c.name + ']' + CASE t.name
        WHEN 'text'
            THEN ' as varchar(max))'
        ELSE ''
        END + ') AS CountDistinct 
        FROM [' + OBJECT_SCHEMA_NAME(c.object_id) + '].[' + Object_Name(c.object_id) + ']' AS SQLText
FROM sys.columns c
INNER JOIN sys.types t ON c.system_type_id = t.system_type_id
INNER JOIN sys.objects o ON c.object_id = o.object_id
WHERE o.type = 'U'

DECLARE @id VARCHAR(36)
DECLARE @SQL VARCHAR(MAX)
DECLARE @receiver TABLE (
    Longest INT
    ,Min VARCHAR(250)
    ,Max VARCHAR(250)
    ,NullCount BIGINT
    ,CountDistinct BIGINT
    )

DECLARE length_cursor CURSOR
FOR
SELECT ID
    ,SQLText
FROM @results

OPEN length_cursor

FETCH NEXT
FROM length_cursor
INTO @id
    ,@SQL

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @receiver (
        Longest
        ,Min
        ,Max
        ,NullCount
        ,CountDistinct
        )
    EXEC (@SQL)

    UPDATE @results
    SET Longest = r.Longest
        ,Min = r.Min
        ,Max = r.Max
        ,NullCount = r.NullCount
        ,CountDistinct = r.CountDistinct
    FROM @receiver r
    WHERE ID = @id

    DELETE
    FROM @receiver

    FETCH NEXT
    FROM length_cursor
    INTO @id
        ,@SQL
END

CLOSE length_cursor

DEALLOCATE length_cursor

SELECT TableName
    ,ColumnName
    ,DataType
    ,MaxLength
    ,Longest
    ,Min
    ,Max
    ,NullCount
    ,CountDistinct
FROM @results WHERE TableName IN  ('analyte', 'pedon', 'SDA_analysis_procedure', 'SDA_Calculations_Including_Estimates_And_Default_Values', 'SDA_Chemical_Properties', 'SDA_Major_And_Trace_Elements_And_Oxides', 'SDA_method_code',  'SDA_Mineralogy_Glass_Count', 'SDA_Physical_Properties',  'SDA_webmap', 'SDA_XRay_And_Thermal', 'site', 'rosetta', 'combine_nasis_ncss', 'preparation', 'layer'  )