%w(git vim gcc openssl-devel readline-devel zlib-devel libcurl-devel sqlite sqlite-devel lsof nmap wget).each do |pkg|
  package pkg do
    action :install
  end
end

# install node.js instead of therubyracer
%w(epel-release gcc gcc-c++).each do |pkg|
	package pkg do
    action :install
  end
end

package "nodejs" do
	action :install
	options "--enablerepo=epel"
end

package "npm" do
	action :install
	options "--enablerepo=epel"
end

# 後でiptablesの設定する。今はとりあえず停止させておく
service "iptables" do
  action [:stop]
end

# install nginx
include_recipe "nginx"

service "nginx" do
  action [:enable, :start, :reload]
end