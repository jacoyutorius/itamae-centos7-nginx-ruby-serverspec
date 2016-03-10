require 'spec_helper'

describe command("/usr/local/rbenv/bin/rbenv -v") do
  its(:stdout){ should match /rbenv 1.0.0/ }
end

describe command("/usr/local/rbenv/shims/ruby -v") do
  its(:stdout){ should match /ruby 2.2.0/ }
end
