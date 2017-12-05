require 'spec_helper'

describe Mongoid::Shell::Commands::Mongorestore do
  include MopedSessionHelper
  context 'local' do
    it 'defaults to local' do
      expect(Mongoid::Shell::Commands::Mongorestore.new.to_s).to eq 'mongorestore --db mongoid_shell_tests'
    end
    it 'includes collection' do
      expect(Mongoid::Shell::Commands::Mongorestore.new(
        collection: 'test',
        restore: 'folder'
      ).to_s).to eq 'mongorestore --db mongoid_shell_tests --collection test folder'
    end
    it 'can override the database, username, password and host' do
      expect(Mongoid::Shell::Commands::Mongorestore.new(
        host: 'my_host',
        username: 'my_username',
        password: 'my_password',
        collection: 'test',
        db: 'my_db',
        restore: 'folder'
      ).to_s).to eq 'mongorestore --host my_host --db my_db --username my_username --password my_password --collection test folder'
    end
    [:collection, :dbpath, :filter].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          option => 'var arg',
          restore: 'a folder'
        ).to_s).to eq "mongorestore --db mongoid_shell_tests --#{option} \"var arg\" \"a folder\""
      end
    end
    [:ipv6, :directoryperdb, :journal, :objcheck, :drop, :oplogReplay, :keepIndexVersion, :noIndexRestore].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          option => true
        ).to_s).to eq "mongorestore --db mongoid_shell_tests --#{option}"
      end
    end
  end
  context 'sessions' do
    context 'default' do
      before :each do
        @session = moped_session(:default)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: 'a folder'
        ).to_s).to eq 'mongorestore --db mongoid_shell_tests "a folder"'
      end
      it 'includes ssl and authenticationDatabase' do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          ssl: true,
          authenticationDatabase: 'admin'
        ).to_s).to eq 'mongorestore --db mongoid_shell_tests --ssl --authenticationDatabase admin'
      end
    end
    context 'a replica set' do
      before :each do
        @session = moped_session(:replica_set)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: 'a folder'
        ).to_s).to eq 'mongorestore --host dedicated1.myapp.com:27017 --db mongoid --username user --password password "a folder"'
      end
    end
    context 'single host' do
      before :each do
        @session = moped_session(:single_host)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: 'a folder'
        ).to_s).to eq 'mongorestore --host something.mongohq.com:27017 --db mongoid --username user --password password "a folder"'
      end
    end
    context 'url' do
      before :each do
        @session = moped_session(:url)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongorestore.new(
          session: @session,
          restore: 'a folder'
        ).to_s).to eq 'mongorestore --host 59.1.22.1:27017 --db mongoid --username user --password password "a folder"'
      end
    end
  end
  context 'without a primary' do
    before :each do
      @session = moped_session(:replica_set)
      if ::Mongoid::Compatibility::Version.mongoid3? || ::Mongoid::Compatibility::Version.mongoid4?
        @session.cluster.nodes.each do |node|
          allow(node).to receive(:primary?).and_return(false)
        end
      else
        @session.cluster.servers.each do |node|
          allow(node).to receive(:standalone?).and_return(false)
          allow(node).to receive(:primary?).and_return(false)
        end
      end
    end
    it 'requires a primary' do
      expect do
        Mongoid::Shell::Commands::Mongorestore.new(
          session: @session
        ).to_s
      end.to raise_error(Mongoid::Shell::Errors::MissingPrimaryNodeError, /Session does not have a primary node./)
    end
  end
end
