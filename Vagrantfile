# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos6"
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.network :private_network, ip: "192.168.111.222"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # No need for ansible to be installed in the host
	config.vm.provision :shell, :path => "bootstrap.sh"

end
