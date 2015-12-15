# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$init_lamp03 = <<SCRIPT
[ -d /vagrant/modules/apache ] && rm -rf /vagrant/modules/apache
puppet module install puppetlabs-apache --target-dir /vagrant/modules
[ -d /vagrant/modules/mysql ] && rm -rf /vagrant/modules/mysql
puppet module install puppetlabs-mysql --target-dir /vagrant/modules
echo "<?php  phpinfo(); ?>" > /vagrant/modules/apache/files/info.php
cd /vagrant && puppet apply --modulepath=./modules  --verbose manifests/lamp03.pp
SCRIPT

$init_nginx = <<SCRIPT
[ -f /etc/puppet/hiera.yaml ] || cp /vagrant/hiera.yaml /etc/puppet
[ -d /etc/puppet/hieradata ] || mkdir -p /etc/puppet/hieradata
[ -f /etc/puppet/hieradata/site.yaml ] || cp /vagrant/site.yaml /etc/puppet/hieradata
cd /vagrant && puppet apply --modulepath=/vagrant/modules -e "include nginx"
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |host|

  host.vm.define "lamp01" do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "lamp01"
    config.vm.network :private_network, ip: "10.2.2.11"
    config.vm.provision "puppet" do |puppet|
      puppet.manifest_file = "lamp01.pp"
    end
  end

  host.vm.define "lamp02" do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "lamp02"
    config.vm.network :private_network, ip: "10.2.2.12"
    config.vm.provision "shell", inline: "cd /vagrant && puppet apply --modulepath=./modules --verbose manifests/lamp02.pp"
  end

  host.vm.define "lamp03" do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "lamp03"
    config.vm.network :private_network, ip: "10.2.2.13"
    config.vm.provision "shell", inline: $init_lamp03
  end

  host.vm.define "nginx" do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "nginx"
    config.vm.network :private_network, ip: "10.2.2.14"
    config.vm.provision "shell", inline: $init_nginx
  end

end
