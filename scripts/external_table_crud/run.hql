use samples;

dfs -put ${hivevar:datadir}/external_table_data.txt ${hivevar:unique_id};
dfs -ls ${hivevar:unique_id};

create external table external_table (
  string_col1 string,
  string_col2 string
)
row format delimited
fields terminated by ','
location '/user/${system:user.name}/${hivevar:unique_id}';

select * from external_table;

drop table if exists external_table;

dfs -ls ${hivevar:unique_id};
