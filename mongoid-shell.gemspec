$:.push File.expand_path("../lib", __FILE__)
require "mongoid/shell/version"

Gem::Specification.new do |s|
  s.name = "mongoid-shell"
  s.version = Mongoid::Shell::VERSION
  s.authors = [ "Daniel Doubrovkine" ]
  s.email = "dblock@dblock.org"
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.require_paths = [ "lib" ]
  s.homepage = "http://github.com/dblock/mongoid-shell"
  s.licenses = [ "MIT" ]
  s.summary = "Derive shell commands from Mongoid configuration options."
  s.add_dependency "mongoid", ">= 4.0.0"
  s.add_dependency "i18n"
end


