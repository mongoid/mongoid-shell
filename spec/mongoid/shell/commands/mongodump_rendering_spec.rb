# frozen_string_literal: true

require 'spec_helper'

describe Mongoid::Shell::Commands::Mongodump do
  subject(:command) do
    described_class.new(host: 'backup.example:27018', db: 'archive', username: 'reader', password: 'secret')
  end

  it 'omits false boolean options' do
    command.ipv6 = false
    expect(command.to_s).not_to include('--ipv6')
  end

  it 'includes true boolean options without a value' do
    command.ipv6 = true
    expect(command.to_s).to end_with(' --ipv6')
  end

  it 'omits an empty repeatable option' do
    command.excludeCollection = []
    expect(command.to_s.split).not_to include('--excludeCollection')
  end

  it 'preserves option order and repeats each collection exclusion' do
    command.excludeCollection = %w[logs audit]
    expect(command.to_s).to eq(
      'mongodump --host backup.example:27018 --db archive --username reader --password secret --excludeCollection logs --excludeCollection audit'
    )
  end

  it 'retains credentials when masking is explicitly disabled' do
    expect(command.to_s(mask_sensitive: false)).to include('--password secret')
  end

  it 'masks only sensitive values' do
    expect(command.to_s(mask_sensitive: true)).to eq(
      'mongodump --host backup.example:27018 --db archive --username reader --password ********'
    )
  end

  it 'quotes ordinary values containing spaces' do
    command.out = 'backup directory'
    expect(command.to_s).to include('--out "backup directory"')
  end

  it 'renders numeric option values' do
    command.collection = 0
    expect(command.to_s).to include('--collection 0')
  end
end
