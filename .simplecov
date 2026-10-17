# frozen_string_literal: true

SimpleCov.start do
  command_name ENV.fetch('COVERAGE_NAME', 'RSpec')
  add_filter '/spec/'
  track_files 'lib/**/*.rb'
end
