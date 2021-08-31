USE nasis;

DROP TABLE IF EXISTS #ncss_one2;

CREATE TABLE #ncss_one2
	(
		[id] [INT] NOT NULL,
		[peiid][int] NOT NULL,	
		[latdegrees] [smallint] NULL,	
		[latminutes] [smallint] NULL,	
		[latseconds][real] NULL,	
		[lat_direction][varchar](10) NULL,		
		[longdegrees][smallint] NULL,	
		[longminutes][smallint] NULL,		
		[longseconds][real] NULL,		
		[long_direction][varchar](10) NULL,	
		[datum_name] [varchar](250)  NULL,	
		[latstddecimaldegrees][float] NULL,	
		[longstddecimaldegrees][float] NULL,	
		[usiteid][varchar](60) NOT NULL,		
		[upedonid][varchar](60) NOT NULL,		
		[labsourceid][varchar](60)  NULL,		
		[labdatadescflag] [smallint] NULL,	
		[priority][varchar](5)  NULL,	
		[priority2][varchar](5)  NULL,		
		[pedlabsampnum1][varchar](60)  NULL,
		[siteiid] [int] NOT NULL,		
		[pedbiidref] [int] NOT NULL,		
		[pedobjupdate][datetime] NULL,	
		[siteobjupdate][datetime] NULL
	)

INSERT INTO #ncss_one2 ([id] ,
		[peiid],
		[latdegrees] ,
		[latminutes] ,
		[latseconds],
		[lat_direction]	,
		[longdegrees],
		[longminutes],
		[longseconds],
		[long_direction],
		[datum_name],
		[latstddecimaldegrees]	,
		[longstddecimaldegrees],
		[usiteid]	,	
		[upedonid],		
		[labsourceid]	,
		[labdatadescflag] ,
		[priority],
		[priority2],		
		[pedlabsampnum1],
		[siteiid],
		[pedbiidref] ,
		[pedobjupdate],
		[siteobjupdate])

		
SELECT TOP 10 1 AS id, 
peiid/1 AS peiid, latdegrees,  latminutes, latseconds, CAST ((select top 1  CAST ([ChoiceName] AS varchar ) from [nasis].[dbo].site AS s, [nasis].[dbo].MetadataDomainMaster dm, [nasis].[dbo].MetadataDomainDetail dd 
WHERE s.siteiid= site.siteiid 
AND latdir  = ChoiceValue 
and DomainName = 'latitude_direction'  AND
dm.DomainID = dd.DomainID ORDER BY latdir DESC) AS varchar) AS  lat_direction,



longdegrees, longminutes, longseconds, CAST ((select top 1  CAST ([ChoiceName] AS varchar ) from [nasis].[dbo].site AS s, [nasis].[dbo].MetadataDomainMaster dm, [nasis].[dbo].MetadataDomainDetail dd 
WHERE s.siteiid= site.siteiid 
AND longdir  = ChoiceValue 
and DomainName = 'longitude_direction'  AND
dm.DomainID = dd.DomainID ORDER BY latdir DESC) AS varchar) AS  long_direction,
 --CODENAME (horizdatnm) AS datum, 

 CAST ((select top 1  CAST ([ChoiceName] AS varchar ) from [nasis].[dbo].site AS s, [nasis].[dbo].MetadataDomainMaster dm, [nasis].[dbo].MetadataDomainDetail dd 
WHERE s.siteiid= site.siteiid 
AND horizdatnm  = ChoiceValue 
and DomainName = 'horizontal_datum_name'  AND
dm.DomainID = dd.DomainID ORDER BY horizdatnm DESC) AS varchar) AS  datum_name,


latstddecimaldegrees, longstddecimaldegrees, 
usiteid, upedonid, labsourceid, labdatadescflag, 
CASE WHEN pedbiidref = '105' THEN 'D' ELSE 'B' END AS priority,
CASE WHEN labdatadescflag != 0 THEN 'A' ELSE 'C' END AS priority2, REPLACE(pedlabsampnum, ' ', '') AS pedlabsampnum1 ,
siteiid/1 AS siteiid, pedbiidref, pedon.objwlupdated AS pedobjupdate, site.objwlupdated AS siteobjupdate


