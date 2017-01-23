#
#  cookbook - kibana
#   install & defaylt setting for Kibana
# 
#   2016.12.24
#

# execute "download kibana-5.1.1-linux-x86_64" do
#   user "root"
#   cwd "/root"
#   command "wget https://artifacts.elastic.co/downloads/kibana/kibana-5.1.1-linux-x86_64.tar.gz"
#   not_if "test -e /opt/kibana"
# end

# execute "tar kibana-5.1.1-linux-x86_64" do
#   user "root"
#   cwd "/root"
#   command "tar -xzvf kibana-5.1.1-linux-x86_64.tar.gz"
#   not_if "test -e /opt/kibana"
# end

# execute "tar kibana-5.1.1-linux-x86_64" do
#   user "root"
#   cwd "/root"
#   command "mv kibana-5.1.1-linux-x86_64 /opt/kibana"
#   not_if "test -e /opt/kibana"
# end

package "https://artifacts.elastic.co/downloads/kibana/kibana-5.1.2-x86_64.rpm" do
  action :install
  not_if "test -e /etc/kibana"
end

execute "backup config" do
  user "root"
  cwd "/etc/kibana"
  command "cp kibana.yml kibana.yml_bk"
end

template "/etc/kibana/kibana.yml" do
  user "root"
  group "root"
  mode "775"
  source "./templates/etc/kibana/kibana.yml.erb"
end

directory "/opt/kibana/logs" do
  mode "775"
  owner "root"
  group "root"
end

service "kibana" do
  action [:start, :restart]
end
