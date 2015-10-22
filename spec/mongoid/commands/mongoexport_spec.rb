require 'spec_helper'

describe Mongoid::Shell::Commands::Mongoexport do
  include MopedSessionHelper
  context 'local' do
    it 'defaults to local' do
      expect(Mongoid::Shell::Commands::Mongoexport.new.to_s).to eq 'mongoexport --db mongoid_shell_tests'
    end
    it 'includes collection' do
      expect(Mongoid::Shell::Commands::Mongoexport.new(
        collection: 'tests',
        out: 'tests.json'
      ).to_s).to eq 'mongoexport --db mongoid_shell_tests --collection tests --out tests.json'
    end
    it 'can override the database, username, password and host' do
      expect(Mongoid::Shell::Commands::Mongoexport.new(
        host: 'my_host',
        username: 'my_username',
        password: 'my_password',
        db: 'my_db',
        collection: 'tests',
        out: 'tests.json'
      ).to_s).to eq 'mongoexport --db my_db --host my_host --username my_username --password my_password --collection tests --out tests.json'
    end
    [:host, :port, :sslCAFile, :sslPEMKeyFile, :sslPEMKeyPassword,
     :sslCRLFile, :sslAllowInvalidCertificates, :out, :query, :limit].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongoexport.new(
          option => 'var arg'
        ).to_s).to eq "mongoexport --db mongoid_shell_tests --#{option} \"var arg\""
      end
    end
    [:verbose, :quiet, :ipv6, :ssl, :sslAllowInvalidCertificates].each do |option|
      it "includes #{option}" do
        expect(Mongoid::Shell::Commands::Mongoexport.new(
          option => true
        ).to_s).to eq "mongoexport --db mongoid_shell_tests --#{option}"
      end
    end
  end

  context 'sessions' do
    context 'default' do
      before :each do
        @session = moped_session(:default)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongoexport.new(
          session: @session
        ).to_s).to eq 'mongoexport --db mongoid_shell_tests'
      end
    end
    context 'a replica set' do
      before :each do
        @session = moped_session(:replica_set)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongoexport.new(
          session: @session
        ).to_s).to eq 'mongoexport --db mongoid --host dedicated1.myapp.com:27017 --username user --password password'
      end
    end
    context 'url' do
      before :each do
        @session = moped_session(:url)
      end
      it 'includes username and password' do
        expect(Mongoid::Shell::Commands::Mongoexport.new(
          session: @session
        ).to_s).to eq 'mongoexport --db mongoid --host 59.1.22.1:27017 --username user --password password'
      end
    end
  end
end
