Vagrant.configure("2") do |config|
  
  config.vm.box = "centos/7"
  config.vm.hostname = "centos7-box"
  config.vm.network "private_network", ip: "150.10.10.10"
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"], type: "virtualbox"
  config.vm.synced_folder "../../code", "/opt/code"
 
  config.vm.provider "virtualbox" do |vb|
    vb.name = "centos7-box"
  end

  config.vm.provision :shell, path: "provisioning-scripts/bootstrap.sh"
end
