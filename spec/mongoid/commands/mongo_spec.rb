require 'spec_helper'

describe Mongoid::Shell::Commands::Mongo do
  include MopedSessionHelper
  context 'local' do
    it 'defaults to local' do
      expect(Mongoid::Shell::Commands::Mongo.new.to_s).to eq 'mongo mongoid_shell_tests'
    end
    it 'includes eval' do
      expect(Mongoid::Shell::Commands::Mongo.new(
        eval: 'find x'
      ).to_s).to eq 'mongo mongoid_shell_tests --eval "find x"'
    end
    it 'overrides primary' do
      expect(Mongoid::Shell::Commands::Mongo.new(
        eval: 'find x',
        primary: 'my_primary'
      ).to_s).to eq 'mongo my_primary/mongoid_shell_tests --eval "find x"'
    end
    [:nodb, :norc, :quiet, :ipv6].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongo.new(
          option => true
        ).to_s).to eq "mongo mongoid_shell_tests --#{option}"
      end
    end
  end
  context 'sessions' do
    context 'default' do
      before :each do
        @session = if ::Mongoid::Compatibility::Version.mongoid3? || ::Mongoid::Compatibility::Version.mongoid4?
                     Mongoid::Sessions.with_name(:default)
                   else
                     Mongoid::Clients.with_name(:default)
                   end
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongo.new(
          session: @session
        ).to_s).to eq 'mongo mongoid_shell_tests'
      end
      it 'includes ssl and authenticationDatabase' do
        expect(Mongoid::Shell::Commands::Mongo.new(
          ssl: true,
          authenticationDatabase: 'admin'
        ).to_s).to eq 'mongo mongoid_shell_tests --ssl --authenticationDatabase admin'
      end
    end
    context 'a replica set' do
      before :each do
        @session = moped_session(:replica_set)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongo.new(
          session: @session
        ).to_s).to eq 'mongo dedicated1.myapp.com:27017/mongoid --username user --password password'
      end
    end
    context 'url' do
      before :each do
        @session = moped_session(:url)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongo.new(
          session: @session
        ).to_s).to eq 'mongo 59.1.22.1:27017/mongoid --username user --password password'
      end
    end
  end
end
