USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go


SET STATISTICS IO ON
GO


	  DROP TABLE IF exists result_light_calcEst
	  DROP TABLE IF EXISTS #tempXX_calcEst
	  DROP TABLE IF EXISTS SDA_Calculations_Including_Estimates_And_Default_Values
	  DROP TABLE IF EXISTS result_light_test3
	  DROP TABLE IF EXISTS SDA_Chemical_Properties2

SET ANSI_NULLS ON
GO

 CREATE TABLE result_light_calcEst (

	   natural_key VARCHAR(10) NOT NULL, 
	   result_key INT NOT NULL, 
	   result_type VARCHAR(128) NOT NULL, 
	   layer_key INT NOT NULL,
	   result_source_key INT NOT NULL, 
	   analyte_key INT NOT NULL, 
	   analyte_analyte_key INT NOT NULL, 
	   prep_key INT, 
	    prep_prep_key INT, 
       result_value VARCHAR(128) ,
	   procedure_key INT, 
	   bridge_procedure_key INT, 
	   analyzed_size_frac VARCHAR(128) , 
	   analyte_abbrev VARCHAR(25), 
	   prep_abbrev VARCHAR(64), 
       prep_code VARCHAR(64),  
	   analyte_format VARCHAR(20), 
	   site_key INT, 
	   source_system_key INT NOT NULL,
	   proced_code VARCHAR(12) NOT NULL ,
	   result_reliability VARCHAR(20),
	  CONSTRAINT pk_result_light_calcEst PRIMARY KEY CLUSTERED (result_key))
	  GO


INSERT INTO result_light_calcEst
SELECT DISTINCT dbo.layer.natural_key, r.result_key, r.result_type, layer_key, r.result_source_key, r.analyte_key, dbo.analyte.analyte_key , r.prep_key, dbo.preparation.prep_key,
                r.result_value, r.procedure_key, dbo.bridge_proced_ss.procedure_key AS bridge_procedure_key , r.analyzed_size_frac, dbo.analyte.analyte_abbrev, dbo.preparation.prep_abbrev, 
                dbo.preparation.prep_code, dbo.analyte.analyte_format, dbo.layer.site_key, r.source_system_key, ISNULL(dbo.bridge_proced_ss.proced_code, '') AS proced_code,
				r.result_reliability
FROM dbo.layer 
INNER JOIN dbo.result AS  r  ON dbo.layer.layer_key = r.result_source_key AND (CASE WHEN r.result_reliability IS NULL THEN 1 WHEN  r.result_reliability = '0' THEN 1 ELSE 2 END = 1)
INNER JOIN dbo.analyte ON r.analyte_key = dbo.analyte.analyte_key 
LEFT JOIN dbo.preparation ON r.prep_key = dbo.preparation.prep_key 
LEFT JOIN dbo.bridge_proced_ss ON r.procedure_key = dbo.bridge_proced_ss.procedure_key 
			AND r.source_system_key = dbo.bridge_proced_ss.source_system_key
WHERE r.analyte_key IN (523, 524, 525, 526, 527, 528, 529, 530, 533, 534, 537, 538, 539, 542, 543, 544, 545, 546, 548, 549, 550, 551, 552, 553, 554, 555, 556, 571, 572, 573, 574, 576, 577, 579, 580, 581, 582, 583, 586, 587, 595, 596, 599, 601, 602, 603, 604, 605, 606, 607, 608, 609, 611, 612, 628, 630, 631) 

--GROUP BY dbo.layer.natural_key, r.result_key, r.result_type, r.result_source_key, r.analyte_key, r.prep_key, 
   --             r.result_value, r.procedure_key, r.analyzed_size_frac, dbo.analyte.analyte_abbrev, dbo.preparation.prep_abbrev, 
   --             dbo.preparation.prep_code, dbo.analyte.analyte_format, dbo.layer.site_key, r.source_system_key, dbo.bridge_proced_ss.proced_code, result_reliability
GO

	CREATE INDEX  result_light_calcEst_idx1c ON  result_light_calcEst (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_calcEst_idx1b ON  result_light_calcEst (analyte_key,  result_reliability)
	CREATE INDEX  result_light_calcEst_result_source_key_idx2 ON  result_light_calcEst (result_source_key )
	CREATE INDEX result_light_calcEst_prep_key_idx3 ON  result_light_calcEst (prep_key)
	CREATE INDEX result_source_system_key_calcEst_idx4 ON result_light_calcEst (source_system_key)
	CREATE INDEX result_light_calcEst_prep_code_idx5 ON  result_light_calcEst (prep_code)
