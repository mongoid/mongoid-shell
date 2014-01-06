require 'spec_helper'

describe Mongoid::Shell::Commands::Mongo do
  include MopedSessionHelper
  context "local" do
    it "defaults to local" do
      Mongoid::Shell::Commands::Mongo.new.to_s.should == "mongo mongoid_shell_tests"
    end
    it "includes eval" do
      Mongoid::Shell::Commands::Mongo.new(
        eval: 'find x'
      ).to_s.should == 'mongo mongoid_shell_tests --eval "find x"'
    end
    it "overrides primary" do
      Mongoid::Shell::Commands::Mongo.new(
        eval: 'find x',
        primary: 'my_primary'
      ).to_s.should == 'mongo my_primary/mongoid_shell_tests --eval "find x"'
    end
    [:nodb, :norc, :quiet, :ipv6].each do |option|
      it "includes #{option}" do
        Mongoid::Shell::Commands::Mongo.new(
          option => true
        ).to_s.should == "mongo mongoid_shell_tests --#{option}"
      end
    end

  end
  context "sessions" do
    context "default" do
      before :each do
        @session = Mongoid::Sessions.with_name(:default)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongo.new(
          session: @session
        ).to_s.should == "mongo mongoid_shell_tests"
      end
    end
    context "a replica set" do
      before :each do
        @session = moped_session(:replica_set)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongo.new(
          session: @session
        ).to_s.should == "mongo dedicated1.myapp.com:27017/mongoid --username user --password password"
      end
    end
    context "url" do
      before :each do
        @session = moped_session(:url)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongo.new(
          session: @session
        ).to_s.should == "mongo 59.1.22.1:27017/mongoid --username user --password password"
      end
    end
  end
end
