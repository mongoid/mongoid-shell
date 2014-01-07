require 'spec_helper'

describe Mongoid::Shell::Properties::Primary do
  subject do
    klass = Class.new do
      include Mongoid::Shell::Properties::Primary

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
      Mongoid.default_session.cluster.nodes.first.stub(:primary?).and_return(false)
    end
    expect {
      subject.primary
    }.to raise_error Mongoid::Shell::Errors::MissingPrimaryNodeError, /Session does not have a primary node./
  end
end
