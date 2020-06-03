--Modernized by Susan McGlasson
--Updated Jason Nemecek

-- Dylan Beaudette comments
--Thought process:
--1.	make results_light, keep data as character
--2.	attempt to convert result into numeric
--3.	for those records where conversion is NULL, use special rules
	--a.	scientific notation "fix"
	--b.	???
--4.	build wide version of table without casting
--5.	use UPDATE statements to re-format each column

-- Create a stored procedure that  
-- generates a divide-by-zero error.  

	  --https://stackoverflow.com/questions/6750021/casting-scientific-notation-from-varchar-numeric-in-a-view
USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go



	  -------------------------------------------
	  DROP TABLE IF EXISTS result_light_chem
	  DROP TABLE IF EXISTS result_light_test2
	  DROP TABLE IF EXISTS result_light
	  DROP TABLE IF EXISTS #tempXX
	  DROP TABLE IF EXISTS SDA_Chemical_Properties_layer_analyte_1

	 
	  CREATE TABLE result_light(result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12),
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  INSERT INTO result_light 
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, r.analyte_key, r.procedure_key, r.source_system_key,   result_value, p.prep_code  , b.proced_code
FROM dbo.layer AS l
INNER JOIN dbo.result AS r  ON l.layer_key = r.result_source_key 
INNER JOIN dbo.analyte AS a ON r.analyte_key = a.analyte_key 
LEFT JOIN dbo.preparation AS p ON r.prep_key = p.prep_key 
LEFT JOIN dbo.bridge_proced_ss AS b ON r.procedure_key = b.procedure_key AND 
                         r.source_system_key = b.source_system_key 
WHERE (result_type = 'layer analyte') AND 
--r.source_system_key = b.source_system_key 
 ( ((isnumeric(result_value) = 1) AND (result_value != 'nil') --AND IIF(
--TRY_CAST([result_value] AS NUMERIC) IS NULL,  1, 2 ) = 2)
		   
		   AND r.analyte_key IN (61,67,678,63,69,680,65,71,682,64,70,681,73, 253, 1121,55,56,683, 62,68,679, 45, 460, 79, 461, 362, 462, 780, 52,51, 53, 452, 47, 46, 50, 48, 58, 59, 57, 60, 244, 455, 247, 456, 246, 1147, 245, 245, 1363, 41, 485, 358, 348, 353, 788, 359, 357, 349, 345,787, 350, 352, 356, 347, 344 , 360, 355, 354, 361, 351, 343, 482, 252, 49, 1128, 1129, 249, 250, 251, 483, 248, 77, 1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372,  1356, 1373, 1381, 1375, 1376, 1377, 1379, 1357, 1386, 1358, 1359, 1380, 1374, 2098, 1382, 1378, 1383, 1360, 1384, 1385, 1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372,1364, 1356, 1373, 1381 , 1375, 1376, 1377, 1379 , 1386, 1357, 1358 , 1359  , 1380 , 1374  , 2098, 1382, 1378, 1383, 1360, 1384, 1385, 1331, 1332, 1333, 1335, 1334, 1337, 1336, 1338, 1339, 1346, 1341, 1342, 1349, 1344, 1340, 1347, 1350, 1343, 1351, 1348, 1345, 1331, 1332 , 1333, 1335, 1334, 1337 , 1336, 1338, 1339,1343, 1346, 1341, 1342, 1349, 1344, 1345, 1340, 1347, 1350,  1351,   1348)))
		   
		   
		   --IN (61, 67, 678, 63, 69, 680, 65, 71, 682, 64, 70, 681, 568, 652, 653, 721, 722, 723, 791, 1152, 1154, 1160, 1161, 1287, 1288, 1289, 1290, 1291, 1292, 1440, 1441, 1442, 2099, 73, 1121, 55, 56, 683, 518, 654, 655, 736, 737, 738, 796, 1046, 1157, 1159, 1162, 1299, 1300, 1301, 1302, 1303, 1304, 1450, 1451, 1452, 2101, 62, 68, 679, 517, 619, 650, 706, 707, 708, 748, 749, 750, 751, 752, 753, 799, 1048, 1097, 1158, 1167, 1168, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1453, 1454, 1455, 1456, 1457, 1458, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2102, 512, 618, 648, 703, 704, 705, 715, 716, 717, 718, 719, 720, 790, 1043, 1096, 1153, 1169, 1170, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1462, 1463, 1464, 1465, 1466, 1467, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045, 2104, 514, 658, 659, 660, 661, 662, 663, 664, 665, 724, 725, 726, 727, 728, 729, 730, 731, 732, 792, 1044, 1155, 1163, 1164, 1459, 1460, 1461, 2103, 513, 666, 667, 733, 734, 735, 793, 1045, 1156, 1165, 1166, 1293, 1294, 1295, 1296, 1297, 1298, 1447, 1448, 1449, 2100, 45, 460, 79, 461, 362, 462, 794, 1070, 1238, 2021, 2022, 780, 559, 647, 1076, 1077, 1078, 1079, 2086, 52, 51, 53, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 1071, 1072, 1073, 1074, 1075, 1090, 1091, 1092, 1093, 1094, 1095, 1846, 1847, 1848, 1849, 1850, 1851, 452, 47, 46, 50, 48, 58, 59, 57, 60, 244, 455, 247, 456, 246, 245, 41, 623, 485, 624, 358, 1147, 1363, 348, 353, 359, 357, 349, 345, 352, 350, 356, 347, 344, 360, 355, 354, 361, 570, 1030, 1171, 1172, 1173, 351, 343, 531, 620, 651, 668, 669, 670, 675, 676, 677, 754, 755, 756, 757, 758, 759, 760, 761, 762, 801, 1174, 1175, 1176, 800, 1177, 1178, 1179, 1183, 1180, 1181, 1182, 563, 636, 803, 1329, 1444, 1445, 1446, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1520, 1521, 1522, 1523, 2094, 2095, 2096, 2097, 787, 788, 1930, 482, 49, 249, 250, 253, 252, 248, 251, 483, 77, 1144, 1143, 1128, 1129, 1887, 1888, 1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372, 1364, 1356, 1373, 1381, 1375, 1376, 1377, 1379, 1357, 1386, 1358, 1359, 1380, 1374, 2098, 1382, 1378, 1383, 1360, 1384, 1385, 1331, 1332, 1333, 1335, 1334, 1337, 1336, 1338, 1339, 1346, 1341, 1342, 1349, 1344, 1340, 1347, 1350, 1343, 1351, 1348, 1345))



	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX result_light_prep_code_idx5 ON  result_light (prep_code)


