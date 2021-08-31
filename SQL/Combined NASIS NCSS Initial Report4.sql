-- Converted from NASIS Report, "Site_Laboratory_Locations_Overlaps__NCSS_site"
--Original Report written by Jason Nemecek 2013

USE nasis;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
DROP TABLE IF EXISTS #ncss_one2;
DROP TABLE IF EXISTS #correlated;
DROP TABLE IF EXISTS #sampled;
DROP TABLE IF EXISTS #overlap3

CREATE TABLE #ncss_one2
(
    [id] [INT] NOT NULL,
    [peiid] [int] NOT NULL,
    [latdegrees] [smallint] NULL,
    [latminutes] [smallint] NULL,
    [latseconds] [real] NULL,
    [lat_direction] [varchar](10) NULL,
    [longdegrees] [smallint] NULL,
    [longminutes] [smallint] NULL,
    [longseconds] [real] NULL,
    [long_direction] [varchar](10) NULL,
    [datum_name] [varchar](250) NULL,
    [latstddecimaldegrees] [float] NULL,
    [longstddecimaldegrees] [float] NULL,
    [usiteid] [varchar](60) NOT NULL,
    [upedonid] [varchar](60) NOT NULL,
    [labsourceid] [varchar](60) NULL,
    [labdatadescflag] [smallint] NULL,
    [priority] [varchar](5) NULL,
    [priority2] [varchar](5) NULL,
    [pedlabsampnum1] [varchar](60) NULL,
    [siteiid] [int] NOT NULL,
    [pedbiidref] [int] NOT NULL,
    [pedobjupdate] [datetime] NULL,
    [siteobjupdate] [datetime] NULL
)

INSERT INTO #ncss_one2
(
    [id],
    [peiid],
    [latdegrees],
    [latminutes],
    [latseconds],
    [lat_direction],
    [longdegrees],
    [longminutes],
    [longseconds],
    [long_direction],
    [datum_name],
    [latstddecimaldegrees],
    [longstddecimaldegrees],
    [usiteid],
    [upedonid],
    [labsourceid],
    [labdatadescflag],
    [priority],
    [priority2],
    [pedlabsampnum1],
    [siteiid],
    [pedbiidref],
    [pedobjupdate],
    [siteobjupdate]
)
SELECT 1 AS id,
       peiid / 1 AS peiid,
       latdegrees,
       latminutes,
       latseconds,
       CAST(
       (
           select top 1
               CAST([ChoiceName] AS varchar)
           from [nasis].[dbo].site AS s,
                [nasis].[dbo].MetadataDomainMaster dm,
                [nasis].[dbo].MetadataDomainDetail dd
           WHERE s.siteiid = site.siteiid
                 AND latdir = ChoiceValue
                 and DomainName = 'latitude_direction'
                 AND dm.DomainID = dd.DomainID
           ORDER BY latdir DESC
       ) AS varchar) AS lat_direction,
       longdegrees,
       longminutes,
       longseconds,
       CAST(
       (
           select top 1
               CAST([ChoiceName] AS varchar)
           from [nasis].[dbo].site AS s,
                [nasis].[dbo].MetadataDomainMaster dm,
                [nasis].[dbo].MetadataDomainDetail dd
           WHERE s.siteiid = site.siteiid
                 AND longdir = ChoiceValue
                 and DomainName = 'longitude_direction'
                 AND dm.DomainID = dd.DomainID
           ORDER BY latdir DESC
       ) AS varchar) AS long_direction,
       --CODENAME (horizdatnm) AS datum, 

       CAST(
       (
           select top 1
               CAST([ChoiceName] AS varchar)
           from [nasis].[dbo].site AS s,
                [nasis].[dbo].MetadataDomainMaster dm,
                [nasis].[dbo].MetadataDomainDetail dd
           WHERE s.siteiid = site.siteiid
                 AND horizdatnm = ChoiceValue
                 and DomainName = 'horizontal_datum_name'
                 AND dm.DomainID = dd.DomainID
           ORDER BY horizdatnm DESC
       ) AS varchar) AS datum_name,
       latstddecimaldegrees,
       longstddecimaldegrees,
       usiteid,
       upedonid,
       labsourceid,
       labdatadescflag,
       CASE
           WHEN pedbiidref = '105' THEN
               'D'
           ELSE
               'B'
       END AS priority,
       CASE
           WHEN labdatadescflag != 0 THEN
               'A'
           ELSE
               'C'
       END AS priority2,
       REPLACE(pedlabsampnum, ' ', '') AS pedlabsampnum1,
       siteiid / 1 AS siteiid,
       pedbiidref,
       pedon.objwlupdated AS pedobjupdate,
       site.objwlupdated AS siteobjupdate
