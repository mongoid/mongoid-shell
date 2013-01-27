require 'spec_helper'

describe Mongoid::Shell::Commands::Mongodump do
  context "default session" do
    it "defaults to local" do
      Mongoid::Shell::Commands::Mongodump.new.to_s.should == "mongodump --host localhost:27017 --db mongoid_shell_tests"
    end
    it "includes collection" do
      Mongoid::Shell::Commands::Mongodump.new({ 
        collection: 'test'
      }).to_s.should == "mongodump --host localhost:27017 --db mongoid_shell_tests --collection test"
    end
    it "includes query" do
      Mongoid::Shell::Commands::Mongodump.new({ 
        query: 'find x' 
      }).to_s.should == 'mongodump --host localhost:27017 --db mongoid_shell_tests --query "find x"'
    end
  end
end
