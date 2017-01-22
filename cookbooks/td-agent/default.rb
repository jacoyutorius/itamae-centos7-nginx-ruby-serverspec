#
#  cookbook - fluentd
#   install & defaylt setting for fluentd
# 
#   2016.12.24
#

git "/root/uptime" do
  repository "https://gist.github.com/jacoyutorius/f71f1ec420fca478b792be254afc5b09"
end

execute "install td-agent" do
	user "root"
	cwd "/root"
	command "curl -L http://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh"
end

execute "install elasticsearch-plugin" do
	user "root"
	cwd "/root"
	command "td-agent-gem install fluent-plugin-elasticsearch"
end

template "/etc/td-agent/td-agent.conf" do
  user "root"
  group "root"
  source "./templates/etc/td-agent/td-agent.conf.erb"
end

# 実行ユーザーをrootに変更
execute "Elasticsearch config" do
  user "root"
  cwd "/root"
  command "sed -i -e 's/TD_AGENT_USER=td-agent/TD_AGENT_USER=root/g' /opt/td-agent/etc/init.d/td-agent;sed -i -e 's/TD_AGENT_GROUP=td-agent/TD_AGENT_GROUP=root/g' /opt/td-agent/etc/init.d/td-agent;sed -i -e 's/TD_AGENT_USER=td-agent/TD_AGENT_USER=root/g' /etc/init.d/td-agent;sed -i -e 's/TD_AGENT_GROUP=td-agent/TD_AGENT_GROUP=root/g' /etc/init.d/td-agent"
end

service "td-agent" do
  action [:start, :restart]
end