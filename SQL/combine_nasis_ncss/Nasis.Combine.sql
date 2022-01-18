-- Converted from NASIS Report, "Site_Laboratory_Locations_Overlaps__NCSS_site"
--Original Report written by Jason Nemecek 2013
USE nasis;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
DROP TABLE IF EXISTS #ncss_one2;
DROP TABLE IF EXISTS #correlated;
DROP TABLE IF EXISTS #sampled;
DROP TABLE IF EXISTS #overlap3

CREATE TABLE #ncss_one2 (
	id INT NOT NULL
	,peiid INT NOT NULL
	,latdegrees SMALLINT NULL
	,latminutes SMALLINT NULL
	,latseconds REAL NULL
	,lat_direction VARCHAR(10) NULL
	,longdegrees SMALLINT NULL
	,longminutes SMALLINT NULL
	,longseconds REAL NULL
	,long_direction VARCHAR(10) NULL
	,datum_name VARCHAR(250) NULL
	,latstddecimaldegrees FLOAT NULL
	,longstddecimaldegrees FLOAT NULL
	,usiteid VARCHAR(60) NOT NULL
	,upedonid VARCHAR(60) NOT NULL
	,labsourceid VARCHAR(60) NULL
	,labdatadescflag SMALLINT NULL
	,[priority] VARCHAR(1) NULL
	,priority2 VARCHAR(1) NULL
	,pedlabsampnum1 VARCHAR(12) NULL
	,siteiid INT NOT NULL
	,pedbiidref INT NOT NULL
	,pedobjupdate DATETIME NULL
	,siteobjupdate DATETIME NULL
	)

INSERT INTO #ncss_one2 (
	id
	,peiid
	,latdegrees
	,latminutes
	,latseconds
	,lat_direction
	,longdegrees
	,longminutes
	,longseconds
	,long_direction
	,datum_name
	,latstddecimaldegrees
	,longstddecimaldegrees
	,usiteid
	,upedonid
	,labsourceid
	,labdatadescflag
	,[priority]
	,priority2
	,pedlabsampnum1
	,siteiid
	,pedbiidref
	,pedobjupdate
	,siteobjupdate
	)
SELECT 1 AS id
	,peiid
	,latdegrees
	,latminutes
	,latseconds
	,lat_direction.lat_direction
	,longdegrees
	,longminutes
	,longseconds
	,long_direction.long_direction
	--,CODENAME (horizdatnm) AS datum
	,datum_name.datum_name
	,latstddecimaldegrees
	,longstddecimaldegrees
	,usiteid
	,upedonid
	,labsourceid
	,labdatadescflag
	,CASE 
		WHEN pedbiidref = '105'
			THEN 'D'
		ELSE 'B'
		END AS [priority]
	,CASE 
		WHEN labdatadescflag != 0
			THEN 'A'
		ELSE 'C'
		END AS priority2
	,REPLACE(pedlabsampnum, ' ', '') AS pedlabsampnum1
	,siteiid
	,pedbiidref
	,pedon.objwlupdated AS pedobjupdate
	,s.objwlupdated AS siteobjupdate
FROM pedon
INNER JOIN siteobs
	ON siteobs.siteobsiid = pedon.siteobsiidref
		--AND peiid = 296211
		AND pedlabsampnum IS NOT NULL
		AND peiid IN (
			SELECT TOP 1 peiid
			FROM pedon AS pchild
			INNER JOIN siteobs
				ON siteobs.siteobsiid = pedon.siteobsiidref
					AND pedlabsampnum IS NOT NULL
					AND pchild.pedlabsampnum = pedon.pedlabsampnum
			ORDER BY CASE 
					WHEN labdatadescflag = 1
						AND pedbiidref != '105'
						THEN 1
					WHEN pedbiidref != '105'
						AND labdatadescflag = 0
						THEN 2
					WHEN labdatadescflag = 1
						AND pedbiidref = '105'
						THEN 3
					WHEN pedbiidref = '105'
						AND labdatadescflag = 0
						THEN 4
					END ASC
			)
INNER JOIN [site] s
	ON s.siteiid = siteobs.siteiidref
