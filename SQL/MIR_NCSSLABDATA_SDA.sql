SET QUOTED_IDENTIFIER  ON 
USE ncsslabdata;
SELECT TOP 100

 l.[labsampnum]
      ,[result_source_key]
      ,[prep_code]
	  ,cnn.[pedon_key]
      ,cnn.[site_key]
      ,p.[pedlabsampnum]
      ,[project_key]
       ,[hzn_top]
      ,[hzn_bot]
      ,[hzn_desgn]
	  ,[upedonid]
  
      ,CASE WHEN [corr_name] IS NULL THEN [samp_name] ELSE [corr_name] END AS soil_name
      ,CASE WHEN [corr_class_type] IS NULL THEN [samp_class_type] ELSE [corr_class_type] END AS class_type
  
      ,CASE WHEN [corr_classification_name] IS NULL THEN [samp_classification_name] ELSE [corr_classification_name]  END AS [classification_name] 
 
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
      ,[pedobjupdate]


      ,[caco3_lt_2_mm]
      ,[caco3_lt_2_mm_method]
     ,[estimated_organic_carbon]
     ,CASE WHEN [estimated_organic_carbon] IS NOT NULL THEN LEFT (ROUND ([estimated_organic_carbon]* 1.724, 2),4)
       WHEN [estimated_organic_carbon] IS NULL AND [caco3_lt_2_mm] IS NOT NULL THEN LEFT (ROUND (([total_carbon_ncs]- ([caco3_lt_2_mm]*0.12))* 1.724, 2),4)
       WHEN [estimated_organic_carbon] IS NULL AND [caco3_lt_2_mm] IS NULL THEN LEFT (ROUND ([total_carbon_ncs]* 1.724,2),4) END AS [estimated_organic_matter]
, (SELECT TOP 1 [texture_lab]
FROM [lab_physical_properties] AS lpp WHERE lpp.labsampnum=l.labsampnum AND [texture_lab] IS NOT NULL) AS [lab_texture]

    
      ,[total_carbon_ncs]
      ,[total_carbon_ncs_method]
	 , [smp_id]
      ,[lab_proj_name]
      ,[filename]
      ,[absorbance]
      ,[rep_num]
      ,[id]
      ,[d_wavelength_array_id]
 ,[description]
      ,[wavelength_string]
   
FROM  [lab_pedon] AS p 
LEFT OUTER JOIN [lab_combine_nasis_ncss] AS cnn ON p.pedon_key=cnn.pedon_key -- AND [upedonid] LIKE '%WI%'
INNER JOIN [lab_layer] AS l ON l.pedon_key=p.pedon_key AND hzn_top = 0 AND [hzn_desgn] LIKE '%A%'
INNER JOIN [lab_chemical_properties_vw] AS lcp ON lcp.labsampnum=l.labsampnum 
INNER JOIN (SELECT [area_code] AS country_code,[area_name] AS country_name, area_key FROM lab_area -- Country
) AS c ON cnn.[country_key]=c.area_key
INNER JOIN  (SELECT [area_code] AS state_code,[area_name] AS state_name, area_key FROM lab_area --State
WHERE [area_code]  = 'NE' ) AS s ON cnn.[state_key]=s.area_key 
 
INNER JOIN  (SELECT [area_code] AS county_code,[area_name] AS county_name, area_key FROM lab_area --County
) AS ct ON cnn.[county_key]=ct.area_key
 
INNER JOIN  (SELECT [area_code] AS mlra_code,[area_name] AS mlra_name, area_key FROM lab_area --MLRA
) AS m ON cnn.[mlra_key]=m.area_key
INNER JOIN (SELECT [area_code] AS ssa_code,[area_name] AS ssa_name, area_key FROM lab_area --SSA
) AS ss ON cnn.[ssa_key]=ss.area_key
INNER JOIN lab_mir_vw AS m2 ON m2.layer_key=l.layer_key
INNER JOIN [d_mir_wavelength_string] AS w ON w.[array_id]=m2.[d_wavelength_array_id]
 