create database if not exists samples comment 'This is a sample database';

use samples;

create table if not exists export_table (
  int_col int,
  string_col string
) partitioned by (
  p_string_col string
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/export_table_data1.txt' into table export_table partition (p_string_col='p_a');
load data local inpath '${hivevar:datadir}/export_table_data2.txt' into table export_table partition (p_string_col='p_b');
