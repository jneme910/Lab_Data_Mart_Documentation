SET STATISTICS IO ON 

USE sdmONLINE
go

DROP TABLE IF EXISTS #temp_geochem_map1;

DECLARE @state_sym VARCHAR(5);



--~DeclareChar(@state_sym,20)~  -- Used for Soil Data Access

SELECT @state_sym = 'WI' -- Enter State Abbreviation i.e. WI


SELECT 
      [lab_webmap].[User_pedon_ID]
      ,cnn.[pedon_Key]
      ,[peiid]
	  ,CASE WHEN [corr_name] IS NULL THEN [samp_name] ELSE [corr_name] END AS soil_name
      ,CASE WHEN [corr_class_type] IS NULL THEN [samp_class_type] ELSE [corr_class_type] END AS class_type
      ,CASE WHEN [corr_classification_name] IS NULL THEN [samp_classification_name] ELSE [corr_classification_name]  END AS [classification_name] 
      ,[Soil_Classification]
      ,[Primary_Lab_Report]
      ,[Taxonomy_Report]
      ,[Supplementary_Lab_Report]
      ,[Water_Retention_Report]
      ,[Correlation_Report]
      ,[pedon_Description_Report]
      ,[Soil_Profile]
      ,[Soil_web]
      ,[lat]
      ,[long]
      ,[latlong]
      ,cnn.[site_key]
      ,p.[pedlabsampnum]
      ,[project_key]
      ,[layer_field_label_1]
      ,[hzn_top]
      ,[hzn_bot]
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
       ,[major_element_method]
      ,[aluminum_major_element]
      ,[calcium_major_element]
      ,[iron_major_element]
      ,[potassium_major_element]
      ,[magnesium_major_element]
      ,[manganese_major_element]
      ,[sodium_major_element]
      ,[phosphorus_major_element]
      ,[silicon_major_element]
      ,[strontium_major_element]
      ,[titanium_major_element]
      ,[zirconium_major_element]
      ,[trace_element_method]
      ,[silver_trace_element]
      ,[arsenic_trace_element]
      ,[barium_trace_element]
      ,[beryllium_trace_element]
      ,[cadmium_trace_element]
      ,[cobalt_trace_element]
      ,[chromium_trace_element]
      ,[copper_trace_element]
      ,[mercury_trace_element]
      ,[manganese_trace_element]
      ,[molybdenum_trace_element]
      ,[nickel_trace_element]
      ,[phosphorus_trace_element]
      ,[lead_trace_element]
      ,[antimony_trace_element]
      ,[selenium_trace_element]
      ,[tin_trace_element]
      ,[strontium_trace_element]
      ,[thallium_trace_element]
      ,[vanadium_trace_element]
      ,[tungsten_trace_element]
      ,[zinc_trace_element]
      ,[iron_oxide_total]
      ,[aluminum_oxide_total]
      ,[potassium_oxide_total]
		,total_carbon_ncs
		,total_carbon_ncs_method
		,total_nitrogen_ncs
		,total_nitrogen_ncs_method
		,total_sulfur_ncs
		,total_sulfur_ncs_method
		,fe_dithionite_citrate_extract
		,aluminum_dithionite_citrate
		,manganese_dithionite_citrate
		,fe_ammoniumoxalate_extractable
		,iron_ammonium_oxalate_method
		,aluminum_ammonium_oxalate
		,al_ammonium_oxalate_method
		,manganese_ammonium_oxalate
		,mn_ammonium_oxalate_method
		,ph_h2o
		,ph_h2o_method
		,caco3_lt_2_mm
		,caco3_lt_2_mm_method
		,corrected_gypsum_lt_2_mm
		,corrected_gyp_lt_2_mm_method
		,clay_total
		,silt_total
		,sand_total
