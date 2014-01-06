module MopedSessionHelper
  # returns a Moped session with stubbed address resolution
  def moped_session(name)
    Moped::Node.any_instance.stub(:resolve_address).and_return(false)
    config = File.join(File.dirname(__FILE__), "../../support/config/mongoid.yml")
    Mongoid.load! config, :production
    session = Mongoid::Sessions.with_name(name)
    session.cluster.nodes.last.stub(:primary?).and_return(true)
    session
  end
end
