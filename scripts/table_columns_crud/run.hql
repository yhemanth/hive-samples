use samples;

select * from base_table;

-- add a column
alter table base_table add columns (
  float_column float
);

-- load data with values for the new column
load data local inpath '${hivevar:datadir}/table_columns_crud_base_data_new_columns.txt' into table base_table partition (p_string_col='b');

select * from base_table;

-- remove back the column
alter table base_table replace columns (
  int_column int,
  string_column string
);

select * from base_table;