OUTER APPLY (
	SELECT dd.ChoiceName lat_direction
	FROM MetadataDomainDetail dd
	INNER JOIN MetadataDomainMaster dm
		ON dm.DomainID = dd.DomainID
	WHERE s.latdir = dd.ChoiceValue
		AND DomainName = 'latitude_direction'
	) AS lat_direction
OUTER APPLY (
	SELECT dd.ChoiceName long_direction
	FROM MetadataDomainDetail dd
	INNER JOIN MetadataDomainMaster dm
		ON dm.DomainID = dd.DomainID
	WHERE s.longdir = dd.ChoiceValue
		AND DomainName = 'longitude_direction'
	) AS long_direction
OUTER APPLY (
	SELECT dd.ChoiceName datum_name
	FROM MetadataDomainDetail dd
	INNER JOIN MetadataDomainMaster dm
		ON dm.DomainID = dd.DomainID
	WHERE s.horizdatnm = dd.ChoiceValue
		AND DomainName = 'horizontal_datum_name'
	) AS datum_name
GROUP BY pedlabsampnum
	,pedbiidref
	,pedon.objwlupdated
	,upedonid
	,peiid
	,latdegrees
	,labsourceid
	,labdatadescflag
	,siteiid
	,usiteid
	,s.objwlupdated
	,latstddecimaldegrees
	,longstddecimaldegrees
	,latdir
	,longdir
	,horizdatnm
	,latseconds
	,latminutes
	,longdegrees
	,longminutes
	,longseconds
	,latstddecimaldegrees
	,longstddecimaldegrees
	,lat_direction
	,long_direction
	,datum_name

CREATE TABLE #correlated (
	corr_peiid_ref INT NOT NULL
	,corr_classdate DATETIME NULL
	,corr_petaxhistoryiid INT NOT NULL
	,corr_class_seq INT NULL
	,corr_soiltaxedition INT NULL
	,corr_classification_name VARCHAR(120) NULL
	,soinmascorr VARCHAR(60) NULL
	,corr_class_type VARCHAR(128) NULL
	,corr_obj VARCHAR(10) NULL
	,corr_taxorder VARCHAR(100) NULL
	,corr_taxsuborder VARCHAR(120) NULL
	,corr_taxgrtgroup VARCHAR(120) NULL
	,corr_taxsubgrp VARCHAR(120) NULL
	,corr_taxpartsize VARCHAR(120) NULL
	,corr_taxpartsizemod VARCHAR(120) NULL
	,corr_taxfamhahatmatcl VARCHAR(120) NULL
	,corr_taxceactcl VARCHAR(120) NULL
	,corr_taxreaction VARCHAR(120) NULL
	,corr_taxtempcl VARCHAR(120) NULL
	,corr_taxmoistscl VARCHAR(120) NULL
	,corr_taxtempregime VARCHAR(120) NULL
	,corr_osdtypelocflag INT NOT NULL
	,corr_iid INT NOT NULL
	,corr_minalogy VARCHAR(120) NULL
	,corr_other VARCHAR(120) NULL
	)

INSERT INTO #correlated (
	corr_peiid_ref
	,corr_classdate
	,corr_petaxhistoryiid
	,corr_class_seq
	,corr_soiltaxedition
	,corr_classification_name
	,soinmascorr
	,corr_class_type
	,corr_obj
	,corr_taxorder
	,corr_taxsuborder
	,corr_taxgrtgroup
	,corr_taxsubgrp
	,corr_taxpartsize
	,corr_taxpartsizemod
	,corr_taxfamhahatmatcl
	,corr_taxceactcl
	,corr_taxreaction
	,corr_taxtempcl
	,corr_taxmoistscl
	,corr_taxtempregime
	,corr_osdtypelocflag
	,corr_iid
	,corr_minalogy
	,corr_other
	)
