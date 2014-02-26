# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/20140121/raring-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.provision :shell, :path => "provision.sh"

  config.vm.network :forwarded_port, guest: 8000, host: 8000
end
