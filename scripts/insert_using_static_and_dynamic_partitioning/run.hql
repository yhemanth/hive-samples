use samples;

-- create a table to load data from

create table if not exists src_table (
  int_col int,
  string_col string,
  p_int_col int,
  p_string_col string
)
row format delimited
fields terminated by ',';

-- create table to load data into

create table if not exists dest_table (
  int_col int,
  string_col string
)
partitioned by (
  part_string_col string,
  part_int_col int
)
row format delimited
fields terminated by '|';

-- load data into source table

load data local inpath '${hivevar:datadir}/insert_into_table_data.txt' overwrite into table src_table;

-- load data into destination from source table using dynamic partitioning scheme

insert overwrite table dest_table
partition (part_string_col='a', part_int_col)
select src.int_col, src.string_col, src.p_int_col from src_table src where src.p_string_col='a';

-- show partitions are available

show partitions dest_table;

-- query data

select * from dest_table where part_string_col='a';

-- cleanup
drop table dest_table;
drop table src_table;
