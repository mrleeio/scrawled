---
applyTo: 'test/**/*.rb'
---

# Minitest Assertions & Matchers (Rails)

Best practices for using assertions in Minitest.

---

## Common Assertions
- `assert_equal expected, actual`
- `refute_equal expected, actual`
- `assert`/`refute` for truthiness
- `assert_nil`/`refute_nil`
- `assert_includes`/`refute_includes`
- `assert_predicate object, :predicate?`
- `assert_difference`/`assert_no_difference`
- `assert_raises(ErrorClass) { ... }`
- `assert_changes`/`assert_no_changes`
- `assert_emails`/`assert_enqueued_jobs` (Rails)

## Example
```ruby
assert_equal 2, 1 + 1
refute_nil user.email
assert_includes response.body, 'Welcome'
assert_difference('User.count', 1) { User.create!(...) }
assert_raises(ActiveRecord::RecordNotFound) { User.find(-1) }

# Avoid ❌ - Using generic assertions or no assertion
assert user.save == true # Not specific, use assert_predicate or assert
# Or missing assertion entirely
user.save
```

## Best Practices
- Prefer one assertion per test for clarity.
- Use the most specific assertion available.
- Use custom assertions for repeated logic.
- Use Rails-specific assertions for jobs, emails, and changes.

## Quick Reference

### Checklist
- [ ] Use the most specific assertion available
- [ ] Prefer one assertion per test
- [ ] Use Rails-specific assertions for jobs, emails, and changes
- [ ] Use custom assertions for repeated logic

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all tests and RuboCop on modified test files

## Resources
- [Minitest Assertions Documentation](https://docs.seattlerb.org/minitest/Minitest/Assertions.html)
- [Rails Testing Guide](https://guides.rubyonrails.org/testing.html)