FROM pedon
    INNER JOIN siteobs
        ON siteobs.siteobsiid = pedon.siteobsiidref
           --AND peiid = 296211


           AND pedlabsampnum IS NOT NULL
           AND peiid IN (
                            SELECT TOP 1
                                peiid
                            FROM pedon AS pchild
                                INNER JOIN siteobs
                                    ON siteobs.siteobsiid = pedon.siteobsiidref
                                       AND pedlabsampnum IS NOT NULL
                                       AND pchild.pedlabsampnum = pedon.pedlabsampnum
                            ORDER BY CASE
                                         WHEN labdatadescflag = 1
                                              and pedbiidref != '105' THEN
                                             1
                                         WHEN pedbiidref != '105'
                                              and labdatadescflag = 0 THEN
                                             2
                                         WHEN labdatadescflag = 1
                                              and pedbiidref = '105' THEN
                                             3
                                         WHEN pedbiidref = '105'
                                              and labdatadescflag = 0 THEN
                                             4
                                     END ASC
                        )
    INNER JOIN site
        ON site.siteiid = siteobs.siteiidref
GROUP BY pedlabsampnum,
         pedbiidref,
         pedon.objwlupdated,
         upedonid,
         peiid,
         latdegrees,
         labsourceid,
         labdatadescflag,
         siteiid,
         usiteid,
         site.objwlupdated,
         latstddecimaldegrees,
         longstddecimaldegrees,
         latdir,
         longdir,
         horizdatnm,
         latseconds,
         latminutes,
         longdegrees,
         longminutes,
         longseconds,
         latstddecimaldegrees,
         longstddecimaldegrees


CREATE TABLE #correlated
(
    [corr_peiid_ref] [INT] NOT NULL,
    [corr_classdate] [datetime] NULL,
    [corr_petaxhistoryiid] [INT] NOT NULL,
    [corr_class_seq] [INT] NULL,
    [corr_soiltaxedition] [INT] NULL,
    [corr_classification_name] [varchar](250) NULL,
    [soinmascorr] [varchar](250) NULL,
    [corr_class_type] [varchar](250) NULL,
    [corr_obj] [varchar](10) NULL,
    [corr_taxorder] [varchar](100) NULL,
    [corr_taxsuborder] [varchar](250) NULL,
    [corr_taxgrtgroup] [varchar](250) NULL,
    [corr_taxsubgrp] [varchar](250) NULL,
    [corr_taxpartsize] [varchar](250) NULL,
    [corr_taxpartsizemod] [varchar](250) NULL,
    [corr_taxfamhahatmatcl] [varchar](250) NULL,
    [corr_taxceactcl] [varchar](250) NULL,
    [corr_taxreaction] [varchar](250) NULL,
    [corr_taxtempcl] [varchar](250) NULL,
    [corr_taxmoistscl] [varchar](250) NULL,
    [corr_taxtempregime] [varchar](250) NULL,
    [corr_osdtypelocflag] [INT] NOT NULL,
    [corr_iid] [INT] NOT NULL,
    [corr_minalogy] [varchar](250) NULL,
    [corr_other] [varchar](250) NULL
)


