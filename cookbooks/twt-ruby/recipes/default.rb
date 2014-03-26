%w{ruby1.9.1 ruby1.9.1-dev ruby-libxml ruby-mysql ruby-sinatra ruby-xmlparser ruby-nokogiri}.each do |pkg|
  apt_package pkg
end

%w{vagrant root}.each do |username|
  sources = username == "root" ? "gem sources" : "sudo -u #{username} -H gem sources"
  execute "Change rubygems sources to ustc mirror" do
    command "
      #{sources} -l | \
        grep -v 'mirrors.ustc.edu.cn' | \
        while read s; do #{sources} -r $s; done
      #{sources} -l | grep 'mirrors.ustc.edu.cn' && exit 0
      #{sources} -a http://mirrors.ustc.edu.cn/rubygems/
    "
    user "root"
    group "root"
  end
end

apt_package "build-essential"

execute "gem install rdoc bundler --no-ri --no-rdoc" do
  user "root"
  group "root"
end
