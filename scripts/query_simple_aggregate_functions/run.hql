use samples;

create table if not exists query_simple_aggregates_table (
  int_col int,
  float_col float
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/query_simple_aggregates_data.txt' overwrite into table query_simple_aggregates_table;

select count(*) from query_simple_aggregates_table;

select avg(int_col), avg(distinct int_col), count(float_col), avg(float_col) from query_simple_aggregates_table;

drop table if exists query_simple_aggregates_table;
