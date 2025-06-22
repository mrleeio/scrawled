ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "database_cleaner/active_record"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    include FactoryBot::Syntax::Methods

    DatabaseCleaner.strategy = :transaction

    setup do
      DatabaseCleaner.start
    end

    teardown do
      DatabaseCleaner.clean
      Rails.cache.clear if Rails.cache.respond_to?(:clear)
    end
  end
end