INSERT INTO #correlated
(
    corr_peiid_ref,
    corr_classdate,
    corr_petaxhistoryiid,
    corr_class_seq,
    corr_soiltaxedition,
    corr_classification_name,
    soinmascorr,
    corr_class_type,
    corr_obj,
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
    corr_osdtypelocflag,
    corr_iid,
    corr_minalogy,
    corr_other
)

--Linkage corr_peiid_ref to peiid

--CORRELATED AS
SELECT peiidref AS corr_peiid_ref,
       classdate AS corr_classdate,
       cpetaxhistory.petaxhistoryiid AS corr_petaxhistoryiid,
       (
           select top 1
               [ChoiceSequence]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND classtype = ChoiceValue
                 and DomainName = 'classification_type'
                 AND dm.DomainID = dd.DomainID
           ORDER BY classtype DESC
       ) AS corr_class_seq,
       cpetaxhistory.soiltaxedition AS corr_soiltaxedition,
       cpetaxhistory.taxclname AS corr_classification_name,
       cpetaxhistory.taxonname AS soinmascorr,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxonkind = ChoiceValue
                 and DomainName = 'component_kind'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxonkind DESC
       ) AS varchar) AS corr_class_type,
       cpetaxhistory.recwlupdated AS corr_obj,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxorder = ChoiceValue
                 and DomainName = 'taxonomic_order'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxorder DESC
       ) AS varchar) AS corr_taxorder,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxsuborder = ChoiceValue
                 and DomainName = 'taxonomic_suborder'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxsuborder DESC
       ) AS varchar) AS corr_taxsuborder,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxgrtgroup = ChoiceValue
                 and DomainName = 'taxonomic_great_group'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxgrtgroup DESC
       ) AS varchar) AS corr_taxgrtgroup,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxsubgrp = ChoiceValue
                 and DomainName = 'taxonomic_subgroup'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxorder DESC
       ) AS varchar) AS corr_taxsubgrp,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxpartsize = ChoiceValue
                 and DomainName = 'taxonomic_family_particle_size'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxpartsize DESC
       ) AS varchar) AS corr_taxpartsize,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxpartsizemod = ChoiceValue
                 and DomainName = 'taxonomic_family_part_size_mod'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxpartsizemod DESC
       ) AS varchar) AS corr_taxpartsizemod,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxfamhahatmatcl = ChoiceValue
                 and DomainName = 'taxonomic_family_haht_mat_class'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxfamhahatmatcl DESC
       ) AS varchar) AS corr_taxfamhahatmatcl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxceactcl = ChoiceValue
                 and DomainName = 'taxonomic_family_c_e_act_class'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxceactcl DESC
       ) AS varchar) AS corr_taxceactcl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxreaction = ChoiceValue
                 and DomainName = 'taxonomic_family_reaction'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxreaction DESC
       ) AS varchar) AS corr_taxreaction,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxtempcl = ChoiceValue
                 and DomainName = 'taxonomic_family_temp_class'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxtempcl DESC
       ) AS varchar) AS corr_taxtempcl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxmoistscl = ChoiceValue
                 and DomainName = 'taxonomic_moisture_subclass'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxmoistscl DESC
       ) AS varchar) AS corr_taxmoistscl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxtempregime = ChoiceValue
                 and DomainName = 'taxonomic_temp_regime'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxtempregime DESC
       ) AS varchar) AS corr_taxtempregime,
       osdtypelocflag as corr_osdtypelocflag,
       petaxhistoryiid as corr_iid,
       SUBSTRING(
       (
           SELECT (', ' + [ChoiceName])
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].petaxhistfmmin AS cthm,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND cthm.pedtaxhistoryiidref = cth.petaxhistoryiid
                 AND taxminalogy = ChoiceValue
                 and DomainName = 'taxonomic_family_mineralogy'
                 AND dm.DomainID = dd.DomainID
           GROUP BY ChoiceName,
                    taxminalogy
           ORDER BY taxminalogy DESC,
                    ChoiceName
           FOR XML PATH('')
       ),
       3,
       50
                ) AS corr_minalogy,
       SUBSTRING(
       (
           SELECT (', ' + [ChoiceName])
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].petxhistfmother AS cthmo,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND cthmo.pedtaxhistoryiidref = cth.petaxhistoryiid
                 AND taxfamother = ChoiceValue
                 and DomainName = 'taxonomic_family_other'
                 AND dm.DomainID = dd.DomainID
           GROUP BY ChoiceName,
                    taxfamother
           ORDER BY taxfamother DESC,
                    ChoiceName
           FOR XML PATH('')
       ),
       3,
       50
                ) AS corr_other
