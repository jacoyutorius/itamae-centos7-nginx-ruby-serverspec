## itamae-env-rails4-nginx-scientific6.5

ScientificLinux6.5 + Nginx + Rails4


### Role

ScientificLinux6.5上でRails4の動くVMを作る。


* ScientificLinux6.5
* Ruby(rbenv)
* Unicorn
* Nginx


### Usage

```
vagrant up
vagrant ssh-config >> ~/.ssh/config
bundle install --path .bundle
bundle exec itamae ssh  --vagrant --host makinami cookbooks/default.rb
```

### Vagrant

```
bundle exec itamae ssh --vargrant --host makinami roles/rails_app.rb -y node.yml
```

### EC2

```
bundle exec itamae ssh -i aws_key_pair.pem --host your_ec2 cookbooks/application.rb -y node.yml
```


bash_profileへ追記

```
# rbenv setting
export RBENV_ROOT=/usr/local/rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init -)"
```


unicorn.rb

```
@path = "/var/www/html/<%= @app_name %>/"

worker_processes 1
working_directory @path
timeout 300
listen "/tmp/<%= @app_name %>.sock"
pid "#{@path}tmp/pids/unicorn.pid"
stderr_path "#{@path}log/unicorn.stderr.log"
stdout_path "#{@path}log/unicorn.stdout.log"
preload_app true
```

unicornをデーモンとして起動。

```
bundle exec unicorn -c unicorn.rb -D
```
