 SELECT labsampnum, [result_type]
      ,r.[result_source_key]
      ,r.[source_system_key]
      ,r.[source_system_id]
      ,a.[analyte_key]
      ,[prep_key]
      ,r.[procedure_key]
      ,[instr_set_key]
      ,[result_value]
      ,[result_calc_date]
      ,[result_reliability]
      ,[method_code]
      ,[analyzed_size_frac]
      ,[num_obs]
      ,[std_dev]
      ,[laboratory_key]
	  ,[analyte_type]
      ,[analyte_name]
      ,[analyte_abbrev]
      ,[analyte_code]
      ,[analyte_data_type]
      ,[analyte_format]
      ,[uom_abbrev]
      ,[analyte_source_type]
      ,[analyte_agg_method]
      ,[analyte_algorithm]
      ,[analyte_desc]
      ,[analyte_size_frac_base]
	  
	  ,b.[bridge_proced_ss_key]
      ,b.[source_system_key]
      ,b.[procedure_key]
	  ,r.[procedure_key]
      ,b.[source_system_id]
      ,b.[proced_code]
	 , a.analyte_key, carbon_sodium_pyro_phospate, labsampnum
	 FROM [lab_chemical_properties] AS lpp
INNER JOIN result AS r ON r.result_source_key=lpp.result_source_key --AND (CAST (carbon_sodium_pyro_phospate AS decimal) =CAST ([result_value] AS decimal)
AND result_type = 'layer analyte'AND CASE
                                 WHEN r.result_reliability IS NULL
                                     THEN 1
                                 WHEN r.result_reliability = '0'
                                     THEN 1
                                 ELSE
                                     2
                             END = 1
  INNER JOIN
                    dbo.analyte AS a
                        ON r.analyte_key = a.analyte_key

  INNER JOIN
                    dbo.bridge_proced_ss AS b
                        ON r.procedure_key = b.procedure_key
                           AND r.source_system_key = b.source_system_key


INNER JOIN lab_method_code AS mc ON mc.[proced_code]=lpp.[c_na_pyro_phosphate_method] AND b.[proced_code]=mc.[proced_code]

--sys.columns 