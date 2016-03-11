require 'spec_helper'

describe package('grafana'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('grafana-server'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
end
