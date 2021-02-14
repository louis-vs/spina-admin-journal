# frozen_string_literal: true

# CodeCov integration
require 'simplecov'

if ENV['CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov

  SimpleCov.start 'rails' do
    enable_coverage :branch
    add_group 'Validators', 'app/validators'

    # these files don't play nicely with simplecov
    add_filter 'app/models/spina/admin/journal.rb'
    add_filter 'lib/spina/admin/journal/version.rb'
  end
end

require 'minitest/mock'
require 'minitest/reporters'
Minitest::Reporters.use!

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../test/dummy/db/migrate', __dir__)]
require 'rails/test_help'

# Filter out the backtrace from minitest while preserving the one from other libraries.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = "#{ActiveSupport::TestCase.fixture_path}/files"
  ActiveSupport::TestCase.fixtures :all
end
