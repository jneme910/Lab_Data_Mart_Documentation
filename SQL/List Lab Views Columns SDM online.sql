USE sdmONLINE;




SELECT --TABLE_CATALOG, TABLE_SCHEMA,

TABLE_NAME, COLUMN_NAME --, COLUMN_DEFAULT
FROM sdmONLINE.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE 'lab%';;