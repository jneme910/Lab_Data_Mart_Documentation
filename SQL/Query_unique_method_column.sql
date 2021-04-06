/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT /*TOP (1000) [labsampnum]
      ,[result_source_key]
      ,[prep_code]
   
      ,[carbon_sodium_pyro_phospate]*/
      --,
	  [c_na_pyro_phosphate_method]
     
  FROM [ncsslabdata].[dbo].[lab_chemical_properties] WHERE carbon_sodium_pyro_phospate IS NOT NULL
