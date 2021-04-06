USE sdmONLINE;

SELECT 
TABLE_NAME, COLUMN_NAME ,LEN(COLUMN_NAME) AS column_name_length,
CASE WHEN PATINDEX('%@%', REPLACE (REVERSE (COLUMN_NAME), '_','@' )) -1 = '-1' THEN '' ELSE
RIGHT (COLUMN_NAME,(PATINDEX('%@%', REPLACE (REVERSE (COLUMN_NAME), '_','@' )) -1)) END  AS Column_cuttoff_name_check,
CASE WHEN COLUMN_NAME = 'volume_pct_20_to_75_mm_third_w' THEN 'x'
WHEN COLUMN_NAME = 'percent_passing_20_micron_siev' THEN 'x'
WHEN COLUMN_NAME = 'phosphorus_anion_resin_capacit' THEN 'x'
WHEN COLUMN_NAME = 'water_retention_10th_bar_meth' THEN 'x'
WHEN COLUMN_NAME = 'water_retention_thirdbar_metho' THEN 'x'
WHEN COLUMN_NAME = 'sand_medium_ethanol_dispersibl' THEN 'x'
WHEN COLUMN_NAME = 'sand_coarse_ethanol_dispersibl' THEN 'x'
WHEN COLUMN_NAME = 'FP_Plagioclase_Feldspar_X_Ra' THEN 'x'
WHEN COLUMN_NAME = 'KH_Halloysite_Differential_thermal_Analysi' THEN 'x' 
WHEN COLUMN_NAME = 'particle_density_calc_sour' THEN 'x' 
WHEN COLUMN_NAME = 'bulk_density_saturated_whole_so' THEN 'x' 
WHEN COLUMN_NAME = 'le_third_ovendry_whole_soi' THEN 'x' 
WHEN COLUMN_NAME = 'void_ratio_third_bar_whole_soi' THEN 'x' 
WHEN COLUMN_NAME = 'volume_pct_20_to_75_mm_third_w' THEN 'x' 
WHEN COLUMN_NAME = 'percent_passing_20_micron_siev' THEN 'x' 
WHEN COLUMN_NAME = 'phosphorus_anion_resin_capacit' THEN 'x' 
WHEN COLUMN_NAME = 'water_retention_10th_bar_meth' THEN 'x' 
WHEN COLUMN_NAME = 'water_retention_thirdbar_metho' THEN 'x' 
WHEN COLUMN_NAME = 'sand_medium_ethanol_dispersibl' THEN 'x' 
WHEN COLUMN_NAME = 'sand_coarse_ethanol_dispersibl' THEN 'x' 
WHEN COLUMN_NAME = 'FP_Plagioclase_Feldspar_X_Ra' THEN 'x' 
WHEN COLUMN_NAME = 'KH_Halloysite_Differential_thermal_Analysi' THEN 'x' 
ELSE '' END AS 'adjust_view_name',
' ' AS suggested_Name
FROM sdmONLINE.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE 'lab%';