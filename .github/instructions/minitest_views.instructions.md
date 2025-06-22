---
applyTo: 'test/views/**/*.rb'
---

# Minitest View Test Instructions (Rails)

Best practices for testing Rails views with Minitest.

---

## Patterns
- Use `ActionView::TestCase` for unit view tests.
- Use integration/system tests for full rendering and user flows.
- Use FactoryBot for data (preferred over fixtures).
- Use `render` and assert on output with `assert_match`, `assert_select`, or `assert_includes`.
- Test partials and helpers in isolation.
- Prefer one assertion per test.

## Example
```ruby
require 'test_helper'

class ArticlesViewTest < ActionView::TestCase
  test 'renders article title' do
    article = FactoryBot.create(:article)
    assign(:article, article)
    render template: 'articles/show'
    assert_match article.title, rendered
  end
end

# Avoid ❌ - Not asserting rendered output or using fixtures directly
class ArticlesViewTest < ActionView::TestCase
  test 'renders article' do
    article = articles(:one)
    assign(:article, article)
    render template: 'articles/show'
    # No assertion on output
  end
end
```

## Quick Reference

### Checklist
- [ ] Use `ActionView::TestCase` for unit view tests
- [ ] Use integration/system tests for user flows
- [ ] Use FactoryBot for data
- [ ] Assert on output with `assert_match`, `assert_select`, `assert_includes`
- [ ] Prefer one assertion per test

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all view tests and RuboCop on modified view test files