FROM #ncss_one2
    INNER JOIN petaxhistory AS cpetaxhistory
        ON cpetaxhistory.peiidref = #ncss_one2.peiid

           ---Sub query to get the top correlated (Many to one relationships)
           AND petaxhistoryiid IN (
                                      SELECT TOP 1
                                          petaxhistoryiid
                                      FROM petaxhistory AS pt2
                                      WHERE (cpetaxhistory.petaxhistoryiid) IS NOT NULL
                                            AND cpetaxhistory.classtype IN ( 1, 3 )
                                            AND #ncss_one2.peiid IN ( pt2.peiidref )
                                      ORDER BY soiltaxedition DESC,
                                               cpetaxhistory.recwlupdated DESC
                                  );


--Sampled AS
CREATE TABLE #sampled
(
    [samp_peiid_ref] [INT] NOT NULL,
    [samp_classdate] [datetime] NULL,
    [samp_petaxhistoryiid] [INT] NOT NULL,
    [samp_class_seq] [INT] NULL,
    [samp_soiltaxedition] [INT] NULL,
    [samp_classification_name] [varchar](250) NULL,
    [soinmassamp] [varchar](250) NULL,
    [samp_class_type] [varchar](250) NULL,
    [samp_obj] [varchar](10) NULL,
    [samp_taxorder] [varchar](100) NULL,
    [samp_taxsuborder] [varchar](250) NULL,
    [samp_taxgrtgroup] [varchar](250) NULL,
    [samp_taxsubgrp] [varchar](250) NULL,
    [samp_taxpartsize] [varchar](250) NULL,
    [samp_taxpartsizemod] [varchar](250) NULL,
    [samp_taxfamhahatmatcl] [varchar](250) NULL,
    [samp_taxceactcl] [varchar](250) NULL,
    [samp_taxreaction] [varchar](250) NULL,
    [samp_taxtempcl] [varchar](250) NULL,
    [samp_taxmoistscl] [varchar](250) NULL,
    [samp_taxtempregime] [varchar](250) NULL,
    [samp_osdtypelocflag] [INT] NOT NULL,
    [samp_iid] [INT] NOT NULL,
    [samp_minalogy] [varchar](250) NULL,
    [samp_other] [varchar](250) NULL
)


INSERT INTO #sampled
(
    samp_peiid_ref,
    samp_classdate,
    samp_petaxhistoryiid,
    samp_class_seq,
    samp_soiltaxedition,
    samp_classification_name,
    soinmassamp,
    samp_class_type,
    samp_obj,
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
    samp_osdtypelocflag,
    samp_iid,
    samp_minalogy,
    samp_other
)

