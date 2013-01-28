require 'spec_helper'

describe Mongoid::Shell::Properties::Host do
  subject do
    klass = Class.new do
      include Mongoid::Shell::Properties::Host

      def session
        Mongoid.default_session
      end
    end
    klass.new
  end
  it "raises an exception when the session is not connected" do
    Mongoid.default_session.cluster.stub(:nodes).and_return([])
    expect {
      subject.host
    }.to raise_error Mongoid::Shell::Errors::SessionNotConnectedError, /Session is not connected./
  end
end
