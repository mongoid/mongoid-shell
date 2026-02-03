# frozen_string_literal: true

require 'spec_helper'

describe Mongoid::Shell::Properties::Primary do
  subject do
    klass = Class.new do
      include Mongoid::Shell::Properties::Primary
      include MongoidSessionHelper

      def session
        default_client_or_session
      end
    end
    klass.new
  end

  it 'raises an exception when the session is not connected' do
    if Mongoid::Compatibility::Version.mongoid3? || Mongoid::Compatibility::Version.mongoid4?
      allow(Mongoid.default_session.cluster.nodes.first).to receive(:primary?).and_return(false)
    else
      server = Mongoid.default_client.cluster.servers.first
      allow(server).to receive(:primary?).and_return(false)
      allow(server).to receive(:standalone?).and_return(false)
    end
    expect do
      subject.primary
    end.to raise_error Mongoid::Shell::Errors::MissingPrimaryNodeError, /Session does not have a primary node./
  end
end
