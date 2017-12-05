require 'spec_helper'

describe Mongoid::Shell::Commands::Mongodump do
  include MopedSessionHelper
  context 'local' do
    it 'defaults to local' do
      expect(Mongoid::Shell::Commands::Mongodump.new.to_s).to eq 'mongodump --db mongoid_shell_tests'
    end
    it 'includes collection' do
      expect(Mongoid::Shell::Commands::Mongodump.new(
        collection: 'test'
      ).to_s).to eq 'mongodump --db mongoid_shell_tests --collection test'
    end
    it 'includes excludeCollection' do
      expect(Mongoid::Shell::Commands::Mongodump.new(
        excludeCollection: %w(test1 test2)
      ).to_s).to eq 'mongodump --db mongoid_shell_tests --excludeCollection test1 --excludeCollection test2'
    end
    it 'includes excludeCollectionsWithPrefix' do
      expect(Mongoid::Shell::Commands::Mongodump.new(
        excludeCollectionsWithPrefix: %w(system local)
      ).to_s).to eq 'mongodump --db mongoid_shell_tests --excludeCollectionsWithPrefix system --excludeCollectionsWithPrefix local'
    end
    it 'includes query' do
      expect(Mongoid::Shell::Commands::Mongodump.new(
        query: 'find x'
      ).to_s).to eq 'mongodump --db mongoid_shell_tests --query "find x"'
    end
    [:out, :dbpath].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongodump.new(
          option => '/this is a folder'
        ).to_s).to eq "mongodump --db mongoid_shell_tests --#{option} \"/this is a folder\""
      end
    end
    [:directoryperdb, :journal, :oplog, :repair, :forceTableScan, :dbpath, :ipv6].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongodump.new(
          option => true
        ).to_s).to eq "mongodump --db mongoid_shell_tests --#{option}"
      end
    end
  end
  context 'sessions' do
    context 'default' do
      before :each do
        @session = moped_session(:default)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongodump.new(
          session: @session
        ).to_s).to eq 'mongodump --db mongoid_shell_tests'
      end
      it 'includes ssl and authenticationDatabase' do
        expect(Mongoid::Shell::Commands::Mongodump.new(
          ssl: true,
          authenticationDatabase: 'admin'
        ).to_s).to eq 'mongodump --db mongoid_shell_tests --ssl --authenticationDatabase admin'
      end
    end
    context 'a replica set' do
      before :each do
        @session = moped_session(:replica_set)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongodump.new(
          session: @session
        ).to_s).to eq 'mongodump --host dedicated1.myapp.com:27017 --db mongoid --username user --password password'
      end
    end
    context 'url' do
      before :each do
        @session = moped_session(:url)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongodump.new(
          session: @session
        ).to_s).to eq 'mongodump --host 59.1.22.1:27017 --db mongoid --username user --password password'
      end
    end
  end
end
