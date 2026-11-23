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
  gem 'ostruct'
  gem 'rake'
  gem 'rspec', '~> 3.0'
  gem 'simplecov', '~> 0.22' if ENV['COVERAGE'] == 'true'
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'rubocop', '~> 1.92'
    gem 'rubocop-md', '~> 3.0', require: false
    gem 'rubocop-prose', '~> 0.2', require: false
    gem 'rubocop-rake', '~> 0.7', require: false
    gem 'rubocop-rspec', '~> 3.10', require: false
    gem 'rubocop-spellcheck', '~> 0.2', require: false
    gem 'rubocop-yaml', '~> 0.1.0', require: false
  end
end
