

USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION

USE ncsslabdata
go


	------------------------------------------ begin - RUN THE FOLLOWING BY ITSELF


	  ---------- create a combined table to reduce the number of joins needed
	  ---------- added wlupdated column - to track changes to result_value and prep_code
	  ---------- to update data as needed -- then append new data
	  ---------- instead of recreating fresh each time
	  -------------------------------------------
	  DROP TABLE IF exists result_light
	  CREATE TABLE result_light(result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12),
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  ---------------  33 seconds  --- (10601391 rows affected)
	  INSERT INTO result_light 
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key, result_value , p.prep_code  , b.proced_code
	FROM dbo.result r
    INNER JOIN dbo.preparation AS p ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key

	--------- new indexs -- 50 seconds
	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX result_light_prep_code_idx5 ON  result_light (prep_code)

	------------------------------------------ end RUN BY ITSELF SQL

/*

------- 0 seconds
Table '#tempXX__00000000002C'. Scan count 0, logical reads 1011, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'result'. Scan count 10948, logical reads 43858, physical reads 64, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'result_light'. Scan count 18767, logical reads 81437, physical reads 0, read-ahead reads 6, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'layer'. Scan count 0, logical reads 4310, physical reads 1, read-ahead reads 24, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(1000 rows affected)

*/



---------------------------- now run the following
SET STATISTICS IO ON

--------- run output to temp table -- or a real table but not to SSMS
--------- 0 seconds
DROP TABLE IF EXISTS #tempXX
DROP TABLE IF EXISTS SDA_Chemical_Properties
GO
SELECT  CAST(natural_key AS varchar) AS natural_key, CAST(result_source_key AS varchar) AS result_source_key, --prep_code,   
 CAST(( SELECT TOP 1 prep_code FROM  layer AS l2 INNER JOIN result_light AS  q2 ON l2.layer_key = q2.result_source_key AND l2.natural_key=layer.natural_key AND result_type = 'layer analyte'
AND l2.layer_key=layer.layer_key) AS varchar) AS prep_code,



--ca_nh4_ph_7
                            CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM           result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (61,67,678))) AS varchar) AS ca_nh4_ph_7,
                             CAST((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (61,67,678)))AS varchar) AS ca_nh4_ph_7_method,


--mg_nh4_ph_7
                             CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (63,69,680)))AS varchar)  AS mg_nh4_ph_7,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (63,69,680)))AS varchar) AS mg_nh4_ph_7_method,

--na_nh4_ph_7
                            CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (65,71,682)))AS varchar) AS na_nh4_ph_7,
                             CAST((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (65,71,682)))AS varchar) AS na_nh4_ph_7_method,

--k_nh4_ph_7
                            CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (64,70,681)))AS varchar) AS k_nh4_ph_7,
                              CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (64,70,681)))AS varchar) AS k_nh4_ph_7_method,
                            
--Sum_of_nh4_ph_7_Ext_bases (Calc)							
							 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (568,652,653,721,722,723,791,1291,1292,1440,2099))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1154,1289,1442))
                                                         UNION
                                                         SELECT        result.result_value, 'S-SK' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1290))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1152,1288,1441))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1160))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1161,1287))) AS result_1
														WHERE        (prep_code = q1.prep_code)) AS varchar)
														AS sum_of_nh4_ph_7_Ext_bases ,


--acidity_bacl2_tea_ph_8_2
													 CAST(  (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
													   FROM              result_light result
													   WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
																				 (result.result_reliability IS NULL OR
																				 result.result_reliability = '0') AND (result.analyte_key in (73, 1121))) AS varchar) AS acidity_bacl2_tea_ph_8_2,
													 CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
													   FROM            result_light result
													   WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
																				 (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
																				 result.result_reliability = '0') AND (result.analyte_key IN (73, 1121)))AS varchar) AS acidity_bacl2_tea_ph_82_method,

--aluminum_kcl_extractable
					          CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (55))) AS varchar) AS aluminum_kcl_extractable,		          
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (55)))AS varchar) AS aluminum_kcl_extract_method,

--manganese_kcl_extractable
							CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (56))) AS varchar) AS manganese_kcl_extractable,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (56))) AS varchar) AS manganese_kcl_extract_method,

--iron_kcl_extractable
							CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (683)))AS varchar) AS iron_kcl_extractable,
                             CAST ((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (683))) AS varchar)AS iron_kcl_extractable_method,


---sum_of_cations_cec_pH_8_2 (calc)
							CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (518,654,655,736,737,738,796,1303,1304,1450,2101))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1157,1301,1452))
                                                         UNION
                                                         SELECT        result.result_value, 'S-SK' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1302))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1046,1300,1451))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1159))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1162,1299))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS varchar)
						AS sum_of_cations_cec_pH_8_2 ,


--cec_nh4_ph_7
							CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (62,68,679))) AS varchar) AS cec_nh4_ph_7,
                             CAST ((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (62,68,679)))AS varchar) AS cec_nh4_ph_7_method,


--ecec_base_plus_aluminum  (Calc) 
										CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (517,619,650,706,707,708,748,749,750,751,752,753,799,1097,1313,1314,1315,1316,1453,1454,2026,2030,2031,2032,2102))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1158,1309,1310,1455,1456,2034,2035))
                                                         UNION
                                                         SELECT        result.result_value, 'S-SK' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1311,1312,2029))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1048,1307,1308,1457,1458,2028,2033))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1167))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1168,1305,1306,2027))) AS result_1
														WHERE        (prep_code = q1.prep_code)) AS varchar)
														AS ecec_base_plus_aluminum ,	
						
						
--aluminum_saturation (calc)						
														CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
														 FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (512,618,648,703,704,705,715,716,717,718,719,720,790,1096,1325,1326,1327,1328,1462,1463,2036,2041,2042,2043,2104))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1153,1321,1322,1466,1467,2039,2045))
                                                         UNION
                                                         SELECT        result.result_value, 'S-SK' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1323,1324,2040))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1043,1319,1320,1464,1465,2038,2044))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1169))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1170,1317,1318,2037))) AS result_1
														WHERE        (prep_code = q1.prep_code)) AS varchar)
														AS aluminum_saturation ,
							
---base_sat_sum_of_cations_ph_8_2 (calc)				
													   CAST(  (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
														 FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (514,658,659,660,661,662,663,664,665,724,728,730,731,732,792,1459,2103))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (727,1155,1461))
                                                         UNION
                                                         SELECT        result.result_value, 'S-SK' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (729))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (726,1044,1460))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1163))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1164,725))) AS result_1
														 WHERE        (prep_code = q1.prep_code)) AS varchar)
														 AS base_sat_sum_of_cations_ph_8_2,


