package "curl"

execute "install composer" do
  command '
    if [ ! -f "/usr/local/bin/composer" ]; then
      curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
    fi
  '
  user 'root'
  group 'root'
end
