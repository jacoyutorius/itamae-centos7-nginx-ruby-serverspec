#
#  cookbook - nginx
#   install & defaylt setting for NGINX
#   2016.2.12
#   2016.3.10 update for CentOS7
#   2016.12.24 delete old code
#

package "nginx" do
  action :install
end

directory "/var/www/html/" do
  owner "nginx"
  group "nginx"
  action :create
end

execute "create index.html" do
  user "root"
  cwd "/var/www/html"
  command 'wget https://s3-ap-northeast-1.amazonaws.com/jacoyutorius/html/jacoyutorius.html -O index.html;sed -i -e "s/hostname/$HOSTNAME/g" index.html'
end

template "/etc/nginx/nginx.conf" do
  user "root"
  group "root"
  source "./templates/etc/nginx/nginx.conf.erb"
end

template "/etc/nginx/conf.d/default.conf" do
  user "root"
  group "root"
  source "./templates/etc/nginx/conf.d/default.conf.erb"
  variables(nginx_root_location: "/var/www/html")
end

service "nginx.service" do
  action [:enable, :start, :reload]
end
