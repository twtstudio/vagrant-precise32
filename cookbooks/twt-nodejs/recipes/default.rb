apt_package "python-software-properties"

execute "add ppa:chris-lea/node.js" do
  command "test -f /etc/apt/sources.list.d/chris-lea-node_js-*.list || add-apt-repository -y ppa:chris-lea/node.js"
  user "root"
  group "root"
end

execute "apt-get update" do
  user "root"
  group "root"
end

apt_package "nodejs"

%w{grunt-cli bower component less coffee-script}.each do |pkg|
  execute "Install #{pkg}" do
    command "npm ls -g #{pkg} || npm install -g #{pkg}"
    user "root"
    group "root"
  end
end
