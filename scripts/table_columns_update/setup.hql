create database if not exists samples comment 'This is a sample database';

use samples;

-- create a base table to work with
create table base_table (
  int_col int,
  string_col string,
  fl_col float
)
row format delimited
fields terminated by ',';

-- load data into base table
load data local inpath '${hivevar:datadir}/table_columns_update_base_data_incorrect_order.txt' overwrite into table base_table; 

