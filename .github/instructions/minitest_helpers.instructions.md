---
applyTo: 'test/helpers/**/*.rb'
---

# Minitest Helper Test Instructions (Rails)

Best practices for testing Rails helpers with Minitest.

---

## Patterns
- Use `ActionView::TestCase` for helper tests.
- Use FactoryBot for data (preferred over fixtures).
- Test helper output for all edge cases.
- Use `assert_equal`, `assert_match`, or `assert_includes` for output.
- Prefer one assertion per test.

## Example
```ruby
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'formats date' do
    date = Date.new(2025, 6, 14)
    assert_equal 'June 14, 2025', format_date(date)
  end
end
```

# Avoid ❌ - Not asserting output or using global variables
```ruby
class ApplicationHelperTest < ActionView::TestCase
  test 'formats date' do
    $date = Date.today
    format_date($date)
    # No assertion on output, uses global variable
  end
end
```

## Quick Reference

### Checklist
- [ ] Use `ActionView::TestCase`
- [ ] Use FactoryBot for data
- [ ] Test all edge cases
- [ ] Assert on output
- [ ] Prefer one assertion per test

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all helper tests and RuboCop on modified helper test files
