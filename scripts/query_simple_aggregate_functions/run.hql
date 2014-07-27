use samples;

create table if not exists query_simple_aggregates_table (
  int_col int,
  float_col float
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/query_simple_aggregates_data.txt' overwrite into table query_simple_aggregates_table;

select count(*) as count from query_simple_aggregates_table;

select 
  avg(int_col) as int_col_average, 
  avg(distinct int_col) as uniq_int_col_average, 
  count(float_col) as non_null_float_col_count, 
  avg(float_col) non_float_col_avg,
  variance(int_col) as int_col_variance,
  var_samp(int_col) as int_col_sample_variance 
from query_simple_aggregates_table;

drop table if exists query_simple_aggregates_table;
