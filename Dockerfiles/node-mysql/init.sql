create user 'hive'@'%' identified by 'Hive@mysql00';
grant all on *.* to 'hive'@'%';
flush privileges;
create database hive;
