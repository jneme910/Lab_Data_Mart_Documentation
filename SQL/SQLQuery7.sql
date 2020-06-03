USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go


GO
SET STATISTICS IO ON
GO


	  DROP TABLE IF exists result_light_calcEst
	  DROP TABLE IF EXISTS #tempXX_calcEst
	  DROP TABLE IF EXISTS result_light_test3
	  DROP TABLE IF EXISTS SDA_Chemical_Properties2

 CREATE TABLE result_light_calcEst (result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) NOT NULL , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12),
	   CONSTRAINT pk_result_light_calcEst PRIMARY KEY CLUSTERED (result_key))
	  go


INSERT INTO result_light_calcEst
	  
SELECT DISTINCT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key,   
	 result_value, p.prep_code, b.proced_code
FROM dbo.result r
  LEFT OUTER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key 
            WHERE   (result_type = 'layer result' AND  analyte_key IN  (590,591,593,516,600,614,617) 
		   AND CASE WHEN r.result_reliability IS NULL THEN 1 WHEN  r.result_reliability = '0' THEN 1 ELSE 2 END = 1)


SELECT  natural_key,result_source_key, prep_code, 
       
(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =590)) AS bulk_density_third_bar_ws,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =591)) AS bulk_density_oven_dry_ws,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =593)) AS bulk_density_saturated_whole_so,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =516)) AS bulk_density_whole_soil_moist,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =600)) AS weight_percent_gt_2_mm_ws,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =614)) AS weight_percent_gt_250_mm_ws,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =617)) AS  weight_pct_75_to_250_mm_ws,
------
(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =610)) AS  weight_pct_75_to_250_mm_ws,	

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =613)) AS  weight_pct_20_to_75_mm_ws,

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =615)) AS  weight_pct_5_to_20_mm_ws,	

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =594)) AS  weight_pct_2_to_5_mm_ws,	

(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =598)) AS  weight_pct_less_than_2_mm_ws,
	
(SELECT TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
FROM result_light_calcEst  AS result
WHERE(result.result_type = 'layer result') AND CASE WHEN (NOT (result.result_value IS NULL)) THEN 1 WHEN result.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (result.analyte_key =575)) AS  volume_pct_gt_2_mm_thirdbarws,


INTO  #tempXX_calcEst
FROM  dbo.layer 
INNER JOIN result_light_calcEst  q1 ON dbo.layer.layer_key = q1.result_source_key 


SELECT natural_key AS labsampnum, 
result_source_key,prep_code, bulk_density_third_bar_ws, bulk_density_oven_dry_ws,bulk_density_saturated_whole_so,bulk_density_whole_soil_moist,weight_percent_gt_2_mm_ws,weight_percent_gt_250_mm_ws, weight_pct_75_to_250_mm_ws,




--INTO SDA_Calculations_Including_Estimates_And_Default_Values
FROM #tempXX_calcEst

GROUP BY natural_key,result_source_key,prep_code, bulk_density_third_bar_ws, bulk_density_oven_dry_ws,bulk_density_saturated_whole_so,bulk_density_whole_soil_moist,weight_percent_gt_2_mm_ws,weight_percent_gt_250_mm_ws


	--CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values (labsampnum, result_source_key) INCLUDE (prep_code)
	--CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values_result_source_key_idx2 ON  SDA_Calculations_Including_Estimates_And_Default_Values (result_source_key )
	--CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values_prep_code_idx5 ON  SDA_Calculations_Including_Estimates_And_Default_Values (prep_code)

GO
SET STATISTICS IO OFF
GO