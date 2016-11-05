#!/usr/bin/env bash
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
yum-config-manager --enable remi-php56
yum -y update
yum install -y httpd mysql-community-server nginx php php-fpm nginx
# yum install -y tmux git gitflow tig htop gcc gcc-c++ make ntp wget rsync
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

mkdir -p /opt/code/logs

touch /opt/code/logs/cdn.tools.access.log
touch /opt/code/logs/cdn.tools.error.log

# Configure MySQL
cp /etc/my.cnf /etc/my.cnf.rpmnew
mv /etc/my.cnf.rpmsave /etc/my.cnf
mysqld --initialize-insecure --user=mysql

# Configure PHP
mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.orig

# Configure nginx
semanage permissive -a httpd_t

# Enable and start services
systemctl daemon-reload
systemctl enable httpd.service
#systemctl enable memcached.service
systemctl enable mysqld.service
systemctl enable php-fpm.service
systemctl enable nginx.service

systemctl start httpd.service
#systemctl start memcached.service
systemctl start mysqld.service
systemctl start php-fpm.service
systemctl start nginx.service

# Create the remote MySQL user
# mysql -e "create user 'root'@'10.%'"
# mysql -e "create user 'root'@'150.10.10.%'"
# mysql -e "grant all privileges on *.* to 'root'@'10.%'"
# mysql -e "grant all privileges on *.* to 'root'@'150.10.10.%'"
