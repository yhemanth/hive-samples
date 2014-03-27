use samples;

create table if not exists partitioned_table (
  int_col int,
  string_col string
)
partitioned by (
int_partition_col int comment "This is a integer valued partitioned column", 
string_partition_col string comment "This is a string valued partitioned column"
)
row format delimited
fields terminated by ',';

-- Describe will show partitioned columns now
describe formatted partitioned_table;

-- Initially empty
show partitions partitioned_table;

load data local inpath '${hivevar:datadir}/partitioned_table_data.txt' overwrite into table partitioned_table
  partition (int_partition_col = 1, string_partition_col = "a");
load data local inpath '${hivevar:datadir}/partitioned_table_data.txt' into table partitioned_table
  partition (int_partition_col = 1, string_partition_col = "b");
load data local inpath '${hivevar:datadir}/partitioned_table_data.txt' into table partitioned_table
  partition (int_partition_col = 2, string_partition_col = "b");

-- describe partitions
show partitions partitioned_table;

-- show DFS structure
dfs -lsr /user/hive/warehouse/samples.db/partitioned_table;

-- select from all partitions, show partition values are listed as columns
select int_col, int_partition_col, string_partition_col from partitioned_table;

-- select using one partition column
select int_col, int_partition_col, string_partition_col from partitioned_table where int_partition_col=1;

-- select using two partition columns
select int_col, int_partition_col, string_partition_col from partitioned_table where int_partition_col=1 and string_partition_col="b";

-- select using 2nd partition column
select int_col, int_partition_col, string_partition_col from partitioned_table where string_partition_col="b";

drop table if exists partitioned_table;
