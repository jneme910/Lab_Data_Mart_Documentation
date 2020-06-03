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
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values
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
FROM dbo.layer 
INNER JOIN dbo.result AS r  ON dbo.layer.layer_key = r.result_source_key AND r.result_source_key  =  (SELECT TOP (1) r2.result_source_key  AS Expr1
FROM result  AS r2
WHERE(r2.result_type = 'layer result') AND CASE WHEN (NOT (r2.result_value IS NULL)) THEN 1 WHEN r2.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(r2.result_source_key = r.result_source_key) AND (CASE WHEN r2.result_reliability IS NULL THEN 1 WHEN r2.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (r2.analyte_key =r.analyte_key))
  LEFT OUTER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key 
            WHERE   (result_type = 'layer result' AND  analyte_key 
		       IN (590, 591, 593, 516, 600, 614, 617, 610, 613, 615, 594, 598, 575)  
		   AND CASE WHEN r.result_reliability IS NULL THEN 1 WHEN  r.result_reliability = '0' THEN 1 ELSE 2 END = 1)
  
UNION 

SELECT DISTINCT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key,   
	 result_value, p.prep_code, b.proced_code
FROM dbo.layer 
INNER JOIN dbo.result AS r  ON dbo.layer.layer_key = r.result_source_key AND r.result_source_key  =  (SELECT TOP (1) r2.result_source_key  AS Expr1
FROM result  AS r2
WHERE(r2.result_type = 'layer result') AND CASE WHEN (NOT (r2.result_value IS NULL)) THEN 1 WHEN r2.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(r2.result_source_key = r.result_source_key) AND (CASE WHEN r2.result_reliability IS NULL THEN 1 WHEN r2.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (r2.analyte_key =r.analyte_key))
  INNER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key 
            WHERE   (result_type = 'layer analyte' AND  analyte_key 
		       IN (4,25	,28	,242,243)  
		   AND CASE WHEN r.result_reliability IS NULL THEN 1 WHEN  r.result_reliability = '0' THEN 1 ELSE 2 END = 1) 
  	
UNION 

	  SELECT DISTINCT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key,   
	 result_value, p.prep_code, b.proced_code
FROM dbo.layer 
INNER JOIN dbo.result AS r  ON dbo.layer.layer_key = r.result_source_key AND r.result_source_key  =  (SELECT TOP (1) r2.result_source_key  AS Expr1
FROM result  AS r2
WHERE(r2.result_type = 'layer result') AND CASE WHEN (NOT (r2.result_value IS NULL)) THEN 1 WHEN r2.result_value <> '' THEN 1 ELSE 2 END = 1 AND 
(r2.result_source_key = r.result_source_key) AND (CASE WHEN r2.result_reliability IS NULL THEN 1 WHEN r2.result_reliability = '0' THEN 1 ELSE 2 END = 1) AND (r2.analyte_key =r.analyte_key))
  LEFT OUTER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key  AND  r.source_system_key = b.source_system_key 
            WHERE (result_type = 'layer result' AND  analyte_key 
		

		   IN (523, 524, 525, 526, 527, 528, 529, 530, 533, 534, 537, 538, 539, 542, 543, 544, 545, 546, 548, 549, 550, 551, 552, 553, 554, 555, 556, 571, 572, 573, 574, 576, 577, 579, 580, 581, 582, 583, 586, 587, 595, 596, 599, 601, 602, 603, 604, 605, 606, 607, 608, 609, 611, 612, 628, 630, 631)
		   AND CASE WHEN r.result_reliability IS NULL THEN 1 WHEN  r.result_reliability = '0' THEN 1 ELSE 2 END = 1)

	GROUP BY result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key,   
	 result_value, p.prep_code, b.proced_code
  	


	CREATE INDEX  result_light_calcEst_idx1c ON  result_light_calcEst (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_calcEst_idx1b ON  result_light_calcEst (analyte_key,  result_reliability)
	CREATE INDEX  result_light_calcEst_result_source_key_idx2 ON  result_light_calcEst (result_source_key )
	CREATE INDEX result_light_calcEst_prep_key_idx3 ON  result_light_calcEst (prep_key)
	CREATE INDEX result_source_system_key_calcEst_idx4 ON result_light_calcEst (source_system_key)
	CREATE INDEX result_light_calcEst_prep_code_idx5 ON  result_light_calcEst (prep_code)


