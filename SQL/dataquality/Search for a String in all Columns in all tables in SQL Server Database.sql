/****** Script for SelectTopNRows command from SSMS  ******/
SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
USE nasis
GO

Declare @SearchString VARCHAR(100)
--Provide the String here. I am using Aamir for search
SET @SearchString='7.4.1'
DECLARE @DatabaseName VARCHAR(100)
DECLARE @SchemaName VARCHAR(100)
DECLARE @TableName VARCHAR(100)
DECLARE @ColumnName VARCHAR(100)
DECLARE @FullyQualifiedTableName VARCHAR(500)
Declare @DataType VARCHAR(50)

--Create Temp Table to Save Results
IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results

CREATE TABLE #Results (
    DatabaseName VARCHAR(100)
    ,SchemaName VARCHAR(100)
    ,TableName VARCHAR(100)
    ,ColumnName VARCHAR(100)
    ,ColumnDataType VARCHAR(50)
    ,TotalTableRowCount INT
    ,StringOccuranceRecordCount INT
    )

DECLARE Cur CURSOR
FOR
SELECT C.Table_CataLog
    ,C.Table_Schema
    ,C.Table_Name
    ,C.Column_Name
    ,'[' + C.Table_CataLog + ']' + '.[' + C.Table_Schema + '].' 
    + '[' + C.Table_Name + ']' AS FullQualifiedTableName,
    C.Data_Type
FROM information_schema.Columns C
INNER JOIN information_Schema.Tables T ON C.Table_Name = T.Table_Name
    AND T.Table_Type LIKE '%'
    and (C.Data_Type like '%CHAR%'
    or C.Data_Type like '%Text%')


OPEN Cur
FETCH NEXT
FROM Cur
INTO @DatabaseName
    ,@SchemaName
    ,@TableName
    ,@ColumnName
    ,@FullyQualifiedTableName
    ,@DataType

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @SQL VARCHAR(MAX) = NULL
    SET @SQL = ' Select ''' + @DatabaseName + ''' AS DatabaseName, ''' 
    + @SchemaName + ''' AS TableName,
      ''' + @TableName + ''' AS SchemaName,
      ''' + @ColumnName + ''' AS ColumnName,
      ''' + @DataType + ''' AS ColumnName,
      (Select count(*) from ' + @FullyQualifiedTableName + ' With (Nolock)) 
      AS TotalTableRowCount,
      count(*) as StringOccuranceRecordCount from ' + @FullyQualifiedTableName 
      + 'With (Nolock) Where  '+@ColumnName+' like '''+'%'+ @SearchString+'%'''

   -- Print @SQL
    INSERT INTO #Results
    EXEC (@SQL)

    FETCH NEXT
    FROM Cur
    INTO @DatabaseName
        ,@SchemaName
        ,@TableName
        ,@ColumnName
        ,@FullyQualifiedTableName
        ,@DataType
END
CLOSE Cur
DEALLOCATE Cur

SELECT *,
Cast((StringOccuranceRecordCount/Cast(TotalTableRowCount as Numeric(13,1)))*100 
AS Numeric(4,1)) AS StringOccurancePercentPerColumn
from #Results
Where StringOccuranceRecordCount<>0
--drop table #Results