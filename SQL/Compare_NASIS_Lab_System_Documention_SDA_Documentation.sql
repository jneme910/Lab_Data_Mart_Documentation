--Need to add analyte table and compare

SET STATISTICS IO ON
DROP TABLE IF EXISTS #nasis_temp;
DROP TABLE IF EXISTS #sdm_temp;
USE nasis;

SELECT (tablognm) AS Table_Logical_Name,
(tabphynm) AS Table_Physical_Name, 
	(attlognm) AS Column_Logical_Name, 
	(attphynm) AS Column_Physical_Name, 


sysnm	,
sysver	,
sysdesc	,
syscreatedate	,
notes	,
sysdbiidref	,
grpiidref	,
objwlupdated	,
objuseriidref	,
sysiid	,
tablecollectiidref	,
tablognm	,
tabphynm	,
tablab	,
tabhelptext	,
soilentitytype	,
importexportfilename	,
tabvisible	,
tabselectable	,
tabeditable	,
tabnoinsertordelete	,
tabroottable	,
tabtemp	,
tabaliased	,
tabstatic	,
tabclientonly	,
tabserveronly	,
tabcreateasview	,
tabssaliasreq	,
tabsscounterpartreq	,
tabpedpctonasis	,
ipdiagmsgsqlstmt	,
daglevel	,
tableid	,
tabdesc	,

systabiid	,
systabiidref	,

coldefseq	,
attiidref	,
collab	,
colphydatatype	,
  (
                    SELECT TOP 1
                        choiceLabel
                    FROM
                        tablecolumn AS a,
                         MetadataDomainMaster dm,
                        MetadataDomainDetail dd
                    WHERE
                        tablecolumn.tabcoliid= a.tabcoliid
                        and colphydatatype = [ChoiceValue]
                        and DomainName = 'physical_data_type'
                        and dm.DomainID = dd.DomainID
                    order by
                        choicesequence DESC
                ) AS colphydatatype2, 

coldisplaysz	,
coldisplaysz_s	,
defaulttype	,
collitdefval	,
colsetonrowchange	,
colsetonobjchange	,
aggregation	,
colnotnulbool	,
colcalc	,
colvisible	,
colprotected	,
colunique	,
colbusinessoriented	,
colsortseq	,
colsorta	,
colsorttyp	,
alignment	,
inreplicationselectlist	,
colincludepedonpc	,
fgdc	,
colsrvdeftypeidentity	,
colspatialdata	,
colsrid	,
filecontentcolumniidref	,
colfieldsizoverride	,
colhelptext	,
columnid	,
tabcoliid	,

attlognm	,
attphynm	,
attlabel	,
--attlogdattyp	,
                (
                    SELECT TOP 1
                        choiceLabel
                    FROM
                        attribute AS a,
                         MetadataDomainMaster dm,
                        MetadataDomainDetail dd
                    WHERE
                        attribute.attiid = a.attiid
                        and attlogdattyp = [ChoiceValue]
                        and DomainName = 'logical_data_type_nasis'
                        and dm.DomainID = dd.DomainID
                    order by
                        choicesequence DESC
                )                                                                  as attlogdattyp2,
attfldsiz	,
attprec	,
uomiidref	,
domiidref	,
attshortdtiq	,
attlongdtiq	,
attmin	,
attmax	,
attcasesensitive	,
attoffdef	,
attextdef	,
attributeid	,
attiid	

	INTO #nasis_temp
FROM system 
INNER JOIN systemtable 
ON system.sysiid = systemtable.sysiidref AND (system.sysver = 'Lab SDA Data Mart 1.0'         )
AND systemtable.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'           ))
INNER JOIN tablecolumn
ON tablecolumn.systabiidref = systemtable.systabiid AND tablecolumn.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'        ))
INNER JOIN attribute 
ON attribute.attiid = tablecolumn.attiidref AND attribute.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'   ))
WHERE tabserveronly <> 1 AND systemtable.tabtemp <> 1;

SELECT 
 *
 INTO	#sdm_temp
FROM sdmONLINE.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME LIKE 'lab%'    ORDER BY COLUMN_NAME ;

SELECT *
FROM #sdm_temp AS s
INNER JOIN #nasis_temp AS n ON  n.attlabel COLLATE SQL_Latin1_General_CP1_CI_AS = s.COLUMN_NAME COLLATE SQL_Latin1_General_CP1_CI_AS

--ON  n.attlabel COLLATE SQL_Latin1_General_CP1_CI_AS = s.COLUMN_NAME COLLATE SQL_Latin1_General_CP1_CI_AS
--Cannot resolve the collation conflict between "SQL_Latin1_General_CP1_CI_AS" and "SQL_Latin1_General_Pref_CP1_CI_AS" in the equal to operation.

SET STATISTICS IO OFF