--base_sat_nh4oac_ph_7 (calc) 
														CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 2)) AS Expr1
														 FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (513,666,667,733,734,735,793,1297,1298,1447,2100))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1156,1295,1449))
                                                         UNION
                                                         SELECT        result.result_value, 'S-SK' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1296))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1045,1294,1448))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1165))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1166,1293))) AS result_1
													     WHERE        (prep_code = q1.prep_code)) AS varchar)
														 AS base_sat_nh4oac_ph_7,
						
--total_carbon_ncs						
											CAST(		(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
												FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (45, 460))) AS varchar) AS total_carbon_ncs,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (45, 460))) AS varchar) AS total_carbon_ncs_method,
														 
---total_nitrogen_ncs														 		
							CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.3') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (79, 461))) AS varchar) AS total_nitrogen_ncs,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (79, 461)))AS varchar) AS total_nitrogen_ncs_method,	
														 
---total_sulfur_ncs														 
							CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (362, 462)))AS varchar) AS total_sulfur_ncs,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (362, 462))) AS varchar)AS total_sulfur_ncs_method,	
---estimated_organic_carbon (calc)														 
								CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (794,1070,1238))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (2021))
                                  
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (2022))) AS result_1
														 WHERE        (prep_code = q1.prep_code))AS varchar) 
														 AS estimated_organic_carbon,


---organic_carbon_walkley_black
							CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 780))AS varchar) AS organic_carbon_walkley_black,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 780))AS varchar) AS oc_walkley_black_method,	

--carbon_to_nitrogen_ratio (calc)
														CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
														 FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (559, 647))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key = 1078)
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1076, 2086))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key = 1077)
                                                                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key = 1079)) AS result_1
														WHERE        (prep_code = q1.prep_code)) AS varchar)
														AS carbon_to_nitrogen_ratio, 

---fe_dithionite_citrate_extract																	 
							CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 52)) AS varchar) AS fe_dithionite_citrate_extract,
                             CAST ((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 52)) AS varchar) AS iron_dc_extract_method,	

--aluminum_dithionite_citrate
					CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 51))AS varchar) AS aluminum_dithionite_citrate,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 51))AS varchar) AS aluminum_dc_extract_method,	

--manganese_dithionite_citrate
					CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 53)) AS varchar) AS manganese_dithionite_citrate,
                        CAST(     (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 53))  AS varchar) AS manganese_dc_extract_method,	

--aluminum_plus_half_iron_oxalat (calc)
						CAST(	 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (1071, 1090, 1851))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1072, 1091, 1848))
                                                         UNION
                                                         SELECT        result.result_value, 'MW' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1095, 1849))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1074, 1093, 1850))
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM            result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1075, 1094, 1846))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1073, 1092, 1847))) AS result_1
														WHERE        (prep_code = q1.prep_code)) AS varchar)
														AS aluminum_plus_half_iron_oxalat,

--ammoniumoxalate_opticaldensity													 								 								 
								CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 452)) AS varchar) AS ammoniumoxalate_opticaldensity,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 452)) AS varchar) AS ammonium_ox_opt_dens_method,	

--fe_ammoniumoxalate_extractable
						CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 47)) AS varchar) AS fe_ammoniumoxalate_extractable,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 47)) AS varchar) AS iron_ammonium_oxalate_method,	


--aluminum_ammonium_oxalate
							CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 46)) AS varchar) AS aluminum_ammonium_oxalate,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 46)) AS varchar) AS al_ammonium_oxalate_method,	

--silica_ammonium_oxalate
							CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 50)) AS varchar) AS silica_ammonium_oxalate,
                             CAST ((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 50)) AS varchar) AS silica_ammonium_oxalate_method,	

--manganese_ammonium_oxalate
					CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '7.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 48))AS varchar)  AS manganese_ammonium_oxalate,
                           CAST (  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 48))AS varchar) AS mn_ammonium_oxalate_method,	

--carbon_sodium_pyro_phospate
								CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 58)) AS varchar) AS carbon_sodium_pyro_phospate,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 58)) AS varchar) AS c_na_pyro_phosphate_method,	

--iron_sodium_pyro_phosphate
								CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 59)) AS varchar) AS iron_sodium_pyro_phosphate,
                             CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 59))AS varchar) AS iron_na_pyro_phosphate_method,	
				
--aluminum_na_pyro_phosphate				
							CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 57)) AS varchar) AS aluminum_na_pyro_phosphate,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 57)) AS varchar) AS aluminum_na_pyro_phosphate_met,	


--manganese_na_pyro_phosphate														 
							  CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 60)) AS varchar) AS manganese_na_pyro_phosphate,
                            CAST ( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 60)) AS varchar) AS mn_na_pyro_phosphate_method,
	----CAST VARCHAR TEST ABOVE										 
														 	
--ph_kcl														 								 
							CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 244)) AS varchar) AS ph_kcl,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 244)) AS varchar) AS ph_kcl_method, 


--ph_cacl2
							CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 455)) AS varchar) AS ph_cacl2,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 455))AS varchar) AS ph_cacl2_method, 

--ph_h2o
				CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 247)) AS varchar) AS ph_h2o,
                 CAST(            (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 247)) AS varchar)AS ph_h2o_method, 


--ph_saturated_paste														 
								CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 456)) AS varchar) AS ph_saturated_paste,
                             CAST ((SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 456)) AS varchar) AS ph_saturated_paste_method, 

----ph_oxidized
								CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 246)) AS varchar) AS ph_oxidized,
							CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1147)) AS varchar) AS ph_oxidized_initial,
							CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (246,1147))) AS varchar) AS ph_oxidized_method, 


--ph_naf
         				CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 245)) AS varchar) AS ph_naf,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 245)) AS varchar) AS ph_naf_method, 

--ph_water_extract
	 				CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1363)) AS varchar) AS ph_water_extract,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1363)) AS varchar)  AS ph_water_extract_method, 	
														 
--caco3_lt_2_mm
	 				 CAST(  (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 41)) AS varchar)  AS caco3_lt_2_mm,
                        CAST(     (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 41)) AS varchar)  AS caco3_lt_2_mm_method, 	

--caco3_lt_20_mm (calc)
											CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
												FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (623))
                                                        ) AS result_1
												 WHERE        (prep_code = q1.prep_code)) AS varchar) 
												AS caco3_lt_20_mm,

--End check
														 
--corrected_gypsum_lt_2_mm 
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 485)) AS varchar)  AS corrected_gypsum_lt_2_mm,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 485)) AS varchar) AS corrected_gyp_lt_2_mm_method, 		
														 
														 													 
														 														 												 
--gypsum_lt_20_mm (calc) 
											CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
												FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (624))
                                                        ) AS result_1
													 WHERE        (prep_code = q1.prep_code)) AS varchar) 
												AS gypsum_lt_20_mm,


--resistivity_saturated_paste
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '7.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 358)) AS varchar)  AS resistivity_saturated_paste,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 358)) AS varchar) AS resistivity_sp_method, 	
														 
