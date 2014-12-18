# Installing MariaDB Server
pacman -S mariadb mariadb-clients --noconfirm

# Starting MariaDB Server 
/usr/share/mysql/mysql.server start 

mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -e "UPDATE mysql.user SET Password=PASSWORD('secure') WHERE User='root';"
mysql -e "GRANT ALL ON *.* TO 'root'@'192.168.0.12' IDENTIFIED BY 'secure';"
mysql -e "GRANT ALL ON *.* TO 'root'@'webserver' IDENTIFIED BY 'secure';"
mysql -e "FLUSH PRIVILEGES;"

# Creating Django Sample DB
mysql -u root -psecure -e "CREATE DATABASE django_sample;"
mysql -u root -psecure -e "GRANT ALL ON django_sample.* TO 'django_user'@'%' IDENTIFIED BY 'supersecure';"

# Networking
echo "192.168.0.12     webserver" >> /etc/hosts

# Temporal Solution for Networking
cat >/etc/netctl/vagrant_network <<EOF
Connection=ethernet
Description='A basic static ethernet connection'
Interface=eth1
IP=static
Address=('192.168.0.11/24')
EOF

netctl enable vagrant_network
netctl start vagrant_network
