---
applyTo: 'test/**/*.rb'
---

# Minitest Flaky Test Prevention (Rails)

Best practices for preventing and fixing flaky tests in Rails/Minitest.

---

## Patterns
- Each test must run independently and in any order.
- Use `setup`/`teardown` to clean up state.
- Use fixtures or FactoryBot for isolated data.
- Use `travel_to` for time-dependent code.
- Mock/stub all external services and APIs.
- Avoid `sleep`; use Capybara's `assert_text`, `has_content?`, or explicit waits.
- Use `assert_enqueued_jobs`, `assert_performed_jobs` for async jobs.
- Use `bin/rails test --seed` to randomize test order and catch order dependencies.

## Example
```ruby
require 'test_helper'

class OrderProcessorTest < ActiveSupport::TestCase
  setup do
    Order.delete_all
    EmailService.stub(:send_notification, nil) { }
  end

  test 'processes pending orders' do
    travel_to Time.zone.local(2025, 6, 14) do
      order = Order.create!(status: 'pending')
      OrderProcessor.new.process_pending
      assert_equal 'processed', order.reload.status
    end
  end
end
```

## Avoid ❌ - Not cleaning up state or using sleep
```ruby
class OrderProcessorTest < ActiveSupport::TestCase
  test 'processes orders' do
    Order.create!(status: 'pending')
    sleep 1
    OrderProcessor.new.process_pending
    # No cleanup, uses sleep, not isolated
  end
end
```

## Quick Reference

### Checklist
- [ ] Tests run independently and in any order
- [ ] Use `setup`/`teardown` for cleanup
- [ ] Use fixtures or FactoryBot for data
- [ ] Use `travel_to` for time
- [ ] Mock/stub all external services
- [ ] Avoid `sleep`; use explicit waits
- [ ] Use `bin/rails test --seed` to randomize order

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all tests with random order and RuboCop on modified test files