--ca_satx
	 							CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 348)) AS varchar) AS ca_satx,
							 CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 348)) AS varchar)  AS ca_satx_method,
--CAST VARCHAR TEST ABOVE FAILED. Reruning it again to see if the troublemaker is somewhere between last mark and here. 														 
														  
--mg_satx
	 			CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 353)) AS varchar)  AS mg_satx,
                       CAST(      (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 353)) AS varchar) AS mg_satx_method,


--ca_plus_mg_satx
	 				CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 788))AS varchar)   AS ca_plus_mg_satx,
                         CAST(    (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 788))AS varchar)  AS ca_plus_mg_satx_method,


--ca_to_mg_ratio (Calc)
									CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.1') AS decimal(10, 2)) AS Expr1
										FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (1930))
                                                        ) AS result_1
										 WHERE        (prep_code = q1.prep_code)) AS varchar) 
											AS ca_to_mg_ratio,


--na_satx
	 			CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 359)) AS varchar)  AS na_satx,
                     CAST(        (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 359)) AS varchar)  AS na_satx_method,


--k_satx
	 	
			 			CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 357)) AS varchar)  AS k_satx,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 357)) AS varchar)  AS k_satx_method,


--co3_satx 
	 				CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 349)) AS varchar)  AS co3_satx,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 349)) AS varchar)  AS co3_satx_method,

--hco3_satx
	 				CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 345))AS varchar)  AS hco3_satx,
                       CAST(      (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 345)) AS varchar)  AS hco3_satx_method,


--co3_plus_hco3_satx
	 				CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 787)) AS varchar)  AS co3_plus_hco3_satx,
                     CAST(        (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 787))AS varchar)  AS co3_plus_hco3_satx_method,


--cl_satx
	 				CAST ((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 350))AS varchar)  AS cl_satx,
                      CAST(       (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 350))AS varchar)  AS cl_satx_method,

--f_satx
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 352)) AS varchar) AS f_satx,
                         CAST(    (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 352))AS varchar)  AS f_satx_method,



--po4_satx
	 				CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 356))AS varchar)  AS po4_satx,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 356))AS varchar)  AS po4_satx_method,

--br_satx
	 			CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 347)) AS varchar)  AS br_satx,
                        CAST(     (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 347)) AS varchar)  AS br_satx_method,

--oac_satx
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 344)) AS varchar)  AS oac_satx,
                        CAST(     (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 344)) AS varchar)  AS oac_satx_method,



--so4_satx
	 			CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 360)) AS varchar)  AS so4_satx,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 360)) AS varchar)  AS so4_satx_method,


--no2_satx
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 355)) AS varchar)  AS no2_satx,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 355)) AS varchar)  AS no2_satx_method,

--no3_satx
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 354)) AS varchar) AS no3_satx,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 354)) AS varchar)  AS no3_satx_method,

--h20_satx
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 361)) AS varchar) AS h20_satx,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 361)) AS varchar) AS h20_satx_method,
--total_estimated_salts_satx (Calc)
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (570,1030,1522,2096))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1171,1329,1523,2097))
                                                         UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1172))
                                           
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1173))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS varchar) 
						AS total_estimated_salts_satx,

--electrical_conductivity_satx
	 				CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 351)) AS varchar)  AS electrical_conductivity_satx,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 351))AS varchar)  AS electrical_cond_satx_method,


--ec_predict_one_to_two
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 343)) AS varchar) AS ec_predict_one_to_two,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 343))AS varchar)  AS ec_predict_one_to_two_method,

--exchangeable_sodium (Calc) --Recheck above if still not working
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (531,620,651,668,669,670,675,676,677,754,755,756,757,758,759,760,761,762,800,801,1444,1445,1446,1512,1513,1514,1515,1516,1517,1518))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1174,1177))
                                                         UNION
                                                         SELECT        result.result_value, 'M' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1183))

															UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1175,1178))
                                           
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1176,1179))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS varchar) 
						AS exchangeable_sodium,

--sodium_absorption_ratio (Calc)
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (563,636,803,1520,2094))
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1180,1521,2095))
                                                  

															UNION
                                                         SELECT        result.result_value, 'HM' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1181))
                                           
                                                         UNION
                                                         SELECT        result.result_value, 'GP' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1182))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS varchar) 
						AS sodium_absorption_ratio,

--melanic_index
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 482)) AS varchar) AS melanic_index,
                        CAST(     (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 482))AS varchar)  AS melanic_index_method,


--new_zealand_phosphorus_retent
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 252)) AS varchar)  AS new_zealand_phosphorus_retent,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 252)) AS varchar)  AS new_zealand_phos_retent_method,


--phosphorus_ammonium_oxalate
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 49)) AS varchar) AS phosphorus_ammonium_oxalate,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 49))AS varchar)  AS phosphorus_ammonium_oxalate_method,


--phosphorus_anion_resin
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1128)) AS varchar) AS phosphorus_anion_resin_one_hr,



	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1129)) AS varchar)  AS phosphorus_anion_resin_24_hr,
              


			              CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (1128,1129)))AS varchar)  AS phosphorus_anion_resin_method,

--phosphorus_anion_resin_capacito (Calc)
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM            (SELECT        result.result_value, 'S' AS prep_code
                                                         FROM           result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                   AND (result.analyte_key IN (1887))
                                           
                                                 													
                                                         UNION
                                                         SELECT        result.result_value, 'N' AS prep_code
                                                         FROM             result_light AS result
                                                         WHERE        (result.result_type = 'layer result') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND (result.result_source_key = q1.result_source_key) 
                                                                                  AND (result.analyte_key IN (1888))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) AS varchar) 
						AS phosphorus_anion_resin_capacit,


--phosphorus_bray1
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 249))AS varchar)  AS phosphorus_bray1,
                            CAST( (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 249)) AS varchar)  AS phosphorus_bray1_method,
														 													 
														 
														 	
--phosphorus_bray2
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 250)) AS varchar)  AS phosphorus_bray2,
                          CAST(   (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 250)) AS varchar)  AS phosphorus_bray2_method,



--phosphorus_citric_acid (Modified need to double check)

	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 251)) AS varchar)  AS phosphorus_citric_acid,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 251)) AS varchar) AS phosphorus_citric_acid_method,




--phosphorus_mehlich_3
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 483)) AS varchar)  AS phosphorus_mehlich_3,
                         CAST(    (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 483)) AS varchar)  AS phosphorus_mehlich_3_method,

--phosphorus_olsen
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 253)) AS varchar) AS phosphorus_olsen,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 253)) AS varchar) AS phosphorus_olsen_method,
---The troublemaker still hasn't shown itself. CAST VARCHAR from here to last spot

--phosphorus_water,
	 			CAST(	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 248)) AS varchar) AS phosphorus_water,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 248)) AS varchar)  AS phosphorus_water_method,

