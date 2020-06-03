USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go


	  DROP TABLE IF exists result_light_test2
	  DROP TABLE IF EXISTS #tempXX_temp3


	  CREATE TABLE result_light_test2(result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12), analyzed_size_frac VARCHAR(128)
	   CONSTRAINT pk_result_light_test2 PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  ---------------  33 seconds  --- (1013671391 rows affected)
	  INSERT INTO result_light_test2 
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, r.analyte_key, r.procedure_key, r.source_system_key,   result_value,  ISNULL(p.prep_code, 
						 CASE WHEN r.analyte_key IN (1125,1126,1127,1185,1186,1187) THEN 'N'
							  WHEN r.analyte_key IN (1434,1435,1436,1437,1438,1439) THEN 'GP'
																							 ELSE 'S' END) AS prep_code  , ISNULL(b.proced_code, '') AS procedure_code, analyzed_size_frac
FROM  dbo.layer AS l 
INNER JOIN dbo.result  AS r ON l.layer_key = r.result_source_key 
INNER JOIN dbo.analyte AS a ON r.analyte_key = a.analyte_key 
LEFT JOIN dbo.preparation AS p ON r.prep_key = p.prep_key 
LEFT JOIN dbo.bridge_proced_ss AS b ON r.procedure_key = b.procedure_key AND 
                         r.source_system_key = b.source_system_key
            WHERE  (r.analyte_key IN (113)) AND (r.result_reliability IS NULL OR
                         r.result_reliability = '0')
--r.source_system_key = b.source_system_key -- AND ( ((isnumeric(result_value) = 1) AND (result_value != 'nil') 
--AND IIF(
--TRY_CAST([result_value] AS NUMERIC) IS NULL,  1, 2 ) = 2) AND  



		   
		   -- WHERE  (((isnumeric(result_value) = 1) AND (result_value != 'nil'))
		   
		   --AND analyte_key IN (1367))


	--------- new indexs -- 1367 seconds
	CREATE INDEX  result_light_test2_idx1c ON  result_light_test2 (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_test2_idx1b ON  result_light_test2 (analyte_key,  result_reliability)
	CREATE INDEX  result_light_test2_result_source_key_idx2 ON  result_light_test2 (result_source_key )
	CREATE INDEX result_light_test2_prep_key_idx3 ON  result_light_test2 (prep_key)
	CREATE INDEX result_source_system_key_idx4 ON result_light_test2 (source_system_key)
	CREATE INDEX result_light_test2_prep_code_idx5 ON  result_light_test2 (prep_code)



GO
SET STATISTICS IO ON



GO
SELECT   CAST (natural_key AS varchar) AS natural_key , CAST (result_source_key AS varchar) AS result_source_key, CAST (prep_code AS VARCHAR) AS prep_code,
														 

                            
		                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM     result_light_test2  AS result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 113))																							AS test

	
								
   
INTO  #tempXX_temp3

-------------- do no use view -- use new table here as well
FROM dbo.layer 
INNER JOIN result_light_test2 AS  q1 ON dbo.layer.layer_key = q1.result_source_key 


--AND          (q1.analyte_key IN (1) AND (q1.result_reliability IS NULL OR
   --                      q1.result_reliability = '0'))




SELECT 
natural_key, result_source_key,prep_code, test

FROM #tempXX_temp3
WHERE test is not null





--GROUP BY natural_key, result_source_key,prep_code,test

GO
SET STATISTICS IO OFF
GO

