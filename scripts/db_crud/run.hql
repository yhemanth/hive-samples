create database if not exists samples_test comment 'This is a test database';
show databases;
describe database extended samples_test;
dfs -ls /user/hive/warehouse;
dfs -ls /user/hive/warehouse/samples_test.db;
drop database samples_test;
dfs -ls /user/hive/warehouse;
