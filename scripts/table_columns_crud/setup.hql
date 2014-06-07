create database if not exists samples comment 'This is a sample database';

use samples;

-- create a base table to work with
create table base_table (
  int_col int,
  string_col string
) partitioned by (
  p_string_col string
)
row format delimited
fields terminated by ',';

-- load data into base table
load data local inpath '${hivevar:datadir}/table_columns_crud_base_data.txt' overwrite into table base_table partition(p_string_col='a');

