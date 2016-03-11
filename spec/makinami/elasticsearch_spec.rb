require 'spec_helper'

describe command("java -version") do
  its(:stdout){ should match /openjdk version \"1.8.0_71\"/ }
end

describe package('elasticsearch'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('elasticsearch'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(9200) do
  it { should be_listening }
end