--Linkage corr_peiid_ref to peiid
--CORRELATED AS
SELECT peiidref AS corr_peiid_ref
	,classdate AS corr_classdate
	,cpetaxhistory.petaxhistoryiid AS corr_petaxhistoryiid
	,corr_class_seq.corr_class_seq
	,cpetaxhistory.soiltaxedition AS corr_soiltaxedition
	,cpetaxhistory.taxclname AS corr_classification_name
	,cpetaxhistory.taxonname AS soinmascorr
	,corr_class_type.corr_class_type
	,cpetaxhistory.recwlupdated AS corr_obj
	,corr_taxorder.corr_taxorder
	,corr_taxsuborder.corr_taxsuborder
	,corr_taxgrtgroup.corr_taxgrtgroup
	,corr_taxsubgrp.corr_taxsubgrp
	,corr_taxpartsize.corr_taxpartsize
	,corr_taxpartsizemod.corr_taxpartsizemod
	,corr_taxfamhahatmatcl.corr_taxfamhahatmatcl
	,corr_taxceactcl.corr_taxceactcl
	,corr_taxreaction.corr_taxreaction
	,corr_taxtempcl.corr_taxtempcl
	,corr_taxmoistscl.corr_taxmoistscl
	,corr_taxtempregime.corr_taxtempregime
	,osdtypelocflag AS corr_osdtypelocflag
	,petaxhistoryiid AS corr_iid
	,SUBSTRING((
			SELECT (', ' + ChoiceName)
			FROM petaxhistory AS cth
			INNER JOIN petaxhistfmmin AS cthm
				ON cthm.pedtaxhistoryiidref = cth.petaxhistoryiid
			INNER JOIN MetadataDomainDetail AS dd
				ON cthm.taxminalogy = dd.ChoiceValue
			INNER JOIN MetadataDomainMaster AS dm
				ON dm.DomainID = dd.DomainID
			WHERE #ncss_one2.peiid = cth.peiidref
				AND dm.DomainName = 'taxonomic_family_mineralogy'
			GROUP BY ChoiceName
				,taxminalogy
			ORDER BY taxminalogy DESC
				,ChoiceName
			FOR XML PATH('')
			), 3, 50) AS corr_minalogy
	,SUBSTRING((
			SELECT (', ' + ChoiceName)
			FROM petaxhistory AS cth
			INNER JOIN petxhistfmother AS cthmo
				ON cthmo.pedtaxhistoryiidref = cth.petaxhistoryiid
			INNER JOIN MetadataDomainDetail AS dd
				ON taxfamother = ChoiceValue
			INNER JOIN MetadataDomainMaster AS dm
				ON dm.DomainID = dd.DomainID
			WHERE #ncss_one2.peiid = cth.peiidref
				AND DomainName = 'taxonomic_family_other'
			GROUP BY ChoiceName
				,taxfamother
			ORDER BY taxfamother DESC
				,ChoiceName
			FOR XML PATH('')
			), 3, 50) AS corr_other
FROM #ncss_one2
INNER JOIN petaxhistory AS cpetaxhistory
	ON cpetaxhistory.peiidref = #ncss_one2.peiid
		---Sub query to get the top correlated (Many to one relationships)
		AND petaxhistoryiid IN (
			SELECT TOP 1 petaxhistoryiid
			FROM petaxhistory AS pt2
			WHERE (cpetaxhistory.petaxhistoryiid) IS NOT NULL
				AND cpetaxhistory.classtype IN (
					1
					,3
					)
				AND #ncss_one2.peiid IN (pt2.peiidref)
			ORDER BY soiltaxedition DESC
				,cpetaxhistory.recwlupdated DESC
			)
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceSequence) OVER (
			ORDER BY classtype DESC
			) corr_class_seq
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.classtype = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'classification_type'
	) corr_class_seq
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxonkind DESC
			) corr_class_type
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxonkind = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'component_kind'
	) corr_class_type
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxorder DESC
			) corr_taxorder
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxorder = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_order'
	) corr_taxorder
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxsuborder DESC
			) corr_taxsuborder
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxsuborder = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_suborder'
	) corr_taxsuborder
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxgrtgroup DESC
			) corr_taxgrtgroup
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxgrtgroup = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_great_group'
	) corr_taxgrtgroup
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxorder DESC
			) corr_taxsubgrp
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxsubgrp = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_subgroup'
	) corr_taxsubgrp
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxpartsize DESC
			) corr_taxpartsize
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxpartsize = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_family_particle_size'
	) corr_taxpartsize
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxpartsizemod DESC
			) corr_taxpartsizemod
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxpartsizemod = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_family_part_size_mod'
	) corr_taxpartsizemod
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxfamhahatmatcl DESC
			) corr_taxfamhahatmatcl
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxfamhahatmatcl = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_family_haht_mat_class'
	) corr_taxfamhahatmatcl
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxceactcl DESC
			) corr_taxceactcl
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxceactcl = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_family_c_e_act_class'
	) corr_taxceactcl
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxreaction DESC
			) corr_taxreaction
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxreaction = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_family_reaction'
	) corr_taxreaction
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxtempcl DESC
			) corr_taxtempcl
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxtempcl = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_family_temp_class'
	) corr_taxtempcl
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxmoistscl DESC
			) corr_taxmoistscl
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxmoistscl = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_moisture_subclass'
	) corr_taxmoistscl
