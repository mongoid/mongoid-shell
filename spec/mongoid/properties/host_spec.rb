require 'spec_helper'

describe Mongoid::Shell::Properties::Host do
  subject do
    klass = Class.new do
      include Mongoid::Shell::Properties::Host
      include MongoidSessionHelper

      def session
        default_client_or_session
      end
    end
    klass.new
  end
  it 'raises an exception when the session is not connected' do
    if ::Mongoid::Compatibility::Version.mongoid5?
      allow(Mongoid.default_client.cluster).to receive(:servers).and_return([])
    else
      allow(Mongoid.default_session.cluster).to receive(:nodes).and_return([])
    end
    expect do
      subject.host
    end.to raise_error Mongoid::Shell::Errors::SessionNotConnectedError, /Session is not connected./
  end
end
