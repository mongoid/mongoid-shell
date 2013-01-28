require 'spec_helper'

describe Mongoid::Shell::Commands::Mongostat do
  include MopedSessionHelper
  context "local" do
    it "defaults to local" do
      Mongoid::Shell::Commands::Mongostat.new.to_s.should == "mongostat"
    end
    it "rowcount" do
      Mongoid::Shell::Commands::Mongostat.new({
        :rowcount => 10
      }).to_s.should == "mongostat --rowcount 10"
    end
    [ :http, :discover, :all, :noheaders ].each do |option|
      it "includes #{option}" do
        Mongoid::Shell::Commands::Mongostat.new({
          option => true
        }).to_s.should == "mongostat --#{option}"
      end
    end
  end
  context "sessions" do
    context "default" do
      before :each do
        @session = Mongoid::Sessions.with_name(:default)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongostat.new({
          session: @session
        }).to_s.should == "mongostat"
      end
    end
    context "a replica set" do
      before :each do
        @session = moped_session(:replica_set)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongostat.new({
          session: @session
        }).to_s.should == "mongostat --host dedicated1.myapp.com:27017 --username user --password password"
      end
    end
    context "url" do
      before :each do
        @session = moped_session(:url)
      end
      it "includes username and password" do
        Mongoid::Shell::Commands::Mongostat.new({
          session: @session
        }).to_s.should == "mongostat --host 59.1.22.1:27017 --username user --password password"
      end
    end
  end
end
