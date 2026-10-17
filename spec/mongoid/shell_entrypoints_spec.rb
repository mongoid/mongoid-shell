# frozen_string_literal: true

require 'spec_helper'
require 'open3'
require 'rbconfig'

describe Mongoid::Shell do
  %w[mongoid-shell mongoid_shell].each do |entrypoint|
    context "when requiring #{entrypoint}" do
      let(:result) do
        script = <<~RUBY
          require 'simplecov' if ENV['COVERAGE'] == 'true'
          require 'mongoid'
          require #{entrypoint.inspect}
          abort 'missing commands' unless Mongoid::Shell::Commands::Mongo < Mongoid::Shell::Commands::Base
          abort 'missing version' unless Mongoid::Shell::VERSION.match?(/\\A\\d+\\.\\d+\\.\\d+/)
          abort 'missing translations' unless Mongoid::Shell::Errors::MissingSessionError.new.problem == 'Missing session.'
        RUBY
        environment = { 'COVERAGE_NAME' => "entrypoint-#{entrypoint}" }
        load_path = ['lib', *$LOAD_PATH].join(File::PATH_SEPARATOR)
        Bundler.with_unbundled_env do
          Open3.capture3(environment, RbConfig.ruby, '-I', load_path, '-e', script)
        end
      end

      it 'loads commands, version and translations in a fresh process' do
        stdout, stderr, status = result
        expect(status.success?).to be(true), "#{stdout}\n#{stderr}"
      end
    end
  end
end