--nitrate_1m_kcl
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 77)) AS varchar) AS nitrate_1m_kcl,
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 77))AS varchar)  AS nitrate_1m_kcl_method,	
--water_extract_method														 													 													 												 														 
                         CAST(    (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372, 1364, 1356, 1373, 1381, 1375, 1376, 1377, 1379, 1357, 1386, 1358, 1359, 1380, 1374, 2098, 1382, 1378, 1383, 1360, 1384, 1385))) AS varchar) AS water_extract_method	,															 	

--acetate_water_extractable
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1352))AS varchar)  AS acetate_water_extractable,

--aluminum_water_extractable
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1365)) AS varchar)  AS aluminum_water_extractable,
--arsenic_water_extractable
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1366)) AS varchar) AS arsenic_water_extractable,
---barium_water_extractable
	 				CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1367)) AS varchar)  AS  barium_water_extractable,
-- boron_water_extractable
						CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1353))AS varchar)  AS  boron_water_extractable,
--bromide_water_extractable
	CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1354))AS varchar)  AS  bromide_water_extractable, 
--cadmium_water_extractable
	CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1369))AS varchar)  AS  cadmium_water_extractable, 


--calcium_water_extractable
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1368))AS varchar)  AS  calcium_water_extractable, 
--chloride_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1368)) AS varchar) AS  chloride_water_extractable, 
--chromium_water_extractabe
	CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1371))AS varchar)  AS  chromium_water_extractabe, 

--cobalt_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1370)) AS varchar)  AS  cobalt_water_extractable, 
--copper_water_extracable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1372)) AS varchar)  AS  copper_water_extracable, 
														 
--ec_water_extract														 	
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1364)) AS varchar) AS  ec_water_extract,
--fluoride_water_extractable														 
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1356))AS varchar) AS  fluoride_water_extractable,	
--iron_water_extractable														 													 															 
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1373)) AS varchar)AS  iron_water_extractable,	
--lead_water_extractable														 
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1381))AS varchar) AS  lead_water_extractable,	

--magnesium_water_extractable													 
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1375)) AS varchar) AS  magnesium_water_extractable, 
														 															 														 														 		--manganese_water_extractable								 
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1376)) AS varchar) AS  manganese_water_extractable, 

--molybdenum_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1377)) AS varchar) AS  molybdenum_water_extractable,
--nickel_water_extractable														 														 
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1379))AS varchar) AS  nickel_water_extractable,
--nitrate_n_water_extractabl														 
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1386)) AS varchar) AS  nitrate_n_water_extractable,	
--nitrate_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1357)) AS varchar)AS  nitrate_water_extractable,

--nitrite_water_extractable
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1358)) AS varchar)AS  nitrite_water_extractable,
														 
--phosphorus_water_extractable														 	
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1359))AS varchar) AS  phosphorus_water_extractable,
--phosphate_water_extractable													 	
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1380))AS varchar) AS  phosphate_water_extractable,

														 
--potassium_water_extractable														 
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1374)) AS varchar) AS potassium_water_extractable,
--selenium_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 2098))AS varchar) AS selenium_water_extractable,

														 
--silicon_water_extractable														 														 					
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1382)) AS varchar)AS silicon_water_extractable,
--sodium_water_extractable
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1378))AS varchar) AS sodium_water_extractable,
--strontium_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1383))AS varchar) AS strontium_water_extractable,
--sulfate_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1360)) AS varchar) AS sulfate_water_extractable,

--vanadium_water_extractable
CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1384)) AS varchar)AS vanadium_water_extractable,
 
 --zinc_water_extractable
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1385))AS varchar) AS zinc_water_extractable,									 
														 
--mehlich_3_extractable												 													 													 												 														 
                           CAST(  (SELECT        TOP (1) ISNULL(result.proced_code, 'Null') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (1331, 1332, 1333, 1335, 1334, 1337, 1336, 1338, 1339, 1346, 1341, 1342, 1349, 1344, 1340, 1347, 1350, 1343, 1351, 1348, 1345))) AS varchar) AS mehlich_3_extractable_method	,												


--aluminum_mehlich3_extractable
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1331)) AS varchar) AS aluminum_mehlich3_extractable	,	
--arsenic_mehlich3_extractable														 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1332)) AS varchar) AS arsenic_mehlich3_extractable,																 			 															 															 	
--barium_mehlich3_extractable
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1333)) AS varchar)AS barium_mehlich3_extractable,	
--cadmium_mehlich3_extractable														 	
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1335))AS varchar) AS cadmium_mehlich3_extractable,		
 
 --calcium_mehlich3_extractable
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1334))AS varchar) AS calcium_mehlich3_extractable,																 														 														 													 														 
 --chromium_mehlich3_extractable
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1337)) AS varchar) AS chromium_mehlich3_extractable,																 				

--cobalt_mehlich3_extractable									 													 								
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1336)) AS varchar) AS cobalt_mehlich3_extractable,		
														 
														 
--copper_mehlich3_extractable														 			 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1338)) AS varchar) AS copper_mehlich3_extractable,	
--iron_mehlich3_extractable														 
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1339)) AS varchar) AS iron_mehlich3_extractable,	
														 
--lead_mehlich3_extractable														 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1346))AS varchar) AS lead_mehlich3_extractable,													


	
--magnesium_mehlich3_extractable,														 
 CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1341)) AS varchar) AS magnesium_mehlich3_extractable,	

--manganese_mehlich3_extractable,														 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1342)) AS varchar) AS manganese_mehlich3_extractable,	
--molybdenum_mehlich3_extractabl														 
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1349)) AS varchar) AS molybdenum_mehlich3_extractabl,
													 
														 															 								 								 				
--nickel_mehlich3_extractable																																																		
								CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1344))AS varchar) AS nickel_mehlich3_extractable,																 					

--phosphorus_mehlich3_extractable								 													 								
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1345)) AS varchar) AS phosphorus_mehlich3_extractable,	
														 
--potassium_mehlich3_extractable														 				 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1340)) AS varchar) AS potassium_mehlich3_extractable,	
-- selenium_mehlich3_extractable														 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1347)) AS varchar) AS selenium_mehlich3_extractable,	
														 
--silicon_mehlich3_extractable														 
CAST( (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1350)) AS varchar) AS silicon_mehlich3_extractable,													
--sodium_mehlich3_extractable
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1343)) AS varchar) AS sodium_mehlich3_extractable,		
--strontium_mehlich3_extractable														 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1351)) AS varchar) AS strontium_mehlich3_extractable,	
--zinc_mehlich3_extractable  														 
 CAST((SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key = 1348))AS varchar) AS zinc_mehlich3_extractable       
INTO  #tempXX

-------------- do no use view -- use new table here as well
FROM  dbo.layer 
INNER JOIN result_light q1 ON dbo.layer.layer_key = q1.result_source_key 
---AND natural_key= '00P00005'

