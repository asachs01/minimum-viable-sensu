Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  
  config.vm.hostname = "sensu-workshop-01"

# Note that the line below is for a linux host. For OS X, change this to `en0` or the interface provided in `ifconfig`
  config.vm.network "public_network", type: "dhcp", bridge: "eno1"
  
# If the above does not work for you, you can also expose the ports by uncommenting the below lines:
#  config.vm.network "forwarded_port", guest: 3000, host: 3000
#  config.vm.network "forwarded_port", guest: 4567, host: 4567

  config.vm.provision "shell", path: "steps.sh"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
end
