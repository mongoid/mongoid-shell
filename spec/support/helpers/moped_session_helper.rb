module MopedSessionHelper
  # returns a Moped session with stubbed address resolution
  def moped_session(name)
    if Mongoid::Shell.mongoid3?
      allow_any_instance_of(Moped::Node).to receive(:resolve_address).and_return(false)
    else
      allow_any_instance_of(Moped::Address).to receive(:resolve).and_return(false)
    end
    config = File.join(File.dirname(__FILE__), "../../support/config/mongoid.yml")
    Mongoid.load! config, :production
    session = Mongoid::Sessions.with_name(name)
    allow(session.cluster.nodes.last).to receive(:primary?).and_return(true)
    session
  end
end
