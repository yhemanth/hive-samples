use samples;

create table if not exists query_advanced_stat_functions_table (
  int_col int,
  positive_related_int_col int,
  negative_related_int_col int,
  unrelated_int_col int
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/query_advanced_stat_functions_data.txt' overwrite into table query_advanced_stat_functions_table;

select 
  covar_pop (int_col, positive_related_int_col) as positive_covariance,
  covar_pop (int_col, negative_related_int_col) as negative_covariance,
  covar_pop (int_col, unrelated_int_col) as no_covariance
from query_advanced_stat_functions_table;

-- show variance is same as covariance if there's only one set.
select
  covar_pop (int_col, int_col) as self_covariance,
  variance (int_col) as variance,
  corr (int_col, positive_related_int_col) as corr1,
  corr (int_col, unrelated_int_col) as corr2
from query_advanced_stat_functions_table;

drop table if exists query_advanced_stat_functions_table;

