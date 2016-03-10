package "sqlite-devel" do
  action :install
end

execute "install mailcatcher" do
  user "root"
  command "/usr/local/rbenv/shims/gem install mailcatcher"
end

execute "start mailcatcher" do
  user "root"
  command "/usr/local/rbenv/shims/mailcatcher --http-ip 192.168.33.12 --smtp-port 587"
end

service "iptables" do
  action :stop
end
