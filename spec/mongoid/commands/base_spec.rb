require 'spec_helper'

describe Mongoid::Shell::Commands::Base do
  context "without a default session" do
    before :each do
      allow(Mongoid).to receive(:default_session).and_return(nil)
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
    expect(command.session).to eq Mongoid.default_session
  end
  it "creates a command using the session provided" do
    session = Moped::Session.new(["127.0.0.1:27017"])
    command = Mongoid::Shell::Commands::Base.new(session: session)
    expect(command.session).to eq session
  end
  it "command_for" do
    command = Mongoid::Shell::Commands::Base.command_for(Mongoid.default_session)
    expect(command.session).to eq Mongoid.default_session
  end
end