OUTER APPLY (
	SELECT DISTINCT FIRST_VALUE(ChoiceName) OVER (
			ORDER BY taxtempregime DESC
			) corr_taxtempregime
	FROM petaxhistory AS cth
	INNER JOIN MetadataDomainDetail AS dd
		ON cth.taxtempregime = dd.ChoiceValue
	INNER JOIN MetadataDomainMaster AS dm
		ON dm.DomainID = dd.DomainID
	WHERE #ncss_one2.peiid = cth.peiidref
		AND DomainName = 'taxonomic_temp_regime'
	) corr_taxtempregime

--Sampled AS
CREATE TABLE #sampled (
	samp_peiid_ref INT NOT NULL
	,samp_classdate DATETIME NULL
	,samp_petaxhistoryiid INT NOT NULL
	,samp_class_seq INT NULL
	,samp_soiltaxedition INT NULL
	,samp_classification_name VARCHAR(120) NULL
	,soinmassamp VARCHAR(60) NULL
	,samp_class_type VARCHAR(128) NULL
	,samp_obj DATETIME NULL
	,samp_taxorder VARCHAR(100) NULL
	,samp_taxsuborder VARCHAR(120) NULL
	,samp_taxgrtgroup VARCHAR(120) NULL
	,samp_taxsubgrp VARCHAR(120) NULL
	,samp_taxpartsize VARCHAR(120) NULL
	,samp_taxpartsizemod VARCHAR(120) NULL
	,samp_taxfamhahatmatcl VARCHAR(120) NULL
	,samp_taxceactcl VARCHAR(120) NULL
	,samp_taxreaction VARCHAR(120) NULL
	,samp_taxtempcl VARCHAR(120) NULL
	,samp_taxmoistscl VARCHAR(120) NULL
	,samp_taxtempregime VARCHAR(120) NULL
	,samp_osdtypelocflag INT NOT NULL
	,samp_iid INT NOT NULL
	,samp_minalogy VARCHAR(120) NULL
	,samp_other VARCHAR(120) NULL
	)

INSERT INTO #sampled (
	samp_peiid_ref
	,samp_classdate
	,samp_petaxhistoryiid
	,samp_class_seq
	,samp_soiltaxedition
	,samp_classification_name
	,soinmassamp
	,samp_class_type
	,samp_obj
	,samp_taxorder
	,samp_taxsuborder
	,samp_taxgrtgroup
	,samp_taxsubgrp
	,samp_taxpartsize
	,samp_taxpartsizemod
	,samp_taxfamhahatmatcl
	,samp_taxceactcl
	,samp_taxreaction
	,samp_taxtempcl
	,samp_taxmoistscl
	,samp_taxtempregime
	,samp_osdtypelocflag
	,samp_iid
	,samp_minalogy
	,samp_other
	)
