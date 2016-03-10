app_name = "shiz_hama_con"
app_repo = "https://github.com/jacoyutorius/shiz_hama_con.git"


directory "/var/www/html" do
  mode "775"
  owner "root"
  group "root"
end

git "/var/www/html/#{app_name}" do
	repository app_repo
end

execute "install gems" do
	user "root"
	cwd "/var/www/html/#{app_name}"
	command "/usr/local/rbenv/shims/bundle install"
end

# remote_file "/etc/nginx/nginx.conf" do
#   source "remote_files/nginx/nginx.conf"
# end
template "/etc/nginx/nginx.conf" do
  source "templates/nginx/nginx.conf.erb"
  variables(app_name: app_name)
end

# remote_file "/var/www/html/#{app_name}/unicorn.rb" do
#   source "remote_files/unicorn/unicorn.rb"
# end
template "/var/www/html/#{app_name}/unicorn.rb" do
  source "templates/unicorn/unicorn.rb.erb"
  variables(app_name: app_name)
end

directory "/var/www/html/#{app_name}/tmp/pids" do
  owner "root"
end

directory "/var/www/html/#{app_name}/log" do
  owner "root"
end

execute "install unicorn" do
  user "root"
  cwd "/var/www/html/#{app_name}"
  command "/usr/local/rbenv/shims/gem install unicorn"
end

execute "start unicorn" do
  user "root"
  cwd "/var/www/html/#{app_name}"
  command "/usr/local/rbenv/shims/bundle exec unicorn -E production -c unicorn.rb -D"
end


service "nginx" do
  action :start
end

# execute "rackup" do
# 	user "root"
# 	cwd "/var/www/html/redbull"
# 	command "/usr/local/rbenv/shims/bundle exec rackup"
# end
