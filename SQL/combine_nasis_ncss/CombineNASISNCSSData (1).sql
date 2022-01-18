CREATE  FUNCTION [dbo].[CombineNASISNCSSData] (@pedon_key INTEGER)
--DECLARE @pedon_key INT = 33423

RETURNS @HeadingData  TABLE (
--DECLARE @HeadingData TABLE (
	natural_key VARCHAR(128)
	,pedon_id VARCHAR(60)
	,submit_proj_name VARCHAR(60)
	,lab_proj_name VARCHAR(60)
	,site_id VARCHAR(60)
	,latitude_direction VARCHAR(128)
	,latitude_degrees NUMERIC(2, 0)
	,latitude_minutes NUMERIC(2, 0)
	,latitude_seconds NUMERIC(4, 2)
	,longitude_direction VARCHAR(128)
	,longitude_degrees NUMERIC(3, 0)
	,longitude_minutes NUMERIC(2, 0)
	,longitude_seconds NUMERIC(4, 2)
	,datum_name VARCHAR(128)
	,latitude_decdegrees FLOAT
	,longitude_decdegrees FLOAT
	,site_country VARCHAR(128)
	,site_state VARCHAR(128)
	,site_county_label VARCHAR(128)
	,site_county VARCHAR(128)
	,site_mlra VARCHAR(20)
	,sampled_as VARCHAR(60)
	,revised_to VARCHAR(60)
	,sampled_class VARCHAR(120)
	,revised_class VARCHAR(120)
	,sampled_date VARCHAR(20)
	,revised_date VARCHAR(20)
	,revised_type VARCHAR(128)
	,labtitle1 VARCHAR(60)
	,labtitle2 VARCHAR(60)
	,labtitle3 VARCHAR(60)
	,labtitle4 VARCHAR(60)
	,labtitle5 VARCHAR(60)
	,labtitle6 VARCHAR(60)
	)
AS  
BEGIN 
INSERT @HeadingData
SELECT DISTINCT combine_nasis_ncss.pedlabsampnum
	,combine_nasis_ncss.upedonid AS pedon_id
	,project.submit_proj_name
	,project.lab_proj_name
	,combine_nasis_ncss.usiteid AS site_id
	,CASE 
		WHEN combine_nasis_ncss.latitude_decimal_degrees < 0
			THEN 'south'
		WHEN combine_nasis_ncss.latitude_decimal_degrees >= 0
			THEN 'north'
		ELSE NULL
		END latitude_direction
	,FLOOR(ABS(combine_nasis_ncss.latitude_decimal_degrees)) latitude_degrees
	,FLOOR((ABS(combine_nasis_ncss.latitude_decimal_degrees) - (FLOOR(ABS(combine_nasis_ncss.latitude_decimal_degrees)))) * 60.0) latitude_minutes
	,ROUND((((ABS(combine_nasis_ncss.latitude_decimal_degrees) - (FLOOR(ABS(combine_nasis_ncss.latitude_decimal_degrees)))) * 60.0) - (FLOOR((ABS(combine_nasis_ncss.latitude_decimal_degrees) - (FLOOR(ABS(combine_nasis_ncss.latitude_decimal_degrees)))) * 60.0))) * 60.0, 2) latitude_seconds
	,CASE 
		WHEN combine_nasis_ncss.longitude_decimal_degrees < 0
			THEN 'west'
		WHEN combine_nasis_ncss.longitude_decimal_degrees >= 0
			THEN 'east'
		ELSE NULL
		END longitude_direction
	,FLOOR(ABS(combine_nasis_ncss.longitude_decimal_degrees)) longitude_degrees
	,FLOOR((ABS(combine_nasis_ncss.longitude_decimal_degrees) - (FLOOR(ABS(combine_nasis_ncss.longitude_decimal_degrees)))) * 60.0) longitude_minutes
	,ROUND((((ABS(combine_nasis_ncss.longitude_decimal_degrees) - (FLOOR(ABS(combine_nasis_ncss.longitude_decimal_degrees)))) * 60.0) - (FLOOR((ABS(combine_nasis_ncss.longitude_decimal_degrees) - (FLOOR(ABS(combine_nasis_ncss.longitude_decimal_degrees)))) * 60.0))) * 60.0, 2) longitude_seconds
	,NULL AS datum_name
	,combine_nasis_ncss.latitude_decimal_degrees
	,combine_nasis_ncss.longitude_decimal_degrees
	,ACountry.area_name AS site_country
	,AState.area_name AS site_state
	,ACounty.area_sub_type AS site_county_label
	,ACounty.area_name AS site_county
	,AMlra.area_code AS site_mlra
	,combine_nasis_ncss.samp_name AS sampled_as
	,ISNULL(combine_nasis_ncss.corr_name, combine_nasis_ncss.SSL_name) revised_to
	,combine_nasis_ncss.samp_classification_name AS sampled_class
	,ISNULL(combine_nasis_ncss.corr_classification_name, combine_nasis_ncss.SSL_classification_name) AS revised_class
	,Format(pSample.full_date, 'MMM d, yyyy') AS sampled_date
	--,pSample.month_abbrev + ' ' + cast(pSample.day_num_in_month AS VARCHAR) + ', ' + cast(pSample.year AS VARCHAR) AS sampled_date
	,isnull(Format(pCorr.full_date, 'MMM d, yyyy'), Format(pCorr.full_date, 'MMM d, yyyy')) revised_date
	--,CASE 
	--	WHEN combine_nasis_ncss.corr_classdate IS NOT NULL
	--		THEN pCorr.month_abbrev + ' ' + cast(pCorr.day_num_in_month AS VARCHAR) + ', ' + cast(pCorr.year AS VARCHAR)
	--	WHEN combine_nasis_ncss.SSL_classdate IS NOT NULL
	--		THEN pSsl.month_abbrev + ' ' + cast(pSsl.day_num_in_month AS VARCHAR) + ', ' + cast(pSsl.year AS VARCHAR)
	--	ELSE NULL
	--	END AS revised_date
	,CASE 
		WHEN combine_nasis_ncss.corr_name IS NOT NULL
			THEN 'correlated'
		WHEN combine_nasis_ncss.SSL_name IS NOT NULL
			THEN 'SSL'
		ELSE NULL
		END AS revised_type
	,source_head1 AS labtitle1
	,source_head2 AS labtitle2
	,source_head3 AS labtitle3
	,source_head4 AS labtitle4
	,source_head5 AS labtitle5
	,source_head6 AS labtitle6
FROM combine_nasis_ncss
INNER JOIN bridge_pedon_ss
	ON bridge_pedon_ss.pedon_key = combine_nasis_ncss.pedon_key
INNER JOIN source_system
	ON bridge_pedon_ss.source_system_key = source_system.source_system_key
INNER JOIN bridge_project_site
	ON combine_nasis_ncss.site_key = bridge_project_site.site_key
INNER JOIN project
	ON project.project_key = bridge_project_site.project_key

LEFT JOIN area ACountry
	ON ACountry.area_key = combine_nasis_ncss.country_key
LEFT JOIN area AState
	ON AState.area_key = combine_nasis_ncss.state_key
LEFT JOIN area ACounty
	ON ACounty.area_key = combine_nasis_ncss.county_key
LEFT JOIN area AMlra
	ON AMlra.area_key = combine_nasis_ncss.mlra_key
LEFT JOIN [period] pSample
	ON pSample.date_key = combine_nasis_ncss.samp_classdate
LEFT JOIN [period] pCorr
	ON pCorr.date_key = combine_nasis_ncss.corr_classdate
LEFT JOIN [period] pSsl
	ON pSsl.date_key = combine_nasis_ncss.SSL_classdate
WHERE combine_nasis_ncss.pedon_key = @pedon_key

RETURN
END
GO

GRANT SELECT
    ON OBJECT::[dbo].[CombineNASISNCSSData] TO [ncsslabdataro]
    AS [dbo];