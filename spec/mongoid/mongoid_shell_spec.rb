require 'spec_helper'

describe Mongoid::Shell do
  it "has a version" do
    Mongoid::Shell::VERSION.should_not be_nil
  end
end

