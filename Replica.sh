### Apache installation
apt install apache2 -y;
sed -i 's/Apache2 Default Page/&2/' /var/www/html/index.html;

### mysql installation
apt install mysql-server-8.0 -y;

###config
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/Replica-mysqld.cnf;
cp Replica-mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf;

service mysql restart;

### REPLICATION
mysql -u root -e "STOP REPLICA;"
mysql -u root -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.1.102', SOURCE_USER='repl', SOURCE_PASSWORD='oTUSlave#2020', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;"
mysql -u root -e "START REPLICA;"


###php installation
sudo apt install php libapache2-mod-php php-mysql php-curl php-gd php-json php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y;

### WP installation
wget https://ru.wordpress.org/wordpress-6.7.1-ru_RU.tar.gz;
tar -xzvf wordpress-6.7.1-ru_RU.tar.gz;

### copy to Apache
cp -r wordpress/* /var/www/html/;

### create db
mysql -u root -e "CREATE DATABASE WP;";
mysql -u root -e "CREATE USER 'wp'@'%' IDENTIFIED BY 'password';";
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'wp'@'%';";

### wp-config
wget https://raw.githubusercontent.com/shchepalin/Ubuntu/refs/heads/main/wp-config.php
cp wp-config.php /var/www/html/;
sudo rm /var/www/html/index.html;