GO
SET STATISTICS IO ON
GO

SELECT   natural_key AS labsampnum , result_source_key, prep_code,

--ca_nh4_ph_7 g
                        (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
                               FROM           result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (61,67,678))) AS ca_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (61,67,678))) AS ca_nh4_ph_7_method,


--mg_nh4_ph_7 g
                              (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
						   --(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (63,69,680))) AS mg_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (63,69,680))) AS mg_nh4_ph_7_method,

--na_nh4_ph_7 g
                            (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
						  -- (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
                               FROM             result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (65,71,682))) AS na_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (65,71,682))) AS na_nh4_ph_7_method,

--k_nh4_ph_7 g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
                          (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (64,70,681))) AS k_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (64,70,681))) AS k_nh4_ph_7_method,
                            



--acidity_bacl2_tea_ph_8_2 g
								--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
													  
								 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
													   FROM              result_light result
													   WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
																				 (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
																				 ) AND (result.analyte_key in (73, 1121))) AS acidity_bacl2_tea_ph_8_2,
													  (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
													   FROM            result_light result
													   WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
																				 (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
																				 ) AND (result.analyte_key IN (73, 1121))) AS acidity_bacl2_tea_ph_82_method,

--aluminum_kcl_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					         --  (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (55))) AS aluminum_kcl_extractable,		          
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (55))) AS aluminum_kcl_extract_method,

--manganese_kcl_extractable g
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(str(cast(result.result_value as real))), '4.1') AS decimal(10, 2)) AS Expr1
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (56))) AS manganese_kcl_extractable,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (56))) AS manganese_kcl_extract_method,

--iron_kcl_extractable g
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (683))) AS iron_kcl_extractable,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (683))) AS iron_kcl_extractable_method,





--cec_nh4_ph_7 g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
							 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (62,68,679))) AS cec_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (62,68,679))) AS cec_nh4_ph_7_method,

					
--total_carbon_ncs	 g	
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
				
		          (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
												FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (45, 460))) AS total_carbon_ncs,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (45, 460))) AS total_carbon_ncs_method,
														 
---total_nitrogen_ncs		g												 		
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(str(cast(result.result_value as real))), '5.3') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (79, 461))) AS total_nitrogen_ncs,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (79, 461))) AS total_nitrogen_ncs_method,	
														 
---total_sulfur_ncs		g												 
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key in (362, 462))) AS total_sulfur_ncs,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (362, 462))) AS total_sulfur_ncs_method,	



