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
  part_int_col int,
  part_string_col string
)
row format delimited
fields terminated by '|';

-- load data into source table

load data local inpath '${hivevar:datadir}/insert_into_table_data.txt' overwrite into table src_table;

-- load data into destination from source table using multi-insert

from src_table src
insert overwrite table dest_table
  partition (part_int_col=1, part_string_col="a")
  select src.int_col, src.string_col where src.p_int_col=1 and src.p_string_col="a"
insert overwrite table dest_table
  partition (part_int_col=1, part_string_col="b")
  select src.int_col, src.string_col where src.p_int_col=1 and src.p_string_col="b"
insert overwrite table dest_table
  partition (part_int_col=2, part_string_col="a")
  select src.int_col, src.string_col where src.p_int_col=2 and src.p_string_col="a"
insert overwrite table dest_table
  partition (part_int_col=2, part_string_col="c")
  select src.int_col, src.string_col where src.p_int_col=2 and src.p_string_col="c";

-- show partitions are available

show partitions dest_table;

-- query data

select * from dest_table where part_int_col=2;

-- cleanup
drop table dest_table;
drop table src_table;
