# My Centos7 Vagrant Box #

## This build is aimed for development primarily.

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

First we need to add Centos/7 iso to vagrant

```
#!sh

vagrant box add centos/7
```

We can see the list of existing vagrant boxes by typing:


```
#!sh

vagrant box list

centos/7             (virtualbox, 1609.01)
puphpet/centos65-x64 (virtualbox, 20151130)
```

For additional info check [official Centos documentation](https://seven.centos.org/2016/10/updated-centos-vagrant-images-available-v1609-01/).

After adding Centos iso to Vagrant we can initialize configuration by specifying desired box name:

```
#!bash

vagrant init centos/7
```