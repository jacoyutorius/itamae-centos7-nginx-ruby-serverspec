require 'spec_helper'

describe service('td-agent'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end
