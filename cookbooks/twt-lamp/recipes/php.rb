%w{php5 php-pear php5-xsl php-apc php5-curl php5-geoip php5-mcrypt php5-imagick php5-ldap php5-imap}.each do |pkg|
  package pkg
end

execute 'a2enmod php5' do
  user "root"
  group "root"
end

execute "make configuration directory" do
  command "mkdir -p #{node[:twt_lamp][:confdir]}"
  user "vagrant"
  group "vagrant"
end

file "/etc/apache2/mods-available/php5.conf" do
  content ""
  owner "root"
  group "root"
  mode "0644"
end

cookbook_file "/etc/php5/conf.d/000vagrant.ini" do
  source "php-conf.ini"
  user "root"
  group "root"
  mode "0644"
end

file "#{node[:twt_lamp][:confdir]}/php.ini" do
  content "date.timezone = 'Asia/Chongqing'"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :create_if_missing
end

link "/etc/php5/conf.d/zzzuser.ini" do
  to "#{node[:twt_lamp][:confdir]}/php.ini"
  owner "root"
  group "root"
end

file "#{node[:twt_lamp][:docroot]}/index.php" do
  content "<?php phpinfo(); ?>"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :create_if_missing
end

service "apache2" do
  action [ :enable, :restart ]
end
