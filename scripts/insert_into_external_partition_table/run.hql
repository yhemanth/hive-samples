use samples;

-- create an external partition table
create table if not exists external_partition_table (
  int_col int,
  string_col string
) partitioned by (
  p_string_col string
) 
row format delimited
fields terminated by ',';

-- load data into table through HDFS, as if done by another process
dfs -mkdir /user/${system:user.name}/p_string_col=a;
dfs -put ${datadir}/insert_into_external_partition_table_data_partition_1.txt /user/${system:user.name}/p_string_col=a/;

-- still no partitions
show partitions external_partition_table;

-- no data
select * from external_partition_table;

-- add a partition to the table
alter table external_partition_table
add partition (p_string_col='a')
location '/user/${system:user.name}/p_string_col=a';

-- show partition is present
show partitions external_partition_table;

-- show data is present
select * from external_partition_table;

-- load data into another partition
dfs -mkdir /user/${system:user.name}/p_string_col=b;
dfs -put ${datadir}/insert_into_external_partition_table_data_partition_2.txt /user/${system:user.name}/p_string_col=b/;

-- show that new data is still not queryable, as partition is not added
select * from external_partition_table;

-- add the new partition
alter table external_partition_table
add partition (p_string_col='b')
location '/user/${system:user.name}/p_string_col=b';

-- now data is present
select * from external_partition_table;

-- add a fictitious partition
alter table external_partition_table
add partition (p_string_col='c')
location '/user/${system:user.name}/p_string_col=c';

-- show this creates a directory
dfs -test -d /user/${system:user.name}/p_string_col=c;

-- query returns no results
select * from external_partition_table where p_string_col='c';

-- add data afterwards
dfs -put ${datadir}/insert_into_external_partition_table_data_partition_3.txt /user/${system:user.name}/p_string_col=c/;

-- now query will give results
select * from external_partition_table where p_string_col='c';

drop table if exists external_partition_table;
dfs -rmr /user/${system:user.name}/p_string_col=a;
dfs -rmr /user/${system:user.name}/p_string_col=b;
dfs -rmr /user/${system:user.name}/p_string_col=c;
