# frozen_string_literal: true

source 'http://rubygems.org'

gemspec

case version = ENV['MONGOID_VERSION'] || '9.0'
when /^9/
  gem 'bigdecimal'
  gem 'mongoid', '~> 9.0'
when /^8/
  gem 'bigdecimal'
  gem 'mongoid', '~> 8.0'
when /^7/
  gem 'bigdecimal'
  gem 'mongoid', '~> 7.0'
when /^6/
  gem 'bigdecimal'
  gem 'mongoid', '~> 6.0'
when /^5/
  gem 'bigdecimal', '< 2'
  gem 'mongoid', '~> 5.0'
when /^4/
  gem 'bigdecimal', '< 2'
  gem 'mongoid', '~> 4.0'
when /^3/
  gem 'bigdecimal', '< 2'
  gem 'mongoid', '~> 3.1'
else
  gem 'bigdecimal'
  gem 'mongoid', version
end

group :development, :test do
  gem 'bundler'
  gem 'danger'
  gem 'danger-changelog'
  gem 'danger-pr-comment'
  gem 'rake'
  gem 'rspec', '~> 3.0'
  gem 'rubocop', '~> 1.84.1'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end
