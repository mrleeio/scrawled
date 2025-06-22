---
applyTo: 'test/**/*.rb'
---

# Minitest Instructions (Rails)

You are working with Minitest, the default Rails testing framework. These instructions reflect current best practices for Rails 7+ and Minitest.

## Table of Contents

| Section | Description | Key Topics |
|---------|-------------|------------|
| **[Models](minitest_models.instructions.md)** | Testing validations, associations, and business logic | Validations, associations, custom methods |
| **[Controllers](minitest_controllers.instructions.md)** | Testing HTTP actions and responses | Integration tests, params, redirects |
| **[Jobs](minitest_jobs.instructions.md)** | Testing background jobs | Enqueue, perform, error handling |
| **[Mailers](minitest_mailers.instructions.md)** | Testing mail delivery and content | Headers, body, delivery |
| **[Views](minitest_views.instructions.md)** | Testing view rendering | Templates, partials, content |
| **[Routing](minitest_routing.instructions.md)** | Testing custom routes | Route recognition, errors |
| **[Helpers](minitest_helpers.instructions.md)** | Testing helper methods | Output, edge cases |
| **[Features](minitest_system.instructions.md)** | System/integration tests | Capybara, user flows |
| **[Assertions](minitest_matchers.instructions.md)** | Common assertions | Equality, errors, collections |
| **[Flaky Tests](minitest_flaky_tests.instructions.md)** | Preventing and fixing flaky tests | Isolation, time, async |

## General Patterns
- Use `test_helper.rb` for global setup and configuration.
- Prefer `ActiveSupport::TestCase` for unit tests, `ActionDispatch::IntegrationTest` for request/system tests.
- Use FactoryBot for test data (preferred over fixtures).
- Use `setup` blocks for per-test initialization.
- Prefer one assertion per test for clarity.
- Use descriptive test names: `test 'does something' do ... end`.
- Avoid testing Rails internals; focus on your app’s behavior.

## Running Tests
- Run all tests: `bin/rails test`
- Run a single test file: `bin/rails test test/models/user_test.rb`
- Run a single test method: `bin/rails test test/models/user_test.rb:15`
- Use `RAILS_ENV=test` and reset the database as needed.

## Best Practices
- Keep tests isolated and order-independent.
- Use `assert_difference`/`assert_no_difference` for side effects.
- Use `travel_to` for time-dependent code.
- Mock/stub external services and APIs.
- Avoid `sleep` and race conditions in async tests.
- Use `assert_enqueued_with` and `perform_enqueued_jobs` for jobs.
- Use `assert_emails` for mail delivery.
- Prefer system/integration tests for user flows (with Capybara if needed).

## Example
```ruby
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = FactoryBot.build(:user)
  end

  test 'valid with valid email' do
    assert @user.valid?
  end

  test 'invalid with blank email' do
    @user.email = ''
    refute @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end
end

# Avoid ❌ - Testing Rails internals or multiple assertions per test
class UserTest < ActiveSupport::TestCase
  test 'invalid user' do
    user = User.new
    assert_equal false, user.save
    assert_equal ["can't be blank"], user.errors[:email]
    # Multiple assertions and testing internals
  end
end
```

## Quick Reference

### Checklist
- [ ] Use FactoryBot for test data
- [ ] One assertion per test
- [ ] Use `setup` for initialization
- [ ] Tests are isolated and repeatable
- [ ] Use domain-specific patterns from linked instructions

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run tests and RuboCop on modified files

For domain-specific patterns, see the linked instructions above.
