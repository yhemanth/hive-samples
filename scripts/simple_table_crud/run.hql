use samples;
create table if not exists simple_table (
  int_column  int comment "This is an integer column",
  string_column string comment "This is a string column",
  float_column float comment "This is a float column"
) 
comment "This is a table demoing simple data types"
row format delimited
fields terminated by ',';
show tables;
dfs -ls /user/hive/warehouse/samples.db/;
describe simple_table;
describe extended simple_table;
describe formatted simple_table;
drop table if exists simple_table;