WHERE        (q1.analyte_key IN (
61,67,678,
63,69,680,
65,71,682,
64,70,681,
568, 652, 653, 721, 722, 723, 791, 1152, 1154, 1160, 1161, 1287, 1288, 1289, 1290, 1291, 1292, 1440, 1441, 1442, 2099,
73, 1121,
55, 56, 683,
518, 654, 655, 736, 737, 738, 796, 1046, 1157, 1159, 1162, 1299, 1300, 1301, 1302, 1303, 1304, 1450, 1451, 1452, 2101,
62, 68, 679,
517, 619, 650, 706, 707, 708, 748, 749, 750, 751, 752, 753, 799, 1048, 1097, 1158, 1167, 1168, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1453, 1454, 1455, 1456, 1457, 1458, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2102, 
512, 618, 648, 703, 704, 705, 715, 716, 717, 718, 719, 720, 790, 1043, 1096, 1153, 1169, 1170, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1462, 1463, 1464, 1465, 1466, 1467, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045, 2104, 
514, 658, 659, 660, 661, 662, 663, 664, 665, 724, 725, 726, 727, 728, 729, 730, 731, 732, 792, 1044, 1155, 1163, 1164, 1459, 1460, 1461, 2103, 
513, 666, 667, 733, 734, 735, 793, 1045, 1156, 1165, 1166, 1293, 1294, 1295, 1296, 1297, 1298, 1447, 1448, 1449, 2100,
45, 460, 79, 461, 362, 462, 794, 1070, 1238, 2021, 2022, 780, 559, 647, 1076, 1077, 1078, 1079, 2086, 52, 51, 53, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 1071, 1072, 1073, 1074, 1075, 1090, 1091, 1092, 1093, 1094, 1095, 1846, 1847, 1848, 1849, 1850, 1851, 452, 47, 46, 50, 48, 58, 59, 57, 60,
244, 455, 247, 456, 246, 245, 41, 623, 485, 624, 358, 1147, 1363,
348, 353, 359, 357, 349, 345, 352, 350, 356, 347, 344, 360, 355, 354, 361, 570, 1030, 1171, 1172, 1173, 351, 343, 531, 620, 
651, 668, 669, 670, 675, 676, 677, 754, 755, 756, 757, 758, 759, 760, 761, 762, 801, 1174, 1175, 1176, 800, 1177, 1178, 1179, 1183, 1180, 1181, 1182, 
563, 636, 803, 1329, 1444, 1445, 1446, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1520, 1521, 1522, 1523, 2094, 2095, 2096, 2097, 787, 788, 1930,
482, 49, 249, 250, 253, 252, 248, 251, 483, 77, 1144, 1143, 1128, 1129, 1887, 1888,
1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372, 1364, 1356, 1373, 1381, 1375, 1376, 1377, 1379, 1357, 1386, 1358, 1359, 1380, 1374, 2098, 1382, 1378, 1383, 1360, 1384, 1385,
1331, 1332, 1333, 1335, 1334, 1337, 1336, 1338, 1339, 1346, 1341, 1342, 1349, 1344, 1340, 1347, 1350, 1343, 1351, 1348, 1345
)) AND (q1.result_reliability IS NULL OR
                         q1.result_reliability = '0')




	   CREATE TABLE SDA_Chemical_Properties (chemid int IDENTITY (1,1),  natural_key VARCHAR(64),  result_source_key INT,   prep_code VARCHAR(64) ,
ca_nh4_ph_7	VARCHAR(64), ca_nh4_ph_7_method	VARCHAR(64), mg_nh4_ph_7	VARCHAR(64), mg_nh4_ph_7_method	VARCHAR(64), na_nh4_ph_7	VARCHAR(64), na_nh4_ph_7_method	VARCHAR(64), k_nh4_ph_7	VARCHAR(64), k_nh4_ph_7_method	VARCHAR(64), sum_of_nh4_ph_7_Ext_bases	VARCHAR(64), acidity_bacl2_tea_ph_8_2	VARCHAR(64), acidity_bacl2_tea_ph_82_method	VARCHAR(64), aluminum_kcl_extractable	VARCHAR(64), aluminum_kcl_extract_method	VARCHAR(64), manganese_kcl_extractable	VARCHAR(64), manganese_kcl_extract_method	VARCHAR(64), iron_kcl_extractable	VARCHAR(64), iron_kcl_extractable_method	VARCHAR(64), sum_of_cations_cec_pH_8_2	VARCHAR(64), cec_nh4_ph_7	VARCHAR(64), cec_nh4_ph_7_method	VARCHAR(64), ecec_base_plus_aluminum	VARCHAR(64), aluminum_saturation	VARCHAR(64), base_sat_sum_of_cations_ph_8_2	VARCHAR(64), base_sat_nh4oac_ph_7	VARCHAR(64), total_carbon_ncs	VARCHAR(64), total_carbon_ncs_method	VARCHAR(64), total_nitrogen_ncs	VARCHAR(64), total_nitrogen_ncs_method	VARCHAR(64), total_sulfur_ncs	VARCHAR(64), total_sulfur_ncs_method	VARCHAR(64), estimated_organic_carbon	VARCHAR(64), organic_carbon_walkley_black	VARCHAR(64), oc_walkley_black_method	VARCHAR(64), carbon_to_nitrogen_ratio	VARCHAR(64), fe_dithionite_citrate_extract	VARCHAR(64), iron_dc_extract_method	VARCHAR(64), aluminum_dithionite_citrate	VARCHAR(64), aluminum_dc_extract_method	VARCHAR(64), manganese_dithionite_citrate	VARCHAR(64), manganese_dc_extract_method	VARCHAR(64), aluminum_plus_half_iron_oxalat	VARCHAR(64), ammoniumoxalate_opticaldensity	VARCHAR(64), ammonium_ox_opt_dens_method	VARCHAR(64), fe_ammoniumoxalate_extractable	VARCHAR(64), iron_ammonium_oxalate_method	VARCHAR(64), aluminum_ammonium_oxalate	VARCHAR(64), al_ammonium_oxalate_method	VARCHAR(64), silica_ammonium_oxalate	VARCHAR(64), silica_ammonium_oxalate_method	VARCHAR(64), manganese_ammonium_oxalate	VARCHAR(64), mn_ammonium_oxalate_method	VARCHAR(64), carbon_sodium_pyro_phospate	VARCHAR(64), c_na_pyro_phosphate_method	VARCHAR(64), iron_sodium_pyro_phosphate	VARCHAR(64), iron_na_pyro_phosphate_method	VARCHAR(64), aluminum_na_pyro_phosphate	VARCHAR(64), aluminum_na_pyro_phosphate_met	VARCHAR(64), manganese_na_pyro_phosphate	VARCHAR(64), mn_na_pyro_phosphate_method	VARCHAR(64), ph_kcl	VARCHAR(64), ph_kcl_method	VARCHAR(64), ph_cacl2	VARCHAR(64), ph_cacl2_method	VARCHAR(64), ph_h2o	VARCHAR(64), ph_h2o_method	VARCHAR(64), ph_saturated_paste	VARCHAR(64), ph_saturated_paste_method	VARCHAR(64), ph_oxidized	VARCHAR(64), ph_oxidized_initial	VARCHAR(64), ph_oxidized_method	VARCHAR(64), ph_naf	VARCHAR(64), ph_naf_method	VARCHAR(64), ph_water_extract	VARCHAR(64), ph_water_extract_method	VARCHAR(64), caco3_lt_2_mm	VARCHAR(64), caco3_lt_2_mm_method	VARCHAR(64), caco3_lt_20_mm	VARCHAR(64), corrected_gypsum_lt_2_mm	VARCHAR(64), corrected_gyp_lt_2_mm_method	VARCHAR(64), gypsum_lt_20_mm	VARCHAR(64), resistivity_saturated_paste	VARCHAR(64), resistivity_sp_method	VARCHAR(64), ca_satx	VARCHAR(64), ca_satx_method	VARCHAR(64), mg_satx	VARCHAR(64), mg_satx_method	VARCHAR(64), ca_plus_mg_satx	VARCHAR(64), ca_plus_mg_satx_method	VARCHAR(64), ca_to_mg_ratio	VARCHAR(64), na_satx	VARCHAR(64), na_satx_method	VARCHAR(64), k_satx	VARCHAR(64), k_satx_method	VARCHAR(64), co3_satx	VARCHAR(64), co3_satx_method	VARCHAR(64), hco3_satx	VARCHAR(64), hco3_satx_method	VARCHAR(64), co3_plus_hco3_satx	VARCHAR(64), co3_plus_hco3_satx_method	VARCHAR(64), cl_satx	VARCHAR(64), cl_satx_method	VARCHAR(64), f_satx	VARCHAR(64), f_satx_method	VARCHAR(64), po4_satx	VARCHAR(64), po4_satx_method	VARCHAR(64), br_satx	VARCHAR(64), br_satx_method	VARCHAR(64), oac_satx	VARCHAR(64), oac_satx_method	VARCHAR(64), so4_satx	VARCHAR(64), so4_satx_method	VARCHAR(64), no2_satx	VARCHAR(64), no2_satx_method	VARCHAR(64), no3_satx	VARCHAR(64), no3_satx_method	VARCHAR(64), h20_satx	VARCHAR(64), h20_satx_method	VARCHAR(64), total_estimated_salts_satx	VARCHAR(64), electrical_conductivity_satx	VARCHAR(64), electrical_cond_satx_method	VARCHAR(64), ec_predict_one_to_two	VARCHAR(64), ec_predict_one_to_two_method	VARCHAR(64), exchangeable_sodium	VARCHAR(64), sodium_absorption_ratio	VARCHAR(64), melanic_index	VARCHAR(64), melanic_index_method	VARCHAR(64), new_zealand_phosphorus_retent	VARCHAR(64), new_zealand_phos_retent_method	VARCHAR(64), phosphorus_ammonium_oxalate	VARCHAR(64), phosphorus_ammonium_oxalate_method	VARCHAR(64), phosphorus_anion_resin_one_hr	VARCHAR(64), phosphorus_anion_resin_24_hr	VARCHAR(64), phosphorus_anion_resin_method	VARCHAR(64), phosphorus_anion_resin_capacit	VARCHAR(64), phosphorus_bray1	VARCHAR(64), phosphorus_bray1_method	VARCHAR(64), phosphorus_bray2	VARCHAR(64), phosphorus_bray2_method	VARCHAR(64), phosphorus_citric_acid	VARCHAR(64), phosphorus_citric_acid_method	VARCHAR(64), phosphorus_mehlich_3	VARCHAR(64), phosphorus_mehlich_3_method	VARCHAR(64), phosphorus_olsen	VARCHAR(64), phosphorus_olsen_method	VARCHAR(64), phosphorus_water	VARCHAR(64), phosphorus_water_method	VARCHAR(64), nitrate_1m_kcl	VARCHAR(64), nitrate_1m_kcl_method	VARCHAR(64), water_extract_method	VARCHAR(64), acetate_water_extractable	VARCHAR(64), aluminum_water_extractable	VARCHAR(64), arsenic_water_extractable	VARCHAR(64), barium_water_extractable	VARCHAR(64), boron_water_extractable	VARCHAR(64), bromide_water_extractable	VARCHAR(64), cadmium_water_extractable	VARCHAR(64), calcium_water_extractable	VARCHAR(64), chloride_water_extractable	VARCHAR(64), chromium_water_extractabe	VARCHAR(64), cobalt_water_extractable	VARCHAR(64), copper_water_extracable	VARCHAR(64), ec_water_extract	VARCHAR(64), fluoride_water_extractable	VARCHAR(64), iron_water_extractable	VARCHAR(64), lead_water_extractable	VARCHAR(64), magnesium_water_extractable	VARCHAR(64), manganese_water_extractable	VARCHAR(64), molybdenum_water_extractable	VARCHAR(64), nickel_water_extractable	VARCHAR(64), nitrate_n_water_extractable	VARCHAR(64), nitrate_water_extractable	VARCHAR(64), nitrite_water_extractable	VARCHAR(64), phosphorus_water_extractable	VARCHAR(64), phosphate_water_extractable	VARCHAR(64), potassium_water_extractable	VARCHAR(64), selenium_water_extractable	VARCHAR(64), silicon_water_extractable	VARCHAR(64), sodium_water_extractable	VARCHAR(64), strontium_water_extractable	VARCHAR(64), sulfate_water_extractable	VARCHAR(64), vanadium_water_extractable	VARCHAR(64), zinc_water_extractable	VARCHAR(64), mehlich_3_extractable_method	VARCHAR(64), aluminum_mehlich3_extractable	VARCHAR(64), arsenic_mehlich3_extractable	VARCHAR(64), barium_mehlich3_extractable	VARCHAR(64), cadmium_mehlich3_extractable	VARCHAR(64), calcium_mehlich3_extractable	VARCHAR(64), chromium_mehlich3_extractable	VARCHAR(64), cobalt_mehlich3_extractable	VARCHAR(64), copper_mehlich3_extractable	VARCHAR(64), iron_mehlich3_extractable	VARCHAR(64), lead_mehlich3_extractable	VARCHAR(64), magnesium_mehlich3_extractable	VARCHAR(64), manganese_mehlich3_extractable	VARCHAR(64), molybdenum_mehlich3_extractabl	VARCHAR(64), nickel_mehlich3_extractable	VARCHAR(64), phosphorus_mehlich3_extractable	VARCHAR(64), potassium_mehlich3_extractable	VARCHAR(64), selenium_mehlich3_extractable	VARCHAR(64), silicon_mehlich3_extractable	VARCHAR(64), sodium_mehlich3_extractable	VARCHAR(64), strontium_mehlich3_extractable	VARCHAR(64), zinc_mehlich3_extractable	VARCHAR(64)
 CONSTRAINT pk_SDA_Chemical_Properties PRIMARY KEY CLUSTERED (natural_key)
	  )
	  go


