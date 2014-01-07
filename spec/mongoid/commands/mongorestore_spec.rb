require 'spec_helper'

describe Mongoid::Shell::Commands::Mongorestore do
  include MopedSessionHelper
  context "local" do
    it "defaults to local" do
      Mongoid::Shell::Commands::Mongorestore.new.to_s.should == "mongorestore --db mongoid_shell_tests"
    end
    it "includes collection" do
      Mongoid::Shell::Commands::Mongorestore.new(
        collection: 'test',
        restore: 'folder'
      ).to_s.should == "mongorestore --db mongoid_shell_tests --collection test folder"
    end
    it "can override the database, username, password and host" do
      Mongoid::Shell::Commands::Mongorestore.new(
        host: 'my_host',
        username: 'my_username',
        password: 'my_password',
        collection: 'test',
        db: 'my_db',
        restore: 'folder'
      ).to_s.should == "mongorestore --host my_host --db my_db --username my_username --password my_password --collection test folder"
    end
    [:collection, :dbpath, :filter].each do |option|
      it "includes #{option}" do
        Mongoid::Shell::Commands::Mongorestore.new(
          option => 'var arg',
          restore: 'a folder'
        ).to_s.should == "mongorestore --db mongoid_shell_tests --#{option} \"var arg\" \"a folder\""
      end
    end
    [:ipv6, :directoryperdb, :journal, :objcheck, :drop, :oplogReplay, :keepIndexVersion, :noIndexRestore].each do |option|
      it "includes #{option}" do
        Mongoid::Shell::Commands::Mongorestore.new(
          option => true
        ).to_s.should == "mongorestore --db mongoid_shell_tests --#{option}"
      end
    end
  end
  context "sessions" do
    context "default" do
      before :each do
        @session = moped_session(:default)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: "a folder"
        ).to_s.should == "mongorestore --db mongoid_shell_tests \"a folder\""
      end
    end
    context "a replica set" do
      before :each do
        @session = moped_session(:replica_set)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: "a folder"
        ).to_s.should == "mongorestore --host dedicated1.myapp.com:27017 --db mongoid --username user --password password \"a folder\""
      end
    end
    context "single host" do
      before :each do
        @session = moped_session(:single_host)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: "a folder"
        ).to_s.should == "mongorestore --host something.mongohq.com:27017 --db mongoid --username user --password password \"a folder\""
      end
    end
    context "url" do
      before :each do
        @session = moped_session(:url)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: "a folder"
        ).to_s.should == "mongorestore --host 59.1.22.1:27017 --db mongoid --username user --password password \"a folder\""
      end
    end
  end
  context "without a primary" do
    before :each do
      @session = moped_session(:replica_set)
      @session.cluster.nodes.each do |node|
        node.stub(:primary?).and_return(false)
      end
    end
    it "requires a primary" do
      expect {
        Mongoid::Shell::Commands::Mongorestore.new(
          session: @session
        ).to_s
      }.to raise_error Mongoid::Shell::Errors::MissingPrimaryNodeError, /Session does not have a primary node./
    end
  end
end
