SELECT 
cnn.[pedon_key]
      ,cnn.[site_key]
      ,[pedlabsampnum]
      ,[project_key]


      ,[layer_field_label_1]
      ,[hzn_top]
      ,[hzn_bot]
	  , CASE  WHEN [hzn_top] <	15 then [hzn_top] ELSE 0 END AS InRangeTop_0_15 
	  ,CASE  WHEN [hzn_bot] <= 15 THEN [hzn_bot] WHEN [hzn_bot] > 15 and [hzn_top] < 15 THEN 15 ELSE 0 END AS InRangeBot_0_15
     -- ,[hzn_desgn_old]
      ,[hzn_desgn]
    --  ,[hzn_discontinuity]
    --  ,[hzn_master]
    --  ,[hzn_prime]
    --  ,[hzn_vert_subdvn]
    --  ,[hzn_desgn_other]
    --  ,[non_hzn_desgn]
    --  ,[stratified_textures_flag]
      ,[pedoniid]
      ,[upedonid]
    --  ,[labdatadescflag]
    --  ,[priority]
    --  ,[priority2]
   --   ,[samp_name]
   --   ,[samp_class_type]
  --    ,[samp_classdate]
  --    ,[samp_classification_name]
  --    ,[samp_taxorder]
  --    ,[samp_taxsuborder]
  --    ,[samp_taxgrtgroup]
  --    ,[samp_taxsubgrp]
   --   ,[samp_taxpartsize]
   --   ,[samp_taxpartsizemod]
   --   ,[samp_taxceactcl]
   --   ,[samp_taxreaction]
  --    ,[samp_taxtempcl]
  --    ,[samp_taxmoistscl]
  --    ,[samp_taxtempregime]
  --    ,[samp_taxminalogy]
  --    ,[samp_taxother]
  --    ,[samp_osdtypelocflag]
      ,CASE WHEN [corr_name] IS NULL THEN [samp_name] ELSE [corr_name] END AS soil_name
      ,CASE WHEN [corr_class_type] IS NULL THEN [samp_class_type] ELSE [corr_class_type] END AS class_type
   --   ,[corr_classdate]
      ,CASE WHEN [corr_classification_name] IS NULL THEN [samp_classification_name] ELSE [corr_classification_name]  END AS [classification_name] 
  --    ,[corr_taxorder]
   --   ,[corr_taxsuborder]
   --   ,[corr_taxgrtgroup]
   --   ,[corr_taxsubgrp]
    --  ,[corr_taxpartsize]
    --  ,[corr_taxpartsizemod]
   --   ,[corr_taxceactcl]
   --   ,[corr_taxreaction]
   --   ,[corr_taxtempcl]
   --   ,[corr_taxmoistscl]
    --  ,[corr_taxtempregime]
    --  ,[corr_taxminalogy]
    --  ,[corr_taxother]
    --  ,[corr_osdtypelocflag]
    --  ,[SSL_name]
   --   ,[SSL_class_type]
   --   ,[SSL_classdate]
   --   ,[SSL_classification_name]
   --   ,[SSL_taxorder]
   --   ,[SSL_taxsuborder]
    --  ,[SSL_taxgrtgroup]
    --  ,[SSL_taxsubgrp]
    --  ,[SSL_taxpartsize]
   --   ,[SSL_taxpartsizemod]
   --   ,[SSL_taxceactcl]
   --   ,[SSL_taxreaction]
   --   ,[SSL_taxtempcl]
    --  ,[SSL_taxmoistscl]
   --   ,[SSL_taxtempregime]
   --   ,[SSL_taxminalogy]
   --   ,[SSL_taxother]
   --   ,[SSL_osdtypelocflag]
      ,[siteiid]
      ,[usiteid]
      ,[site_obsdate]
      ,[latitude_decimal_degrees]
      ,[longitude_decimal_degrees]
      ,country_code
	  ,country_name
	 , state_code
	 , state_name
	  , county_code
	 , county_name
	 , mlra_code
	, mlra_name
	, ssa_code
	, ssa_name
        ,[note]
  --    ,[samp_taxfamhahatmatcl]
   --   ,[corr_taxfamhahatmatcl]
  --    ,[SSL_taxfamhahatmatcl]
      ,[pedobjupdate]
      ,[siteobjupdate]
  --     ,[labsampnum]
  --    ,[result_source_key]
      ,[prep_code]
      ,[labsampnum]
      ,[total_carbon_ncs]
      ,[total_carbon_ncs_method]
      ,[caco3_lt_2_mm]
      ,[caco3_lt_2_mm_method]
      ,[estimated_organic_carbon]
     ,CASE WHEN [estimated_organic_carbon] IS NOT NULL THEN LEFT (ROUND ([estimated_organic_carbon]* 1.724, 2),4)
	 WHEN [estimated_organic_carbon] IS NULL AND [caco3_lt_2_mm] IS NOT NULL THEN LEFT (ROUND (([total_carbon_ncs]- ([caco3_lt_2_mm]*0.12))* 1.724, 2),4)
	 WHEN [estimated_organic_carbon] IS NULL AND [caco3_lt_2_mm] IS NULL THEN LEFT (ROUND ([total_carbon_ncs]* 1.724,2),4) END AS [estimated_organic_matter]
, (SELECT TOP 1 [texture_lab]
FROM [lab_physical_properties] AS lpp WHERE lpp.labsampnum=l.natural_key AND [texture_lab] IS NOT NULL) AS [lab_texture]
FROM [ncsslabdata].[dbo].[combine_nasis_ncss] AS cnn
INNER JOIN [ncsslabdata].[dbo].[pedon] AS p ON p.pedon_key=cnn.pedon_key --AND [upedonid] LIKE '%WI%'
INNER JOIN [ncsslabdata].[dbo].[layer] AS l ON l.pedon_key=p.pedon_key AND ([hzn_top] <= 15 AND [hzn_desgn] NOT LIKE '%O%')
INNER JOIN [ncsslabdata].[dbo].[lab_chemical_properties] AS lcp ON lcp.labsampnum=l.natural_key AND [total_carbon_ncs] IS NOT NULL
INNER JOIN (SELECT [area_code] AS country_code,[area_name] AS country_name, area_key FROM area -- Country
) AS c ON cnn.[country_key]=c.area_key
INNER JOIN  (SELECT [area_code] AS state_code,[area_name] AS state_name, area_key FROM area --State
WHERE [area_code] = 'WI') AS s ON cnn.[state_key]=s.area_key 

INNER JOIN (SELECT [area_code] AS county_code,[area_name] AS county_name, area_key FROM area --County
) AS ct ON cnn.[county_key]=ct.area_key

INNER JOIN (SELECT [area_code] AS mlra_code,[area_name] AS mlra_name, area_key FROM area --MLRA
) AS m ON cnn.[mlra_key]=m.area_key
INNER JOIN (SELECT [area_code] AS ssa_code,[area_name] AS ssa_name, area_key FROM area --SSA
) AS ss ON cnn.[ssa_key]=ss.area_key


;
