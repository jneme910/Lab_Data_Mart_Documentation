CREATE VIEW [dbo].[pedon] AS [pedon]
SELECT [pedon_key]
      ,[natural_key] AS  [pedlabsampnum]
      ,[observation_date]
      ,[user_pedon_id]
      ,[pedon_seq_num]
      ,[cntrl_depth_to_top]
      ,[cntrl_depth_to_bot]
      ,[fldsyb]
      ,[mapsyb]
      ,[site_key]
	   FROM [ncsslabdata].[dbo].[pedon]
GO
