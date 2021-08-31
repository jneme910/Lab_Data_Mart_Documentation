USE sdmONLINE;




SELECT --TABLE_CATALOG, TABLE_SCHEMA,

TABLE_NAME, COLUMN_NAME, * --, COLUMN_DEFAULT
FROM sdmONLINE.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE 'lab%' AND COLUMN_NAME like '%analyte_size_frac%' ;;

/*
D_Feldspar_X_Ray  --good
eight_percent_gt_250_mm_ws -- good
analyte_size_frac_baseASanalyzed_size_frac

*/