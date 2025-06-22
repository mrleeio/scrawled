---
applyTo: 'test/features/**/*.rb'
---

# Minitest System Test Instructions (Rails)

Best practices for Rails system/integration tests with Minitest.

---

## Patterns
- Use `ActionDispatch::SystemTestCase` for browser/system tests (with Capybara or Selenium).
- Use `ActionDispatch::IntegrationTest` for API/user flow tests.
- Use FactoryBot for data (preferred over fixtures).
- Use Capybara DSL: `visit`, `fill_in`, `click_button`, `assert_text`, etc.
- Use `driven_by` to specify browser driver.
- Prefer one assertion per test.
- Use `setup` for per-test initialization.

## Example
```ruby
require 'application_system_test_case'

class UserSignupTest < ApplicationSystemTestCase
  driven_by :rack_test

  test 'user can sign up' do
    user_attrs = FactoryBot.attributes_for(:user)
    visit signup_path
    fill_in 'Email', with: user_attrs[:email]
    fill_in 'Password', with: user_attrs[:password]
    click_button 'Sign up'
    assert_text "Welcome, #{user_attrs[:email]}"
  end
end
```

# Avoid ❌ - Not using Capybara DSL or not asserting on output
class UserSignupTest < ApplicationSystemTestCase
  test 'user can sign up' do
    visit signup_path
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Sign up'
    # No assertion on output, missing Capybara assertions
  end
end

## Quick Reference

### Checklist
- [ ] Use `ActionDispatch::SystemTestCase` for browser/system tests
- [ ] Use Capybara DSL for user flows
- [ ] Use FactoryBot for data
- [ ] Prefer one assertion per test
- [ ] Use `setup` for initialization

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all system tests and RuboCop on modified system test files
