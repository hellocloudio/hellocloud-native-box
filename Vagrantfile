# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_SSH_PATH = ENV['VAGRANT_SSH_PATH'] || "/home/htoohtoo/hellocloud/hellocloud-native-box/.ssh/hc_id_rsa"

VAGRANT_BOX_IMAGE = "bento/ubuntu-22.04"
VAGRANT_BOX_NAME  = "hellocloud-native-box"
CPUS_FOR_BOX      = 4
MEMORY_FOR_BOX    = 8192
BOX_IP_ADDRESS    = "192.168.56.85"

Vagrant.configure("2") do |config|
  config.vm.define VAGRANT_BOX_NAME do |vm1|
    config.ssh.private_key_path = VAGRANT_SSH_PATH
    config.ssh.forward_agent = true
    config.ssh.username = "vagrant"
    config.ssh.password = "vagrant"
    vm1.vm.hostname = VAGRANT_BOX_NAME
    vm1.vm.box = VAGRANT_BOX_IMAGE
    vm1.vm.network "private_network", ip: BOX_IP_ADDRESS
    vm1.vm.synced_folder ".", "/home/vagrant/"
    vm1.vm.provider "virtualbox" do |vb|
      vb.name = VAGRANT_BOX_NAME
      vb.memory = MEMORY_FOR_BOX
      vb.cpus = CPUS_FOR_BOX
      vb.gui = false
    end

    config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{VAGRANT_SSH_PATH}.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo "Successfully inserted SSH Public key"
      SHELL
    end

    vm1.vm.provision "shell", run: "always", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y net-tools zip curl jq tree unzip wget siege apt-transport-https ca-certificates software-properties-common gnupg lsb-release
      netstat -tunlp
      echo "Hello from $VAGRANT_BOX_NAME"
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
  
    # vm1.vm.provision "shell",
    #   privileged: true,
    #   path: './scripts/4-helm-install.sh'

    # vm1.vm.provision "shell",
    #   privileged: true,
    #   path: './scripts/8-grpcurl-install.sh'

    vm1.vm.provision "shell",
      privileged: true,
      path: './scripts/10-cilium-install.sh'
  end
end
