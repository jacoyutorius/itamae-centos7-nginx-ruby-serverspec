
package "java-1.8.0-openjdk.x86_64" do
  action :install
end

# https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html
template "/etc/yum.repos.d/elasticsearch.repo" do
  user "root"
  group "root"
  source "./templates/etc/yum.repos.d/elasticsearch.repo.erb"
  not_if "test -e /etc/yum.repos.d/elasticsearch.repo"
end

package "elasticsearch" do
  action :install
end

# kuromoji
# https://www.elastic.co/guide/en/elasticsearch/plugins/2.0/analysis-kuromoji.html
execute "install analysis-kuromoji" do
	user "root"
	cwd "/usr/share/elasticsearch"
	command "bin/plugin install analysis-kuromoji"
  not_if "test -e /usr/share/elasticsearch/plugins/analysis-kuromoji"
end


# http://qiita.com/yuku_t/items/cc3895a375aedd6c05c5
# Inquisitor
execute "install elasticsearch-inquisitor" do
	user "root"
	cwd "/usr/share/elasticsearch"
	command "bin/plugin install polyfractal/elasticsearch-inquisitor"
  not_if "test -e /usr/share/elasticsearch/plugins/elasticsearch-inquisitor"
end

# HQ
execute "install elasticsearch-HQ" do
	user "root"
	cwd "/usr/share/elasticsearch"
	command "bin/plugin install royrusso/elasticsearch-HQ"
  not_if "test -e /usr/share/elasticsearch/plugins/hq"
end

template "/etc/elasticsearch/elasticsearch.yml" do
  user "root"
  group "root"
  source "./templates/etc/elasticsearch.yml.erb"
end

# user,groupをelasticsearchにしないとサービス起動でエラーになる
execute "change owner to elasticsearch" do
	user "root"
	cwd "/etc/"
	command "chown -R elasticsearch elasticsearch;chgrp -R elasticsearch elasticsearch"
end

service "elasticsearch" do
  action [:enable, :start]
end

# [TODO]
# sudo /bin/systemctl daemon-reload
# sudo /bin/systemctl enable elasticsearch.service
