---
applyTo: 'test/mailers/**/*.rb'
---

# Minitest Mailer Test Instructions (Rails)

Best practices for testing Rails mailers with Minitest.

---

## Patterns
- Inherit from `ActionMailer::TestCase`.
- Use FactoryBot for test data (preferred over fixtures).
- Test mail headers (`subject`, `to`, `from`) and body content.
- Use `assert_emails` to check delivery count.
- Use `assert_enqueued_emails` for async delivery.
- Use `assert_match` or `assert_includes` for body content.
- Prefer one assertion per test.

## Example
```ruby
require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'welcome email' do
    user = FactoryBot.create(:user)
    email = UserMailer.welcome(user)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal [user.email], email.to
    assert_equal ['no-reply@example.com'], email.from
    assert_match 'Welcome', email.subject
    assert_match user.name, email.body.encoded
  end

  test 'does not send email for inactive user' do
    user = FactoryBot.create(:user, :inactive)
    assert_no_emails do
      UserMailer.welcome(user).deliver_now
    end
  end
end

# Avoid ❌ - Not asserting delivery or headers
class UserMailerTest < ActionMailer::TestCase
  test 'welcome email' do
    user = FactoryBot.create(:user)
    UserMailer.welcome(user).deliver_now
    # No assertions on delivery or content
  end
end
```

## Quick Reference

### Checklist
- [ ] Inherit from `ActionMailer::TestCase`
- [ ] Use FactoryBot for data
- [ ] Test headers and body content
- [ ] Use `assert_emails` and `assert_enqueued_emails`
- [ ] Prefer one assertion per test

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all mailer tests and RuboCop on modified mailer test files
