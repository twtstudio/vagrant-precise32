execute "Change Localtime to Asia/Shanghai" do
  command "cp -f /usr/share/zoneinfo/posix/Asia/Shanghai /etc/localtime"
  user "root"
  group "root"
end

cookbook_file "/var/lib/locales/supported.d/local" do
  source "supported"
  owner "root"
  group "root"
  mode "0644"
end

cookbook_file "/etc/default/locale" do
  source "locale"
  owner "root"
  group "root"
  mode "0644"
end

execute "Generate Locale files" do
  command "locale-gen --purge"
  user "root"
  group "root"
end
