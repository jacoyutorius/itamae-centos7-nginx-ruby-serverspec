require 'spec_helper'

describe port(5601) do
  it { should be_listening }
end
