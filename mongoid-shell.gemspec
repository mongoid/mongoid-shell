Gem::Specification.new do |s|
  s.name = "mongoid-shell"
  s.version = Mongoid::Shell::VERSION
  s.authors = [ "Daniel Doubrovkine" ]
  s.email = "dblock@dblock.org"
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("lib/**/*") + %w(CHANGELOG.md LICENSE.md README.md Rakefile)
  s.homepage = "http://github.com/dblock/mongoid-shell"
  s.licenses = [ "MIT" ]
  s.require_paths = ["lib"]
  s.summary = "Derive shell commands from Mongoid configuration options."
  s.add_dependency "mongoid"
end


