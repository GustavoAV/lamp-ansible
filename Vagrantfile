# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  ips = File.readlines("inventory").map(&:strip)
  
  config.vm.define "ub20" do |ub20|
    ub20.vm.box = "ubuntu/focal64"
    ub20.vm.network "private_network", ip: ips[0]
    ub20.vm.provision "shell", inline: <<-SHELL
      cat /vagrant/ansible_ed25519.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL
  end

  config.vm.define "ub22" do |ub22|
    ub22.vm.box = "ubuntu/jammy64"
    ub22.vm.network "private_network", ip: ips[1]
    ub22.vm.provision "shell", inline: <<-SHELL
      cat /vagrant/ansible_ed25519.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL
  end

end
