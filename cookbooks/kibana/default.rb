kibana_url = "https://download.elastic.co/kibana/kibana"
kibana_file = "kibana-4.5.0-linux-x64"

commands = [
  "wget #{kibana_url}/#{kibana_file}.tar.gz",
  "tar -xzvf #{kibana_file}.tar.gz ",
  "mv #{kibana_file} kibana",
  "rm -f #{kibana_file}.tar.gz",
  "chown vagrant:vagrant -R /var/www/html/kibana"
].each do |command|
  execute "#{command}" do
    user "root"
  	cwd "/var/www/html"
    command command
  end
end

# fix "Kibana Unable to connect to elasticsearch at http://localhost:9200" error
# https://discuss.elastic.co/t/kibana-unable-to-connect-to-elasticsearch-at-http-localhost-9200/29865
template "/var/www/html/kibana/config/kibana.yml" do
  user "root"
  group "root"
  source "./templates/var/www/html/kibana/config/kibana.yml"
end

execute "launch kibana" do
  user "root"
  cwd "/var/www/htm/kibana"
  command "./bin/kibana > ./kibana.log &"
end
