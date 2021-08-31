
USE nasis;

SELECT (tablognm) AS Table_Logical_Name, (tabphynm) AS Table_Physical_Name, 
	(attlognm) AS Column_Logical_Name, (attphynm) AS Column_Physical_Name, *
FROM system 
INNER JOIN systemtable 
ON system.sysiid = systemtable.sysiidref AND (system.sysver = 'Lab SDA Data Mart 1.0'         )
AND systemtable.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'           ))
INNER JOIN tablecolumn
ON tablecolumn.systabiidref = systemtable.systabiid AND tablecolumn.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'        ))
INNER JOIN attribute 
ON attribute.attiid = tablecolumn.attiidref AND attribute.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = 'Lab SDA Data Mart 1.0'   ))
WHERE tabserveronly <> 1 AND systemtable.tabtemp <> 1;