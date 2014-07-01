require 'spec_helper'

describe Mongoid::Shell::Properties::Primary do
  subject do
    klass = Class.new do
      include Mongoid::Shell::Properties::Primary

      def session
        Mongoid.default_session
      end
    end
    klass.new
  end
  it "raises an exception when the session is not connected" do
    allow(Mongoid.default_session.cluster.nodes.first).to receive(:primary?).and_return(false)
    expect {
      subject.primary
    }.to raise_error Mongoid::Shell::Errors::MissingPrimaryNodeError, /Session does not have a primary node./
  end
end
