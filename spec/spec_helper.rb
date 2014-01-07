$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'mongoid'
require 'mongoid-shell'

["support/helpers/*.rb"].each do |path|
  Dir["#{File.dirname(__FILE__)}/#{path}"].each do |file|
    require file
  end
end

Mongoid.configure do |config|
  if Mongoid::Shell.mongoid2?
    config.master = Mongo::Connection.new.db('mongoid_shell_tests')
    config.master.connection.instance_variable_set "@default_db", 'mongoid_shell_tests'
  else
    config.connect_to('mongoid_shell_tests')
  end
end
