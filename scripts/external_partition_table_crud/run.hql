use samples;

-- create an external partition table
create external table if not exists external_partition_table (
  int_col int,
  string_col string
) partitioned by (
  p_string_col string
) 
row format delimited
fields terminated by ',';

-- load data into table through HDFS, as if done by another process
dfs -mkdir -p /user/${system:user.name}/${unique_id}/p_string_col=a;
dfs -put ${datadir}/insert_into_external_partition_table_data_partition_1.txt /user/${system:user.name}/${unique_id}/p_string_col=a/;

-- still no partitions
show partitions external_partition_table;

-- no data
select * from external_partition_table;

-- add a partition to the table
alter table external_partition_table
add partition (p_string_col='a')
location '/user/${system:user.name}/${unique_id}/p_string_col=a';

-- show partition is present
show partitions external_partition_table;

-- show data is present
select * from external_partition_table;

-- load data into another partition
dfs -mkdir -p /user/${system:user.name}/${unique_id}/p_string_col=b;
dfs -put ${datadir}/insert_into_external_partition_table_data_partition_2.txt /user/${system:user.name}/${unique_id}/p_string_col=b/;

-- show that new data is still not queryable, as partition is not added
select * from external_partition_table;

-- add the new partition
alter table external_partition_table
add partition (p_string_col='b')
location '/user/${system:user.name}/${unique_id}/p_string_col=b';

-- show partition is present
show partitions external_partition_table;

-- now data is present
select * from external_partition_table where p_string_col='b';

-- add a fictitious partition
alter table external_partition_table
add partition (p_string_col='c')
location '/user/${system:user.name}/${unique_id}/p_string_col=c';

-- show this creates a directory
dfs -test -d /user/${system:user.name}/${unique_id}/p_string_col=c;

-- query returns no results
select * from external_partition_table where p_string_col='c';

-- add data afterwards
dfs -put ${datadir}/insert_into_external_partition_table_data_partition_3.txt /user/${system:user.name}/${unique_id}/p_string_col=c/;

-- now query will give results
select * from external_partition_table where p_string_col='c';

-- delete partition
alter table external_partition_table drop if exists partition (p_string_col='a');
show partitions external_partition_table;

-- shouldn't affect data
dfs -ls /user/${system:user.name}/${unique_id}/p_string_col=a;

-- update a partition by copying data into new location, and updating location
dfs -mkdir -p /user/${system:user.name}/${unique_id}/p_string_col=new_b/;
dfs -mv /user/${system:user.name}/${unique_id}/p_string_col=b/* /user/${system:user.name}/${unique_id}/p_string_col=new_b/;

-- describe should reflect old location, but won't return any results
describe formatted external_partition_table partition (p_string_col='b');
select * from external_partition_table where p_string_col='b';

-- set the new location
alter table external_partition_table partition (p_string_col='b') set location 'hdfs:///user/${system:user.name}/${unique_id}/p_string_col=new_b';
describe formatted external_partition_table partition (p_string_col='b');
select * from external_partition_table where p_string_col='b';

drop table if exists external_partition_table;
