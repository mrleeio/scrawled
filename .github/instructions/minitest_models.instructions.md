---
applyTo: 'test/models/**/*.rb'
---

# Minitest Model Test Instructions (Rails)

These are best practices for testing Rails models with Minitest.

---

## Patterns
- Inherit from `ActiveSupport::TestCase`.
- Use FactoryBot for test data (preferred over fixtures).
- Use `setup` for per-test initialization.
- Test validations, associations, scopes, and custom methods.
- Prefer one assertion per test for clarity.
- Use `assert_changes`, `assert_difference`, and `assert_no_difference` for side effects.
- Use `assert_predicate` for boolean methods.

## Example
```ruby
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = FactoryBot.create(:user) # preferred over fixtures
  end

  test 'valid with valid attributes' do
    assert @user.valid?
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test 'email must be unique' do
    duplicate = FactoryBot.build(:user, email: @user.email)
    refute duplicate.valid?
    assert_includes duplicate.errors[:email], 'has already been taken'
  end

  test 'active scope returns only active users' do
    assert_includes User.active, @user if @user.active?
  end

  test 'full_name returns first and last name' do
    assert_equal "#{@user.first_name} #{@user.last_name}", @user.full_name
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

## Quick Reference

### Checklist
- [ ] Use FactoryBot for data
- [ ] Test validations, associations, scopes, and methods
- [ ] Prefer one assertion per test
- [ ] Use `setup` for initialization
- [ ] Use `assert_difference` for side effects
- [ ] Use `assert_predicate` for boolean methods
- [ ] Avoid testing Rails internals

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all model tests and RuboCop on modified model test files
