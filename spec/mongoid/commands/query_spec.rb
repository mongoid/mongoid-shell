# frozen_string_literal: true

require 'spec_helper'
require 'open3'
require 'rbconfig'

[Mongoid::Shell::Commands::Mongodump, Mongoid::Shell::Commands::Mongoexport].each do |command_class|
  describe command_class do
    let(:query) do
      '{ "scope": { "$eq": "offer" }, "created_at": { "$gte": { "$date": "2019-12-24T09:36:56.312Z" } } }'
    end

    def query_argument(input)
      command = described_class.new(query: input)
      executable = Shellwords.escape(RbConfig.ruby)
      script = Shellwords.escape('require "json"; puts JSON.generate(ARGV)')
      stdout, stderr, status = Open3.capture3("#{executable} -e #{script} -- #{command.vargs.compact.join(' ')}")
      expect(status.success?).to be(true), stderr
      expect(stderr).to eq ''
      arguments = JSON.parse(stdout)
      arguments.fetch(arguments.index('--query') + 1)
    end

    it 'preserves an Extended JSON string through the shell' do
      expect(query_argument(query)).to eq query
    end

    it 'serializes a Hash as JSON before shell escaping' do
      input = JSON.parse(query)
      expect(JSON.parse(query_argument(input))).to eq input
    end

    it 'serializes symbol keys as JSON' do
      input = { scope: { '$eq' => 'offer' } }
      expect(JSON.parse(query_argument(input))).to eq 'scope' => { '$eq' => 'offer' }
    end

    it 'preserves compact JSON and shell metacharacters literally' do
      input = JSON.generate('scope' => "O'Brien \"$HOME\" `printf changed` $(printf changed) \\path\nnext")
      expect(query_argument(input)).to eq input
    end
  end
end