---organic_carbon_walkley_black g
								--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(str(cast(result.result_value as real))), '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 780)) AS organic_carbon_walkley_black,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 780)) AS oc_walkley_black_method,	



---fe_dithionite_citrate_extract g																	 
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 52)) AS fe_dithionite_citrate_extract,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 52)) AS iron_dc_extract_method,	

--aluminum_dithionite_citrate g
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
					--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 51)) AS aluminum_dithionite_citrate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 51)) AS aluminum_dc_extract_method,	

--manganese_dithionite_citrate g
					--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
					(SELECT      TOP (1) CAST(ROUND (  CAST (LTRIM(cast(result.result_value as real)) AS float), 1) AS decimal(10, 3)) AS Expr1 
					-- TOP (1) CAST(ROUND (  CAST (LTRIM(str(cast(result.result_value as real))) AS float), 1) AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 53)) AS manganese_dithionite_citrate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 53)) AS manganese_dc_extract_method,	



--ammoniumoxalate_opticaldensity 	g												 								 								 
								--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '4.2') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 452)) AS ammoniumoxalate_opticaldensity,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 452)) AS ammonium_ox_opt_dens_method,	

--fe_ammoniumoxalate_extractable g
						--(SELECT        TOP (1) CAST(cast(result.result_value as real) AS decimal(10, 2)) AS Expr1
						(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '4.2') AS decimal(10, 2)) AS Expr1
						--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 47)) AS fe_ammoniumoxalate_extractable,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 47)) AS iron_ammonium_oxalate_method,	


--aluminum_ammonium_oxalate
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 46)) AS aluminum_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 46)) AS al_ammonium_oxalate_method,	

--silica_ammonium_oxalate g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 50)) AS silica_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 50)) AS silica_ammonium_oxalate_method,	

--manganese_ammonium_oxalate g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '7.1') AS decimal(10, 1)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 48)) AS manganese_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 48)) AS mn_ammonium_oxalate_method,	

--carbon_sodium_pyro_phospate g
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '5.1') AS decimal(10, 1)) AS Expr1
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 58)) AS carbon_sodium_pyro_phospate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 58)) AS c_na_pyro_phosphate_method,	

--iron_sodium_pyro_phosphate g
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '5.1') AS decimal(10, 1)) AS Expr1
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 59)) AS iron_sodium_pyro_phosphate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 59)) AS iron_na_pyro_phosphate_method,	
				
--aluminum_na_pyro_phosphate	g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1			
									(SELECT        TOP (1) CAST(dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '5.1') AS decimal(10, 1)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 57)) AS aluminum_na_pyro_phosphate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 57)) AS aluminum_na_pyro_phosphate_met,	


--manganese_na_pyro_phosphate	(Possible Flag Might need to revert back to AsymArithRnd)	g												 
							 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
							-- (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 60)) AS manganese_na_pyro_phosphate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 60)) AS mn_na_pyro_phosphate_method,
														 
														 	
--ph_kcl	g													 								 
							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 244)) AS ph_kcl,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 244)) AS ph_kcl_method, 


--ph_cacl2 g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
							(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 455)) AS ph_cacl2,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 455)) AS ph_cacl2_method, 

--ph_h2o g
-- (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
				(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1  
                                                         ) AND (result.analyte_key = 247)) AS ph_h2o,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 247)) AS ph_h2o_method, 


--ph_saturated_paste	g													 
									--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
									(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 456)) AS ph_saturated_paste,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 456)) AS ph_saturated_paste_method, 

----ph_oxidized g
							--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 246)) AS ph_oxidized,
								
								--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1147)) AS ph_oxidized_initial,
							 (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (246,1147))) AS ph_oxidized_method, 


--ph_naf
         				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
						(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 245)) AS ph_naf,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 245)) AS ph_naf_method, 

--ph_water_extract g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1363)) AS ph_water_extract,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1363)) AS ph_water_extract_method, 	
														 
--caco3_lt_2_mm g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) dbo.AsymArithRnd(LTRIM(cast(result.result_value as real)), '3.0') AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 41)) AS caco3_lt_2_mm,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 41)) AS caco3_lt_2_mm_method, 	



--End check
														 
--corrected_gypsum_lt_2_mm (Possible Flag Might need to revert back to AsymArithRnd)g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 485)) AS corrected_gypsum_lt_2_mm,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 485)) AS corrected_gyp_lt_2_mm_method, 		
														 
														 													 
														 														 												 