--Linkage samp_peiid_ref to peiid
SELECT peiidref AS samp_peiid_ref,
       classdate AS samp_classdate,
       spetaxhistory.petaxhistoryiid AS samp_petaxhistoryiid,
       (
           select top 1
               [ChoiceSequence]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND classtype = ChoiceValue
                 and DomainName = 'classification_type'
                 AND dm.DomainID = dd.DomainID
           ORDER BY classtype DESC
       ) AS samp_class_seq,
       spetaxhistory.soiltaxedition AS samp_soiltaxedition,
       spetaxhistory.taxclname AS samp_classification_name,
       spetaxhistory.taxonname AS soinmassamp,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxonkind = ChoiceValue
                 and DomainName = 'component_kind'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxonkind DESC
       ) AS varchar) AS samp_class_type,
       spetaxhistory.recwlupdated AS samp_obj,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxorder = ChoiceValue
                 and DomainName = 'taxonomic_order'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxorder DESC
       ) AS varchar) AS samp_taxorder,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxsuborder = ChoiceValue
                 and DomainName = 'taxonomic_suborder'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxsuborder DESC
       ) AS varchar) AS samp_taxsuborder,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxgrtgroup = ChoiceValue
                 and DomainName = 'taxonomic_great_group'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxgrtgroup DESC
       ) AS varchar) AS samp_taxgrtgroup,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxsubgrp = ChoiceValue
                 and DomainName = 'taxonomic_subgroup'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxorder DESC
       ) AS varchar) AS samp_taxsubgrp,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxpartsize = ChoiceValue
                 and DomainName = 'taxonomic_family_particle_size'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxpartsize DESC
       ) AS varchar) AS samp_taxpartsize,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxpartsizemod = ChoiceValue
                 and DomainName = 'taxonomic_family_part_size_mod'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxpartsizemod DESC
       ) AS varchar) AS samp_taxpartsizemod,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxfamhahatmatcl = ChoiceValue
                 and DomainName = 'taxonomic_family_haht_mat_class'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxfamhahatmatcl DESC
       ) AS varchar) AS samp_taxfamhahatmatcl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxceactcl = ChoiceValue
                 and DomainName = 'taxonomic_family_c_e_act_class'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxceactcl DESC
       ) AS varchar) AS samp_taxceactcl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxreaction = ChoiceValue
                 and DomainName = 'taxonomic_family_reaction'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxreaction DESC
       ) AS varchar) AS samp_taxreaction,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxtempcl = ChoiceValue
                 and DomainName = 'taxonomic_family_temp_class'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxtempcl DESC
       ) AS varchar) AS samp_taxtempcl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxmoistscl = ChoiceValue
                 and DomainName = 'taxonomic_moisture_subclass'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxmoistscl DESC
       ) AS varchar) AS samp_taxmoistscl,
       CAST(
       (
           select top 1
               [ChoiceName]
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND taxtempregime = ChoiceValue
                 and DomainName = 'taxonomic_temp_regime'
                 AND dm.DomainID = dd.DomainID
           ORDER BY taxtempregime DESC
       ) AS varchar) AS samp_taxtempregime,
       osdtypelocflag as samp_osdtypelocflag,
       petaxhistoryiid as samp_iid,
       SUBSTRING(
       (
           SELECT (', ' + [ChoiceName])
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].petaxhistfmmin AS cthm,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND cthm.pedtaxhistoryiidref = cth.petaxhistoryiid
                 AND taxminalogy = ChoiceValue
                 and DomainName = 'taxonomic_family_mineralogy'
                 AND dm.DomainID = dd.DomainID
           GROUP BY ChoiceName,
                    taxminalogy
           ORDER BY taxminalogy DESC,
                    ChoiceName
           FOR XML PATH('')
       ),
       3,
       50
                ) AS samp_minalogy,
       SUBSTRING(
       (
           SELECT (', ' + [ChoiceName])
           from [nasis].[dbo].petaxhistory AS cth,
                [nasis].[dbo].petxhistfmother AS cthmo,
                [nasis].[dbo].MetadataDomainMaster AS dm,
                [nasis].[dbo].MetadataDomainDetail AS dd
           WHERE #ncss_one2.peiid = cth.peiidref
                 AND cthmo.pedtaxhistoryiidref = cth.petaxhistoryiid
                 AND taxfamother = ChoiceValue
                 and DomainName = 'taxonomic_family_other'
                 AND dm.DomainID = dd.DomainID
           GROUP BY ChoiceName,
                    taxfamother
           ORDER BY taxfamother DESC,
                    ChoiceName
           FOR XML PATH('')
       ),
       3,
       50
                ) AS samp_other