INSERT INTO SDA_Chemical_Properties ( natural_key ,  result_source_key ,   prep_code  ,
	ca_nh4_ph_7	, ca_nh4_ph_7_method	, mg_nh4_ph_7	, mg_nh4_ph_7_method	, na_nh4_ph_7	, na_nh4_ph_7_method	, k_nh4_ph_7	, k_nh4_ph_7_method	, sum_of_nh4_ph_7_Ext_bases	, acidity_bacl2_tea_ph_8_2	, acidity_bacl2_tea_ph_82_method	, aluminum_kcl_extractable	, aluminum_kcl_extract_method	, manganese_kcl_extractable	, manganese_kcl_extract_method	, iron_kcl_extractable	, iron_kcl_extractable_method	, sum_of_cations_cec_pH_8_2	, cec_nh4_ph_7	, cec_nh4_ph_7_method	, ecec_base_plus_aluminum	, aluminum_saturation	, base_sat_sum_of_cations_ph_8_2	, base_sat_nh4oac_ph_7	, total_carbon_ncs	, total_carbon_ncs_method	, total_nitrogen_ncs	, total_nitrogen_ncs_method	, total_sulfur_ncs	, total_sulfur_ncs_method	, estimated_organic_carbon	, organic_carbon_walkley_black	, oc_walkley_black_method	, carbon_to_nitrogen_ratio	, fe_dithionite_citrate_extract	, iron_dc_extract_method	, aluminum_dithionite_citrate	, aluminum_dc_extract_method	, manganese_dithionite_citrate	, manganese_dc_extract_method	, aluminum_plus_half_iron_oxalat	, ammoniumoxalate_opticaldensity	, ammonium_ox_opt_dens_method	, fe_ammoniumoxalate_extractable	, iron_ammonium_oxalate_method	, aluminum_ammonium_oxalate	, al_ammonium_oxalate_method	, silica_ammonium_oxalate	, silica_ammonium_oxalate_method	, manganese_ammonium_oxalate	, mn_ammonium_oxalate_method	, carbon_sodium_pyro_phospate	, c_na_pyro_phosphate_method	, iron_sodium_pyro_phosphate	, iron_na_pyro_phosphate_method	, aluminum_na_pyro_phosphate	, aluminum_na_pyro_phosphate_met	, manganese_na_pyro_phosphate	, mn_na_pyro_phosphate_method	, ph_kcl	, ph_kcl_method	, ph_cacl2	, ph_cacl2_method	, ph_h2o	, ph_h2o_method	, ph_saturated_paste	, ph_saturated_paste_method	, ph_oxidized	, ph_oxidized_initial	, ph_oxidized_method	, ph_naf	, ph_naf_method	, ph_water_extract	, ph_water_extract_method	, caco3_lt_2_mm	, caco3_lt_2_mm_method	, caco3_lt_20_mm	, corrected_gypsum_lt_2_mm	, corrected_gyp_lt_2_mm_method	, gypsum_lt_20_mm	, resistivity_saturated_paste	, resistivity_sp_method	, ca_satx	, ca_satx_method	, mg_satx	, mg_satx_method	, ca_plus_mg_satx	, ca_plus_mg_satx_method	, ca_to_mg_ratio	, na_satx	, na_satx_method	, k_satx	, k_satx_method	, co3_satx	, co3_satx_method	, hco3_satx	, hco3_satx_method	, co3_plus_hco3_satx	, co3_plus_hco3_satx_method	, cl_satx	, cl_satx_method	, f_satx	, f_satx_method	, po4_satx	, po4_satx_method	, br_satx	, br_satx_method	, oac_satx	, oac_satx_method	, so4_satx	, so4_satx_method	, no2_satx	, no2_satx_method	, no3_satx	, no3_satx_method	, h20_satx	, h20_satx_method	, total_estimated_salts_satx	, electrical_conductivity_satx	, electrical_cond_satx_method	, ec_predict_one_to_two	, ec_predict_one_to_two_method	, exchangeable_sodium	, sodium_absorption_ratio	, melanic_index	, melanic_index_method	, new_zealand_phosphorus_retent	, new_zealand_phos_retent_method	, phosphorus_ammonium_oxalate	, phosphorus_ammonium_oxalate_method	, phosphorus_anion_resin_one_hr	, phosphorus_anion_resin_24_hr	, phosphorus_anion_resin_method	, phosphorus_anion_resin_capacit	, phosphorus_bray1	, phosphorus_bray1_method	, phosphorus_bray2	, phosphorus_bray2_method	, phosphorus_citric_acid	, phosphorus_citric_acid_method	, phosphorus_mehlich_3	, phosphorus_mehlich_3_method	, phosphorus_olsen	, phosphorus_olsen_method	, phosphorus_water	, phosphorus_water_method	, nitrate_1m_kcl	, nitrate_1m_kcl_method	, water_extract_method	, acetate_water_extractable	, aluminum_water_extractable	, arsenic_water_extractable	, barium_water_extractable	, boron_water_extractable	, bromide_water_extractable	, cadmium_water_extractable	, calcium_water_extractable	, chloride_water_extractable	, chromium_water_extractabe	, cobalt_water_extractable	, copper_water_extracable	, ec_water_extract	, fluoride_water_extractable	, iron_water_extractable	, lead_water_extractable	, magnesium_water_extractable	, manganese_water_extractable	, molybdenum_water_extractable	, nickel_water_extractable	, nitrate_n_water_extractable	, nitrate_water_extractable	, nitrite_water_extractable	, phosphorus_water_extractable	, phosphate_water_extractable	, potassium_water_extractable	, selenium_water_extractable	, silicon_water_extractable	, sodium_water_extractable	, strontium_water_extractable	, sulfate_water_extractable	, vanadium_water_extractable	, zinc_water_extractable	, mehlich_3_extractable_method	, aluminum_mehlich3_extractable	, arsenic_mehlich3_extractable	, barium_mehlich3_extractable	, cadmium_mehlich3_extractable	, calcium_mehlich3_extractable	, chromium_mehlich3_extractable	, cobalt_mehlich3_extractable	, copper_mehlich3_extractable	, iron_mehlich3_extractable	, lead_mehlich3_extractable	, magnesium_mehlich3_extractable	, manganese_mehlich3_extractable	, molybdenum_mehlich3_extractabl	, nickel_mehlich3_extractable	, phosphorus_mehlich3_extractable	, potassium_mehlich3_extractable	, selenium_mehlich3_extractable	, silicon_mehlich3_extractable	, sodium_mehlich3_extractable	, strontium_mehlich3_extractable	, zinc_mehlich3_extractable		);

