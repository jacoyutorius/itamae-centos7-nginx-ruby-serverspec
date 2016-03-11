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
