---
applyTo: 'test/jobs/**/*.rb'
---

# Minitest Job Test Instructions (Rails)

Best practices for testing Rails background jobs with Minitest.

---

## Patterns
- Inherit from `ActiveJob::TestCase`.
- Use FactoryBot for test data (preferred over fixtures).
- Use `assert_enqueued_with`, `assert_enqueued_jobs`, `assert_performed_jobs`, and `perform_enqueued_jobs`.
- Test both enqueuing and performing jobs.
- Use `assert_no_enqueued_jobs` and `assert_no_performed_jobs` for negative cases.
- Use `perform_now` for synchronous execution, `perform_later` for async.
- Mock/stub external services.

## Example
```ruby
require 'test_helper'

class ExampleJobTest < ActiveJob::TestCase
  test 'enqueues job' do
    user = FactoryBot.create(:user)
    assert_enqueued_with(job: ExampleJob, args: [user.id]) do
      ExampleJob.perform_later(user.id)
    end
  end

  test 'performs job' do
    user = FactoryBot.create(:user)
    perform_enqueued_jobs do
      ExampleJob.perform_later(user.id)
    end
    # Assert side effects here
  end

  test 'does not enqueue job for invalid input' do
    assert_no_enqueued_jobs only: ExampleJob do
      ExampleJob.perform_later(nil)
    end
  end
end

# Avoid ❌ - Mixing business logic and not asserting enqueuing
class ExampleJobTest < ActiveJob::TestCase
  test 'performs job' do
    user = FactoryBot.create(:user)
    ExampleJob.perform_now(user.id)
    # No assertion on enqueuing or side effects
  end
end
```

## Quick Reference

### Checklist
- [ ] Inherit from `ActiveJob::TestCase`
- [ ] Use FactoryBot for data
- [ ] Test both enqueuing and performing
- [ ] Use `assert_enqueued_with`, `assert_performed_jobs`
- [ ] Mock/stub external services

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all job tests and RuboCop on modified job test files
