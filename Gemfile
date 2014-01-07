source 'http://rubygems.org'

gemspec

case version = ENV['MONGOID_VERSION'] || '~> 3.1'
when /4/
  gem 'mongoid', github: 'mongoid/mongoid'
when /3/
  gem 'mongoid', '~> 3.1'
when /2/
  gem 'mongoid', '~> 2.8'
  gem 'bson_ext'
else
  gem 'mongoid', version
end

group :development, :test do
  gem 'rake'
  gem 'bundler'
  gem 'rspec'
  gem 'rubocop', '~> 0.16.0'
end
