apt_package "rlwrap"

remote_file "/tmp/nodejs_0.10.26-1chl1~precise1_i386.deb" do
  checksum "4e1a96dad82a8d156b15da99e12943233331452ba53b8ed9b8277f3f929db23d"
  group "root"
  owner "root"
  source "http://store-web.twtapps.net/nodejs_0.10.26-1chl1~precise1_i386.deb"
end

execute "Install nodejs 0.10.26" do
  command "dpkg -i -E -G '/tmp/nodejs_0.10.26-1chl1~precise1_i386.deb'"
  user "root"
  group "root"
end

%w{grunt-cli bower less coffee-script}.each do |pkg|
  execute "Install #{pkg}" do
    command "npm ls -g #{pkg} || npm install -g #{pkg}"
    user "root"
    group "root"
  end
end