FROM pedon
INNER JOIN siteobs ON  siteobs.siteobsiid=pedon.siteobsiidref 
AND pedlabsampnum IS NOT NULL 
			AND peiid IN (SELECT TOP 1 peiid
			FROM  pedon AS pchild 
			INNER JOIN  siteobs ON siteobs.siteobsiid=pedon.siteobsiidref AND pedlabsampnum IS NOT NULL 
			AND pchild.pedlabsampnum=pedon.pedlabsampnum 
			ORDER BY  
			CASE WHEN labdatadescflag = 1 and pedbiidref != '105' THEN 1
			WHEN pedbiidref != '105' and labdatadescflag = 0 THEN 2
			WHEN labdatadescflag = 1 and pedbiidref = '105' THEN 3
			WHEN pedbiidref = '105' and labdatadescflag = 0 THEN 4 
			END ASC)
INNER JOIN site ON site.siteiid=siteobs.siteiidref
GROUP BY pedlabsampnum, pedbiidref,  pedon.objwlupdated, upedonid,
peiid, latdegrees,
labsourceid, labdatadescflag, siteiid, usiteid, site.objwlupdated, 
latstddecimaldegrees, 
longstddecimaldegrees,latdir, longdir, horizdatnm,  latseconds, latminutes, 
longdegrees, longminutes, longseconds, 
latstddecimaldegrees, longstddecimaldegrees 

