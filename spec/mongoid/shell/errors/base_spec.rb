# frozen_string_literal: true

require 'spec_helper'

describe Mongoid::Shell::Errors::Base do
  {
    MissingSessionError: ['Missing session.', 'The command requires a session.', /Your code is missing a parameter/],
    SessionNotConnectedError: ['Session is not connected.', 'The command requires a connected session.', /Ensure that the database/],
    MissingPrimaryNodeError: ['Session does not have a primary node.', 'The command requires a primary node.', /Ensure that the database/]
  }.each do |error_class, (problem, summary, resolution)|
    context "with #{error_class}" do
      subject(:error) { Mongoid::Shell::Errors.const_get(error_class).new }

      it 'provides the localized problem' do
        expect(error.problem).to eq problem
      end

      it 'provides the localized summary' do
        expect(error.summary).to eq summary
      end

      it 'provides actionable resolution text' do
        expect(error.resolution).to match resolution
      end

      it 'composes the exception message from all three sections' do
        expect(error.message).to eq "\nProblem:\n  #{error.problem}\nSummary:\n  #{error.summary}\nResolution:\n  #{error.resolution}"
      end
    end
  end

  it 'interpolates attributes and strips translation whitespace' do
    # I18n interpolation uses template tokens, not Ruby's annotated format tokens.
    translations = { message: ' %{name} failed. ', summary: ' Check %{name}. ', resolution: ' Retry %{name}. ' } # rubocop:disable Style/FormatStringToken
    I18n.backend.store_translations(:en, mongoid: { shell: { errors: { messages: { coverage_example: translations } } } })
    error = described_class.new
    expect(error.compose_message('coverage_example', name: 'backup')).to eq(
      "\nProblem:\n  backup failed.\nSummary:\n  Check backup.\nResolution:\n  Retry backup."
    )
  end
end
