/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [result_key]
      ,[result_source_key]
      ,[prep_key]
      ,[result_type]
      ,[result_reliability]
      ,[analyte_key]
      ,[procedure_key]
      ,[source_system_key]
      ,[result_value]
      ,[prep_code]
      ,[proced_code]
	  , IIF(
TRY_CAST([result_value] AS NUMERIC) IS NULL,  1, 2 ) AS test
  FROM [ncsslabdata].[dbo].[result_light] WHERE  IIF(
TRY_CAST([result_value] AS NUMERIC) IS NULL,  1, 2 ) = 1