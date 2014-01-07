require 'spec_helper'

describe Mongoid::Shell::Properties::Host do
  subject do
    klass = Class.new do
      include Mongoid::Shell::Properties::Host

      def session
        if Mongoid::Shell.mongoid2?
          Mongoid.master.connection
        else
          Mongoid.default_session
        end
      end
    end
    klass.new
  end
  it "raises an exception when the session is not connected" do
    if Mongoid::Shell.mongoid2?
      Mongoid.master.stub(:connection).and_return(nil)
    else
      Mongoid.default_session.cluster.stub(:nodes).and_return([])
    end
    expect {
      subject.host
    }.to raise_error Mongoid::Shell::Errors::SessionNotConnectedError, /Session is not connected./
  end
end