SELECT natural_key ,  result_source_key ,   prep_code  , 
ca_nh4_ph_7	, ca_nh4_ph_7_method	, mg_nh4_ph_7	, mg_nh4_ph_7_method	, na_nh4_ph_7	, na_nh4_ph_7_method	, k_nh4_ph_7	, k_nh4_ph_7_method	, sum_of_nh4_ph_7_Ext_bases	, acidity_bacl2_tea_ph_8_2	, acidity_bacl2_tea_ph_82_method	, aluminum_kcl_extractable	, aluminum_kcl_extract_method	, manganese_kcl_extractable	, manganese_kcl_extract_method	, iron_kcl_extractable	, iron_kcl_extractable_method	, sum_of_cations_cec_pH_8_2	, cec_nh4_ph_7	, cec_nh4_ph_7_method	, ecec_base_plus_aluminum	, aluminum_saturation	, base_sat_sum_of_cations_ph_8_2	, base_sat_nh4oac_ph_7	, total_carbon_ncs	, total_carbon_ncs_method	, total_nitrogen_ncs	, total_nitrogen_ncs_method	, total_sulfur_ncs	, total_sulfur_ncs_method	, estimated_organic_carbon	, organic_carbon_walkley_black	, oc_walkley_black_method	, carbon_to_nitrogen_ratio	, fe_dithionite_citrate_extract	, iron_dc_extract_method	, aluminum_dithionite_citrate	, aluminum_dc_extract_method	, manganese_dithionite_citrate	, manganese_dc_extract_method	, aluminum_plus_half_iron_oxalat	, ammoniumoxalate_opticaldensity	, ammonium_ox_opt_dens_method	, fe_ammoniumoxalate_extractable	, iron_ammonium_oxalate_method	, aluminum_ammonium_oxalate	, al_ammonium_oxalate_method	, silica_ammonium_oxalate	, silica_ammonium_oxalate_method	, manganese_ammonium_oxalate	, mn_ammonium_oxalate_method	, carbon_sodium_pyro_phospate	, c_na_pyro_phosphate_method	, iron_sodium_pyro_phosphate	, iron_na_pyro_phosphate_method	, aluminum_na_pyro_phosphate	, aluminum_na_pyro_phosphate_met	, manganese_na_pyro_phosphate	, mn_na_pyro_phosphate_method	, ph_kcl	, ph_kcl_method	, ph_cacl2	, ph_cacl2_method	, ph_h2o	, ph_h2o_method	, ph_saturated_paste	, ph_saturated_paste_method	, ph_oxidized	, ph_oxidized_initial	, ph_oxidized_method	, ph_naf	, ph_naf_method	, ph_water_extract	, ph_water_extract_method	, caco3_lt_2_mm	, caco3_lt_2_mm_method	, caco3_lt_20_mm	, corrected_gypsum_lt_2_mm	, corrected_gyp_lt_2_mm_method	, gypsum_lt_20_mm	, resistivity_saturated_paste	, resistivity_sp_method	, ca_satx	, ca_satx_method	, mg_satx	, mg_satx_method	, ca_plus_mg_satx	, ca_plus_mg_satx_method	, ca_to_mg_ratio	, na_satx	, na_satx_method	, k_satx	, k_satx_method	, co3_satx	, co3_satx_method	, hco3_satx	, hco3_satx_method	, co3_plus_hco3_satx	, co3_plus_hco3_satx_method	, cl_satx	, cl_satx_method	, f_satx	, f_satx_method	, po4_satx	, po4_satx_method	, br_satx	, br_satx_method	, oac_satx	, oac_satx_method	, so4_satx	, so4_satx_method	, no2_satx	, no2_satx_method	, no3_satx	, no3_satx_method	, h20_satx	, h20_satx_method	, total_estimated_salts_satx	, electrical_conductivity_satx	, electrical_cond_satx_method	, ec_predict_one_to_two	, ec_predict_one_to_two_method	, exchangeable_sodium	, sodium_absorption_ratio	, melanic_index	, melanic_index_method	, new_zealand_phosphorus_retent	, new_zealand_phos_retent_method	, phosphorus_ammonium_oxalate	, phosphorus_ammonium_oxalate_method	, phosphorus_anion_resin_one_hr	, phosphorus_anion_resin_24_hr	, phosphorus_anion_resin_method	, phosphorus_anion_resin_capacit	, phosphorus_bray1	, phosphorus_bray1_method	, phosphorus_bray2	, phosphorus_bray2_method	, phosphorus_citric_acid	, phosphorus_citric_acid_method	, phosphorus_mehlich_3	, phosphorus_mehlich_3_method	, phosphorus_olsen	, phosphorus_olsen_method	, phosphorus_water	, phosphorus_water_method	, nitrate_1m_kcl	, nitrate_1m_kcl_method	, water_extract_method	, acetate_water_extractable	, aluminum_water_extractable	, arsenic_water_extractable	, barium_water_extractable	, boron_water_extractable	, bromide_water_extractable	, cadmium_water_extractable	, calcium_water_extractable	, chloride_water_extractable	, chromium_water_extractabe	, cobalt_water_extractable	, copper_water_extracable	, ec_water_extract	, fluoride_water_extractable	, iron_water_extractable	, lead_water_extractable	, magnesium_water_extractable	, manganese_water_extractable	, molybdenum_water_extractable	, nickel_water_extractable	, nitrate_n_water_extractable	, nitrate_water_extractable	, nitrite_water_extractable	, phosphorus_water_extractable	, phosphate_water_extractable	, potassium_water_extractable	, selenium_water_extractable	, silicon_water_extractable	, sodium_water_extractable	, strontium_water_extractable	, sulfate_water_extractable	, vanadium_water_extractable	, zinc_water_extractable	, mehlich_3_extractable_method	, aluminum_mehlich3_extractable	, arsenic_mehlich3_extractable	, barium_mehlich3_extractable	, cadmium_mehlich3_extractable	, calcium_mehlich3_extractable	, chromium_mehlich3_extractable	, cobalt_mehlich3_extractable	, copper_mehlich3_extractable	, iron_mehlich3_extractable	, lead_mehlich3_extractable	, magnesium_mehlich3_extractable	, manganese_mehlich3_extractable	, molybdenum_mehlich3_extractabl	, nickel_mehlich3_extractable	, phosphorus_mehlich3_extractable	, potassium_mehlich3_extractable	, selenium_mehlich3_extractable	, silicon_mehlich3_extractable	, sodium_mehlich3_extractable	, strontium_mehlich3_extractable	, zinc_mehlich3_extractable		

 FROM #tempXX

GO
SET STATISTICS IO OFF
GO