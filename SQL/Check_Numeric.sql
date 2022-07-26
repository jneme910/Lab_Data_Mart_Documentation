USE ncsslabdata
drop TABLE IF EXISTS #result_light;
drop TABLE IF EXISTS #findvchar;

	  CREATE TABLE #result_light(result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12), analyzed_size_frac VARCHAR(128)
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  INSERT INTO #result_light 
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, r.analyte_key, r.procedure_key, r.source_system_key,   result_value, p.prep_code  , b.proced_code, r.analyzed_size_frac
FROM  dbo.layer AS l
INNER JOIN dbo.result AS r ON l.layer_key = r.result_source_key 
INNER JOIN dbo.analyte AS a ON r.analyte_key = a.analyte_key 
LEFT JOIN dbo.preparation AS p ON r.prep_key = p.prep_key 
LEFT JOIN dbo.bridge_proced_ss AS b ON r.procedure_key = b.procedure_key AND 
                         r.source_system_key = b.source_system_key
            WHERE  (r.analyte_key IN (421
			
			/*397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 
            -           425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 811, 812, 813, 42, 43, 364, 365, 366, 
                         367, 809, 810, 814, 815, 816, 1122, 1123, 1201, 1205, 1231, 1242, 1751, 1758, 1759, 1760, 1881, 2085, 2157, 2158, 2159, 2160, 2161, 2162, 2163, 2172, 1099, 1433, 
                         1524, 1525, 1883, 1885, 1886, 1884, 1148, 1149, 1150, 1185, 1186, 1187, 1434, 1435, 1436
						 */
						 )) AND (r.result_reliability IS NULL OR
                         r.result_reliability = '0')

	CREATE INDEX  result_light_idx1c ON #result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  #result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  #result_light (result_source_key )
	CREATE INDEX result_light_prep_key_idx3 ON  #result_light (prep_key)
	CREATE INDEX result_source_system_key_idx4 ON #result_light (source_system_key)
	CREATE INDEX result_light_prep_code_idx5 ON  #result_light (prep_code)


	SELECT  [result_key]
      ,[result_source_key]
      ,[prep_key]
      ,[result_type]
      ,[result_reliability]
      ,[analyte_key]
      ,[procedure_key]
      ,[source_system_key]
      ,[result_value]
      ,[prep_code]
      ,[proced_code]

   ,

   ---Subquery Start

  (
        SELECT TOP (1)
            CAST(SUBSTRING(   result_value, 1, CASE CHARINDEX(':', result_value)
                                                   WHEN 0
                                                       THEN LEN(result_value)
                                                   ELSE
                                                       CHARINDEX(':', result_value) - 1
                                               END
                          ) AS NUMERIC) AS Expr1
        FROM
            #result_light AS result_46
            LEFT JOIN
                preparation
                    ON result_46.prep_key = preparation.prep_key
        WHERE
            (result_type = 'layer analyte')
            AND (result_value <> '')
            AND (result_source_key = q1.result_source_key)
            AND (preparation.prep_code = q1.prep_code)
            AND (analyzed_size_frac = q1.analyzed_size_frac)
            AND (analyte_key = 421)

	---Subquery END
	)
	AS r_value
INTO #findvchar
  FROM #result_light AS q1


SELECT result_key
 , r_value
 , LEN (r_value) AS rv_length
 , TRY_CAST([r_value] AS NUMERIC) AS TC
 , IIF(TRY_CAST([r_value] AS NUMERIC) IS NULL,  1, 2 ) AS QC_IF_NULL_TC
	  --If its numeric then numeric value else null. 
	  --If its null then 1 Else 2
	  -- Need three queries. Second Query use subquery then third query use the checks

FROM #findvchar

WHERE  IIF(
TRY_CAST([r_value] AS NUMERIC) IS NULL,  1, 2 ) = 1 --QC is 1. If its a 1 then its not numeric 


DROP TABLE IF EXISTS #result_light;
DROP TABLE IF EXISTS #findvchar;