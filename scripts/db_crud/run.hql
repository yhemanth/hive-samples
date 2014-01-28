create database if not exists samples comment 'This is a sample database';
show databases;
describe database extended samples;
dfs -ls /user/hive/warehouse;
dfs -ls /user/hive/warehouse/samples.db;
drop database samples;
dfs -ls /user/hive/warehouse;
