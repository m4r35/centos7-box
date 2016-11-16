#!/usr/bin/env sh
# Common VM provisioning tasks.
yum -y install yum-utils epel-release
yum -y update
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo

# Install general tools, daemons, and build tools.
#yum -y install vim-enhanced tmux git gitflow tig htop policycoreutils-python the_silver_searcher gcc gcc-c++ make ntp wget rsync
yum -y install rsync vim-enhanced tmux policycoreutils-python git ntp wget make

# Double check the system time.
timedatectl set-timezone UTC
ntpdate pool.ntp.org

# Copy machine-specific files into place.
if [ -d "/vagrant/box-config/$HOSTNAME" ]; then
  rsync --recursive --verbose --backup /vagrant/box-config/$HOSTNAME/ /
fi