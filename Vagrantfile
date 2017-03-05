# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos-6.7-x86_64"

  # Weblogic AdminServer ports
  config.vm.network :forwarded_port, guest: 7001, host: 7001
  config.vm.network :forwarded_port, guest: 7002, host: 7002

  # Weblogic managed servers ports
  config.vm.network :forwarded_port, guest: 7011, host: 7011
  config.vm.network :forwarded_port, guest: 7012, host: 7012
 
  # Create a private network
  config.vm.network "private_network", ip: "192.168.33.10"

  # VirtualBox provider configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "CentOS 6.7 - Weblogic"
    vb.memory = "2048"
  end

  # Perform shell script provisioning
  config.vm.provision "shell", path: "jdk/provision_jdk.sh"
  config.vm.provision "shell", path: "maven/provision_maven.sh"
  config.vm.provision "shell", path: "weblogic/provision_weblogic_domain.sh"
  config.vm.provision "shell", path: "weblogic/provision_weblogic_servers.sh"
  config.vm.provision "shell", path: "weblogic/provision_weblogic_maven.sh"

end