--resistivity_saturated_paste g
	 			--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '7.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 358)) AS resistivity_saturated_paste,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 358)) AS resistivity_sp_method, 	
														 
--ca_satx g
	 							--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
								(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 348)) AS ca_satx,
							  (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 348)) AS ca_satx_method,
														 
														  
--mg_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 353)) AS mg_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 353)) AS mg_satx_method,


--ca_plus_mg_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 788)) AS ca_plus_mg_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 788)) AS ca_plus_mg_satx_method,





--na_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 359)) AS na_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 359)) AS na_satx_method,


--k_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 357)) AS k_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 357)) AS k_satx_method,


--co3_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 349)) AS co3_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 349)) AS co3_satx_method,

--hco3_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10,2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 345)) AS hco3_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 345)) AS hco3_satx_method,


--co3_plus_hco3_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 787)) AS co3_plus_hco3_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 787)) AS co3_plus_hco3_satx_method,


--cl_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE      (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 350)) AS cl_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 350)) AS cl_satx_method,

--f_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 352)) AS f_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 352)) AS f_satx_method,



--po4_satx (Possible Flag Might need to revert back to AsymArithRnd)g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 356)) AS po4_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 356)) AS po4_satx_method,

--br_satx (Possible Flag Might need to revert back to AsymArithRnd)g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 347)) AS br_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 347)) AS br_satx_method,

--oac_satx (Possible Flag Might need to revert back to AsymArithRnd) g
	 			--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 344)) AS oac_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 344)) AS oac_satx_method,



--so4_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 360)) AS so4_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 360)) AS so4_satx_method,


--no2_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 355)) AS no2_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 355)) AS no2_satx_method,

--no3_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 354)) AS no3_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 354)) AS no3_satx_method,

--h20_satx g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 361)) AS h20_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 361)) AS h20_satx_method,


--electrical_conductivity_satx
	 				
				--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 351)) AS electrical_conductivity_satx,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 351)) AS electrical_cond_satx_method,


--ec_predict_one_to_two
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 2) AS decimal(10, 2)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 343)) AS ec_predict_one_to_two,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 343)) AS ec_predict_one_to_two_method,





--melanic_index
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 482)) AS melanic_index,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 482)) AS melanic_index_method,


--new_zealand_phosphorus_retent
	 				(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 252)) AS new_zealand_phosphorus_retent,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 252)) AS new_zealand_phos_retent_method,


--phosphorus_ammonium_oxalate g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
	 				(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 49)) AS phosphorus_ammonium_oxalate,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 49)) AS phosphorus_ammonium_oxalate_method,


--phosphorus_anion_resin g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1128)) AS phosphorus_anion_resin_one_hr,



	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1129)) AS phosphorus_anion_resin_24_hr,
              


			               (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (1128,1129))) AS phosphorus_anion_resin_method,




--phosphorus_bray1 (Possible Flag Might need to revert back to AsymArithRnd) g
	 			--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 249)) AS phosphorus_bray1,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 249)) AS phosphorus_bray1_method,
														 													 
														 
														 	
--phosphorus_bray2 g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 250)) AS phosphorus_bray2,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 250)) AS phosphorus_bray2_method,



--phosphorus_citric_acid (Modified need to double check) g

	 			--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 251)) AS phosphorus_citric_acid,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 251)) AS phosphorus_citric_acid_method,




--phosphorus_mehlich_3 g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 483)) AS phosphorus_mehlich_3,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 483)) AS phosphorus_mehlich_3_method,

--phosphorus_olsen g
	 			--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 253)) AS phosphorus_olsen,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 253)) AS phosphorus_olsen_method,


--phosphorus_water g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 248)) AS phosphorus_water,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 248)) AS phosphorus_water_method,

--nitrate_1m_kcl g
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 77)) AS nitrate_1m_kcl,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 77)) AS nitrate_1m_kcl_method,	
--water_extract_method	(conversion stop)													 													 													 												 														 
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (1352, 1365, 1366, 1367, 1353, 1354, 1369, 1368, 1355, 1371, 1370, 1372, 1364, 1356, 1373, 1381, 1375, 1376, 1377, 1379, 1357, 1386, 1358, 1359, 1380, 1374, 2098, 1382, 1378, 1383, 1360, 1384, 1385))) AS water_extract_method	,															 	

--acetate_water_extractable
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1352)) AS acetate_water_extractable,

--aluminum_water_extractable
	 			--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1365)) AS aluminum_water_extractable,
