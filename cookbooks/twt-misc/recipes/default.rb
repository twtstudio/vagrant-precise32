apt_package "python-pip"
apt_package "build-essential"

cookbook_file "/etc/motd.tail" do
  source "motd"
  owner 'root'
  group 'root'
  mode '0644'
end
