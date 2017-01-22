include_recipe "../cookbooks/default"

# install nginx
include_recipe "../cookbooks/nginx/default"

# install ruby
include_recipe "../cookbooks/ruby/default"

# install elasticsearch
include_recipe "../cookbooks/elasticsearch"

# install td-agent
include_recipe "../cookbooks/td-agent/default"

# install kibana
include_recipe "../cookbooks/kibana"