--arsenic_water_extractable
	 				--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1366)) AS arsenic_water_extractable,
---barium_water_extractable
	 			--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
					(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1367)) AS  barium_water_extractable,
-- boron_water_extractable g
					--	(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
						(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1353)) AS  boron_water_extractable,
--bromide_water_extractable g
	--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1354)) AS  bromide_water_extractable, 
--cadmium_water_extractable g
	--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
	(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1369)) AS  cadmium_water_extractable, 


--calcium_water_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--Error converting data type varchar to numeric.
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(18, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1368)) AS  calcium_water_extractable, 
--chloride_water_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(18, 3)) AS Expr1
--Error converting data type varchar to numeric.
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1355)) AS  chloride_water_extractable, 
--chromium_water_extractabe g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1371)) AS  chromium_water_extractabe, 

--cobalt_water_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1370)) AS  cobalt_water_extractable, 
--copper_water_extracable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1372)) AS  copper_water_extracable, 
														 
--ec_water_extract	g	 												 	
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1364)) AS  ec_water_extract,
--fluoride_water_extractable	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1356)) AS  fluoride_water_extractable,	
--iron_water_extractable	g													 													 															 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1373)) AS  iron_water_extractable,	
--lead_water_extractable	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1381)) AS  lead_water_extractable,	

--magnesium_water_extractable	g												 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
--Go back to 1380 if there is a problem
--Msg 8114, Level 16, State 5, Line 84
--Error converting data type varchar to numeric.
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(18, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1375)) AS  magnesium_water_extractable, 
														 															 														 											-
--manganese_water_extractable	g							 
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1376)) AS  manganese_water_extractable, 

--molybdenum_water_extractable g
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1377)) AS  molybdenum_water_extractable,
--nickel_water_extractable	g													 														 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1379)) AS  nickel_water_extractable,
--nitrate_n_water_extractabl g														 
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '6.2') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1386)) AS  nitrate_n_water_extractable,	
--nitrate_water_extractable
--Error converting data type varchar to numeric.
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE       (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1357)) AS  nitrate_water_extractable,

--nitrite_water_extractable
--Error converting data type varchar to numeric.
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1358)) AS  nitrite_water_extractable,
														 
--phosphorus_water_extractable	(Possible Flag Might need to revert back to AsymArithRnd)													 	
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '5.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1359)) AS  phosphorus_water_extractable,
--phosphate_water_extractable													 	
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1380)) AS  phosphate_water_extractable,

														 
--potassium_water_extractable	
--Msg 8114, Level 16, State 5, Line 108
--Error converting data type varchar to numeric.													 
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1374)) AS potassium_water_extractable,
--selenium_water_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 2098)) AS selenium_water_extractable,

														 
--silicon_water_extractable														 														 					
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--Error converting data type varchar to numeric.
 --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(18, 5)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1382)) AS silicon_water_extractable,
--sodium_water_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--Error converting data type varchar to numeric.
--(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(18, 5)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1378)) AS sodium_water_extractable,
--strontium_water_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1383)) AS strontium_water_extractable,
--sulfate_water_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
--Error converting data type varchar to numeric.
(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(18, 5)) AS Expr1
 --(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1360)) AS sulfate_water_extractable,

--vanadium_water_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1384)) AS vanadium_water_extractable,
 
 --zinc_water_extractable
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1385)) AS zinc_water_extractable,									 
														 
--mehlich_3_extractable												 													 													 												 														 
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key IN (1331, 1332, 1333, 1335, 1334, 1337, 1336, 1338, 1339, 1346, 1341, 1342, 1349, 1344, 1340, 1347, 1350, 1343, 1351, 1348, 1345))) AS mehlich_3_extractable_method	,												


--aluminum_mehlich3_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1331)) AS aluminum_mehlich3_extractable	,	
--arsenic_mehlich3_extractable	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1332)) AS arsenic_mehlich3_extractable,																 			 															 															 	
--barium_mehlich3_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1333)) AS barium_mehlich3_extractable,	
--cadmium_mehlich3_extractable	g													 	
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1335)) AS cadmium_mehlich3_extractable,		
 
 --calcium_mehlich3_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1334)) AS calcium_mehlich3_extractable,																 														 														 													 														 
 --chromium_mehlich3_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1337)) AS chromium_mehlich3_extractable,																 				

--cobalt_mehlich3_extractable	g								 													 								
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1336)) AS cobalt_mehlich3_extractable,		
														 
														 
--copper_mehlich3_extractable	g													 			 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1338)) AS copper_mehlich3_extractable,	
--iron_mehlich3_extractable		g												 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1339)) AS iron_mehlich3_extractable,	
														 
