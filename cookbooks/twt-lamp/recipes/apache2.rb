apt_package "apache2"

execute "run apache2 with vagrant user" do
  command '
    sed -i".bak" -E "s#APACHE_RUN_(USER|GROUP)=.*#APACHE_RUN_\1=vagrant#g" /etc/apache2/envvars
    chown -R vagrant /var/run/apache2
    chown -R vagrant /var/lock/apache2
  '
  user "root"
  group "root"
end

execute 'a2enmod rewrite ssl' do
  user "root"
  group "root"
end

file "/etc/apache2/conf.d/disableSendfile" do
  content "EnableSendfile off"
  owner "root"
  group "root"
  mode "0644"
end

execute "make default site directory" do
  command "mkdir -p #{node[:twt_lamp][:docroot]} #{node[:twt_lamp][:logdir]}"
  user "vagrant"
  group "vagrant"
end

file "#{node[:twt_lamp][:docroot]}/index.html" do
  content "<h1>It works!</h1>"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :create_if_missing
end

template "/etc/apache2/sites-available/default" do
  owner "root"
  group "root"
  mode "0644"
  source "apache2-default-site.erb"
end

execute "enable default site" do
  command 'a2ensite default'
  user "root"
  group "root"
end

service "apache2" do
  action [ :enable, :restart ]
end
