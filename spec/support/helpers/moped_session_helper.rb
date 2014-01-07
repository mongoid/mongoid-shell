module MopedSessionHelper
  # returns a Moped session with stubbed address resolution
  def moped_session(name)
    if Mongoid::Shell.mongoid3?
      Moped::Node.any_instance.stub(:resolve_address).and_return(false)
    else
      Moped::Address.any_instance.stub(:resolve).and_return(false)
    end
    config = File.join(File.dirname(__FILE__), "../../support/config/mongoid.yml")
    Mongoid.load! config, :production
    session = Mongoid::Sessions.with_name(name)
    session.cluster.nodes.last.stub(:primary?).and_return(true)
    session
  end
end
