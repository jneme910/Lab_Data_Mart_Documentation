USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go





	  DROP TABLE IF exists result_light_calcEst
	  DROP TABLE IF EXISTS #tempXX_calcEst
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values
	  DROP TABLE IF EXISTS result_light_test3
	  DROP TABLE IF EXISTS SDA_Chemical_Properties2

 CREATE TABLE result_light_calcEst (result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12),
	   CONSTRAINT pk_result_light_calcEst PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  ---------------  33 seconds  --- (10601391 rows affected)
	  INSERT INTO result_light_calcEst
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, analyte_key, r.procedure_key, r.source_system_key,   
	 
	 result_value,
	  --https://stackoverflow.com/questions/6750021/casting-scientific-notation-from-varchar-numeric-in-a-view

    p.prep_code  , b.proced_code
FROM dbo.result r
    INNER JOIN dbo.preparation AS p  ON r.prep_key = p.prep_key
    LEFT OUTER JOIN dbo.bridge_proced_ss AS b  ON r.procedure_key = b.procedure_key AND r.source_system_key = b.source_system_key 
            WHERE --AND ( ((isnumeric(result_value) = 1) AND (result_value != 'nil') AND IIF(
	    --TRY_CAST([result_value] AS NUMERIC) IS NULL,  1, 2 ) = 2)
		   (result_value IS NOT NULL AND 
		   --AND
		    analyte_key 
		   IN (4, 25, 28, 242, 243, 516, 523, 524, 525, 526, 527, 528, 529, 530, 533, 534, 537, 538, 539, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 571, 572, 573, 574, 575, 576, 577, 579, 580, 581, 582, 583, 586, 587, 590, 591, 593, 594, 595, 596, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 617, 628, 630, 631))

  	CREATE INDEX  result_light_calcEst_idx1c ON  result_light_calcEst (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_calcEst_idx1b ON  result_light_calcEst (analyte_key,  result_reliability)
	CREATE INDEX  result_light_calcEst_result_source_key_idx2 ON  result_light_calcEst (result_source_key )
	CREATE INDEX result_light_calcEst_prep_key_idx3 ON  result_light_calcEst (prep_key)
	CREATE INDEX result_source_system_key_calcEst_idx4 ON result_light_calcEst (source_system_key)
	CREATE INDEX result_light_calcEst_prep_code_idx5 ON  result_light_calcEst (prep_code)


GO
SET STATISTICS IO ON
GO

SELECT  CAST (natural_key AS varchar) AS natural_key , CAST (result_source_key AS varchar) AS result_source_key, CAST (prep_code AS VARCHAR) AS prep_code,

								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM  result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																					   result.analyte_key = 4),
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 25),
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM  result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 28),
								1.45))) 
							AS bulk_density_3rd_bar_for_calc, 

									CASE WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 4) IS NULL THEN 'db_13b'
									 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																			   result.analyte_key = 25) IS NULL THEN 'db_3rw'
									 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 28) IS NULL THEN 'db_3est'
									 ELSE 'default'
								END 
							AS bulk_density_3rd_bar_source,
												ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																						   result.analyte_key = 243),
								ISNULL((SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 242),
								2.65)) 
							AS particle_density_for_calc,
								CASE WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 243) IS NULL THEN 'pd_g2'
									 WHEN NOT (SELECT     TOP 1 (cast(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(4, 2)))
															FROM result_light_calcEst AS result
															WHERE      result_type = 'layer analyte' AND result.result_value <> '' AND result_source_key = q1.result_source_key AND 
																				   result.analyte_key = 242) IS NULL THEN 'pd_l2'
									 ELSE 'default'
								END 
							AS particle_density_calc_sour,
		


						  (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 590)) AS bulk_density_third_bar_ws,

								     (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 591)) AS bulk_density_oven_dry_ws,

								     (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
					                          FROM result_light_calcEst  result
		                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 593)) AS bulk_density_saturated_whole_so,						

    (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 516)) AS bulk_density_whole_soil_moist	,
								   
								   
	   (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '4.2') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 600)) AS  weight_percent_gt_2_mm_ws	,
								   
-- Need to double check								   
	   (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.prep_code = q1.prep_code) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 614)) AS  weight_percent_gt_250_mm_ws	,
								   
									   
	   (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 617)) AS  weight_pct_75_to_250_mm_ws,	
								   
	   (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 610)) 	AS weight_pct_2_to_75_mm_ws,

	   (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 613)) 	AS weight_pct_20_to_75_mm_ws,


