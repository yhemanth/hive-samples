use samples;

-- Create table
create table if not exists simple_table (
  int_column  int comment "This is an integer column",
  string_column string comment "This is a string column",
  float_column float comment "This is a float column"
) 
comment "This is a table demoing simple data types"
row format delimited
fields terminated by ',';

-- Show table is created
show tables;
dfs -lsr /user/hive/warehouse/samples.db/;

-- Describe the table
describe simple_table;
describe extended simple_table;
describe formatted simple_table;

-- Load data from local fs
!echo "Listing files in data dir before load"; 
!ls ${hivevar:datadir};
load data local inpath '${hivevar:datadir}/simple_table_data.txt' overwrite into table simple_table;
dfs -lsr /user/hive/warehouse/samples.db/simple_table;
!echo "Listing files in data dir after load"; 
!ls ${hivevar:datadir};

-- Load data from HDFS
dfs -copyFromLocal ${hivevar:datadir}/simple_table_data.txt ${hivevar:unique_id}/simple_table_data.txt;
load data inpath '${hivevar:unique_id}' into table simple_table;
dfs -ls ${hivevar:unique_id};
dfs -lsr /user/hive/warehouse/samples.db/simple_table;

-- Show data is loaded by querying
select * from simple_table;

--Cleanup the table
drop table if exists simple_table;

-- Show underlying data is deleted
dfs -lsr /user/hive/warehouse/samples.db;

