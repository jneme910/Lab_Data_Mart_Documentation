USE nasis
SELECT 

coldefseq, 
tablognm,
tabphynm, 
collab, 
(logdatatype.cholabtxt) AS Logical_Data_Type, 
(phydatatype.chodetxt) AS Physical_Data_Type, 
CASE colnotnulbool WHEN 0 THEN 'no' ELSE 'yes' END Not_Null, 
attfldsiz, 
attprec, 
attmin, 
attmax, 
(uomsym) AS UOM, 
domnm,
tablab, 
ISNULL(tabhelptext, 'No help text available.') AS TabHelp, 
attlognm, 
attphynm, 
CASE when visibleingrideditor = 1 and colvisible = 1 and tabvisible = 1 THEN 'yes' ELSE 'no' END as visible

FROM system
INNER JOIN tablecollection on tablecollection.sysiidref= system.sysiid AND (system.sysver = 'Lab SDA Data Mart 1.0')
INNER JOIN systemtable ON tablecollection.tablecollectiid = systemtable.tablecollectiidref and system.sysiid = systemtable.sysiidref AND (system.sysver = 'Lab SDA Data Mart 1.0')
	AND systemtable.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0')) 
	
INNER JOIN tablecolumn ON  tablecolumn.systabiidref = systemtable.systabiid AND tablecolumn.sysiidref  IN 
	((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'))
INNER JOIN attribute ON attribute.attiid = tablecolumn.attiidref AND attribute.sysiidref IN 
	((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'))
LEFT JOIN domaindetail phydatatype ON phydatatype.choid = tablecolumn.colphydatatype 
	AND phydatatype.domiidref = 7862
LEFT JOIN domaindetail logdatatype ON logdatatype.choid = attribute.attlogdattyp 
	AND logdatatype.domiidref = 12539
LEFT JOIN uom ON uom.uomiid = attribute.uomiidref AND attribute.uomiidref IS NOT NULL
LEFT JOIN domainmaster ON domainmaster.domiid = attribute.domiidref AND attribute.domiidref IS NOT NULL
WHERE systemtable.tabserveronly <> 1 AND systemtable.tabtemp <> 1