--lead_mehlich3_extractable	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1346)) AS lead_mehlich3_extractable,													


	
--magnesium_mehlich3_extractable,	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1341)) AS magnesium_mehlich3_extractable,	

--manganese_mehlich3_extractable,	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1342)) AS manganese_mehlich3_extractable,	
--molybdenum_mehlich3_extractabl	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1349)) AS molybdenum_mehlich3_extractabl,
													 
														 															 								 								 				
--nickel_mehlich3_extractable	g																																																
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1344)) AS nickel_mehlich3_extractable,																 					

--phosphorus_mehlich3_extractable g								 													 								
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1345)) AS phosphorus_mehlich3_extractable,	
														 
--potassium_mehlich3_extractable g	 													 				 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1340)) AS potassium_mehlich3_extractable,	
-- selenium_mehlich3_extractable g														 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1347)) AS selenium_mehlich3_extractable,	
														 
--silicon_mehlich3_extractable	g													 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                                FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1350)) AS silicon_mehlich3_extractable,													
--sodium_mehlich3_extractable g
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1343)) AS sodium_mehlich3_extractable,		
--strontium_mehlich3_extractable g														 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1351)) AS strontium_mehlich3_extractable,	
--zinc_mehlich3_extractable  g														 
--(SELECT        TOP (1) CAST(ROUND (  CAST (result.result_value AS float), 3) AS decimal(10, 3)) AS Expr1
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.1') AS decimal(10, 3)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1
                                                         ) AND (result.analyte_key = 1348)) AS zinc_mehlich3_extractable       
INTO  #tempXX
FROM  dbo.layer 
INNER JOIN result_light q1 ON dbo.layer.layer_key = q1.result_source_key 


