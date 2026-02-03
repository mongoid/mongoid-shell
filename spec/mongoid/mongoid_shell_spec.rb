# frozen_string_literal: true

require 'spec_helper'

describe Mongoid::Shell do
  it 'has a version' do
    expect(Mongoid::Shell::VERSION).not_to be_nil
  end
end
