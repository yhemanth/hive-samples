use samples;

create table if not exists arithmetic_operators_table (
  int_col1 int,
  int_col2 int,
  float_col1 float,
  float_col2 float
) 
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/arithmetic_operators_table.txt' overwrite into table arithmetic_operators_table;

select 
  int_col1, 
  int_col2, 
  int_col1 + int_col2, 
  int_col1 - int_col2, 
  int_col1 * int_col2, 
  float_col1,
  float_col2,
  float_col1 / float_col2, 
  float_col1 % float_col2,
  float_col1 / 20.0 
from arithmetic_operators_table;

drop table if exists arithmetic_operators_table;
