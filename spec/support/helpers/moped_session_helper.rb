# frozen_string_literal: true

module MopedSessionHelper
  # returns a Moped session with stubbed address resolution
  if ::Mongoid::Compatibility::Version.mongoid3?
    def moped_session(name)
      allow_any_instance_of(Moped::Node).to receive(:resolve_address).and_return(false)
      config = File.join(File.dirname(__FILE__), '../../support/config/mongoid34.yml')
      Mongoid.load! config, :production
      session = Mongoid::Sessions.with_name(name)
      allow(session.cluster.nodes.last).to receive(:primary?).and_return(true)
      session
    end
  elsif ::Mongoid::Compatibility::Version.mongoid4?
    def moped_session(name)
      allow_any_instance_of(Moped::Address).to receive(:resolve).and_return(true)
      config = File.join(File.dirname(__FILE__), '../../support/config/mongoid34.yml')
      Mongoid.load! config, :production
      session = Mongoid::Sessions.with_name(name)
      allow(session.cluster.nodes.last).to receive(:primary?).and_return(true)
      session
    end
  else
    def moped_session(name)
      socket = Mongo::Socket::TCP.new('127.0.0.1', 27_017, 30, Socket::PF_INET)
      allow_any_instance_of(Mongo::Address).to receive(:socket).and_return(socket)
      config = File.join(File.dirname(__FILE__), '../../support/config/mongoid5.yml')
      Mongoid.load! config, :production
      session = Mongoid::Clients.with_name(name)
      allow(session.cluster).to receive(:servers).and_return(session.cluster.instance_variable_get(:@servers))
      server = session.cluster.servers.first
      allow(server).to receive(:primary?).and_return(true)
      session
    end
  end
end
