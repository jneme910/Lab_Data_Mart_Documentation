/****** Script for SelectTopNRows command from SSMS  ******/
 USE SSL_Repo
 /*
 UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/sites/default/files/2023-01/SSIR42.pdf'
  WHERE lab_datamart_pair_key = 'SSIR_42_Link_URL'

  
  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/sites/default/files/2022-10/SSIR45.pdf'
  WHERE lab_datamart_pair_key = 'SSIR_45_Link_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/sites/default/files/2023-01/SSIR51.pdf'
  WHERE lab_datamart_pair_key = 'SSIR_51_Link_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/accessibility'
  WHERE lab_datamart_pair_key = 'Bottom_Link_Accessibility_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/foia'
  WHERE lab_datamart_pair_key = 'Bottom_Link_FOIA_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/non-discrimination'
  WHERE lab_datamart_pair_key = 'Bottom_Link_Non_Discrimination_Statement_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/privacy'
  WHERE lab_datamart_pair_key = 'Bottom_Link_Privacy_Policy_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/'
  WHERE lab_datamart_pair_key = 'Bottom_Link_NRCS_URL'

  --Added JLN 
  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/resources/education-and-teaching-materials/national-soil-information-system-nasis'
  WHERE lab_datamart_pair_key = 'NASIS_Link_URL'

  
  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/resources/guides-and-instructions/national-soil-survey-handbook'
  WHERE lab_datamart_pair_key = 'National_Soil_Survey_Handbook_Link_URL'

  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/resources/guides-and-instructions/soil-taxonomy'
  WHERE lab_datamart_pair_key = 'Soil_Taxonomy_Link_URL'


  UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/resources/guides-and-instructions/keys-to-soil-taxonomy'
  WHERE lab_datamart_pair_key = 'Keys_To_Soil_Taxonomy_Link_URL'
  */
    UPDATE lab_datamart_data
  SET lab_datamart_pair_value = 'https://www.nrcs.usda.gov/resources/data-and-reports/soil-survey-geographic-database-ssurgo'
  WHERE lab_datamart_pair_key = '2006_MLRA_Geographic_Database_Link_URL'
