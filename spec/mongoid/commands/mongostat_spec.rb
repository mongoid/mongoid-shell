require 'spec_helper'

describe Mongoid::Shell::Commands::Mongostat do
  include MopedSessionHelper
  context 'local' do
    it 'defaults to local' do
      expect(Mongoid::Shell::Commands::Mongostat.new.to_s).to eq 'mongostat'
    end
    it 'rowcount' do
      expect(Mongoid::Shell::Commands::Mongostat.new(
        rowcount: 10
      ).to_s).to eq 'mongostat --rowcount 10'
    end
    [:http, :discover, :all, :noheaders].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongostat.new(
          option => true
        ).to_s).to eq "mongostat --#{option}"
      end
    end
  end
  context 'sessions' do
    context 'default' do
      before :each do
        @session = moped_session(:default)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongostat.new(
          session: @session
        ).to_s).to eq 'mongostat'
      end
      it 'includes ssl and authenticationDatabase' do
        expect(Mongoid::Shell::Commands::Mongostat.new(
          ssl: true,
          authenticationDatabase: 'admin'
        ).to_s).to eq 'mongostat --ssl --authenticationDatabase admin'
      end
    end
    context 'a replica set' do
      before :each do
        @session = moped_session(:replica_set)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongostat.new(
          session: @session
        ).to_s).to eq 'mongostat --host dedicated1.myapp.com:27017 --username user --password password'
      end
    end
    context 'url' do
      before :each do
        @session = moped_session(:url)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongostat.new(
          session: @session
        ).to_s).to eq 'mongostat --host 59.1.22.1:27017 --username user --password password'
      end
    end
  end
end
