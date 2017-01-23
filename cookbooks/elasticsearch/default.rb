#
#  cookbook - elasticsearch
#   install & defaylt setting for Elasticsearch
# 
#   2016.12.24
#

# elastic_user = "vagrant"
# elastic_base_dir = "/home/vagrant"

package "java-1.8.0-openjdk.x86_64" do
  action :install
end

package "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.2.rpm" do
	action :install
	not_if "test -e /etc/elasticsearch"
end

execute "install cerebro 0.5.0" do
	user "root"
	cwd "/root"
	command "wget https://github.com/lmenezes/cerebro/releases/download/v0.5.0/cerebro-0.5.0.tgz;tar -xzvf cerebro-0.5.0.tgz;mv cerebro-0.5.0 /opt/cerebro"
	not_if "/opt/cerebro"
end

service "elasticsearch" do
  action [:start, :restart]
end