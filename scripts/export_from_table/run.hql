use samples;

dfs -mkdir file:///tmp/${hivevar:unique_id};

from export_table et
  insert overwrite local directory '/tmp/${hivevar:unique_id}/p_a' 
    select * where et.p_string_col='p_a'
  insert overwrite local directory '/tmp/${hivevar:unique_id}/p_b'
    select * where et.p_string_col='p_b';

dfs -lsr file:///tmp/${hivevar:unique_id}/;

dfs -cat file:///tmp/${hivevar:unique_id}/*/*;

dfs -rmr file:///tmp/${hivevar:unique_id};


