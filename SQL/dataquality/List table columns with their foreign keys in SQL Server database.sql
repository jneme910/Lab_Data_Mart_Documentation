select schema_name(tab.schema_id) + '.' + tab.name as [table],
    col.column_id,
    col.name as column_name,
    case when fk.object_id is not null then '>-' else null end as rel,
    schema_name(pk_tab.schema_id) + '.' + pk_tab.name as primary_table,
    pk_col.name as pk_column_name,
    fk_cols.constraint_column_id as no,
    fk.name as fk_constraint_name
from sys.tables tab
    inner join sys.columns col 
        on col.object_id = tab.object_id
    left outer join sys.foreign_key_columns fk_cols
        on fk_cols.parent_object_id = tab.object_id
        and fk_cols.parent_column_id = col.column_id
    left outer join sys.foreign_keys fk
        on fk.object_id = fk_cols.constraint_object_id
    left outer join sys.tables pk_tab
        on pk_tab.object_id = fk_cols.referenced_object_id
    left outer join sys.columns pk_col
        on pk_col.column_id = fk_cols.referenced_column_id
        and pk_col.object_id = fk_cols.referenced_object_id
WHERE tab.name IN ('analyte', 'pedon', 'lab_analysis_procedure', 'lab_Calculations_Including_Estimates_And_Default_Values', 'lab_Chemical_Properties', 'lab_Major_And_Trace_Elements_And_Oxides', 'lab_method_code',  'lab_Mineralogy_Glass_Count', 'lab_Physical_Properties',  'lab_webmap', 'lab_XRay_And_Thermal', 'site', 'rosetta', 'combine_nasis_ncss', 'preparation', 'layer' )
order by schema_name(tab.schema_id) + '.' + tab.name,
    col.column_id