SELECT labsampnum,result_source_key,prep_code,ca_nh4_ph_7,ca_nh4_ph_7_method,mg_nh4_ph_7,mg_nh4_ph_7_method,na_nh4_ph_7,na_nh4_ph_7_method,k_nh4_ph_7,k_nh4_ph_7_method,acidity_bacl2_tea_ph_8_2,acidity_bacl2_tea_ph_82_method,aluminum_kcl_extractable,aluminum_kcl_extract_method,manganese_kcl_extractable,manganese_kcl_extract_method,iron_kcl_extractable,iron_kcl_extractable_method,cec_nh4_ph_7,cec_nh4_ph_7_method,total_carbon_ncs,total_carbon_ncs_method,total_nitrogen_ncs,total_nitrogen_ncs_method,total_sulfur_ncs,total_sulfur_ncs_method,organic_carbon_walkley_black,oc_walkley_black_method,fe_dithionite_citrate_extract,iron_dc_extract_method,aluminum_dithionite_citrate,aluminum_dc_extract_method,manganese_dithionite_citrate,manganese_dc_extract_method,ammoniumoxalate_opticaldensity,ammonium_ox_opt_dens_method,fe_ammoniumoxalate_extractable,iron_ammonium_oxalate_method,aluminum_ammonium_oxalate,al_ammonium_oxalate_method,silica_ammonium_oxalate,silica_ammonium_oxalate_method,manganese_ammonium_oxalate,mn_ammonium_oxalate_method,carbon_sodium_pyro_phospate,c_na_pyro_phosphate_method,iron_sodium_pyro_phosphate,iron_na_pyro_phosphate_method,aluminum_na_pyro_phosphate,aluminum_na_pyro_phosphate_met,manganese_na_pyro_phosphate,mn_na_pyro_phosphate_method,ph_kcl,ph_kcl_method,ph_cacl2,ph_cacl2_method,ph_h2o,ph_h2o_method,ph_saturated_paste,ph_saturated_paste_method,ph_oxidized,ph_oxidized_initial,ph_oxidized_method,ph_naf,ph_naf_method,ph_water_extract,ph_water_extract_method,caco3_lt_2_mm,caco3_lt_2_mm_method,corrected_gypsum_lt_2_mm,corrected_gyp_lt_2_mm_method,resistivity_saturated_paste,resistivity_sp_method,ca_satx,ca_satx_method,mg_satx,mg_satx_method,ca_plus_mg_satx,ca_plus_mg_satx_method,na_satx,na_satx_method,k_satx,k_satx_method,co3_satx,co3_satx_method,hco3_satx,hco3_satx_method,co3_plus_hco3_satx,co3_plus_hco3_satx_method,cl_satx,cl_satx_method,f_satx,f_satx_method,po4_satx,po4_satx_method,br_satx,br_satx_method,oac_satx,oac_satx_method,so4_satx,so4_satx_method,no2_satx,no2_satx_method,no3_satx,no3_satx_method,h20_satx,h20_satx_method,electrical_conductivity_satx,electrical_cond_satx_method,ec_predict_one_to_two,ec_predict_one_to_two_method,melanic_index,melanic_index_method,new_zealand_phosphorus_retent,new_zealand_phos_retent_method,phosphorus_ammonium_oxalate,phosphorus_ammonium_oxalate_method,phosphorus_anion_resin_one_hr,phosphorus_anion_resin_24_hr,phosphorus_anion_resin_method,phosphorus_bray1,phosphorus_bray1_method,phosphorus_bray2,phosphorus_bray2_method,phosphorus_citric_acid,phosphorus_citric_acid_method,phosphorus_mehlich_3,phosphorus_mehlich_3_method,phosphorus_olsen,phosphorus_olsen_method,phosphorus_water,phosphorus_water_method,nitrate_1m_kcl,nitrate_1m_kcl_method,water_extract_method,acetate_water_extractable,aluminum_water_extractable,arsenic_water_extractable,barium_water_extractable,boron_water_extractable,bromide_water_extractable,cadmium_water_extractable,calcium_water_extractable,chloride_water_extractable,chromium_water_extractabe,cobalt_water_extractable,copper_water_extracable,ec_water_extract,fluoride_water_extractable,iron_water_extractable,lead_water_extractable,magnesium_water_extractable,manganese_water_extractable,molybdenum_water_extractable,nickel_water_extractable,nitrate_n_water_extractable,nitrate_water_extractable,nitrite_water_extractable,phosphorus_water_extractable,phosphate_water_extractable,potassium_water_extractable,selenium_water_extractable,silicon_water_extractable,sodium_water_extractable,strontium_water_extractable,sulfate_water_extractable,vanadium_water_extractable,zinc_water_extractable,mehlich_3_extractable_method,aluminum_mehlich3_extractable,arsenic_mehlich3_extractable,barium_mehlich3_extractable,cadmium_mehlich3_extractable,calcium_mehlich3_extractable,chromium_mehlich3_extractable,cobalt_mehlich3_extractable,copper_mehlich3_extractable,iron_mehlich3_extractable,lead_mehlich3_extractable,magnesium_mehlich3_extractable,manganese_mehlich3_extractable,molybdenum_mehlich3_extractabl,nickel_mehlich3_extractable,phosphorus_mehlich3_extractable,potassium_mehlich3_extractable,selenium_mehlich3_extractable,silicon_mehlich3_extractable,sodium_mehlich3_extractable,strontium_mehlich3_extractable,zinc_mehlich3_extractable
INTO SDA_Chemical_Properties_layer_analyte_1
FROM #tempXX
GROUP BY labsampnum,result_source_key,prep_code,ca_nh4_ph_7,ca_nh4_ph_7_method,mg_nh4_ph_7,mg_nh4_ph_7_method,na_nh4_ph_7,na_nh4_ph_7_method,k_nh4_ph_7,k_nh4_ph_7_method,acidity_bacl2_tea_ph_8_2,acidity_bacl2_tea_ph_82_method,aluminum_kcl_extractable,aluminum_kcl_extract_method,manganese_kcl_extractable,manganese_kcl_extract_method,iron_kcl_extractable,iron_kcl_extractable_method,cec_nh4_ph_7,cec_nh4_ph_7_method,total_carbon_ncs,total_carbon_ncs_method,total_nitrogen_ncs,total_nitrogen_ncs_method,total_sulfur_ncs,total_sulfur_ncs_method,organic_carbon_walkley_black,oc_walkley_black_method,fe_dithionite_citrate_extract,iron_dc_extract_method,aluminum_dithionite_citrate,aluminum_dc_extract_method,manganese_dithionite_citrate,manganese_dc_extract_method,ammoniumoxalate_opticaldensity,ammonium_ox_opt_dens_method,fe_ammoniumoxalate_extractable,iron_ammonium_oxalate_method,aluminum_ammonium_oxalate,al_ammonium_oxalate_method,silica_ammonium_oxalate,silica_ammonium_oxalate_method,manganese_ammonium_oxalate,mn_ammonium_oxalate_method,carbon_sodium_pyro_phospate,c_na_pyro_phosphate_method,iron_sodium_pyro_phosphate,iron_na_pyro_phosphate_method,aluminum_na_pyro_phosphate,aluminum_na_pyro_phosphate_met,manganese_na_pyro_phosphate,mn_na_pyro_phosphate_method,ph_kcl,ph_kcl_method,ph_cacl2,ph_cacl2_method,ph_h2o,ph_h2o_method,ph_saturated_paste,ph_saturated_paste_method,ph_oxidized,ph_oxidized_initial,ph_oxidized_method,ph_naf,ph_naf_method,ph_water_extract,ph_water_extract_method,caco3_lt_2_mm,caco3_lt_2_mm_method,corrected_gypsum_lt_2_mm,corrected_gyp_lt_2_mm_method,resistivity_saturated_paste,resistivity_sp_method,ca_satx,ca_satx_method,mg_satx,mg_satx_method,ca_plus_mg_satx,ca_plus_mg_satx_method,na_satx,na_satx_method,k_satx,k_satx_method,co3_satx,co3_satx_method,hco3_satx,hco3_satx_method,co3_plus_hco3_satx,co3_plus_hco3_satx_method,cl_satx,cl_satx_method,f_satx,f_satx_method,po4_satx,po4_satx_method,br_satx,br_satx_method,oac_satx,oac_satx_method,so4_satx,so4_satx_method,no2_satx,no2_satx_method,no3_satx,no3_satx_method,h20_satx,h20_satx_method,electrical_conductivity_satx,electrical_cond_satx_method,ec_predict_one_to_two,ec_predict_one_to_two_method,melanic_index,melanic_index_method,new_zealand_phosphorus_retent,new_zealand_phos_retent_method,phosphorus_ammonium_oxalate,phosphorus_ammonium_oxalate_method,phosphorus_anion_resin_one_hr,phosphorus_anion_resin_24_hr,phosphorus_anion_resin_method,phosphorus_bray1,phosphorus_bray1_method,phosphorus_bray2,phosphorus_bray2_method,phosphorus_citric_acid,phosphorus_citric_acid_method,phosphorus_mehlich_3,phosphorus_mehlich_3_method,phosphorus_olsen,phosphorus_olsen_method,phosphorus_water,phosphorus_water_method,nitrate_1m_kcl,nitrate_1m_kcl_method,water_extract_method,acetate_water_extractable,aluminum_water_extractable,arsenic_water_extractable,barium_water_extractable,boron_water_extractable,bromide_water_extractable,cadmium_water_extractable,calcium_water_extractable,chloride_water_extractable,chromium_water_extractabe,cobalt_water_extractable,copper_water_extracable,ec_water_extract,fluoride_water_extractable,iron_water_extractable,lead_water_extractable,magnesium_water_extractable,manganese_water_extractable,molybdenum_water_extractable,nickel_water_extractable,nitrate_n_water_extractable,nitrate_water_extractable,nitrite_water_extractable,phosphorus_water_extractable,phosphate_water_extractable,potassium_water_extractable,selenium_water_extractable,silicon_water_extractable,sodium_water_extractable,strontium_water_extractable,sulfate_water_extractable,vanadium_water_extractable,zinc_water_extractable,mehlich_3_extractable_method,aluminum_mehlich3_extractable,arsenic_mehlich3_extractable,barium_mehlich3_extractable,cadmium_mehlich3_extractable,calcium_mehlich3_extractable,chromium_mehlich3_extractable,cobalt_mehlich3_extractable,copper_mehlich3_extractable,iron_mehlich3_extractable,lead_mehlich3_extractable,magnesium_mehlich3_extractable,manganese_mehlich3_extractable,molybdenum_mehlich3_extractabl,nickel_mehlich3_extractable,phosphorus_mehlich3_extractable,potassium_mehlich3_extractable,selenium_mehlich3_extractable,silicon_mehlich3_extractable,sodium_mehlich3_extractable,strontium_mehlich3_extractable,zinc_mehlich3_extractable

CREATE INDEX  SDA_Chemical_Properties_layer_analyte_1_idx1c ON  SDA_Chemical_Properties_layer_analyte_1 (labsampnum, result_source_key) INCLUDE (prep_code)
CREATE INDEX  SDA_Chemical_Properties_layer_analyte_1_result_source_key_idx2 ON  SDA_Chemical_Properties_layer_analyte_1 (result_source_key )
CREATE INDEX  SDA_Chemical_Properties_layer_analyte_1_prep_code_idx5 ON  SDA_Chemical_Properties_layer_analyte_1 (prep_code)

GO
SET STATISTICS IO OFF
GO