INTO #temp_geochem_map1	
FROM [lab_combine_nasis_ncss] AS cnn
INNER JOIN [lab_pedon] AS p ON p.pedon_key=cnn.pedon_key 
INNER JOIN [lab_layer] AS l ON l.pedon_key=p.pedon_key 
INNER JOIN [lab_chemical_properties] AS lcp ON lcp.labsampnum=l.labsampnum 
INNER JOIN [lab_physical_properties] AS lpp ON lpp.labsampnum=l.labsampnum 
INNER JOIN (SELECT [area_code] AS country_code,[area_name] AS country_name, area_key FROM lab_area) AS c ON cnn.[country_key]=c.area_key -- Country
INNER JOIN  (SELECT [area_code] AS state_code,[area_name] AS state_name, area_key FROM lab_area 
WHERE [area_code] = @state_sym ) AS s ON cnn.[state_key]=s.area_key  --State
INNER JOIN (SELECT [area_code] AS county_code,[area_name] AS county_name, area_key FROM lab_area ) AS ct ON cnn.[county_key]=ct.area_key --County
INNER JOIN (SELECT [area_code] AS mlra_code,[area_name] AS mlra_name, area_key FROM lab_area ) AS m ON cnn.[mlra_key]=m.area_key --MLRA
INNER JOIN (SELECT [area_code] AS ssa_code,[area_name] AS ssa_name, area_key FROM lab_area ) AS ss ON cnn.[ssa_key]=ss.area_key --SSA
INNER JOIN [lab_webmap] ON [lab_webmap].[pedon_Key]=cnn.[pedon_key] 
LEFT OUTER JOIN lab_major_and_trace_elements_and_oxides  AS mt ON  mt.labsampnum=l.labsampnum 
AND EXISTS (
SELECT l2.labsampnum 
FROM [lab_combine_nasis_ncss] AS cnn2
INNER JOIN [lab_pedon] AS p2 ON p2.pedon_key=cnn2.pedon_key AND p2.[pedlabsampnum]=p.[pedlabsampnum]
INNER JOIN [lab_layer] AS l2 ON l2.pedon_key=p2.pedon_key 
INNER JOIN lab_major_and_trace_elements_and_oxides  AS mt2 ON mt2.labsampnum=l2.labsampnum ) 
ORDER BY p.[pedlabsampnum] ASC, hzn_top ASC

--select * from tempdb.sys.columns where object_id =
--object_id('tempdb..#temp_geochem_map1') AND name LIKE '%method%';

/*
SELECT DISTINCT major_element_method,
trace_element_method,
total_carbon_ncs_method,
total_nitrogen_ncs_method,
total_sulfur_ncs_method,
iron_ammonium_oxalate_method,
al_ammonium_oxalate_method,
mn_ammonium_oxalate_method,
ph_h2o_method,
caco3_lt_2_mm_method,
corrected_gyp_lt_2_mm_method
FROM #temp_geochem_map1

 SELECT * FROM 
 (
 SELECT  major_element_method,
trace_element_method,
total_carbon_ncs_method,
total_nitrogen_ncs_method,
total_sulfur_ncs_method,
iron_ammonium_oxalate_method,
al_ammonium_oxalate_method,
mn_ammonium_oxalate_method,
ph_h2o_method,
caco3_lt_2_mm_method,
corrected_gyp_lt_2_mm_method
 FROM #temp_geochem_map1

 ) #d
 UNPIVOT (
 MIN (featdept_r) 
   FOR method IN (
   [Argillic horizon],
   [Albic horizon],--Albic materials --Interfingering of albic materials
[Cambic horizon],
[Densic contact], --Densic materials
[Duripan],
[Fragipan],
[Lithic contact],
[Oxic horizon],
[Paralithic contact], --Paralithic materials
[Petro], --[Petrocalcic horizon --Petroferric contact --Petrogypsic horizon
[Spodic horizon], [Salic horizon]) 
) AS #diag_pivot_table;

*/
SELECT  DISTINCT [pedon_Key], [User_pedon_ID], [peiid],  lower (soil_name) AS soil_name ,
 class_type,
[classification_name] ,

 [pedlabsampnum], [site_key]
     
      ,[project_key]
      ,[siteiid]
      ,[usiteid],[Primary_Lab_Report],
[pedon_Description_Report], 
[Soil_Profile],[Soil_web],country_code  ,country_name , state_code, state_name, county_code , county_name , mlra_code , mlra_name , ssa_code , ssa_name,
 lat,  [long]
     
	  
     
    

FROM #temp_geochem_map1	
GROUP BY [pedon_Key], [User_pedon_ID], [peiid], [Primary_Lab_Report], [pedlabsampnum],soil_name,
 class_type,
[classification_name] ,

[pedon_Description_Report],
[Soil_Profile],[Soil_web],country_code  ,country_name , state_code, state_name, county_code , county_name , mlra_code , mlra_name , ssa_code , ssa_name , lat,  [long], site_key, project_key,  [siteiid]
      ,[usiteid]
	
	  
DROP TABLE IF EXISTS #temp_geochem_map1;


SET STATISTICS IO OFF
