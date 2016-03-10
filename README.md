# Vagrant+CentOS7+Nginx+Itamae+Serverspec

## Setup

```
git clone
cd this-repo
bundle install
vagrant up
bundle exec itamae ssh --vargrant --host makinami roles/rails_app.rb -y node.yml
ASK_SUDO_PASSWORD=1 rake spec
```
