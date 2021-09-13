--USE lims;

--TRANSFORM Sum(CDbl([calc_value])) AS analyte_val
SELECT dbo_project.lab_proj_name, dbo_project.submit_proj_name, dbo_lims_pedon.user_pedon_id, dbo_layer.natural_key, dbo_layer.lay_field_label1, dbo_layer.horizon_designation, dbo_layer.lay_depth_to_top, dbo_layer.lay_depth_to_bottom
FROM ((((dbo_project INNER JOIN dbo_layer ON dbo_project.proj_id = dbo_layer.proj_id) LEFT JOIN dbo_lims_pedon ON dbo_layer.lims_pedon_id = dbo_lims_pedon.lims_pedon_id) INNER JOIN dbo_layer_analyte ON dbo_layer.lay_id = dbo_layer_analyte.lay_id) INNER JOIN dbo_analyte ON dbo_layer_analyte.analyte_id = dbo_analyte.analyte_id) INNER JOIN dbo_procedure ON dbo_layer_analyte.proced_id = dbo_procedure.proced_id
WHERE (((dbo_project.lab_proj_name)='C2010USNE012') AND ((dbo_layer_analyte.proced_id)<>999) AND (Not (dbo_layer_analyte.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True)) OR (((dbo_project.lab_proj_name)='C2010USNE016') AND ((dbo_layer_analyte.proced_id)<>999) AND (Not (dbo_layer_analyte.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True)) OR (((dbo_project.lab_proj_name)='C2010USNE025') AND ((dbo_layer_analyte.proced_id)<>999) AND (Not (dbo_layer_analyte.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True)) OR (((dbo_project.lab_proj_name)='C2010USNE028') AND ((dbo_layer_analyte.proced_id)<>999) AND (Not (dbo_layer_analyte.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True))
GROUP BY dbo_project.lab_proj_name, dbo_project.submit_proj_name, dbo_lims_pedon.user_pedon_id, dbo_layer.natural_key, dbo_layer.lay_field_label1, dbo_layer.horizon_designation, dbo_layer.lay_depth_to_top, dbo_layer.lay_depth_to_bottom, dbo_project.proj_id, dbo_layer.lay_rpt_seq_num
ORDER BY dbo_project.proj_id, dbo_layer.lay_rpt_seq_num, [proced_abbrev] & "-" & [analyte_name]
--PIVOT [proced_abbrev] & "-" & [analyte_name];

--TRANSFORM Sum(CDbl([calc_value])) AS analyte_val
SELECT dbo_project.lab_proj_name, dbo_project.submit_proj_name, dbo_lims_pedon.user_pedon_id, dbo_layer.natural_key, dbo_layer.lay_field_label1, dbo_layer.horizon_designation, dbo_layer.lay_depth_to_top, dbo_layer.lay_depth_to_bottom
FROM ((dbo_project INNER JOIN dbo_layer ON dbo_project.proj_id = dbo_layer.proj_id) LEFT JOIN dbo_lims_pedon ON dbo_layer.lims_pedon_id = dbo_lims_pedon.lims_pedon_id) INNER JOIN (dbo_result INNER JOIN dbo_calc ON dbo_result.calc_id = dbo_calc.calc_id) ON dbo_layer.lay_id = dbo_result.result_source_id
WHERE (((dbo_project.lab_proj_name)='C2010USNE012') AND ((dbo_result.result_type)="layer") AND (Not (dbo_result.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True)) OR (((dbo_project.lab_proj_name)='C2010USNE016') AND ((dbo_result.result_type)="layer") AND (Not (dbo_result.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True)) OR (((dbo_project.lab_proj_name)='C2010USNE025') AND ((dbo_result.result_type)="layer") AND (Not (dbo_result.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True)) OR (((dbo_project.lab_proj_name)='C2010USNE028') AND ((dbo_result.result_type)="layer") AND (Not (dbo_result.calc_value) Is Null) AND ((IsNumeric([calc_value]))=True))
GROUP BY dbo_project.lab_proj_name, dbo_project.submit_proj_name, dbo_lims_pedon.user_pedon_id, dbo_layer.natural_key, dbo_layer.lay_field_label1, dbo_layer.horizon_designation, dbo_layer.lay_depth_to_top, dbo_layer.lay_depth_to_bottom, dbo_project.proj_id, dbo_layer.lay_rpt_seq_num, dbo_result.result_type
ORDER BY dbo_project.proj_id, dbo_layer.lay_rpt_seq_num
--PIVOT dbo_calc.calc_name;

