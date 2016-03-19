# http://qiita.com/michiomochi@github/items/1a3cd07497550bc4d5c2
execute "add repo" do
	user "root"
	cwd "/"
	# command "curl -L http://toolbelt.treasure-data.com/sh/install-redhat.sh | sh"
  command "curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh"
end

template "/etc/td-agent/td-agent.conf" do
  user "root"
  group "root"
  source "./templates/etc/td-agent/td-agent.conf.erb"
end

execute "install elasticsearch plugin" do
	user "root"
	command "td-agent-gem install fluent-plugin-elasticsearch"
end

# /etc/init.d/td-agentのTD_AGENT_USERとTD_AGENT_GROUPをrootに変更する必要あり
#  http://kenzo0107.hatenablog.com/entry/2015/08/21/011624
execute "change daemon execute user" do
	user "root"
	cwd "/etc/init.d"
	command 'sed -i -e "s/td-agent/root/g" td-agent'
end

service "td-agent" do
  action [:enable, :start]
end

# CentOS7ではservice ではなく、systemctl
execute "restart service" do
	user "root"
	command "systemctl daemon-reload"
end
