USE NCSS_LDM
GO

/*
-----------------  31 seconds

Table '#tempXX_____________________________________________________________________________________________________________00000000002E'. Scan count 0, logical reads 6229049, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 11253, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'result'. Scan count 94, logical reads 419500, physical reads 9, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'bridge_proced_ss'. Scan count 5, logical reads 18, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'preparation'. Scan count 9, logical reads 20, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'analyte'. Scan count 1, logical reads 97, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'layer'. Scan count 1, logical reads 714, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(6155967 rows affected)

*/

---------------------------- Original SQL -- with out using chemical_property_list view
---------------------------- run the following
GO
SET STATISTICS IO ON 
GO 

----------------------- run again with sql at end and not the chemical_properties_list view
--------- write results to either a temp table or a real table -- instead of displaying in SSMS
DROP TABLE IF EXISTS #tempXX;
DROP TABLE IF EXISTS SDA_Chemical_Properties;
GO
SELECT natural_key,
       result_source_key,
       prep_code,
       (
           SELECT TOP (1)
               CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS DECIMAL(10, 2)) AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 61, 67, 678 ))
       ) AS ca_nh4_ph_7,
       (
           SELECT TOP (1)
               ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
               LEFT OUTER JOIN dbo.bridge_proced_ss
                   ON result.procedure_key = bridge_proced_ss.procedure_key
                      AND result.source_system_key = bridge_proced_ss.source_system_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_value <> '')
                 AND (NOT (result.result_value IS NULL))
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 61, 67, 678 ))
       ) AS ca_nh4_ph_7_method,
       (
           SELECT TOP (1)
               CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS DECIMAL(10, 2)) AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 63, 69, 680 ))
       ) AS mg_nh4_ph_7,
       (
           SELECT TOP (1)
               ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
               LEFT OUTER JOIN dbo.bridge_proced_ss
                   ON result.procedure_key = bridge_proced_ss.procedure_key
                      AND result.source_system_key = bridge_proced_ss.source_system_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_value <> '')
                 AND (NOT (result.result_value IS NULL))
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 63, 69, 680 ))
       ) AS mg_nh4_ph_7_method,
       (
           SELECT TOP (1)
               CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS DECIMAL(10, 2)) AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 65, 71, 682 ))
       ) AS na_nh4_ph_7,
       (
           SELECT TOP (1)
               ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
               LEFT OUTER JOIN dbo.bridge_proced_ss
                   ON result.procedure_key = bridge_proced_ss.procedure_key
                      AND result.source_system_key = bridge_proced_ss.source_system_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_value <> '')
                 AND (NOT (result.result_value IS NULL))
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 65, 71, 682 ))
       ) AS na_nh4_ph_7_method,
       (
           SELECT TOP (1)
               CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS DECIMAL(10, 2)) AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 64, 70, 681 ))
       ) AS k_nh4_ph_7,
       (
           SELECT TOP (1)
               ISNULL(bridge_proced_ss.proced_code, '') AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
               LEFT OUTER JOIN dbo.bridge_proced_ss
                   ON result.procedure_key = bridge_proced_ss.procedure_key
                      AND result.source_system_key = bridge_proced_ss.source_system_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_value <> '')
                 AND (NOT (result.result_value IS NULL))
                 AND (result.result_source_key = result.result_source_key)
                 AND (preparation.prep_code = preparation.prep_code)
                 AND (
                         result.result_reliability IS NULL
                         OR result.result_reliability = '0'
                     )
                 AND (result.analyte_key IN ( 64, 70, 681 ))
       ) AS k_nh4_ph_7_method,
       (
           SELECT TOP (1)
               CAST(dbo.AsymArithRnd(result_value, '4.1') AS DECIMAL(10, 2)) AS Expr1
           FROM
           (
               SELECT result_value,
                      'S' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = result.result_source_key)
                     AND (analyte_key IN ( 568, 652, 653, 721, 722, 723, 791, 1291, 1292, 1440, 2099 ))
               UNION
               SELECT result_value,
                      'N' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = result.result_source_key)
                     AND (analyte_key IN ( 1154, 1289, 1442 ))
               UNION
               SELECT result_value,
                      'S-SK' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = result.result_source_key)
                     AND (analyte_key IN ( 1290 ))
               UNION
               SELECT result_value,
                      'M' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = result.result_source_key)
                     AND (analyte_key IN ( 1152, 1288, 1441 ))
               UNION
               SELECT result_value,
                      'HM' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = result.result_source_key)
                     AND (analyte_key IN ( 1160 ))
               UNION
               SELECT result_value,
                      'GP' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = result.result_source_key)
                     AND (analyte_key IN ( 1161, 1287 ))
           ) AS result_1
           WHERE (prep_code = preparation.prep_code)
       ) AS sum_of_nh4_ph_7_Ext_bases
INTO SDA_Chemical_Properties

FROM            dbo.layer 
INNER JOIN dbo.result q1 ON dbo.layer.layer_key = q1.result_source_key 
INNER JOIN dbo.analyte ON q1.analyte_key = dbo.analyte.analyte_key 
LEFT JOIN dbo.preparation ON q1.prep_key = dbo.preparation.prep_key 
LEFT JOIN dbo.bridge_proced_ss ON q1.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                         q1.source_system_key = dbo.bridge_proced_ss.source_system_key
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
GO
CREATE INDEX [natural_key] ON [SDA_Chemical_Properties](natural_key)
GO
GO
SET STATISTICS IO OFF 
GO