--Linkage samp_peiid_ref to peiid
SELECT peiidref AS samp_peiid_ref
	,classdate AS samp_classdate
	,spetaxhistory.petaxhistoryiid AS samp_petaxhistoryiid
	,(
		SELECT TOP 1 ChoiceSequence
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND classtype = ChoiceValue
			AND DomainName = 'classification_type'
			AND dm.DomainID = dd.DomainID
		ORDER BY classtype DESC
		) AS samp_class_seq
	,spetaxhistory.soiltaxedition AS samp_soiltaxedition
	,spetaxhistory.taxclname AS samp_classification_name
	,spetaxhistory.taxonname AS soinmassamp
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxonkind = ChoiceValue
			AND DomainName = 'component_kind'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxonkind DESC
		) AS samp_class_type
	,spetaxhistory.recwlupdated AS samp_obj
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxorder = ChoiceValue
			AND DomainName = 'taxonomic_order'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxorder DESC
		) AS samp_taxorder
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxsuborder = ChoiceValue
			AND DomainName = 'taxonomic_suborder'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxsuborder DESC
		) AS samp_taxsuborder
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxgrtgroup = ChoiceValue
			AND DomainName = 'taxonomic_great_group'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxgrtgroup DESC
		) AS samp_taxgrtgroup
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxsubgrp = ChoiceValue
			AND DomainName = 'taxonomic_subgroup'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxorder DESC
		) AS samp_taxsubgrp
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxpartsize = ChoiceValue
			AND DomainName = 'taxonomic_family_particle_size'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxpartsize DESC
		) AS samp_taxpartsize
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxpartsizemod = ChoiceValue
			AND DomainName = 'taxonomic_family_part_size_mod'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxpartsizemod DESC
		) AS samp_taxpartsizemod
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxfamhahatmatcl = ChoiceValue
			AND DomainName = 'taxonomic_family_haht_mat_class'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxfamhahatmatcl DESC
		) AS samp_taxfamhahatmatcl
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxceactcl = ChoiceValue
			AND DomainName = 'taxonomic_family_c_e_act_class'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxceactcl DESC
		) AS samp_taxceactcl
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxreaction = ChoiceValue
			AND DomainName = 'taxonomic_family_reaction'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxreaction DESC
		) AS samp_taxreaction
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxtempcl = ChoiceValue
			AND DomainName = 'taxonomic_family_temp_class'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxtempcl DESC
		) AS samp_taxtempcl
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxmoistscl = ChoiceValue
			AND DomainName = 'taxonomic_moisture_subclass'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxmoistscl DESC
		) AS samp_taxmoistscl
	,(
		SELECT TOP 1 ChoiceName
		FROM petaxhistory AS cth
			,MetadataDomainMaster AS dm
			,MetadataDomainDetail AS dd
		WHERE #ncss_one2.peiid = cth.peiidref
			AND taxtempregime = ChoiceValue
			AND DomainName = 'taxonomic_temp_regime'
			AND dm.DomainID = dd.DomainID
		ORDER BY taxtempregime DESC
		) AS samp_taxtempregime
	,osdtypelocflag AS samp_osdtypelocflag
	,petaxhistoryiid AS samp_iid
	,SUBSTRING((
			SELECT (', ' + ChoiceName)
			FROM petaxhistory AS cth
				,petaxhistfmmin AS cthm
				,MetadataDomainMaster AS dm
				,MetadataDomainDetail AS dd
			WHERE #ncss_one2.peiid = cth.peiidref
				AND cthm.pedtaxhistoryiidref = cth.petaxhistoryiid
				AND taxminalogy = ChoiceValue
				AND DomainName = 'taxonomic_family_mineralogy'
				AND dm.DomainID = dd.DomainID
			GROUP BY ChoiceName
				,taxminalogy
			ORDER BY taxminalogy DESC
				,ChoiceName
			FOR XML PATH('')
			), 3, 50) AS samp_minalogy
	,SUBSTRING((
			SELECT (', ' + ChoiceName)
			FROM petaxhistory AS cth
				,petxhistfmother AS cthmo
				,MetadataDomainMaster AS dm
				,MetadataDomainDetail AS dd
			WHERE #ncss_one2.peiid = cth.peiidref
				AND cthmo.pedtaxhistoryiidref = cth.petaxhistoryiid
				AND taxfamother = ChoiceValue
				AND DomainName = 'taxonomic_family_other'
				AND dm.DomainID = dd.DomainID
			GROUP BY ChoiceName
				,taxfamother
			ORDER BY taxfamother DESC
				,ChoiceName
			FOR XML PATH('')
			), 3, 50) AS samp_other
