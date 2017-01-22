#
#  cookbook - elasticsearch
#   install & defaylt setting for Elasticsearch
# 
#   2016.12.24
#

elastic_user = "vagrant"
elastic_base_dir = "/home/vagrant"

package "java-1.8.0-openjdk.x86_64" do
  action :install
end

package "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.2.rpm" do
	action :install
	not_if "test -e /etc/elasticsearch"
end

# execute "download Elasticsearch 5.1.1" do
# 	user elastic_user
# 	cwd elastic_base_dir
# 	command "wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.tar.gz"
# 	not_if "test -e /opt/elasticsearch"
# end

# execute "tar Elasticsearch 5.1.1" do
# 	user elastic_user
# 	cwd elastic_base_dir
# 	command "tar -xzvf elasticsearch-5.1.1.tar.gz"
# 	not_if "test -e /opt/elasticsearch"
# end

# execute "tar Elasticsearch 5.1.1" do
# 	user elastic_user
# 	cwd elastic_base_dir
# 	command "mv elasticsearch-5.1.1 /opt/elasticsearch"
# 	not_if "test -e /opt/elasticsearch"
# end

# execute "start Elasticsearch 5.1.1 by background" do
# 	user elastic_user
# 	command "/opt/elasticsearch/bin/elasticsearch -d -p pid"
# end

service "elasticsearch" do
  action [:start, :restart]
end