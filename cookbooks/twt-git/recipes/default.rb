apt_package "git"

cookbook_file "/etc/gitconfig" do
  source "gitconfig"
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
end
