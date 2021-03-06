/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT --SUM (CASE WHEN [result_value] NOT LIKE '%.%' THEN 1 ELSE 0 END) AS INT_COUNT,
--(CASE WHEN [result_value] LIKE  '%.%' THEN 1 ELSE 0  END)  AS DECIMAL_COUNT,

--SUM (CASE WHEN [result_value] NOT LIKE '%.%' THEN 1 ELSE 0 END) over(partition by analyte_key) AS INT_COUNT, 
--SUM (CASE WHEN [result_value]  LIKE '%.%' THEN 1 ELSE 0 END) over(partition by analyte_key) AS DECIMAL_COUNT, 
--CASE WHEN SUM (CASE WHEN [result_value] NOT LIKE '%.%' THEN 1 ELSE 0 END) over(partition by analyte_key) >= SUM (CASE WHEN [result_value]  LIKE '%.%' THEN 1 ELSE 0 END) over(partition by --analyte_key) THEN 'TRUE' ELSE 'FALSE' END AS INT_GREATER,
COUNT ([result_source_key]) AS count_analyte,
--result_source_key,
 analyte_key --,
-- [result_key]
    --  ,[result_source_key]
     ---- ,[prep_key]
    --  ,[result_type]
     -- ,[result_reliability]
--,[analyte_key]
     -- ,[procedure_key]
    --  ,[source_system_key]
    --  [result_value]
    --  ,[prep_code]
     -- ,[proced_code]
	--, TRY_PARSE( [result_value] AS NUMERIC(10,2) USING 'El-GR' ) AS test
	--,IIF( TRY_PARSE ([result_value] AS NUMERIC) IS NULL,  'True', 'False' ) AS test2
  FROM [ncsslabdata].[EDC\pnemej01].[result_light_chem] WITH (NOLOCK)
 -- WHERE  
  
  --WHERE [result_value] NOT LIKE '%.%'
  
   WHERE IIF( TRY_PARSE ([result_value] AS NUMERIC) IS NULL,  'True', 'False' ) = 'True'

  GROUP BY [analyte_key]