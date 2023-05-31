CREATE USER 'cluster-admin'@'%' IDENTIFIED BY 'cl-admin';

GRANT ALL privileges ON *.* TO 'cluster-admin'@'%' with grant option;

reset master;