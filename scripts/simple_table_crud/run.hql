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
!echo "Listing files in data dir before load"; 
!ls ${hivevar:datadir};
load data local inpath '${hivevar:datadir}/simple_table_data.txt' overwrite into table simple_table;
!echo "Listing files in data dir after load"; 
!ls ${hivevar:datadir};
select * from simple_table;
drop table if exists simple_table;

