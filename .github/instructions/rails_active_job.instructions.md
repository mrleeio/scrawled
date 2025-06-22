---
applyTo: 'app/jobs/**/*.rb'
---

# Rails Active Job Instructions

Active Job is a framework for declaring jobs and running them on a variety of queueing backends. It allows you to move long-running tasks out of the request-response cycle.

---

## Creating Jobs

Use the Rails generator to create a job:

```bash
bin/rails generate job job_name
```

This creates a job file in `app/jobs` and a corresponding test file in `test/jobs`.

Define the `perform` method in your job class to specify the task:

```ruby
class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Task logic here
  end
end
```

---

## Enqueuing Jobs

Enqueue jobs using `perform_later` for asynchronous execution:

```ruby
ExampleJob.perform_later(arg1, arg2)
```

Use `set` to configure options like delay or queue:

```ruby
ExampleJob.set(wait: 5.minutes).perform_later(arg1, arg2)
```

---

## Managing Queues

Specify the queue for a job using `queue_as`:

```ruby
class ExampleJob < ApplicationJob
  queue_as :low_priority
end
```

Configure global queue settings in `config/application.rb`:

```ruby
config.active_job.queue_name_prefix = Rails.env
config.active_job.queue_name_delimiter = '.'
```

---

## Callbacks

Use callbacks to trigger logic during the job lifecycle:

```ruby
class ExampleJob < ApplicationJob
  before_enqueue :before_enqueue_callback
  after_perform :after_perform_callback

  private

  def before_enqueue_callback
    # Logic before enqueue
  end

  def after_perform_callback
    # Logic after perform
  end
end
```

---

## Error Handling

Handle errors using `rescue_from`:

```ruby
class ExampleJob < ApplicationJob
  rescue_from(StandardError) do |exception|
    # Error handling logic
  end
end
```

---

## Testing Jobs

Refer to the Rails testing guide for job testing best practices:

```ruby
assert_enqueued_with(job: ExampleJob) do
  ExampleJob.perform_later(arg1, arg2)
end
```

---

## Best Practices

### Use Service Objects

Jobs should delegate business logic to service objects. This ensures that jobs remain focused on their primary responsibility: managing background tasks.

Example:

```ruby
class ExampleJob < ApplicationJob
  def perform(*args)
    MyService.new(args).call
  end
end

class MyService
  def initialize(args)
    @args = args
  end

  def call
    # Business logic here
  end
end
```

---

## Examples

```ruby
# Good ✅ - Job delegates to service object with proper structure
class ProcessOrderJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    OrderProcessingService.new(order_id).call
  end
end

# Avoid ❌ - Business logic mixed into job
class ProcessOrderJob < ApplicationJob
  def perform(order_id)
    order = Order.find(order_id)
    order.update(status: 'processed')
    OrderMailer.confirmation(order).deliver_now
    InventoryService.update_stock(order.items)
  end
end
```

---

## Quick Reference

### Checklist
- [ ] Jobs inherit from ApplicationJob
- [ ] Business logic is delegated to service objects
- [ ] Jobs use `perform_later` for asynchronous execution
- [ ] Appropriate queues are specified with `queue_as`
- [ ] Error handling is implemented with `rescue_from`
- [ ] Jobs have appropriate test coverage

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run `bin/rails test` and `bin/rubocop` on modified job files
