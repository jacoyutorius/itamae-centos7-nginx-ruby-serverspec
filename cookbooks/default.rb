execute "register yum repo" do
  command "rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
  not_if "test -e /etc/nginx"
end

%w(git vim nginx gcc openssl-devel readline-devel zlib-devel libcurl-devel sqlite sqlite-devel mysql-server mysql-devel).each do |pkg|
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

include_recipe "rbenv::system"

# ↓ itamae-pluginに置き換える。
# # [ "git clone git://github.com/sstephenson/rbenv.git rbenv",
# #   "mkdir rbenv/shims rbenv/versions rbenv/plugins",
# #   "groupadd rbenv",
# #   "chmod -R g+rwxXs rbenv" ]
# [ "git clone git://github.com/sstephenson/rbenv.git rbenv" ].each do |exec_command|
#   execute "install rbenv -- #{exec_command}" do
#     cwd "/usr/local"
#     user "root"
#     command exec_command
#     not_if "test -e /usr/local/rbenv"
#   end
# end

# group "rbenv" do
#   action :create
# end

# directory "/usr/local/rbenv/shims" do
#   mode "g+rwxXs"
#   owner "root"
#   group "rbenv"
# end

# directory "/usr/local/rbenv/versions" do
#   mode "g+rwxXs"
#   owner "root"
#   group "rbenv"
# end

# directory "/usr/local/rbenv/plugins" do
#   mode "g+rwxXs"
#   owner "root"
#   group "rbenv"
# end

# [
#   "git clone git://github.com/sstephenson/ruby-build.git ruby-build",
#   "chgrp -R rbenv ruby-build",
#   "chmod -R g+rwxs ruby-build"
# ].each do |exec_command|
#   execute "install ruby-build -- #{exec_command}" do
#     cwd "/usr/local/rbenv/plugins"
#     user "root"
#     command exec_command
#     not_if "test -e /usr/local/rbenv/plugins/ruby-build"
#   end
# end

# [
#   "git clone git://github.com/sstephenson/rbenv-default-gems.git rbenv-default-gems",
#   "chgrp -R rbenv rbenv-default-gems",
#   "chmod -R g+rwxs rbenv-default-gems"
# ].each do |exec_command|
#   execute "install rbenv-default-gems -- #{exec_command}" do
#     cwd "/usr/local/rbenv/plugins"
#     user "root"
#     command exec_command
#     not_if "test -e /usr/local/rbenv/plugins/rbenv-default-gems"
#   end
# end

# remote_file "/etc/profile.d/rbenv.sh" do
#   user "root"
#   group "root"
#   source "remote_files/rbenv.sh"
# end

# remote_file "/usr/local/rbenv/default-gems" do
#   user "root"
#   group "root"
#   source "remote_files/default-gems"
# end

# execute "load setting" do
#   user "root"
#   command "source /etc/profile.d/rbenv.sh"
# end

# # 何故かエラーになるのでコメントアウト
# # execute "check installable ruby version" do
# #   user "root"
# #   cwd "/root"
# #   command "/usr/local/rbenv/bin/rbenv install -l"
# # end
# #
# # execute "install Ruby2.1.2" do
# #   user "root"
# #   cwd "/root"
# #   command "/usr/local/rbenv/bin/rbenv install 2.1.2; /usr/local/rbenv/bin/rbenv global 2.1.2;"
# # end


# 後でiptablesの設定する。今はとりあえず停止させておく
service "iptables" do
  action [:stop]
end
