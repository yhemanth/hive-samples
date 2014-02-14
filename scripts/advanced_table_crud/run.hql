use samples;

create table if not exists advanced_table (
  array_column array<int> comment "Stores an array of integers",
  map_column map<string, string> comment "Stores a map of string to string",
  struct_column struct<struct_field1:float, struct_field2:float> comment "Stores a structure with 2 fields"
)
comment "Demonstrates the definition of composite data types"
row format delimited
fields terminated by ','
collection items terminated by '\;'
map keys terminated by ':'
stored as textfile;

desc formatted advanced_table;

load data local inpath '${hivevar:datadir}/advanced_table_data.txt' overwrite into table advanced_table;

-- select array items
select array_column from advanced_table;
select array_column[0],array_column[1] from advanced_table;

-- select map items
select map_column from advanced_table;
select map_column['k1'] from advanced_table;
select map_column['k2'],map_column['k3'] from advanced_table;

-- select struct items
select struct_column from advanced_table;
select struct_column.struct_field2 from advanced_table;

drop table if exists advanced_table;