FROM #ncss_one2
    INNER JOIN petaxhistory AS spetaxhistory
        ON spetaxhistory.peiidref = #ncss_one2.peiid

           ---Sub query to get the top Sampled (Many to one relationships)
           AND petaxhistoryiid IN (
                                      SELECT TOP 1
                                          petaxhistoryiid
                                      FROM petaxhistory AS pt2
                                      WHERE (spetaxhistory.petaxhistoryiid) IS NOT NULL
                                            AND spetaxhistory.classtype IN ( 2, 4 )
                                            AND #ncss_one2.peiid IN ( pt2.peiidref )
                                      ORDER BY CASE
                                                   WHEN spetaxhistory.classtype = 2 THEN
                                                       1
                                                   WHEN spetaxhistory.classtype = 4 THEN
                                                       2
                                               END ASC,
                                               soiltaxedition DESC,
                                               spetaxhistory.recwlupdated DESC
                                  )

CREATE TABLE #overlap3
(
    siteiid [INT] NOT NULL,
    county_symbol [varchar](20) NULL,
    state_symbol [varchar](20) NULL,
    mlra_symbol [varchar](20) NULL,
    ssa_symbol [varchar](20) NULL,
    park_symbol [varchar](20) NULL,
    forest_symbol [varchar](20) NULL,
    county_symbol2 [varchar](20) NULL,
    state_symbol2 [varchar](20) NULL,
    mlra_symbol2 [varchar](20) NULL,
    undisclosed_Location_flag [varchar](5) NULL,
    country_symbol [varchar](100) NULL
)

INSERT INTO #overlap3
(
    siteiid,
    county_symbol,
    state_symbol,
    mlra_symbol,
    ssa_symbol,
    park_symbol,
    forest_symbol,
    county_symbol2,
    state_symbol2,
    mlra_symbol2,
    undisclosed_Location_flag,
    country_symbol
)

--linkage -- siteiid to siteiid

