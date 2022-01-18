SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT p.pedon_key --SSL_REPO	
	,site_key  --SSL_REPO
	,pedlabsampnum
	,peiid
	,upedonid
	,labdatadescflag
	,[priority]
	,priority2
	,samp_name
	,samp_class_type
	,samp_classdate
	,samp_classification_name
	,samp_taxorder
	,samp_taxsuborder
	,samp_taxgrtgroup
	,samp_taxsubgrp
	,samp_taxpartsize
	,samp_taxpartsizemod
	,samp_taxceactcl
	,samp_taxreaction
	,samp_taxtempcl
	,samp_taxmoistscl
	,samp_taxtempregime
	,samp_taxminalogy
	,samp_taxother
	,samp_osdtypelocflag
	,corr_name
	,corr_class_type
	,corr_classdate
	,corr_classification_name
	,corr_taxorder
	,corr_taxsuborder
	,corr_taxgrtgroup
	,corr_taxsubgrp
	,corr_taxpartsize
	,corr_taxpartsizemod
	,corr_taxceactcl
	,corr_taxreaction
	,corr_taxtempcl
	,corr_taxmoistscl
	,corr_taxtempregime
	,corr_taxminalogy
	,corr_taxother
	,corr_osdtypelocflag
	--/* --SSL_REPO
	,SSL_name
	,SSL_class_type
	,SSL_classdate
	,SSL_classification_name
	,SSL_taxorder
	,SSL_taxsuborder
	,SSL_taxgrtgroup
	,SSL_taxsubgrp
	,SSL_taxpartsize
	,SSL_taxpartsizemod
	,SSL_taxceactcl
	,SSL_taxreaction
	,SSL_taxtempcl
	,SSL_taxmoistscl
	,SSL_taxtempregime
	,SSL_taxminalogy
	,SSL_taxother
	,SSL_osdtypelocflag
	  --*/
	,siteiid
	,usiteid
	,site_obsdate
	,latitude_decimal_degrees
	,longitude_decimal_degrees

	--/*SSL_REPO
	,Acountry.area_key as country_key
	,Astate.area_key as state_key
	,Acounty.area_key as county_key
	,Amlra.area_key as mlra_key
	,Assa.area_key as ssa_key
	,Anpark.area_key as npark_key
	,Anforest.area_key as nforest_key
	--*/

	,note
	,samp_taxfamhahatmatcl
	,corr_taxfamhahatmatcl

	,SSL_taxfamhahatmatcl --SSL_Repo DB
	,pedobjupdate
	,siteobjupdate
FROM pedon p
INNER JOIN combine_nasis_ncss_lite nasis
	ON p.natural_key = nasis.pedlabsampnum
OUTER APPLY (
	SELECT pedon_key
		,taxon_hist_key
		--,[version]
		,class_date_key as SSL_classdate
		--,class_person_key
		--,class_type
		,taxon_name as SSL_name
		,taxon_kind as SSL_class_type
		--,series_status
		,class_name as SSL_classification_name
		,tax_order as SSL_taxorder
		,suborder as SSL_taxsuborder
		,great_group as SSL_taxgrtgroup
		,subgroup as SSL_taxsubgrp
		,fam_part_size as SSL_taxpartsize
		,fam_part_size_mod as SSL_taxpartsizemod
		,fam_c_e_act_class as SSL_taxceactcl
		,fam_reaction as SSL_taxreaction
		,fam_temp_class as SSL_taxtempcl
		,moist_subclass as SSL_taxmoistscl
		,temp_regime as SSL_taxtempregime
		--,pedon_osd
		,fam_haht_mat_class as SSL_taxfamhahatmatcl
		,dbo.TaxMinString(taxon_hist_key) as SSL_taxminalogy
		,dbo.TaxOthString(taxon_hist_key) as SSL_taxother
		,NULL AS SSL_osdtypelocflag
	FROM pedon_tax_hist in_pth
	INNER JOIN (
		SELECT pth.pedon_key inPedonKey
			,max(class_date_key) maxClassDateKey
		FROM pedon_tax_hist pth
		WHERE p.pedon_key = pth.pedon_key
			AND pth.class_type = 'SSL'
		GROUP BY pth.pedon_key
		) in_pth2
		ON in_pth.pedon_key = in_pth2.inPedonKey
			AND in_pth.class_date_key = in_pth2.maxClassDateKey
	WHERE in_pth.class_type = 'SSL'
	) pth
LEFT JOIN area Acountry
	ON nasis.country_symbol = Acountry.area_code
		AND Acountry.area_type = 'country'
LEFT JOIN area Astate
	ON nasis.state_symbol = Astate.area_code
		AND Astate.area_type = 'state_admin_div'
LEFT JOIN area Acounty
	ON nasis.county_symbol = Acounty.area_code
		AND Acounty.area_type = 'county'
LEFT JOIN area Amlra
	ON nasis.mlra_symbol = Amlra.area_code
		AND Amlra.area_type = 'mlra'
LEFT JOIN area Assa
	ON nasis.ssa_symbol = Assa.area_code
		AND Assa.area_type = 'ssa'
LEFT JOIN area Anpark
	ON nasis.park_symbol = Anpark.area_code
		AND Anpark.area_type = 'national_park_system_land'
LEFT JOIN area Anforest
	ON nasis.nforest_symbol = Anforest.area_code
		AND Anforest.area_type = 'National_Forest_System_Land'
