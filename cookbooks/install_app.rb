directory "/var/www/html" do
  mode "775"
  owner "root"
  group "root"
end

git "/var/www/html/redbull" do
	repository "https://github.com/jacoyutorius/redbull_framework.git"
end

execute "install gems" do
	user "root"
	cwd "/var/www/html/redbull"
	command "/usr/local/rbenv/shims/bundle install"
end

remote_file "/etc/nginx/nginx.conf" do
  source "remote_files/nginx/nginx.conf"
end

remote_file "/var/www/html/redbull/unicorn.rb" do
  source "remote_files/unicorn/unicorn.rb"
end

directory "/var/www/html/redbull/tmp/pids" do
  owner "root"
end

directory "/var/www/html/redbull/log" do
  owner "root"
end

execute "install unicorn" do
  user "root"
  cwd "/var/www/html/redbull"
  command "/usr/local/rbenv/shims/gem install unicorn"
end

execute "start unicorn" do
  user "root"
  cwd "/var/www/html/redbull"
  command "unicorn -E production -c unicorn.rb -D"
end


service "nginx" do
  action :start
end

# execute "rackup" do
# 	user "root"
# 	cwd "/var/www/html/redbull"
# 	command "/usr/local/rbenv/shims/bundle exec rackup"
# end
