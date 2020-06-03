USE [master]
GO
ALTER DATABASE [NCSS_LDM] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION

USE NCSS_LDM
go


	------------------------------------------ begin - RUN THE FOLLOWING BY ITSELF


	  ---------- create a combined table to reduce the number of joins needed
	  ---------- added wlupdated column - to track changes to result_value and prep_code
	  ---------- to update data as needed -- then append new data
	  ---------- instead of recreating fresh each time
	  -------------------------------------------
	  drop TABLE IF exists result_light
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
    INNER JOIN dbo.preparation p
        ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss b
        ON r.procedure_key = b.procedure_key
           AND r.source_system_key = b.source_system_key

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
GO
SELECT TOP 1000 natural_key, result_source_key, prep_code,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM           result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (61,67,678))) AS ca_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (61,67,678))) AS ca_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (63,69,680))) AS mg_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (63,69,680))) AS mg_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM             result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (65,71,682))) AS na_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (65,71,682))) AS na_nh4_ph_7_method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM              result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND 
                                                         (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key in (64,70,681))) AS k_nh4_ph_7,
                             (SELECT        TOP (1) ISNULL(result.proced_code, '') AS Expr1
                               FROM            result_light result
                               WHERE        (result.result_type = 'layer analyte') AND (result.result_value <> '') AND (NOT (result.result_value IS NULL)) AND 
                                                         (result.result_source_key = q1.result_source_key) AND (result.prep_code = q1.prep_code) AND (result.result_reliability IS NULL OR
                                                         result.result_reliability = '0') AND (result.analyte_key IN (64,70,681))) AS k_nh4_ph_7_method,
                            
							
							 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(10, 2)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code
                                                         FROM            dbo.result_light
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (analyte_key IN (568,652,653,721,722,723,791,1291,1292,1440,2099))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code
                                                         FROM             dbo.result_light
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1154,1289,1442))
                                                         UNION
                                                         SELECT        result_value, 'S-SK' AS prep_code
                                                         FROM             dbo.result_light
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1290))
                                                         UNION
                                                         SELECT        result_value, 'M' AS prep_code
                                                         FROM             dbo.result_light
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1152,1288,1441))
                                                         UNION
                                                         SELECT        result_value, 'HM' AS prep_code
                                                         FROM             dbo.result_light
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1160))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code
                                                         FROM             dbo.result_light
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (analyte_key IN (1161,1287))) AS result_1
                               WHERE        (prep_code = q1.prep_code)) 
						AS sum_of_nh4_ph_7_Ext_bases
INTO  #tempXX

-------------- do no use view -- use new table here as well
FROM            dbo.layer 
INNER JOIN dbo.result_light q1 ON dbo.layer.layer_key = q1.result_source_key 
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

