create user 'pmm'@'%' identified by '123456' with MAX_USER_CONNECTIONS 10;
grant SELECT, PROCESS, REPLICATION CLIENT, RELOAD, BACKUP_ADMIN on *.* to 'pmm'@'%';
