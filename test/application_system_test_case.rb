require "test_helper"
require "test_helpers/system/better_rails_system_tests"
require "test_helpers/system/capybara_setup"
require "test_helpers/system/cuprite_helpers"
require "test_helpers/system/cuprite_setup"
require "database_cleaner/active_record"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [ 1400, 1400 ]

  include BetterRailsSystemTests
  include CupriteHelpers

  # System tests require different database cleaning strategy
  DatabaseCleaner.strategy = :truncation

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end
