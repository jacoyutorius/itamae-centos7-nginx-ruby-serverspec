rbenv_path = "/usr/local/rbenv"
gem_path = "#{rbenv_path}/shims/gem" 

# use itamae-plugin-rbenv gem
include_recipe "rbenv::system"

[
  "export RBENV_ROOT=#{rbenv_path}",
  'export PATH="${RBENV_ROOT}/bin:${PATH}"',
  'eval "$(rbenv init -)"'
].each do |command|
  execute "set bash" do
    user "root"
    command "echo '#{command}' >> ~/.bashrc"
  end
end

execute "install rails" do
	user "root"
	command "#{gem_path} install rails --no-rdoc --no-ri"
end