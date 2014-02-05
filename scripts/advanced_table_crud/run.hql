use samples;
create table advanced_table (
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
drop table advanced_table;