SELECT a.siteiid,
       (
           SELECT TOP 1
               areasymbol AS county_code
           FROM site AS s1
               INNER JOIN area AS county
                   ON county.areaiid = s1.countyareaiidref
               INNER JOIN areatype AS co
                   ON co.areatypeiid = county.areatypeiidref
                      AND co.areatypename = 'County or Parish'
                      AND s1.siteiid = a.siteiid
       ) AS county_symbol,
       (
           SELECT TOP 1
               areasymbol AS state_code
           FROM site AS s1
               INNER JOIN area AS st
                   ON st.areaiid = s1.stateareaiidref
               INNER JOIN areatype AS co
                   ON co.areatypeiid = st.areatypeiidref
                      AND co.areatypename = 'State or Territory'
                      AND s1.siteiid = a.siteiid
       ) AS state_symbol,
       (
           SELECT TOP 1
               areasymbol AS mlra_code
           FROM site AS s1
               INNER JOIN area AS m
                   ON m.areaiid = s1.mlraareaiidref
               INNER JOIN areatype AS co
                   ON co.areatypeiid = m.areatypeiidref
                      AND co.areatypename = 'mlra'
                      AND s1.siteiid = a.siteiid
       ) AS mlra_symbol,
       (
           SELECT TOP 1
               areasymbol AS ssa_symbol
           FROM site AS s1
               INNER JOIN siteaoverlap
                   ON siteaoverlap.siteiidref = s1.siteiid
                      AND s1.siteiid = a.siteiid
               INNER JOIN area AS SSAs
                   ON SSAs.areaiid = siteaoverlap.areaiidref
               INNER JOIN areatype AS SSA
                   ON SSA.areatypeiid = SSAs.areatypeiidref
                      AND SSA.areatypename = 'Non-MLRA Soil Survey Area'
       ) AS ssa_symbol,
       (
           SELECT TOP 1
               areasymbol AS park_symbol
           FROM site AS s1
               INNER JOIN siteaoverlap
                   ON siteaoverlap.siteiidref = s1.siteiid
                      AND s1.siteiid = a.siteiid
               INNER JOIN area AS SSAs
                   ON SSAs.areaiid = siteaoverlap.areaiidref
               INNER JOIN areatype AS SSA
                   ON SSA.areatypeiid = SSAs.areatypeiidref
                      AND SSA.areatypename = 'National Park System Land'
       ) AS park_symbol,
       (
           SELECT TOP 1
               areasymbol AS forest_symbol
           FROM site AS s1
               INNER JOIN siteaoverlap
                   ON siteaoverlap.siteiidref = s1.siteiid
                      AND s1.siteiid = a.siteiid
               INNER JOIN area AS SSAs
                   ON SSAs.areaiid = siteaoverlap.areaiidref
               INNER JOIN areatype AS SSA
                   ON SSA.areatypeiid = SSAs.areatypeiidref
                      AND SSA.areatypename = 'forest_symbol'
       ) AS forest_symbol,

       -- Second 
       (
           SELECT TOP 1
               areasymbol AS county_symbol2
           FROM site AS s1
               INNER JOIN siteaoverlap
                   ON siteaoverlap.siteiidref = s1.siteiid
                      AND s1.siteiid = a.siteiid
               INNER JOIN area AS SSAs
                   ON SSAs.areaiid = siteaoverlap.areaiidref
               INNER JOIN areatype AS SSA
                   ON SSA.areatypeiid = SSAs.areatypeiidref
                      AND SSA.areatypename = 'County or Parish'
       ) AS county_symbol2,
       (
           SELECT TOP 1
               areasymbol AS state_symbol2
           FROM site AS s1
               INNER JOIN siteaoverlap
                   ON siteaoverlap.siteiidref = s1.siteiid
                      AND s1.siteiid = a.siteiid
               INNER JOIN area AS SSAs
                   ON SSAs.areaiid = siteaoverlap.areaiidref
               INNER JOIN areatype AS SSA
                   ON SSA.areatypeiid = SSAs.areatypeiidref
                      AND SSA.areatypename = 'State or Territory'
       ) AS state_symbol2,
       (
           SELECT TOP 1
               areasymbol AS mlra_symbol2
           FROM site AS s1
               INNER JOIN siteaoverlap
                   ON siteaoverlap.siteiidref = s1.siteiid
                      AND s1.siteiid = a.siteiid
               INNER JOIN area AS SSAs
                   ON SSAs.areaiid = siteaoverlap.areaiidref
               INNER JOIN areatype AS SSA
                   ON SSA.areatypeiid = SSAs.areatypeiidref
                      AND SSA.areatypename = 'mlra'
       ) AS mlra_symbol2,
       (
           SELECT TOP 1
               CASE
                   WHEN textsubcat = 'Undisclosed Location' THEN
                       'Yes'
                   ELSE
                       'No'
               END
           FROM site AS s1
               INNER JOIN sitetext
                   ON sitetext.siteiidref = s1.siteiid
                      AND sitetext.textsubcat = 'Undisclosed Location'
                      AND s1.siteiid = a.siteiid
       ) AS undisclosed_Location_flag,
       (
           SELECT TOP 1
               areasymbol AS country_symbol
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
FROM #ncss_one2 AS a
--------


SELECT --[pedon_key], --SSL_REPO	
    --[site_key],  --SSL_REPO
    pedlabsampnum1 AS [pedlabsampnum],
    peiid,
    [upedonid],
    [labdatadescflag],
    [priority],
    [priority2],
    soinmassamp AS [samp_name],
    [samp_class_type],
    [samp_classdate],
    [samp_classification_name],
    [samp_taxorder],
    [samp_taxsuborder],
    [samp_taxgrtgroup],
    [samp_taxsubgrp],
    [samp_taxpartsize],
    [samp_taxpartsizemod],
    [samp_taxceactcl],
    [samp_taxreaction],
    [samp_taxtempcl],
    [samp_taxmoistscl],
    [samp_taxtempregime],
    samp_minalogy AS [samp_taxminalogy],
    samp_other AS [samp_taxother],
    [samp_osdtypelocflag],
    corr_classification_name AS [corr_name],
    [corr_class_type],
    [corr_classdate],
    [corr_classification_name],
    [corr_taxorder],
    [corr_taxsuborder],
    [corr_taxgrtgroup],
    [corr_taxsubgrp],
    [corr_taxpartsize],
    [corr_taxpartsizemod],
    [corr_taxceactcl],
    [corr_taxreaction],
    [corr_taxtempcl],
    [corr_taxmoistscl],
    [corr_taxtempregime],
    corr_minalogy AS [corr_taxminalogy],
    corr_other AS [corr_taxother],
    [corr_osdtypelocflag],
                                     /* --SSL_REPO
	  [SSL_name],
      [SSL_class_type],
      [SSL_classdate],
      [SSL_classification_name],
      [SSL_taxorder],
      [SSL_taxsuborder],
      [SSL_taxgrtgroup],
      [SSL_taxsubgrp],
      [SSL_taxpartsize],
      [SSL_taxpartsizemod],
      [SSL_taxceactcl],
      [SSL_taxreaction],
      [SSL_taxtempcl],
      [SSL_taxmoistscl],
      [SSL_taxtempregime],
      [SSL_taxminalogy],
      [SSL_taxother],
      [SSL_osdtypelocflag],
	  */
    [a].[siteiid],
    [usiteid],
    samp_obj AS [site_obsdate],
    CASE
        WHEN undisclosed_Location_flag = 'Yes' THEN
            NULL
        ELSE
            latstddecimaldegrees
    END AS [latitude_decimal_degrees],
    CASE
        WHEN undisclosed_Location_flag = 'Yes' THEN
            NULL
        ELSE
            longstddecimaldegrees
    END AS [longitude_decimal_degrees],

                                     -- The keys need to all be filled out somehow up to from country to SSA
    country_symbol,                  --[country_key] -- Need to be converted to SSL Repo Area Key
    CASE
        WHEN state_symbol IS NULL THEN
            state_symbol2
        ELSE
            state_symbol
    END AS state_symbol,             --[state_key] -- Need to be converted to SSL Repo Area Key
    CASE
        WHEN county_symbol IS NULL THEN
            county_symbol2
        ELSE
            county_symbol
    END AS county_symbol,            --[county_key] -- Need to be converted to SSL Repo Area Key
    CASE
        WHEN mlra_symbol IS NULL THEN
            mlra_symbol2
        ELSE
            mlra_symbol
    END AS mlra_symbol,              --[mlra_key] -- Need to be converted to SSL Repo Area Key
    ssa_symbol,                      --[ssa_key] -- Need to be converted to SSL Repo Area Key
    park_symbol,                     --[npark_key] -- Need to be converted to SSL Repo Area Key
    forest_symbol AS nforest_symbol, --[nforest_key] -- Need to be converted to SSL Repo Area Key
    CASE
        WHEN [siteobjupdate] > [pedobjupdate] THEN
            CONCAT('NASIS updated ', [siteobjupdate])
        ELSE
            CONCAT('NASIS updated ', [pedobjupdate])
    END AS [note],
    [samp_taxfamhahatmatcl],
    [corr_taxfamhahatmatcl],
                                     -- [SSL_taxfamhahatmatcl], --SSL_Repo DB
    [pedobjupdate],
    [siteobjupdate]
FROM #ncss_one2 AS a
    LEFT OUTER JOIN #correlated AS b
        ON b.corr_peiid_ref = a.peiid
    LEFT OUTER JOIN #sampled AS c
        ON c.samp_peiid_ref = a.peiid
    LEFT OUTER JOIN #overlap3 AS d
        ON d.siteiid = a.siteiid;

DROP TABLE IF EXISTS #ncss_one2;
DROP TABLE IF EXISTS #correlated;
DROP TABLE IF EXISTS #sampled;
DROP TABLE IF EXISTS #overlap3