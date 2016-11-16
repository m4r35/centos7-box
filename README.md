# My Centos7 Vagrant Box #



### Software Prerequisites

* Vagrant 1.8.4
* VirtualBox 5.0.26

### Packages Included ###

mysql-community-server httpd php php-mysql nginx rsync vim-enhanced tmux policycoreutils-python git ntp wget make

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

>For additional info check [official Centos documentation](https://seven.centos.org/2016/10/updated-centos-vagrant-images-available-v1609-01/).

After adding Centos iso to Vagrant, configure synced folder on your local machine by editing Vargant file ( e.g. /code folder on local machine will be synced to /opt/code on virtual machine ):

```
#!bash
config.vm.synced_folder "../../code", "/opt/code"

```

Boot machine:
```
#!bash

vagrant up
```

### Additional Configuration ###


By default, nginx is configured to listen on port 80 while apache is listening on port 8080. This can be tweaked on provisioning level as well as vhost configuration for both nginx and apache.

`box-config` folder contains box level configuration (in this case for `centos7-box` box). Everything inside `centos7-box` folder will be mapped to newly provisioned box, which means that we can have independent configurations for different boxes.

Adding or removing packages from the box is done by modifying `provisioning-scripts/centos7-box.sh` file.

After modifying existing configuration files we need to re-provision Vagrant box:

```
#!bash

vagrant reload --provision
```
To login into newly created machine, type: 
```
#!bash

vagrant ssh
```

To turn off machine, type: 
```
#!bash

vagrant halt
```

To save machine snapshot run:
```
#!bash

vagrant snapshot save NAME
```

and to restore a snapshot:

```
#!bash

vagrant snapshot restore NAME
```

Run into problem with vm?

```
#!bash

vagrant destroy
```

and then 

```
#!bash

vagrant up
```