FROM #ncss_one2
INNER JOIN petaxhistory AS spetaxhistory
	ON spetaxhistory.peiidref = #ncss_one2.peiid
		---Sub query to get the top Sampled (Many to one relationships)
		AND petaxhistoryiid IN (
			SELECT TOP 1 petaxhistoryiid
			FROM petaxhistory AS pt2
			WHERE (spetaxhistory.petaxhistoryiid) IS NOT NULL
				AND spetaxhistory.classtype IN (
					2
					,4
					)
				AND #ncss_one2.peiid IN (pt2.peiidref)
			ORDER BY CASE 
					WHEN spetaxhistory.classtype = 2
						THEN 1
					WHEN spetaxhistory.classtype = 4
						THEN 2
					END ASC
				,soiltaxedition DESC
				,spetaxhistory.recwlupdated DESC
			)

CREATE TABLE #overlap3 (
	siteiid INT NOT NULL
	,county_symbol VARCHAR(20) NULL
	,state_symbol VARCHAR(20) NULL
	,mlra_symbol VARCHAR(20) NULL
	,ssa_symbol VARCHAR(20) NULL
	,park_symbol VARCHAR(20) NULL
	,forest_symbol VARCHAR(20) NULL
	,county_symbol2 VARCHAR(20) NULL
	,state_symbol2 VARCHAR(20) NULL
	,mlra_symbol2 VARCHAR(20) NULL
	,undisclosed_Location_flag VARCHAR(5) NULL
	,country_symbol VARCHAR(100) NULL
	)

INSERT INTO #overlap3 (
	siteiid
	,county_symbol
	,state_symbol
	,mlra_symbol
	,ssa_symbol
	,park_symbol
	,forest_symbol
	,county_symbol2
	,state_symbol2
	,mlra_symbol2
	,undisclosed_Location_flag
	,country_symbol
	)
--linkage -- siteiid to siteiid
SELECT a.siteiid
	,(
		SELECT TOP 1 areasymbol AS county_code
		FROM site AS s1
		INNER JOIN area AS county
			ON county.areaiid = s1.countyareaiidref
		INNER JOIN areatype AS co
			ON co.areatypeiid = county.areatypeiidref
				AND co.areatypename = 'County or Parish'
				AND s1.siteiid = a.siteiid
		) AS county_symbol
	,(
		SELECT TOP 1 areasymbol AS state_code
		FROM site AS s1
		INNER JOIN area AS st
			ON st.areaiid = s1.stateareaiidref
		INNER JOIN areatype AS co
			ON co.areatypeiid = st.areatypeiidref
				AND co.areatypename = 'State or Territory'
				AND s1.siteiid = a.siteiid
		) AS state_symbol
	,(
		SELECT TOP 1 areasymbol AS mlra_code
		FROM site AS s1
		INNER JOIN area AS m
			ON m.areaiid = s1.mlraareaiidref
		INNER JOIN areatype AS co
			ON co.areatypeiid = m.areatypeiidref
				AND co.areatypename = 'mlra'
				AND s1.siteiid = a.siteiid
		) AS mlra_symbol
	,(
		SELECT TOP 1 areasymbol AS ssa_symbol
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'Non-MLRA Soil Survey Area'
		) AS ssa_symbol
	,(
		SELECT TOP 1 areasymbol AS park_symbol
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'National Park System Land'
		) AS park_symbol
	,(
		SELECT TOP 1 areasymbol AS forest_symbol
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'forest_symbol'
		) AS forest_symbol
	,
	-- Second 
	(
		SELECT TOP 1 areasymbol AS county_symbol2
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'County or Parish'
		) AS county_symbol2
	,(
		SELECT TOP 1 areasymbol AS state_symbol2
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'State or Territory'
		) AS state_symbol2
	,(
		SELECT TOP 1 areasymbol AS mlra_symbol2
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'mlra'
		) AS mlra_symbol2
	,(
		SELECT TOP 1 CASE 
				WHEN textsubcat = 'Undisclosed Location'
					THEN 'Yes'
				ELSE 'No'
				END
		FROM site AS s1
		INNER JOIN sitetext
			ON sitetext.siteiidref = s1.siteiid
				AND sitetext.textsubcat = 'Undisclosed Location'
				AND s1.siteiid = a.siteiid
		) AS undisclosed_Location_flag
	,(
		SELECT TOP 1 areasymbol AS country_symbol
		FROM site AS s1
		INNER JOIN siteaoverlap
			ON siteaoverlap.siteiidref = s1.siteiid
				AND s1.siteiid = a.siteiid
		INNER JOIN area AS SSAs
			ON SSAs.areaiid = siteaoverlap.areaiidref
		INNER JOIN areatype AS SSA
			ON SSA.areatypeiid = SSAs.areatypeiidref
				AND SSA.areatypename = 'Country'
		) AS country_symbol
