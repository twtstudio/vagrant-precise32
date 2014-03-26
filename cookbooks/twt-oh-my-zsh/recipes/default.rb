apt_package "git"
apt_package "zsh"

omz_path="/home/vagrant/.oh-my-zsh"
omz_repo="git://github.com/robbyrussell/oh-my-zsh.git"

execute "check out oh-my-zsh repo" do
  command "test -d #{omz_path} || git clone #{omz_repo} #{omz_path}"
  user "vagrant"
  group "vagrant"
end

template "/home/vagrant/.zshrc" do
  source "zshrc.erb"
  user "vagrant"
  group "vagrant"
  mode "0644"
  action :create_if_missing
end

execute "set zsh as default shell" do
  command "chsh -s $(which zsh) vagrant"
end
