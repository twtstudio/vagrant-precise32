%w{mysql-server php5-mysql libmysqlclient18}.each do |pkg|
  apt_package pkg
end

cookbook_file "/etc/mysql/conf.d/000vagrant.cnf" do
  source "mysql.cnf"
  owner 'root'
  group 'root'
  mode "0644"
end

execute "make configuration directory" do
  command "mkdir -p #{node[:twt_lamp][:confdir]}"
  user "vagrant"
  group "vagrant"
end

file "#{node[:twt_lamp][:confdir]}/my.cnf" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :touch
end

link "/etc/mysql/conf.d/zzzuser.cnf" do
  to "#{node[:twt_lamp][:confdir]}/my.cnf"
  owner "root"
  group "root"
end

cookbook_file "/tmp/grants.sql" do
  source "grants.sql"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, 'execute[grant_mysql]'
end

execute "grant_mysql" do
  command 'mysql -uroot < /tmp/grants.sql'
  action :nothing
end

service "mysql" do
  action [ :enable, :restart ]
end
