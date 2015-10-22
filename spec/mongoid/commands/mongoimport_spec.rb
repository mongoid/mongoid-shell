require 'spec_helper'

describe Mongoid::Shell::Commands::Mongoimport do
  include MopedSessionHelper
  context 'local' do
    it 'defaults to local' do
      expect(Mongoid::Shell::Commands::Mongoimport.new.to_s).to eq 'mongoimport --db mongoid_shell_tests'
    end
    it 'includes collection' do
      expect(Mongoid::Shell::Commands::Mongoimport.new(
        collection: 'tests',
        file: 'tests.json'
      ).to_s).to eq 'mongoimport --db mongoid_shell_tests --collection tests --file tests.json'
    end
    it 'can override the database, username, password and host' do
      expect(Mongoid::Shell::Commands::Mongoimport.new(
        host: 'my_host',
        username: 'my_username',
        password: 'my_password',
        db: 'my_db',
        collection: 'tests',
        file: 'tests.json'
      ).to_s).to eq 'mongoimport --db my_db --host my_host --username my_username --password my_password --collection tests --file tests.json'
    end
    [:version, :host, :port, :fields].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongoimport.new(
          option => 'var arg'
        ).to_s).to eq "mongoimport --db mongoid_shell_tests --#{option} \"var arg\""
      end
    end
    [:verbose, :quiet, :ignoreBlanks, :drop, :stopOnError].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongoimport.new(
          option => true
        ).to_s).to eq "mongoimport --db mongoid_shell_tests --#{option}"
      end
    end
  end

  context 'sessions' do
    context 'default' do
      before :each do
        @session = moped_session(:default)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongoimport.new(
          session: @session
        ).to_s).to eq 'mongoimport --db mongoid_shell_tests'
      end
    end
    context 'a replica set' do
      before :each do
        @session = moped_session(:replica_set)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongoimport.new(
          session: @session
        ).to_s).to eq 'mongoimport --db mongoid --host dedicated1.myapp.com:27017 --username user --password password'
      end
    end
    context 'url' do
      before :each do
        @session = moped_session(:url)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongoimport.new(
          session: @session
        ).to_s).to eq 'mongoimport --db mongoid --host 59.1.22.1:27017 --username user --password password'
      end
    end
  end
end
