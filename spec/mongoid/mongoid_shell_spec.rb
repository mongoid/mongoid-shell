require 'spec_helper'

describe Mongoid::Shell do
  it "has a version" do
    expect(Mongoid::Shell::VERSION).to_not be nil
  end
end
