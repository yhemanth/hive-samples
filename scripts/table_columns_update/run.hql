use samples;

-- show data is incorrect
select * from base_table;

-- update float column to new name
alter table base_table 
change column fl_col float_col float;

-- update string column to right position
alter table base_table
change column string_col string_col string
after float_col;

-- show data is correct now
select * from base_table;