/*
#CORRELATED AS
EXEC SQL SELECT TOP 1 peiidref AS corr_peiid_ref, classdate AS corr_classdate, cpetaxhistory.petaxhistoryiid AS corr_petaxhistoryiid,
CODESEQ (cpetaxhistory.classtype) AS corr_class_seq, soiltaxedition AS corr_soiltaxedition,
cpetaxhistory.taxonomic_classification_name AS corr_classification_name, 
cpetaxhistory.taxon_name AS soinmascorr, CODENAME (cpetaxhistory.taxon_kind) AS corr_class_type,
cpetaxhistory.recwlupdated AS corr_obj, CODENAME (cpetaxhistory.taxorder) as corr_taxorder, CODENAME (cpetaxhistory.taxsuborder) as corr_taxsuborder,
CODENAME (cpetaxhistory.taxgrtgroup) as corr_taxgrtgroup, CODENAME (cpetaxhistory.taxsubgrp) as corr_taxsubgrp,
CODENAME (cpetaxhistory.taxpartsize) as corr_taxpartsize, CODENAME (cpetaxhistory.taxpartsizemod) as corr_taxpartsizemod, 
CODENAME (cpetaxhistory.taxfamhahatmatcl) as corr_taxfamhahatmatcl, CODENAME (cpetaxhistory.taxceactcl) as corr_taxceactcl,
CODENAME (cpetaxhistory.taxreaction) as corr_taxreaction, CODENAME (cpetaxhistory.taxtempcl) as corr_taxtempcl,
CODENAME (cpetaxhistory.taxmoistscl) as corr_taxmoistscl, CODENAME (cpetaxhistory.taxtempregime) as corr_taxtempregime,
osdtypelocflag as corr_osdtypelocflag, petaxhistoryiid as corr_iid
FROM REAL pedon 
INNER JOIN REAL petaxhistory AS  cpetaxhistory ON cpetaxhistory.peiidref=pedon.peiid AND peiid IN ($peiid) AND (cpetaxhistory.petaxhistoryiid) IS NOT NULL
AND cpetaxhistory.classtype IN (1,3)
ORDER BY soiltaxedition DESC, cpetaxhistory.recwlupdated DESC ;
AGGREGATE COLUMN corr_class_type FIRST , corr_peiid_ref FIRST, corr_classdate FIRST , corr_class_seq FIRST ,
corr_classification_name FIRST, soinmascorr FIRST, corr_class_type FIRST, corr_soiltaxedition FIRST, corr_obj FIRST, 
corr_taxorder FIRST, corr_taxsuborder FIRST, corr_taxgrtgroup FIRST, corr_taxsubgrp FIRST,
corr_taxpartsize FIRST, corr_taxpartsizemod FIRST, corr_taxceactcl FIRST,
corr_taxreaction FIRST, corr_taxtempcl FIRST, corr_taxmoistscl FIRST, corr_taxtempregime FIRST,
corr_osdtypelocflag FIRST, corr_iid FIRST, corr_petaxhistoryiid FIRST.

#CORRELATED MINERALOGY
EXEC SQL SELECT 1 AS id2, petaxhistoryiid AS cm_petaxhistoryiid, petaxhistfmmin.minorder , CODENAME (petaxhistfmmin.taxminalogy) as corr_minalogy
FROM REAL  petaxhistory 
INNER JOIN REAL  petaxhistfmmin ON  petaxhistfmmin.pedtaxhistoryiidref=petaxhistory.petaxhistoryiid AND petaxhistoryiid IN ($corr_petaxhistoryiid)
GROUP BY petaxhistoryiid, minorder,taxminalogy ORDER BY minorder; AGGREGATE ROWS BY id2 COLUMN cm_petaxhistoryiid LIST ','.

ASSIGN  corr_minalogy ARRAYCAT (corr_minalogy, ',').

#CORRELATED OTHER
EXEC SQL SELECT 1 AS id3, petaxhistoryiid AS co_petaxhistoryiid, petxhistfmother.seqnum, CODENAME (petxhistfmother.taxfamother) as corr_other
FROM REAL  petaxhistory 
INNER JOIN REAL  petxhistfmother ON petxhistfmother.pedtaxhistoryiidref=petaxhistory.petaxhistoryiid AND petaxhistoryiid IN ($corr_petaxhistoryiid)
GROUP BY petaxhistoryiid, petxhistfmother.seqnum, taxfamother ORDER BY petxhistfmother.seqnum; AGGREGATE ROWS BY id3 COLUMN co_petaxhistoryiid LIST ','.

ASSIGN  corr_other ARRAYCAT (corr_other, ',').

#SAMPLED AS 
EXEC SQL SELECT TOP 1 peiidref AS samp_peiid_ref, classdate AS samp_classdate, spetaxhistory.petaxhistoryiid AS samp_petaxhistoryiid,
CODESEQ (classtype) AS samp_class_seq,  soiltaxedition AS samp_soiltaxedition,
spetaxhistory.taxonomic_classification_name AS samp_classification_name, CODENAME (spetaxhistory.taxon_kind) AS samp_class_type, 
spetaxhistory.taxon_name AS soinmassamp, spetaxhistory.recwlupdated AS samp_obj, CODENAME (spetaxhistory.taxorder) as samp_taxorder, CODENAME (spetaxhistory.taxsuborder) as samp_taxsuborder,
CODENAME (spetaxhistory.taxgrtgroup) as samp_taxgrtgroup, CODENAME (spetaxhistory.taxsubgrp) as samp_taxsubgrp,
CODENAME (spetaxhistory.taxpartsize) as samp_taxpartsize, CODENAME (spetaxhistory.taxpartsizemod) as samp_taxpartsizemod, 
CODENAME (spetaxhistory.taxfamhahatmatcl) as samp_taxfamhahatmatcl, CODENAME (spetaxhistory.taxceactcl) as samp_taxceactcl,
CODENAME (spetaxhistory.taxreaction) as samp_taxreaction, CODENAME (spetaxhistory.taxtempcl) as samp_taxtempcl,
CODENAME (spetaxhistory.taxmoistscl) as samp_taxmoistscl, CODENAME (spetaxhistory.taxtempregime) as samp_taxtempregime,
osdtypelocflag as samp_osdtypelocflag, petaxhistoryiid as sampiid
FROM REAL pedon
INNER JOIN REAL petaxhistory AS spetaxhistory ON peiidref=pedon.peiid 
AND peiid IN ($peiid) AND classtype IN (2,4) 
ORDER BY CASE WHEN  spetaxhistory.classtype = 2 THEN 1
WHEN  spetaxhistory.classtype = 4 THEN 2 END ASC, soiltaxedition DESC, spetaxhistory.recwlupdated DESC;
AGGREGATE COLUMN samp_peiid_ref FIRST, samp_classdate FIRST,  samp_class_seq FIRST,
samp_classification_name FIRST,  soinmassamp FIRST, samp_soiltaxedition FIRST, samp_obj FIRST,
samp_taxorder FIRST, samp_taxsuborder FIRST, samp_taxgrtgroup FIRST, samp_taxsubgrp FIRST,
samp_taxpartsize FIRST, samp_taxpartsizemod FIRST, samp_taxceactcl FIRST,
samp_taxreaction FIRST, samp_taxtempcl FIRST, samp_taxmoistscl FIRST, samp_taxtempregime FIRST,
samp_osdtypelocflag FIRST, sampiid FIRST.

#SAMPLED AS MINERALOGY
EXEC SQL SELECT 1 AS id4, petaxhistoryiid AS sm_petaxhistoryiid, spetaxhistfmmin.minorder AS s_minorder , CODENAME (spetaxhistfmmin.taxminalogy) as samp_minalogy
FROM REAL  petaxhistory 
INNER JOIN REAL  petaxhistfmmin AS spetaxhistfmmin ON  spetaxhistfmmin.pedtaxhistoryiidref=petaxhistory.petaxhistoryiid AND petaxhistoryiid IN ($samp_petaxhistoryiid)
GROUP BY petaxhistoryiid, minorder,taxminalogy ORDER BY minorder; AGGREGATE ROWS BY id4 COLUMN sm_petaxhistoryiid LIST ','.

ASSIGN  samp_minalogy ARRAYCAT (samp_minalogy, ',').

#SAMPLED AS OTHER
EXEC SQL SELECT 1 AS id5, petaxhistoryiid AS so_petaxhistoryiid, spetxhistfmother.seqnum, CODENAME (spetxhistfmother.taxfamother) as samp_other
FROM REAL  petaxhistory 
INNER JOIN REAL  petxhistfmother AS spetxhistfmother ON spetxhistfmother.pedtaxhistoryiidref=petaxhistory.petaxhistoryiid AND petaxhistoryiid IN ($samp_petaxhistoryiid)
GROUP BY petaxhistoryiid, spetxhistfmother.seqnum, taxfamother ORDER BY spetxhistfmother.seqnum; AGGREGATE ROWS BY id5 COLUMN so_petaxhistoryiid LIST ','.

ASSIGN  samp_other ARRAYCAT (samp_other, ',').

#EXEC SQL SELECT TOP 1 QUOTENAME (REPLACE (counties.areaname, ',', ''), '"') AS county, areasymbol as county_symbol
#FROM REAL site 
#INNER JOIN REAL siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
#INNER JOIN REAL area AS counties ON counties.areaiid=siteaoverlap.areaiidref
#INNER JOIN REAL areatype AS co ON co.areatypeiid=counties.areatypeiidref AND co.areatypename = "County or Parish"; .

####################################################
#  				      COUNTY    		    	   #
####################################################
EXEC SQL SELECT TOP 1 QUOTENAME (REPLACE (counties.areaname, ',', ''), '"') AS county, areasymbol as county_symbol
FROM REAL site 
INNER JOIN REAL area AS counties BY site_county AND siteiid IN ($siteiid)
INNER JOIN REAL areatype AS co BY default AND co.areatypename = "County or Parish";.


EXEC SQL SELECT TOP 1 countries.areasymbol as country_symbol
#QUOTENAME (REPLACE (countries.areaname, ',', ''), '"') AS Country, areasymbol as country_symbol
FROM REAL site 
INNER JOIN siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
INNER JOIN REAL area AS countries ON countries.areaiid=siteaoverlap.areaiidref
INNER JOIN REAL areatype AS country ON country.areatypeiid=countries.areatypeiidref AND country.areatypename = "Country";.


####################################################
#  				      STATE    		    	       #
####################################################
#EXEC SQL SELECT  sts.areaname, sts.areasymbol, st.areatypename 
EXEC SQL SELECT TOP 1 sts.areasymbol as state_symbol
#QUOTENAME (REPLACE (sts.areaname, ',', ''), '"') AS state, areasymbol as state_symbol
#FROM REAL site
#INNER JOIN REAL siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
#INNER JOIN REAL area AS sts ON sts.areaiid=siteaoverlap.areaiidref
#INNER JOIN REAL areatype AS st ON st.areatypeiid=sts.areatypeiidref AND st.areatypename = 'State or Territory';.
FROM site 
INNER JOIN REAL area AS sts BY site_state  AND siteiid IN ($siteiid)
INNER JOIN REAL areatype AS st BY default AND st.areatypename = "State or Territory";.

####################################################
#  			            MLRA   	         	       #
####################################################
EXEC SQL SELECT TOP 1 QUOTENAME (REPLACE (mlras.areaname, ',',''), '"') AS mlra, areasymbol as mlra_symbol

#EXEC SQL SELECT mlras.areaname, mlras.areasymbol, ml.areatypename
FROM site 
INNER JOIN REAL area AS mlras BY site_mlra  AND siteiid IN ($siteiid)
INNER JOIN REAL areatype AS ml BY default AND ml.areatypename = "MLRA";.
#FROM REAL site
#INNER JOIN REAL siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
#INNER JOIN REAL area AS mlras ON mlras.areaiid=siteaoverlap.areaiidref
#INNER JOIN REAL areatype AS mlra ON mlra.areatypeiid=mlras.areatypeiidref AND mlra.areatypename = 'MLRA';.

EXEC SQL SELECT TOP 1 QUOTENAME (REPLACE (SSAs.areaname, ',', ''), '"') AS SSAs, areasymbol as ssa_symbol
FROM REAL  site
INNER JOIN REAL siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
INNER JOIN REAL area AS SSAs ON SSAs.areaiid=siteaoverlap.areaiidref
INNER JOIN REAL areatype AS SSA ON SSA.areatypeiid=SSAs.areatypeiidref AND SSA.areatypename = 'Non-MLRA Soil Survey Area';.


EXEC SQL SELECT TOP 1 Parks.areasymbol as park_symbol
#QUOTENAME (REPLACE (Parks.areaname, ',', ''), '"') AS Park
FROM REAL  site
INNER JOIN REAL siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
INNER JOIN REAL area AS Parks ON Parks.areaiid=siteaoverlap.areaiidref
INNER JOIN REAL areatype AS Park ON Park.areatypeiid=Parks.areatypeiidref AND Park.areatypename = 'National Park System Land';.

EXEC SQL SELECT TOP 1 Forests.areasymbol as forest_symbol
#QUOTENAME (REPLACE (Forests.areaname, ',', ''), '"') AS Forest
FROM REAL  site
INNER JOIN REAL siteaoverlap ON siteaoverlap.siteiidref=site.siteiid AND siteiid IN ($siteiid)
INNER JOIN REAL area AS Forests ON Forests.areaiid=siteaoverlap.areaiidref
INNER JOIN REAL areatype AS Forest ON Forest.areatypeiid=Forests.areatypeiidref AND Forest.areatypename = 'National Forest System Land';.

EXEC SQL SELECT sitetext.textsubcat 
FROM site
INNER JOIN sitetext by default AND siteiid IN ($siteiid) AND (sitetext.textsubcat =  'Undisclosed Location');
AGGREGATE COLUMN sitetext.textsubcat None.

Assign latstddecimaldegrees IF Any (sitetext.textsubcat == "Undisclosed Location") then "" else latstddecimaldegrees.

Assign longstddecimaldegrees if any (sitetext.textsubcat == "Undisclosed Location") then "" else longstddecimaldegrees.

TEMPLATE site WIDTH UNLIMITED SEPARATOR"|"
AT LEFT FIELD   SEPARATOR  "" ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD ,
                              FIELD.
PAGE LENGTH UNLIMITED WIDTH UNLIMITED.

SECTION HEADING
USING site
"labdatadescflag",
"priority2",
"priority",
"pedoniid",
"siteiid",
"pedobjupdate", 
"siteobjupdate",
"pedlabsampnum",
"upedonid",
"usiteid",
"latitude_degrees",
"latitude_minutes",
"latitude_seconds",
"latitude_direction",
"longitude_degrees",
"longitude_minutes",
"longitude_seconds",
"longitude_direction",
"datum_name",
"country_symbol",
"state_symbol",
"county_symbol",
"mlra_symbol",
"ssa_symbol",
"nforest_symbol",
"npark_symbol",
"latitude_decimal_degrees",
"longitude_decimal_degrees",
"samp_name",
"samp_class_type",
"samp_classification_name",
"samp_taxorder",
"samp_taxsuborder",
"samp_taxgrtgroup",
"samp_taxsubgrp",
"samp_taxpartsize",
"samp_taxpartsizemod",
"samp_taxfamhahatmatcl", 
"samp_taxceactcl",
"samp_taxreaction",
"samp_taxtempcl",
"samp_taxmoistscl",
"samp_taxtempregime",
"samp_taxminalogy",
"samp_taxother",
"samp_osdtypelocflag",
"samp_classdate",
"corr_name",
"corr_class_type",
"corr_classification_name",
"corr_taxorder",
"corr_taxsuborder",
"corr_taxgrtgroup",
"corr_taxsubgrp",
"corr_taxpartsize",
"corr_taxpartsizemod",
"corr_taxfamhahatmatcl", 
"corr_taxceactcl",
"corr_taxreaction",
"corr_taxtempcl",
"corr_taxmoistscl",
"corr_taxtempregime",
"corr_taxminalogy",
"corr_taxother",
"corr_osdtypelocflag",
"corr_classdate".
END SECTION.

SECTION WHEN FIRST OF pedlabsampnum1
DATA 
USING  site
labdatadescflag ,
priority2 ,
priority ,
peiid ,
siteiid,
pedobjupdate, 
siteobjupdate,
pedlabsampnum1 ,
upedonid ,
usiteid ,
latdegrees ,
latminutes ,
latseconds ,
latdirect ,
longdegrees ,
longminutes ,
longseconds ,
longdirect ,
datum ,
country_symbol,
state_symbol,
county_symbol,
mlra_symbol,
ssa_symbol,
forest_symbol,
park_symbol,
latstddecimaldegrees ,
longstddecimaldegrees ,
soinmassamp ,
samp_class_type, 
samp_classification_name ,
samp_taxorder,
samp_taxsuborder, 
samp_taxgrtgroup, 
samp_taxsubgrp,
samp_taxpartsize, 
samp_taxpartsizemod, 
samp_taxfamhahatmatcl, 
samp_taxceactcl,
samp_taxreaction, 
samp_taxtempcl, 
samp_taxmoistscl, 
samp_taxtempregime,
samp_minalogy,
samp_other,
samp_osdtypelocflag, 
samp_classdate,
soinmascorr,
corr_class_type,
corr_classification_name,
corr_taxorder,
corr_taxsuborder, 
corr_taxgrtgroup, 
corr_taxsubgrp,
corr_taxpartsize, 
corr_taxpartsizemod, 
corr_taxfamhahatmatcl, 
corr_taxceactcl,
corr_taxreaction, 
corr_taxtempcl, 
corr_taxmoistscl, 
corr_taxtempregime,
corr_minalogy,
corr_other,
corr_osdtypelocflag, 
corr_classdate.
END SECTION.

*/

