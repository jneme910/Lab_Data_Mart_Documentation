/****** Script for SelectTopNRows command from SSMS  ******/
SELECT   sysver, tablab , 
attlognm, attphynm, attlabel, attoffdef
 ,a.[sysiidref]
      ,a.[attlognm]
      ,a.[attphynm]
      ,a.[attlabel]
      ,a.[attlogdattyp]
      ,a.[attfldsiz]
      ,a.[attprec]
      ,a.[uomiidref]
      ,a.[domiidref]
      ,a.[attshortdtiq]
      ,a.[attlongdtiq]
      ,a.[attmin]
      ,a.[attmax]
      ,a.[attcasesensitive]
      ,a.[attoffdef]
      ,a.[attextdef]
      ,a.[attributeid]
      ,a.[orgper]
      ,a.[conper]
      ,a.[pendact]
      ,a.[pendstat]
      ,a.[recwlupdated]
      ,a.[recuseriidref]
      ,a.[attiid]

  FROM  system AS s  WITH (NOLOCK)
INNER JOIN attribute AS a WITH (NOLOCK) ON a.sysiidref=s.sysiid AND
CASE 
WHEN attlabel LIKE '%aluminum%' THEN 1 
WHEN attlognm LIKE '%aluminum%' THEN 1 
WHEN attphynm LIKE '%aluminum%' THEN 1 

ELSE 2 END = 1 AND attoffdef IS NOT NULL
LEFT OUTER JOIN tablecolumn  WITH (NOLOCK) ON a.attiid=tablecolumn.attiidref
LEFT OUTER JOIN systemtable  WITH (NOLOCK)ON tablecolumn.systabiidref=systemtable.systabiid
ORDER BY a.[attlognm] ASC