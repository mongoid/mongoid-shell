require 'spec_helper'

describe Mongoid::Shell::Commands::Base do
  context "without a default session" do
    before :each do
      if Mongoid::Shell.mongoid2?
        Mongoid.stub(:master).and_return(nil)
      else
        Mongoid.stub(:default_session).and_return(nil)
      end
    end
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
  it "creates a command using the default session" do
    command = Mongoid::Shell::Commands::Base.new
    if Mongoid::Shell.mongoid2?
      command.session.should eq Mongoid.master
    else
      command.session.should eq Mongoid.default_session
    end
  end
  it "creates a command using the session provided" do
    if Mongoid::Shell.mongoid2?
      session = Mongo::Connection.new.db
    else
      session = Moped::Session.new(["127.0.0.1:27017"])
    end
    command = Mongoid::Shell::Commands::Base.new(session: session)
    command.session.should eq session
  end
  it "command_for" do
    if Mongoid::Shell.mongoid2?
      session = Mongoid.master
    else
      session = Mongoid.default_session
    end
    command = Mongoid::Shell::Commands::Base.command_for(session)
    if Mongoid::Shell.mongoid2?
      command.session.should eq Mongoid.master
    else
      command.session.should eq Mongoid.default_session
    end
  end
end
