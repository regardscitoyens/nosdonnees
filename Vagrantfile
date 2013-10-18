# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
config.vm.box = "debian-wheezy64"
config.vm.box_url = "https://dl.dropbox.com/u/2289657/squeeze32-vanilla.box"
config.cache.auto_detect = true
config.vm.hostname = "nosdonnees"
#config.vm.provision :shell, :path => "append_authorized_keys_to_root.sh"
config.vm.provision :hostmanager
config.hostmanager.enabled = true
config.hostmanager.ignore_private_ip = false
config.vm.network :private_network, ip: "192.168.33.10"
config.vm.network :forwarded_port, guest: 80, host: 8080
config.hostsupdater.aliases = [
      "www.nosdonnees.fr"
      ]
config.hostmanager.aliases = [
      "www.nosdonnees.fr"
    ]
#config.vm.synced_folder ".", "/vagrant/"
end

