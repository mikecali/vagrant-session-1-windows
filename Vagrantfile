# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
  boxes = [
    { 
      :name => "client1", 
      :box => "pmsmith/windows2008",
      :ram => 2048,
      :vcpu => 1,
      :ip => "192.168.29.2" 
    },
    { 
      :name => "client2",
      :box => "pmsmith/windows2008", 
      :ram => 2048,
      :vcpu => 1,
      :ip => "192.168.29.3" 
    },
    { 
      :name => "ansible-host",
      :box => "Datacom_Centos7.3_gui_v3",
      :ram => 4048,
      :vcpu => 1,
      :ip => "192.168.29.4" 
    }
  ]

  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
#   Only Enable this if you are connecting to Proxy server
      config.proxy.http     = "http://172.17.172.72:3128"
      config.proxy.https    = "http://172.17.172.72:3128"
      config.proxy.no_proxy = "localhost,127.0.0.1"
      config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
      config.ssh.insert_key = false
      config.vm.box = opts[:box]
      config.vm.hostname = opts[:name]
      config.vm.provider :virtualbox do |v|
        v.memory = opts[:ram]
        v.cpus = opts[:vcpu]
      end
      config.vm.network :private_network, ip: opts[:ip]
        
      # Provision Windows VM.
      if opts[:name] == "client1"
      config.vm.define opts[:name] do |vb|
        vb.vm.guest = :windows
        vb.vm.name = "client1"
#        vb.vm.network "private_network", ip: "192.168.100.10"
        vb.vm.hostname = "win-client1"
        vb.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
        vb.winrm.retry_limit = 20
        vb.winrm.retry_delay = 10
        vb.vm.communicator = "winrm"
        vb.winrm.username = "vagrant"
        vb.winrm.password = "vagrant"
        end
      config.vm.provider "virtualbox" do |vb|
        vb.name = "client1"
        end
      end
      
      if opts[:name] == "client2"
      config.vm.define opts[:name] do |vb|
        vb.vm.guest = :windows
        vb.vm.name = "client2"
#        vb.vm.network "private_network", ip: "192.168.100.10"
        vb.vm.hostname = "win-client1"
        vb.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
        vb.winrm.retry_limit = 20
        vb.winrm.retry_delay = 10
        vb.vm.communicator = "winrm"
        vb.winrm.username = "vagrant"
        vb.winrm.password = "vagrant"
        end
      config.vm.provider "virtualbox" do |vb|
        vb.name = "client2"
        end
      end
            
      if opts[:name] == "ansible-host"
        config.vm.provision :shell, path: "ansible-install.sh"
        config.vm.provision :shell, path: "host.sh"
      end
      if opts[:name] == "ansible-host"
        config.vm.provision :file do |file|
        file.source     = 'tower/inventory'
        file.destination    = '/home/vagrant/ansible-tower-setup-bundle-3.1.2-1.el7/inventory'
        end
      end
      if opts[:name] == "ansible-host"
        config.vm.provision :file do |file|
		    file.source     = 'windows.playbooks/create-user.yml'
	      file.destination    = '/home/vagrant/windows.playbooks/create-user.yml'
        end
      end
       if opts[:name] == "ansible-host"
        config.vm.provision :file do |file|
        file.source     = 'windows.playbooks/inventory'
        file.destination    = '/home/vagrant/inventory'
        end
      end
      if opts[:name] == "ansible-host"
        config.vm.provision :file do |file|
	      file.source     = 'windows.playbooks/test.yml'
	      file.destination    = '/home/vagrant/windows.playbooks/test.yml'
        end
      end 
      if opts[:name] == "ansible-host"
        config.vm.provision :shell, path: "ansible-tower-install.sh"
      end
    config.vm.provision :shell, path: "bootstrap-node.sh"
   end    
  end
end

