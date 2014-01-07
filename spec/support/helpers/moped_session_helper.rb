module MopedSessionHelper
  # returns a Moped session with stubbed address resolution
  def moped_session(name)
    if Mongoid::Shell.mongoid2?
      Mongo::MongoClient.any_instance.stub(:connected?).and_return(true)
      Mongo::Node.any_instance.stub(:connect).and_return(true)
      Mongo::Node.any_instance.stub(:healthy?).and_return(true)
      Mongo::DB.any_instance.stub(:issue_authentication).and_return(true)
    elsif Mongoid::Shell.mongoid3?
      Moped::Node.any_instance.stub(:resolve_address).and_return(false)
    else
      Moped::Address.any_instance.stub(:resolve).and_return(false)
    end
    if Mongoid::Shell.mongoid2?
      ENV['RACK_ENV'] = name.to_s
      config = File.join(File.dirname(__FILE__), "../../support/config/mongoid2.yml")
      Mongoid.load! config
      Mongoid.master.connection.instance_variable_set "@default_db", Mongoid.master.name
      pool = Mongo::Pool.new(
        Mongoid.master.connection,
        Mongoid.master.connection.instance_variable_get("@host"),
        Mongoid.master.connection.instance_variable_get("@port")
      )
      Mongoid.master.connection.instance_variable_set "@primary_pool", pool
      Mongoid.master
    else
      config = File.join(File.dirname(__FILE__), "../../support/config/mongoid3.yml")
      Mongoid.load! config, :production
      session = Mongoid::Sessions.with_name(name)
      session.cluster.nodes.last.stub(:primary?).and_return(true)
      session
    end
  end
end
