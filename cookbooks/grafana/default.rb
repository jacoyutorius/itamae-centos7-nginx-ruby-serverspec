
# http://docs.grafana.org/installation/rpm/#install-via-yum-repository
template "/etc/yum.repos.d/grafana.repo" do
  user "root"
  group "root"
  source "./templates/etc/yum.repos.d/grafana.repo.erb"
end

package "grafana" do
  action :install
end

# http://blog.serverworks.co.jp/tech/2016/03/11/play-with-grafana-1/
# [TODO] レシピ実行後何故かgragana.iniの所有者がvagrantになっていた。後ほど対策する
template "/etc/grafana/grafana.ini" do
  user "root"
  group "root"
  source "./templates/etc/grafana/grafana.ini"
end

service "grafana-server" do
  action [:enable, :start]
end
