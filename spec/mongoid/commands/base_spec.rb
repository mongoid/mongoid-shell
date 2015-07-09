require 'spec_helper'

describe Mongoid::Shell::Commands::Base do
  include MongoidSessionHelper

  context 'without a default session' do
    before :each do
      default_function = ::Mongoid::Compatibility::Version.mongoid3? || ::Mongoid::Compatibility::Version.mongoid4? ? :default_session : :default_client
      allow(Mongoid).to receive(default_function).and_return(nil)
    end
    it 'raises an exception when a session is missing' do
      expect do
        Mongoid::Shell::Commands::Base.new({})
      end.to raise_error Mongoid::Shell::Errors::MissingSessionError, /Missing session./
    end
    it 'raises an exception when options are missing' do
      expect do
        Mongoid::Shell::Commands::Base.new(nil)
      end.to raise_error Mongoid::Shell::Errors::MissingSessionError, /Missing session./
    end
  end
  if ::Mongoid::Compatibility::Version.mongoid5?
    it 'creates a command using the default session' do
      command = Mongoid::Shell::Commands::Base.new
      expect(command.session).to eq Mongoid.default_client
    end
  else
    it 'creates a command using the default session' do
      command = Mongoid::Shell::Commands::Base.new
      expect(command.session).to eq Mongoid.default_session
    end
  end
  it 'creates a command using the session provided' do
    command = Mongoid::Shell::Commands::Base.new(session: default_client_or_session)
    expect(command.session).to eq default_client_or_session
  end
  it 'command_for' do
    command = Mongoid::Shell::Commands::Base.command_for(default_client_or_session)
    expect(command.session).to eq default_client_or_session
  end
end
