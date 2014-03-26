DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
GRANT ALL privileges ON *.* TO root@'%' identified by 'vagrant';