FROM (
	SELECT siteiid
	FROM #ncss_one2
	GROUP BY siteiid
	) a

--------
DELETE FROM ncsslabdata.dbo.combine_nasis_ncss_lite
INSERT INTO ncsslabdata.dbo.combine_nasis_ncss_lite
SELECT --p.pedon_key --SSL_REPO	
	--,site_key  --SSL_REPO
	pedlabsampnum1 AS pedlabsampnum
	,peiid
	,upedonid
	,labdatadescflag
	,[priority]
	,priority2
	,soinmassamp AS samp_name
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
	,samp_minalogy AS samp_taxminalogy
	,samp_other AS samp_taxother
	,samp_osdtypelocflag
	,soinmascorr AS corr_name
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
	,corr_minalogy AS corr_taxminalogy
	,corr_other AS corr_taxother
	,corr_osdtypelocflag
	/* --SSL_REPO
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
	  */
	,a.siteiid
	,usiteid
	,samp_obj AS site_obsdate
	,CASE 
		WHEN undisclosed_Location_flag = 'Yes'
			THEN NULL
		ELSE latstddecimaldegrees
		END AS latitude_decimal_degrees
	,CASE 
		WHEN undisclosed_Location_flag = 'Yes'
			THEN NULL
		ELSE longstddecimaldegrees
		END AS longitude_decimal_degrees

	-- The keys need to all be filled out somehow up to from country to SSA
	,country_symbol											--country_key	-- Need to be converted to SSL Repo Area Key
	,isnull(state_symbol, state_symbol2) AS state_symbol	--state_key		-- Need to be converted to SSL Repo Area Key
	,isnull(county_symbol, county_symbol2) AS county_symbol --county_key	-- Need to be converted to SSL Repo Area Key
	,isnull(mlra_symbol, mlra_symbol2) AS mlra_symbol		--mlra_key		-- Need to be converted to SSL Repo Area Key
	,ssa_symbol												--ssa_key		-- Need to be converted to SSL Repo Area Key
	,park_symbol											--npark_key		-- Need to be converted to SSL Repo Area Key
	,forest_symbol AS nforest_symbol						--nforest_key	-- Need to be converted to SSL Repo Area Key

	,CASE 
		WHEN siteobjupdate > pedobjupdate
			THEN CONCAT (
					'NASIS updated '
					,siteobjupdate
					)
		ELSE CONCAT (
				'NASIS updated '
				,pedobjupdate
				)
		END AS note
	,samp_taxfamhahatmatcl
	,corr_taxfamhahatmatcl

	-- SSL_taxfamhahatmatcl, --SSL_Repo DB
	,pedobjupdate
	,siteobjupdate
FROM #ncss_one2 AS a
LEFT OUTER JOIN #correlated AS b
	ON b.corr_peiid_ref = a.peiid
LEFT OUTER JOIN #sampled AS c
	ON c.samp_peiid_ref = a.peiid
LEFT OUTER JOIN #overlap3 AS d
	ON d.siteiid = a.siteiid