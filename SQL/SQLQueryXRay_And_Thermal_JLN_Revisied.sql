SELECT natural_key, result_source_key, prep_code, analyzed_size_frac
INTO #TEMP_XRay_And_Thermal_List 
FROM  dbo.XRay_And_Thermal_List AS q1 

SELECT natural_key, result_source_key, prep_code, analyzed_size_frac
FROM #TEMP_XRay_And_Thermal_List 
DROP TABLE #TEMP_XRay_And_Thermal_List 
