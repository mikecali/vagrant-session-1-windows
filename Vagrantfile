# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  config.vm.define "client1" do |aso|
    aso.vm.box = "pmsmith/windows2008"
    aso.vm.guest = :windows
    aso.vm.network "private_network", ip: "192.168.100.10"
    aso.vm.hostname = "win-client1"
    aso.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    aso.winrm.retry_limit = 20
    aso.winrm.retry_delay = 10
    aso.vm.communicator = "winrm"
    aso.winrm.username = "vagrant"
    aso.winrm.password = "vagrant"
    aso.vm.customize ["modifyvm", :id, "--name", "win-client1"]
  end
 
  config.vm.define "client2" do |tao|
    tao.vm.box = "pmsmith/windows2008"
    tao.vm.guest = :windows
    tao.vm.network "private_network", ip: "192.168.100.11"
    tao.vm.host_name = "win-client2"
    tao.vm.network :forwarded_port, guest: 5985, host: 5986, id: "winrm", auto_correct: true
    tao.vm.communicator = "winrm"
    tao.winrm.username = "vagrant"
    tao.winrm.password = "vagrant"
    tao.winrm.retry_limit = 20
    tao.winrm.retry_delay = 10
    tao.vm.customize ["modifyvm", :id, "--name", "win-client2"]
  end
 
  config.vm.define "ansible-host" do |master|
#   Only Enable this if you are connecting to Proxy server
#      config.proxy.http     = "http://usernam:password@dnzwgpx2.datacom.co.nz:80"
#      config.proxy.https    = "http://usernam:password@dnzwgpx2.datacom.co.nz:80"
#    master.vm.guest = :linux    
    master.proxy.no_proxy = "localhost,127.0.0.1"
    master.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
    master.ssh.insert_key = false
    master.vm.hostname = "ansible-host"
    master.vm.communicator = "ssh"
    master.vm.box = "Datacom_Centos7.3_gui_v3"
    master.vm.network "private_network", ip: "192.168.100.12"
    master.vm.host_name = "ansible-host"
    master.vm.provision :shell, path: "ansible-install.sh"
    master.vm.provision :shell, path: "host.sh"
    master.vm.provision :file do |file|
        file.source     = 'tower/inventory'
        file.destination    = '/home/vagrant/ansible-tower-setup-bundle-3.1.2-1.el7/inventory'
       end   
    master.vm.provision :shell, path: "ansible-tower-install.sh"
    master.vm.provision :shell, path: "bootstrap-node.sh"
  end
  
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
    # Customize the amount of memory on the VM:
    vb.cpus = 2
    vb.memory = 2048
  end
end