(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 615)) 	AS weight_pct_5_to_20_mm_ws,

 (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 594)) 	AS weight_pct_2_to_5_mm_ws,	
								   
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key) AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 598)) 	AS weight_pct_less_than_2_mm_ws,	
								   
								   
(SELECT        TOP (1) CAST(dbo.AsymArithRnd(result.result_value, '3.0') AS decimal(15, 3)) AS Expr1
				                          FROM result_light_calcEst  result
	                               WHERE       (result.result_type = 'layer result') AND (result.result_source_key = q1.result_source_key)  AND (CASE WHEN result.result_reliability IS NULL THEN 1 WHEN result.result_reliability = '0' THEN 1 ELSE 2 END = 1 ) AND (analyte_key = 575)) 	AS  volume_pct_gt_2_mm_thirdbarws,	

				         (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_33
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =580)) 
						AS volume_pct_gt_250_mm_thirdbarw,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =582)) 
						AS volume_pct_75_to_250_mm_third,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_31
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =578)) 
						AS volume_pct_2_to_75_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_30
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =579)) 
						AS volume_pct_20_to_75_mm_third_w,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_29
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =581)) 
						AS volume_pct_5_to_20_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_28
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =577)) 
						AS volume_pct_2_to_5_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_27
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =574)) 
						AS volume_pct_lt_2_mm_third_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_26
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =583)) 
						AS volume_pct_usda_sand_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_25
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =576)) 
						AS vol_pct_usda_silt_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_24
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =573)) 
						AS volume_pct_usda_clay_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =555)) 
                         AS pct_pores_drained_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_35
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =556)) 
                         AS pct_pores_filled_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_1
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =599)) 
                         AS wt_pct_gt_2_mm_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_20
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =612)) 
                         AS wt_pct_2_75_mm_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_19
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =611)) 
                         AS wt_pct_2_20_mm_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_18
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =604)) 
                         AS wt_pct_sand_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_17
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =602)) 
                         AS wt_pct_silt_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_16
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =596)) 
                         AS wt_pct_tot_clay_clay_free_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_15
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =609)) 
                         AS wt_pct_vcs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_14
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =608)) 
                         AS wt_pct_cs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_13
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =607)) 
                         AS wt_pct_ms_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_12
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =605)) 
                         AS wt_pct_fs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_11
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =587)) 
                         AS wt_pct_vfs_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_10
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =603)) 
                         AS wt_pct_csi_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_9
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =601)) 
                         AS wt_pct_fsi_clay_free_lt2mmbase,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_8
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =595)) 
                         AS wt_pct_clay_clay_free_2mmbase,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM    result_light_calcEst AS result_5
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key =628)) 
						AS wf_25,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM     result_light_calcEst AS result_4
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key =631)) 
						AS wf_520,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM result_light_calcEst AS result_3
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key =630)) 
						AS wf_2075,
                          (SELECT     TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 3)) AS Expr1
                            FROM result_light_calcEst AS result_2
                            WHERE      (result_type = 'layer result') AND (result_value <> '') AND (isnumeric(result_value) = 1) AND (result_source_key = q1.result_source_key) AND 
                                                   (analyte_key =606)) 
						AS wf_0175,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =547)) 
						AS percent_passing_3_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  result
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =544)) 
						AS percent_passing_2_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_65
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =542)) 
						AS percent_passing_1_and_1_half,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_64
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =543)) 
						AS percent_passing_1_inch_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_63
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =548))
						AS percent_passing_3_quarter_inch,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_62
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =549)) 
						AS percent_passing_3_eights_inch,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_61
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =553)) 
                         AS percent_passing_no_4_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_60
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =551)) 
                         AS percent_passing_no_10_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_59
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =554)) 
                         AS percent_passing_no_40_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_58
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =552)) 
                         AS percent_passing_no_200_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_57
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =546)) 
                         AS percent_passing_20_micron_siev,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_56
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =550)) 
                         AS percent_passing_5_micron_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_55
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =545)) 
                         AS percent_passing_2_micron_sieve,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_54
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =528)) 
                         AS cumulative_curve_less_than_1mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_53
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =526)) 
                         AS cumulative_curve_lt_1_half_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_52
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =525)) 
                         AS cumulative_curve_lt_1_fourthmm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_51
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =524)) 
                         AS cumulative_curve_lt_1_tenth_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(10, 0)) AS Expr1
                               FROM result_light_calcEst  AS result_50
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =523)) 
                         AS cumulative_curve_lt_5_hundredt,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '5.2') AS decimal(12, 2)) AS Expr1
                               FROM result_light_calcEst  AS result_49
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =530)) 
                         AS cumulative_curve_size_lt_60_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '6.3') AS decimal(13, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_48
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =529)) 
                         AS cumulative_curve_size_lt_50_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '6.3') AS decimal(13, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_47
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =527)) 
                         AS cumulative_curve_size_lt_10_pe,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '7.1') AS decimal(13, 1)) AS Expr1
                               FROM result_light_calcEst  AS result_44
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =534)) 
                         AS gradiation_uniformity,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(11, 1)) AS Expr1
                               FROM result_light_calcEst  AS result_43
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =533)) 
                         AS gradation_curvature,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_7
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =538)) 
						AS le_third_ovendry_whole_soi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_7
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =537)) 
						AS le_third_bar_to_oven_dry_rewet,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.1') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_8
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =539)) 
						AS le_third_fifteen_whole_soil,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_31
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =571)) 
                         AS void_ratio_third_bar_lt_2_mm,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =572)) 
                         AS void_ratio_third_bar_whole_soi,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =586)) 
                         AS water_retention_difference_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =555)) 
                         AS pores_drained_third_bar_ws,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '4.2') AS decimal(15, 3)) AS Expr1
                               FROM result_light_calcEst  AS result_32
                               WHERE        (result_type = 'layer result') AND (result_value <> '') AND (result_source_key = q1.result_source_key) AND (analyte_key =556)) 
                         AS pores_filled_third_bar_ws



