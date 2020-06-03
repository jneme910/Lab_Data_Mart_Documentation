USE NCSS_LDM;
GO

/*

Run time: 41:37

Table '#tempXX_000000000024'. Scan count 0, logical reads 678278, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 9406016, logical reads 1595049036, physical reads 3569217, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'result'. Scan count 15, logical reads 6284025, physical reads 10598, read-ahead reads 2088845, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'bridge_proced_ss'. Scan count 4, logical reads 24, physical reads 1, read-ahead reads 4, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'preparation'. Scan count 1, logical reads 9036036, physical reads 3, read-ahead reads 8, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'analyte'. Scan count 1, logical reads 101, physical reads 2, read-ahead reads 99, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'layer'. Scan count 1, logical reads 714, physical reads 2, read-ahead reads 780, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(671858 rows affected)


NOTE:  rerun the original SQL but do not use the view -- I found this saved a bunch of time using the 
	actual sql and not the view

*/


-------------------- original view sql -- using only part of the original sql so the test runs faster
SET STATISTICS IO ON;
GO

--------- write results to either a temp table or a real table -- instead of displaying in SSMS
DROP TABLE IF EXISTS #tempXX;
GO
SELECT 1000 natural_key,
       result_source_key,
       prep_code,
       (
           SELECT TOP (1)
               CAST(dbo.AsymArithRnd(result.result_value, '4.1') AS DECIMAL(10, 2)) AS Expr1
           FROM dbo.result
               INNER JOIN dbo.preparation
                   ON result.prep_key = preparation.prep_key
           WHERE (result.result_type = 'layer analyte')
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                 AND (result.result_source_key = q1.result_source_key)
                 AND (preparation.prep_code = q1.prep_code)
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
                     AND (result_source_key = q1.result_source_key)
                     AND (analyte_key IN ( 568, 652, 653, 721, 722, 723, 791, 1291, 1292, 1440, 2099 ))
               UNION
               SELECT result_value,
                      'N' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = q1.result_source_key)
                     AND (analyte_key IN ( 1154, 1289, 1442 ))
               UNION
               SELECT result_value,
                      'S-SK' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = q1.result_source_key)
                     AND (analyte_key IN ( 1290 ))
               UNION
               SELECT result_value,
                      'M' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = q1.result_source_key)
                     AND (analyte_key IN ( 1152, 1288, 1441 ))
               UNION
               SELECT result_value,
                      'HM' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = q1.result_source_key)
                     AND (analyte_key IN ( 1160 ))
               UNION
               SELECT result_value,
                      'GP' AS prep_code
               FROM dbo.result
               WHERE (result_type = 'layer result')
                     AND (result_value <> '')
                     AND (NOT (result_value IS NULL))
                     AND (result_source_key = q1.result_source_key)
                     AND (analyte_key IN ( 1161, 1287 ))
           ) AS result_1
           WHERE (prep_code = q1.prep_code)
       ) AS sum_of_nh4_ph_7_Ext_bases
INTO #tempXX
FROM dbo.Chemical_Properties_List AS q1
GROUP BY natural_key,
         result_source_key,
         prep_code;


