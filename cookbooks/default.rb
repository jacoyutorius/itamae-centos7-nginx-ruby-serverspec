%w(git vim gcc gcc-c++ epel-release openssl-devel readline-devel zlib-devel libcurl-devel sqlite sqlite-devel lsof nmap wget tree).each do |pkg|
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

# execute "disable SELINUX" do
# 	user "root"
# 	cwd "/etc/selinux"
# 	command "sed -i -e 's/SELINUX\=enforcing/SELINUX\=disabled/g' config"
# end

# execute "reboot" do
# 	user "root"
# 	command "reboot"
# end