# frozen_string_literal: true

require 'spec_helper'

describe Mongoid::Shell::Commands::Base do
  include MongoidSessionHelper

  context 'without a default session' do
    before do
      default_function = Mongoid::Compatibility::Version.mongoid5_or_newer? ? :default_client : :default_session
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

  if Mongoid::Compatibility::Version.mongoid5_or_newer?
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

  context 'with custom argument definitions' do
    let(:command_class) do
      Class.new(described_class) do
        def destination
          'archive'
        end

        option :quiet
        arg :destination
      end
    end

    it 'preserves an existing property reader when registering an argument' do
      expect(command_class.new.destination).to eq 'archive'
    end

    it 'renders positional arguments without an option key' do
      expect(command_class.new(quiet: true).vargs).to eq %w[--quiet archive]
    end

    it 'does not leak argument definitions to the base class' do
      original_args = described_class.args
      command_class
      expect(described_class.args).to eq(original_args)
    end
  end
end
