# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.define "mesos-ubuntu-14.04" do |mesos_dev|
    mesos_dev.vm.box = "ubuntu/trusty64"
    mesos_dev.vm.synced_folder ".", "/home/vagrant/projects/mesos-vagrant"
    mesos_dev.vm.network :"private_network", type:"dhcp"
    mesos_dev.vm.hostname="mesos-ubuntu-14.04"
    mesos_dev.vm.provider "virtualbox" do |v|
        v.name ="mesos-ubuntu-14.04"
        v.memory=8192
        v.cpus=4
    end
    mesos_dev.vm.provision :shell, path: "bootstrap-ubuntu-14.04.sh"
  end

  config.vm.define "mesos-centos-6.6" do |mesos_dev|
    mesos_dev.vm.box = "https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.0.0/centos-6.6-x86_64.box"
    mesos_dev.vm.synced_folder ".", "/home/vagrant/projects/mesos-vagrant"
    mesos_dev.vm.network :"private_network", type:"dhcp"
    mesos_dev.vm.hostname="mesos-centos-6.6"
    mesos_dev.vm.provider "virtualbox" do |v|
        v.name ="mesos-centos-6.6"
        v.memory=8192
        v.cpus=4
    end
    mesos_dev.vm.provision :shell, path: "bootstrap-centos-6.6.sh"
  end

  config.vm.define "mesos-centos-7.1" do |mesos_dev|
    mesos_dev.vm.box = "bento/centos-7.1"
    mesos_dev.vm.synced_folder ".", "/home/vagrant/projects/mesos-vagrant"
    mesos_dev.vm.network :"private_network", type:"dhcp"
    mesos_dev.vm.hostname="mesos-centos-7.1"
    mesos_dev.vm.provider "virtualbox" do |v|
        v.name ="mesos-centos-7.1"
        v.memory=8192
        v.cpus=4
    end
    mesos_dev.vm.provision :shell, path: "bootstrap-centos-7.1.sh"
  end
end
