DROP TABLE IF EXISTS #p1;

/*
lab_analysis_procedure
lab_analyte
lab_area
lab_calculations_including_estimates_and_default_values
lab_chemical_properties
lab_combine_nasis_ncss
lab_layer
lab_major_and_trace_elements_and_oxides
lab_method_code
lab_mineralogy_glass_count
lab_pedon
lab_physical_properties
lab_preparation
lab_rosetta_Key
lab_site
lab_webmap
lab_xray_and_thermal
*/

WITH polygons
 AS (SELECT 'p1' id, 
            geometry::STGeomFromText('polygon ((-91.57097 43.37706,-91.57097 43.48543,-91.28187 43.48543,-91.28187 43.37706,-91.57097 43.37706))', 4326) poly
),
 points
 AS (SELECT *, latlong as p FROM lab_webmap)
 SELECT Series,	User_pedon_ID,	
 pedon_Key
 ,	peiid, lat, long, 
        points.wmiid, 
       p.STAsText() as Location
INTO #p1
 FROM polygons
      RIGHT JOIN points ON polygons.poly.STIntersects(points.p) = 1
 WHERE polygons.id IS NOT NULL;

 ----Lab Tables
  SELECT
  
  /*#p1.Series,	#p1.User_pedon_ID,	
 #p1.pedon_Key
 ,	#p1.peiid, #p1.lat, #p1.long, 
        #p1.wmiid, 
       #p1.Location , *
	   */
