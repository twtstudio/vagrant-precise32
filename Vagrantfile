# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "hashicorp/precise32"
  config.vm.box_url = "http://store-web.twtapps.net/precise32.box"
  config.vm.box_download_checksum = "82507518dd38a507287f9703e5ffba30349b25f2"
  config.vm.box_download_checksum_type = "sha1"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vbox|
    vbox.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"

    chef.add_recipe "twt-locale"
    chef.add_recipe "twt-apt-mirror"
    chef.add_recipe "twt-lamp"
    #chef.add_recipe "twt-nodejs"
    chef.add_recipe "twt-ruby"
    chef.add_recipe "twt-git"
    chef.add_recipe "twt-vim"
    chef.add_recipe "twt-oh-my-zsh"
    chef.add_recipe "twt-misc"

    # You may also specify custom JSON attributes:
    # chef.json = { :mysql_password => "foo" }
  end

end
