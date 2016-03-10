%w(sqlite sqlite-devel mysql-server mysql-devel).each do |pkg|
  package pkg do
    action :install
  end
end

# install node.js instead of therubyracer
package "nodejs" do
	action :install
	options "--enablerepo=epel"
end

package "npm" do
	action :install
	options "--enablerepo=epel"
end
