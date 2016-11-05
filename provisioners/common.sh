#!/usr/bin/env sh
# Common VM provisioning tasks.
yum -y install yum-utils epel-release
yum -y update

# Install general tools, daemons, and build tools.
#yum -y install vim-enhanced tmux git gitflow tig htop policycoreutils-python the_silver_searcher gcc gcc-c++ make ntp wget rsync
yum -y install rsync vim-enhanced policycoreutils-python

# Double check the system time.
timedatectl set-timezone UTC
ntpdate pool.ntp.org

# Add common hosts entries.
#echo "172.17.8.10 portal.stackpath.local" >> /etc/hosts

# Copy machine-specific files into place.
if [ -d "/vagrant/files/$HOSTNAME" ]; then
  rsync --recursive --verbose --backup /vagrant/files/$HOSTNAME/ /
fi
