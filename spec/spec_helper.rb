$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'mongoid'
require 'mongoid-shell'

Mongoid.configure do |config|
  config.connect_to('mongoid_shell_tests')
end
