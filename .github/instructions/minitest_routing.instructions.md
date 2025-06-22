---
applyTo: 'test/routing/**/*.rb'
---

# Minitest Routing Test Instructions (Rails)

Best practices for testing Rails routing with Minitest.

---

## Patterns
- Use `ActionDispatch::IntegrationTest` for routing tests.
- Use `assert_routing`, `assert_recognizes`, and `assert_generates`.
- Test custom and edge-case routes.
- Test that invalid routes raise errors.
- Prefer one assertion per test.

## Example
```ruby
require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  test 'routes /articles to articles#index' do
    assert_routing '/articles', controller: 'articles', action: 'index'
  end

  test 'routes /articles/1 to articles#show' do
    assert_routing '/articles/1', controller: 'articles', action: 'show', id: '1'
  end

  test 'invalid route raises error' do
    assert_raises(ActionController::RoutingError) do
      get '/not-a-route'
    end
  end
end
```

## Avoid ❌ - Not asserting on routing or using deprecated test types
```ruby
class RoutingTest < ActionController::TestCase
  test 'routes /articles' do
    get :index, path: '/articles'
    # No assertion on routing
  end
end
```

## Quick Reference

### Checklist
- [ ] Use `ActionDispatch::IntegrationTest`
- [ ] Use `assert_routing`, `assert_recognizes`, `assert_generates`
- [ ] Test custom and invalid routes
- [ ] Prefer one assertion per test

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all routing tests and RuboCop on modified routing test files