chem.[labsampnum]
      ,[result_source_key]
      ,[prep_code]
      ,[ca_nh4_ph_7]
      ,[ca_nh4_ph_7_method]
      ,[mg_nh4_ph_7]
      ,[mg_nh4_ph_7_method]
      ,[na_nh4_ph_7]
      ,[na_nh4_ph_7_method]
      ,[k_nh4_ph_7]
      ,[k_nh4_ph_7_method]
      ,[acidity_bacl2_tea_ph_8_2]
      ,[acidity_bacl2_tea_ph_82_method]
      ,[aluminum_kcl_extractable]
      ,[aluminum_kcl_extract_method]
      ,[manganese_kcl_extractable]
      ,[manganese_kcl_extract_method]
      ,[iron_kcl_extractable]
      ,[iron_kcl_extractable_method]
      ,[cec_nh4_ph_7]
      ,[cec_nh4_ph_7_method]
      ,[total_carbon_ncs]
      ,[total_carbon_ncs_method]
      ,[total_nitrogen_ncs]
      ,[total_nitrogen_ncs_method]
      ,[total_sulfur_ncs]
      ,[total_sulfur_ncs_method]
      ,[organic_carbon_walkley_black]
      ,[oc_walkley_black_method]
      ,[fe_dithionite_citrate_extract]
      ,[iron_dc_extract_method]
      ,[aluminum_dithionite_citrate]
      ,[aluminum_dc_extract_method]
      ,[manganese_dithionite_citrate]
      ,[manganese_dc_extract_method]
      ,[ammoniumoxalate_opticaldensity]
      ,[ammonium_ox_opt_dens_method]
      ,[fe_ammoniumoxalate_extractable]
      ,[iron_ammonium_oxalate_method]
      ,[aluminum_ammonium_oxalate]
      ,[al_ammonium_oxalate_method]
      ,[silica_ammonium_oxalate]
      ,[silica_ammonium_oxalate_method]
      ,[manganese_ammonium_oxalate]
      ,[mn_ammonium_oxalate_method]
      ,[carbon_sodium_pyro_phospate]
      ,[c_na_pyro_phosphate_method]
      ,[iron_sodium_pyro_phosphate]
      ,[iron_na_pyro_phosphate_method]
      ,[aluminum_na_pyro_phosphate]
      ,[aluminum_na_pyro_phosphate_met]
      ,[manganese_na_pyro_phosphate]
      ,[mn_na_pyro_phosphate_method]
      ,[ph_kcl]
      ,[ph_kcl_method]
      ,[ph_cacl2]
      ,[ph_cacl2_method]
      ,[ph_h2o]
      ,[ph_h2o_method]
      ,[ph_saturated_paste]
      ,[ph_saturated_paste_method]
      ,[ph_oxidized]
      ,[ph_oxidized_initial]
      ,[ph_oxidized_method]
      ,[ph_naf]
      ,[ph_naf_method]
      ,[ph_water_extract]
      ,[ph_water_extract_method]
      ,[caco3_lt_2_mm]
      ,[caco3_lt_2_mm_method]
      ,[corrected_gypsum_lt_2_mm]
      ,[corrected_gyp_lt_2_mm_method]
      ,[resistivity_saturated_paste]
      ,[resistivity_sp_method]
      ,[ca_satx]
      ,[ca_satx_method]
      ,[mg_satx]
      ,[mg_satx_method]
      ,[ca_plus_mg_satx]
      ,[ca_plus_mg_satx_method]
      ,[na_satx]
      ,[na_satx_method]
      ,[k_satx]
      ,[k_satx_method]
      ,[co3_satx]
      ,[co3_satx_method]
      ,[hco3_satx]
      ,[hco3_satx_method]
      ,[co3_plus_hco3_satx]
      ,[co3_plus_hco3_satx_method]
      ,[cl_satx]
      ,[cl_satx_method]
      ,[f_satx]
      ,[f_satx_method]
      ,[po4_satx]
      ,[po4_satx_method]
      ,[br_satx]
      ,[br_satx_method]
      ,[oac_satx]
      ,[oac_satx_method]
      ,[so4_satx]
      ,[so4_satx_method]
      ,[no2_satx]
      ,[no2_satx_method]
      ,[no3_satx]
      ,[no3_satx_method]
      ,[h20_satx]
      ,[h20_satx_method]
      ,[electrical_conductivity_satx]
      ,[electrical_cond_satx_method]
      ,[ec_predict_one_to_two]
      ,[ec_predict_one_to_two_method]
      ,[melanic_index]
      ,[melanic_index_method]
      ,[new_zealand_phosphorus_retent]
      ,[new_zealand_phos_retent_method]
      ,[phosphorus_ammonium_oxalate]
      ,[phosphorus_ammonium_oxalate_method]
      ,[phosphorus_anion_resin_one_hr]
      ,[phosphorus_anion_resin_24_hr]
      ,[phosphorus_anion_resin_method]
      ,[phosphorus_bray1]
      ,[phosphorus_bray1_method]
      ,[phosphorus_bray2]
      ,[phosphorus_bray2_method]
      ,[phosphorus_citric_acid]
      ,[phosphorus_citric_acid_method]
      ,[phosphorus_mehlich_3]
      ,[phosphorus_mehlich_3_method]
      ,[phosphorus_olsen]
      ,[phosphorus_olsen_method]
      ,[phosphorus_water]
      ,[phosphorus_water_method]
      ,[nitrate_1m_kcl]
      ,[nitrate_1m_kcl_method]
      ,[water_extract_method]
      ,[acetate_water_extractable]
      ,[aluminum_water_extractable]
      ,[arsenic_water_extractable]
      ,[barium_water_extractable]
      ,[boron_water_extractable]
      ,[bromide_water_extractable]
      ,[cadmium_water_extractable]
      ,[calcium_water_extractable]
      ,[chloride_water_extractable]
      ,[chromium_water_extractabe]
      ,[cobalt_water_extractable]
      ,[copper_water_extracable]
      ,[ec_water_extract]
      ,[fluoride_water_extractable]
      ,[iron_water_extractable]
      ,[lead_water_extractable]
      ,[magnesium_water_extractable]
      ,[manganese_water_extractable]
      ,[molybdenum_water_extractable]
      ,[nickel_water_extractable]
      ,[nitrate_n_water_extractable]
      ,[nitrate_water_extractable]
      ,[nitrite_water_extractable]
      ,[phosphorus_water_extractable]
      ,[phosphate_water_extractable]
      ,[potassium_water_extractable]
      ,[selenium_water_extractable]
      ,[silicon_water_extractable]
      ,[sodium_water_extractable]
      ,[strontium_water_extractable]
      ,[sulfate_water_extractable]
      ,[vanadium_water_extractable]
      ,[zinc_water_extractable]
      ,[mehlich_3_extractable_method]
      ,[aluminum_mehlich3_extractable]
      ,[arsenic_mehlich3_extractable]
      ,[barium_mehlich3_extractable]
      ,[cadmium_mehlich3_extractable]
      ,[calcium_mehlich3_extractable]
      ,[chromium_mehlich3_extractable]
      ,[cobalt_mehlich3_extractable]
      ,[copper_mehlich3_extractable]
      ,[iron_mehlich3_extractable]
      ,[lead_mehlich3_extractable]
      ,[magnesium_mehlich3_extractable]
      ,[manganese_mehlich3_extractable]
      ,[molybdenum_mehlich3_extractabl]
      ,[nickel_mehlich3_extractable]
      ,[phosphorus_mehlich3_extractable]
      ,[potassium_mehlich3_extractable]
      ,[selenium_mehlich3_extractable]
      ,[silicon_mehlich3_extractable]
      ,[sodium_mehlich3_extractable]
      ,[strontium_mehlich3_extractable]
      ,[zinc_mehlich3_extractable]
      ,[sum_of_nh4_ph_7_Ext_bases]
      ,[sum_of_cations_cec_pH_8_2]
      ,[ecec_base_plus_aluminum]
      ,[aluminum_saturation]
      ,[base_sat_sum_of_cations_ph_8_2]
      ,[base_sat_nh4oac_ph_7]
      ,[estimated_organic_carbon]
      ,[carbon_to_nitrogen_ratio]
      ,[aluminum_plus_half_iron_oxalat]
      ,[caco3_lt_20_mm]
      ,[gypsum_lt_20_mm]
      ,[ca_to_mg_ratio]
      ,[total_estimated_salts_satx]
      ,[exchangeable_sodium]
      ,[sodium_absorption_ratio]
      ,[phosphorus_anion_resin_capacit]

FROM #p1
INNER JOIN lab_pedon ON lab_pedon.pedon_key=#p1.pedon_key
INNER JOIN lab_layer ON lab_layer.pedon_key=#p1.pedon_key
INNER JOIN lab_chemical_properties AS chem ON chem.labsampnum=lab_layer.labsampnum -- labsampnum will need to be changed to layer_key once the views are updated



