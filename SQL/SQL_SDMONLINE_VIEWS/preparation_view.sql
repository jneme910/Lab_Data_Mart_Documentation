  CREATE VIEW [dbo].[preparation] AS [preparation]
SELECT [prep_key]
      ,[prep_code]
      ,[prep_abbrev]
      ,[moisture_state]
      ,[orig_size_frac]
      ,[final_size_frac]
      ,[prep_desc]
      ,[prep_rpt_sort_order]
	   FROM [ncsslabdata].[dbo].[preparation]
GO
