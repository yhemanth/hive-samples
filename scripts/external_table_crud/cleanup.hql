drop database if exists samples;
dfs -rmr ${hivevar:unique_id};
