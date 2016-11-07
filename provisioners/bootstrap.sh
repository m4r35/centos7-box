#!/usr/bin/env bash
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
yum-config-manager --enable remi-php56
yum -y update
yum install -y memcached mysql-community-server httpd php php-fpm php-mysql php-gd php-intl php-mbstring php-xmlrpc php-pecl-apcu php-pecl-memcached php-pecl-xdebug php-soap php-bcmath nginx rubygems ruby-devel rubygem-json_pure nodejs npm
npm install gulp -g
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

# Create log files
mkdir -p /opt/code/logs

touch /opt/code/logs/cdn.tools.access.log
touch /opt/code/logs/cdn.tools.error.log
touch /opt/code/logs/apartmanimandic.access.log
touch /opt/code/logs/apartmanimandic.error.log
touch /opt/code/logs/plesnagrupafly.access.log
touch /opt/code/logs/plesnagrupafly.error.log

# Update hosts file
echo "127.0.0.1 cdn.tools.test" >> /etc/hosts
echo "127.0.0.1 apartmanimandic.test" >> /etc/hosts
echo "127.0.0.1 plesnagrupafly.test" >> /etc/hosts

# Configure Apache virtual hosts
mkdir -p /etc/httpd/sites-available
mkdir -p /etc/httpd/sites-enabled

echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
ln -s /etc/httpd/sites-available/*.conf /etc/httpd/sites-enabled/

# Configure MySQL
cp /etc/my.cnf /etc/my.cnf.rpmnew
mv /etc/my.cnf.rpmsave /etc/my.cnf
mysqld --initialize-insecure --user=mysql

# Configure PHP
mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.orig

# Configure nginx
semanage permissive -a httpd_t

# Install composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable and start services
systemctl daemon-reload
systemctl enable httpd.service
systemctl enable memcached.service
systemctl enable mysqld.service
systemctl enable php-fpm.service
systemctl enable nginx.service

systemctl start httpd.service
systemctl start memcached.service
systemctl start mysqld.service
systemctl start php-fpm.service
systemctl start nginx.service

# Configure databases
mysqladmin create wordpress

# Create the remote MySQL user
mysql -e "create user 'root'@'10.%'"
mysql -e "create user 'root'@'150.10.10.%'"
mysql -e "grant all privileges on *.* to 'root'@'10.%'"
mysql -e "grant all privileges on *.* to 'root'@'150.10.10.%'"

# Configure databases
mysql -u root wordpress < /vagrant/files/$HOSTNAME/db/apartmanimandic.sql

# Make helper script
mkdir -p /scripts
touch /scripts/services.sh
echo "#!/usr/bin/env sh" >> /scripts/services.sh
echo "systemctl status httpd.service" >> /scripts/services.sh
echo "systemctl status memcached.service" >> /scripts/services.sh
echo "systemctl status mysqld.service" >> /scripts/services.sh
echo "systemctl status php-fpm.service" >> /scripts/services.sh
echo "systemctl status nginx.service" >> /scripts/services.sh
