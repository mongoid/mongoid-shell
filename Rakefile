require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'

require File.expand_path('../lib/mongoid/shell/version', __FILE__)

require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]
