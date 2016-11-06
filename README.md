# My Centos7 Vagrant Box #



### Software Prerequisites

* Vagrant 1.8.4
* VirtualBox 5.0.26

### Packages Included ###

* vim
* tmux
* policycoreutils-python
* git
* ntp
* wget
* make
* memcached
* mysql-community-server
* httpd
* php (php-mysql, php-gd, php-intl php-mbstring, php-xmlrpc, php-pecl-apcu, php-pecl-memcached, php-pecl-xdebug php-soap php-bcmath)
* php-fpm
* nginx 
* rubygems 
* ruby-devel 
* rubygem-json_pure 
* nodejs 
* npm
* gulp
* composer

### Quick Start ###

First we need to add Centos/7 iso to Vagrant

```
#!sh

vagrant box add centos/7
```

We can see the list of existing Vagrant boxes by typing:


```
#!sh

vagrant box list

centos/7             (virtualbox, 1609.01)
puphpet/centos65-x64 (virtualbox, 20151130)
```

For additional info check [official Centos documentation](https://seven.centos.org/2016/10/updated-centos-vagrant-images-available-v1609-01/).

After adding Centos iso to Vagrant we can bootstrap our new box:

```
#!bash

vagrant up
```
Configuration shouldn't take longer than 10 minutes :)

### Additional Configuration ###

By default, nginx is configured to listen on port 80 while apache is listening on port 8080. This can be tweaked on provisioning level as well as configuring additional vhosts for both nginx and apache.