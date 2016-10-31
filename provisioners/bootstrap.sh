#!/usr/bin/env bash
#rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum update
yum install -y httpd mariadb-server mariadb nginx
#php php-fpm nginx
# yum install -y tmux git gitflow tig htop gcc gcc-c++ make ntp wget rsync
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Configure MySQL
#cp /etc/my.cnf /etc/my.cnf.rpmnew
#mv /etc/my.cnf.rpmsave /etc/my.cnf
#mysqld --initialize-insecure --user=mysql

# Configure PHP
#mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.orig

# Configure nginx
#semanage permissive -a httpd_t

# Enable and start services
systemctl daemon-reload
systemctl enable httpd
#systemctl enable memcached.service
systemctl enable mariadb
#systemctl enable php-fpm.service
systemctl enable nginx

systemctl start httpd
#systemctl start memcached.service
systemctl start mariadb
#systemctl start php-fpm.service
systemctl start nginx

# Create the remote MySQL user
# mysql -e "create user 'root'@'10.%'"
# mysql -e "create user 'root'@'150.10.10.%'"
# mysql -e "grant all privileges on *.* to 'root'@'10.%'"
# mysql -e "grant all privileges on *.* to 'root'@'150.10.10.%'"
