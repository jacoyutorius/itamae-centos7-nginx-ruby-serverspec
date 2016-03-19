
commands = [
  "wget https://download.elastic.co/kibana/kibana/kibana-4.4.2-linux-x64.tar.gz",
  "tar -xzvf kibana-4.4.2-linux-x64.tar.gz",
  "mv kibana-4.4.2-linux-x64 kibana",
  "rm -f kibana-4.4.2-linux-x64.tar.gz",
  "chown vagrant:vagrant -R /var/www/html/kibana"
].each do |command|
  execute "#{command}" do
    user "root"
  	cwd "/var/www/html"
    command command
  end
end

execute "launch kibana" do
  user "root"
  cwd "/var/www/htm/kibana"
  command "./bin/kibana > ./kibana.log &"
end
