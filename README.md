# Vagrant+CentOS7+Nginx+Itamae+Serverspec

## Setup

```
git clone
cd this-repo
bundle install
vagrant up
bundle exec itamae ssh --vagrant --host makinami roles/application.rb -y node.yml
ASK_SUDO_PASSWORD=1 rake spec
```


## Install apps

* ruby
* rails
* nginx
* grafana

## 2017.1.9

```
# boxを更新
#  https://atlas.hashicorp.com/centos/boxes/7
vagrant box add centos/7 centos/7
```