INTO  #tempXX_calcEst
FROM  dbo.layer 
INNER JOIN result_light_calcEst  q1 ON dbo.layer.layer_key = q1.result_source_key 


SELECT natural_key AS labsampnum, 
result_source_key,prep_code,bulk_density_3rd_bar_for_calc,bulk_density_3rd_bar_source,particle_density_for_calc,particle_density_calc_sour,bulk_density_third_bar_ws,bulk_density_oven_dry_ws,bulk_density_saturated_whole_so,bulk_density_whole_soil_moist,weight_percent_gt_2_mm_ws,weight_percent_gt_250_mm_ws,weight_pct_75_to_250_mm_ws,weight_pct_2_to_75_mm_ws,weight_pct_20_to_75_mm_ws,weight_pct_5_to_20_mm_ws,weight_pct_2_to_5_mm_ws,weight_pct_less_than_2_mm_ws,volume_pct_gt_2_mm_thirdbarws,volume_pct_gt_250_mm_thirdbarw,volume_pct_75_to_250_mm_third,volume_pct_2_to_75_mm_third_ws,volume_pct_20_to_75_mm_third_w,volume_pct_5_to_20_mm_third_ws,volume_pct_2_to_5_mm_third_ws,volume_pct_lt_2_mm_third_ws,volume_pct_usda_sand_ws,vol_pct_usda_silt_third_bar_ws,volume_pct_usda_clay_ws,pct_pores_drained_third_bar_ws,pct_pores_filled_third_bar_ws,wt_pct_gt_2_mm_clay_free_ws,wt_pct_2_75_mm_clay_free_ws,wt_pct_2_20_mm_clay_free_ws,wt_pct_sand_clay_free_ws,wt_pct_silt_clay_free_ws,wt_pct_tot_clay_clay_free_ws,wt_pct_vcs_clay_free_lt2mmbase,wt_pct_cs_clay_free_lt2mmbase,wt_pct_ms_clay_free_lt2mmbase,wt_pct_fs_clay_free_lt2mmbase,wt_pct_vfs_clay_free_lt2mmbase,wt_pct_csi_clay_free_lt2mmbase,wt_pct_fsi_clay_free_lt2mmbase,wt_pct_clay_clay_free_2mmbase,wf_25,wf_520,wf_2075,wf_0175,percent_passing_3_inch_sieve,percent_passing_2_inch_sieve,percent_passing_1_and_1_half,percent_passing_1_inch_sieve,percent_passing_3_quarter_inch,percent_passing_3_eights_inch,percent_passing_no_4_sieve,percent_passing_no_10_sieve,percent_passing_no_40_sieve,percent_passing_no_200_sieve,percent_passing_20_micron_siev,percent_passing_5_micron_sieve,percent_passing_2_micron_sieve,cumulative_curve_less_than_1mm,cumulative_curve_lt_1_half_mm,cumulative_curve_lt_1_fourthmm,cumulative_curve_lt_1_tenth_mm,cumulative_curve_lt_5_hundredt,cumulative_curve_size_lt_60_pe,cumulative_curve_size_lt_50_pe,cumulative_curve_size_lt_10_pe,gradiation_uniformity,gradation_curvature,le_third_ovendry_whole_soi,le_third_bar_to_oven_dry_rewet,le_third_fifteen_whole_soil,void_ratio_third_bar_lt_2_mm,void_ratio_third_bar_whole_soi,water_retention_difference_ws,pores_drained_third_bar_ws,pores_filled_third_bar_ws



