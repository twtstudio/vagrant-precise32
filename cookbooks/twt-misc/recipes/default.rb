apt_package "python-pip"
apt_package "build-essential"
apt_package "python-software-properties"

cookbook_file "/etc/motd.tail" do
  source "motd"
  owner 'root'
  group 'root'
  mode '0644'
end

execute "Check vagrant provision complete" do
  command "touch /home/vagrant/twt-precise-installed"
  user "vagrant"
  group "vagrant"
end
