package "lsb-release"

bash "replace apt mirrors" do
  code '
    export CODENAME=$(lsb_release -c -s)
    sed -i".bak" -E \
      "s#^\s*deb(-src)?(.+)$CODENAME#deb\1 $MIRROR $CODENAME#g" \
      /etc/apt/sources.list
  '
  user "root"
  group "root"
  environment ({'MIRROR' => node[:twt_apt_mirror][:ubuntu]})
end

execute "apt-get update" do
  user "root"
  group "root"
end
