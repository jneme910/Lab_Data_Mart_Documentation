CREATE VIEW [dbo].[rosetta_key] AS rosetta
SELECT [rosetta_key] AS [result_source_key]
      ,[layer_key]
      ,[theta_r]
      ,[theta_s]
      ,[alpha]
      ,[npar]
      ,[usedmodel]
      ,[wlupdated]
      ,[Ks]
      ,[Ko]
      ,[Lpar]
  FROM [ncsslabdata].[dbo].[rosetta]
	   GO