#
#  cookbook - nginx
#   install & defaylt setting for NGINX
#   2016.2.12
#   2017.3.10 update for CentOS7
#

# execute "register yum repo" do
#   command "rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
#   not_if "test -e /etc/nginx"
# end

package "nginx" do
  action :install
end

directory "/var/www/html/" do
  owner "nginx"
  group "nginx"
  action :create
end

file "/var/www/html/index.html" do
  owner "nginx"
  group "nginx"
  action :create
  content "Hello,"
end

execute "write index.html" do
  user "root"
  cwd "/var/www/html"
  command "hostname >> index.html"
end

template "/etc/nginx/conf.d/default.conf" do
  user "root"
  group "root"
  source "./templates/etc/nginx/conf.d/default.conf.erb"
  variables(nginx_root_location: "/var/www/html")
end

# template "/etc/nginx/conf.d/application.conf" do
#   user "root"
#   group "root"
#   source "./templates/etc/nginx/conf.d/application.conf.erb"
#   variables(app_name: node[:app_name])
# end

service "nginx" do
  action [:enable, :start, :reload]
end

# # 後でiptablesの設定する。今はとりあえず停止させておく
# service "iptables" do
#   action [:stop]
# end
