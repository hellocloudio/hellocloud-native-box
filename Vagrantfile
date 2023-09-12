# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

    config.vm.define "hellocloud-native-box" do |vm1|
      config.ssh.private_key_path = "/Users/sai/hellocloud-boxes/hellocloud-native-box/.ssh/id_rsa"
      config.ssh.forward_agent = true
      config.ssh.username = "vagrant"
      config.ssh.password = "vagrant"
      vm1.vm.hostname = "hellocloud-native-box"
      vm1.vm.box = "bento/ubuntu-22.04"
      vm1.vm.network "private_network", ip: "192.168.56.85"
      # vm1.vm.network "forwarded_port", guest: 8200, host: 8200
      vm1.vm.synced_folder ".", "/home/vagrant/"
      vm1.vm.provider "virtualbox" do |vb|
        vb.name = "hellocloud-native-box"
        vb.memory = "8192"
        vb.cpus = 4
        vb.gui = false
      end
  
      vm1.vm.provision "shell", run: "always", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get install net-tools zip curl jq tree unzip wget siege apt-transport-https ca-certificates software-properties-common gnupg lsb-release -y
        netstat -tunlp
        echo "Hello from hellocloud-native-box"
      SHELL
  
      vm1.vm.provision "shell",
        privileged: true,
        path: './scripts/1-docker-install.sh'
  
      vm1.vm.provision "shell",
        privileged: true,
        path: './scripts/2-kubectl-install.sh'
  
      vm1.vm.provision "shell",
        privileged: true,
        path: './scripts/3-kind-install.sh'
  
      vm1.vm.provision "shell",
        privileged: true,
        path: './scripts/4-helm-install.sh'

      vm1.vm.provision "shell",
        privileged: true,
        path: './scripts/8-grpcurl-install.sh'
    end
  end