INTO SDA_Calculations_Including_Estimates_And_Default_Values
FROM #tempXX_calcEst

GROUP BY natural_key,result_source_key,prep_code,bulk_density_3rd_bar_for_calc,bulk_density_3rd_bar_source,particle_density_for_calc,particle_density_calc_sour,bulk_density_third_bar_ws,bulk_density_oven_dry_ws,bulk_density_saturated_whole_so,bulk_density_whole_soil_moist,weight_percent_gt_2_mm_ws,weight_percent_gt_250_mm_ws,weight_pct_75_to_250_mm_ws,weight_pct_2_to_75_mm_ws,weight_pct_20_to_75_mm_ws,weight_pct_5_to_20_mm_ws,weight_pct_2_to_5_mm_ws,weight_pct_less_than_2_mm_ws,volume_pct_gt_2_mm_thirdbarws,volume_pct_gt_250_mm_thirdbarw,volume_pct_75_to_250_mm_third,volume_pct_2_to_75_mm_third_ws,volume_pct_20_to_75_mm_third_w,volume_pct_5_to_20_mm_third_ws,volume_pct_2_to_5_mm_third_ws,volume_pct_lt_2_mm_third_ws,volume_pct_usda_sand_ws,vol_pct_usda_silt_third_bar_ws,volume_pct_usda_clay_ws,pct_pores_drained_third_bar_ws,pct_pores_filled_third_bar_ws,wt_pct_gt_2_mm_clay_free_ws,wt_pct_2_75_mm_clay_free_ws,wt_pct_2_20_mm_clay_free_ws,wt_pct_sand_clay_free_ws,wt_pct_silt_clay_free_ws,wt_pct_tot_clay_clay_free_ws,wt_pct_vcs_clay_free_lt2mmbase,wt_pct_cs_clay_free_lt2mmbase,wt_pct_ms_clay_free_lt2mmbase,wt_pct_fs_clay_free_lt2mmbase,wt_pct_vfs_clay_free_lt2mmbase,wt_pct_csi_clay_free_lt2mmbase,wt_pct_fsi_clay_free_lt2mmbase,wt_pct_clay_clay_free_2mmbase,wf_25,wf_520,wf_2075,wf_0175,percent_passing_3_inch_sieve,percent_passing_2_inch_sieve,percent_passing_1_and_1_half,percent_passing_1_inch_sieve,percent_passing_3_quarter_inch,percent_passing_3_eights_inch,percent_passing_no_4_sieve,percent_passing_no_10_sieve,percent_passing_no_40_sieve,percent_passing_no_200_sieve,percent_passing_20_micron_siev,percent_passing_5_micron_sieve,percent_passing_2_micron_sieve,cumulative_curve_less_than_1mm,cumulative_curve_lt_1_half_mm,cumulative_curve_lt_1_fourthmm,cumulative_curve_lt_1_tenth_mm,cumulative_curve_lt_5_hundredt,cumulative_curve_size_lt_60_pe,cumulative_curve_size_lt_50_pe,cumulative_curve_size_lt_10_pe,gradiation_uniformity,gradation_curvature,le_third_ovendry_whole_soi,le_third_bar_to_oven_dry_rewet,le_third_fifteen_whole_soil,void_ratio_third_bar_lt_2_mm,void_ratio_third_bar_whole_soi,water_retention_difference_ws,pores_drained_third_bar_ws,pores_filled_third_bar_ws


	CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values_idx1c ON  SDA_Calculations_Including_Estimates_And_Default_Values (labsampnum, result_source_key) INCLUDE (prep_code)
	CREATE INDEX  SDA_Calculations_Including_Estimates_And_Default_Values_result_source_key_idx2 ON  SDA_Calculations_Including_Estimates_And_Default_Values (result_source_key )
	CREATE INDEX SDA_Calculations_Including_Estimates_And_Default_Values_prep_code_idx5 ON  SDA_Calculations_Including_Estimates_And_Default_Values (prep_code)

GO
SET STATISTICS IO OFF
GO