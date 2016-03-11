
package "java-1.8.0-openjdk.x86_64" do
  action :install
end

# https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html
template "/etc/yum.repos.d/elasticsearch.repo" do
  user "root"
  group "root"
  source "./templates/etc/yum.repos.d/elasticsearch.repo.erb"
end

package "elasticsearch" do
  action :install
end

# kuromoji
# https://www.elastic.co/guide/en/elasticsearch/plugins/2.0/analysis-kuromoji.html
execute "install gems" do
	user "root"
	cwd "/usr/share/elasticsearch"
	command "bin/plugin install analysis-kuromoji"
end


service "elasticsearch" do
  action [:enable, :start]
end
