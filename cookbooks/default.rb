%w(git vim gcc gcc-c++ epel-release openssl-devel readline-devel zlib-devel libcurl-devel sqlite sqlite-devel lsof nmap wget).each do |pkg|
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
