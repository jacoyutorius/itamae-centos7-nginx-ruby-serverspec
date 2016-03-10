%w(epel-release gcc gcc-c++).each do |pkg|
	package pkg do
    action :install
  end
end

%w(git vim openssl-devel readline-devel zlib-devel libcurl-devel).each do |pkg|
  package pkg do
    action :install
  end
end

# use itamae-plugin-rbenv gem
include_recipe "rbenv::system"

[
  'export RBENV_ROOT=/usr/local/rbenv',
  'export PATH="${RBENV_ROOT}/bin:${PATH}"',
  'eval "$(rbenv init -)"'
].each do |command|
  execute "set bash" do
    user "root"
    command "echo '#{command}' >> ~/.bashrc"
  end
end
