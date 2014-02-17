use samples;

create table if not exists mismatched_data_types_table (
  int_col int,
  string_col string,
  float_col float
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/mismatched_data_types_data.txt' overwrite into table mismatched_data_types_table;

-- select mismatched data;
select int_col from mismatched_data_types_table;
select float_col from mismatched_data_types_table;

-- see what happens when we select *
select * from mismatched_data_types_table;

drop table if exists mismatched_data_types_table;

create table if not exists missing_data_table (
  string_col1 string,
  string_col2 string
)
row format delimited
fields terminated by ',';

load data local inpath '${hivevar:datadir}/missing_data.txt' overwrite into table missing_data_table;

select * from missing_data_table;

drop table if exists missing_data_table;
