$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'mongoid'
require 'mongoid-shell'

['support/helpers/*.rb'].each do |path|
  Dir["#{File.dirname(__FILE__)}/#{path}"].each do |file|
    require file
  end
end

RSpec.configure(&:raise_errors_for_deprecations!)

Mongoid.configure do |config|
  config.connect_to('mongoid_shell_tests')
end
