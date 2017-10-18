## Minimum Viable Sensu Workshop
In order to complete the Minimum Viable Sensu workshop on your own computer, please install the following:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* Vagrantfile provided in this gist
* [Centos 7.3 Vagrant box](https://atlas.hashicorp.com/bento/boxes/centos-7.3) -- should be downloaded automatically

A couple of notes:
* This assumes that you're downloading the Vagrantfile & `steps.sh` to the same directory
* You'll also want to review the `bridge` option in the Vagrant file, or optionally, remove the `bridge` option and uncomment the `forwarded_port` lines

## Up and Running
To get up and running, simply do the following:
* `git clone https://github.com/asachs01/minimum-viable-sensu.git`
* `cd minimum-viable-sensu`
* `vagrant up`

Once the box file is downloaded and the VM is running, use `vagrant ssh` to log in to the VM via ssh.
