apt_package "vim"

cookbook_file "/home/vagrant/.vimrc" do
  source "vimrc"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :create_if_missing
end
