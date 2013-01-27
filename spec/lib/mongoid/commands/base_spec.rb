require 'spec_helper'

describe Mongoid::Shell::Commands::Base do
  it "raises an exception when a session is missing" do
    expect { 
      Mongoid::Shell::Commands::Base.new({})
    }.to raise_error Mongoid::Shell::Errors::MissingSessionError, /Missing session./
  end
  it "raises an exception when options are missing" do
    expect { 
      Mongoid::Shell::Commands::Base.new(nil)
    }.to raise_error Mongoid::Shell::Errors::MissingSessionError, /Missing session./
  end
end
