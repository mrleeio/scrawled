---
applyTo: 'app/**/*.rb'
---

# Ruby on Rails Error Handling Instructions

Error handling in Rails is essential for building robust applications. Below are guidelines and examples for managing errors effectively using Rails' error reporter.

---

## Error Reporting

### Subscribing to the Reporter
- Create a custom subscriber with a `report` method:
  ```ruby
  class ErrorSubscriber
    def report(error, handled:, severity:, context:, source: nil)
      MyErrorReportingService.report_error(error, context: context, handled: handled, level: severity)
    end
  end
  ```
- Register the subscriber:
  ```ruby
  Rails.error.subscribe(ErrorSubscriber.new)
  ```
- Unregister a subscriber:
  ```ruby
  Rails.error.unsubscribe(ErrorSubscriber)
  ```

### Using the Error Reporter

#### Reporting and Swallowing Errors
- Use `Rails.error.handle` to report and swallow errors:
  ```ruby
  result = Rails.error.handle do
    1 + "1" # raises TypeError
  end
  ```
- Provide a fallback:
  ```ruby
  user = Rails.error.handle(fallback: -> { User.anonymous }) do
    User.find(params[:id])
  end
  ```

#### Reporting and Re-raising Errors
- Use `Rails.error.record` to report and re-raise errors:
  ```ruby
  Rails.error.record do
    1 + "1" # raises TypeError
  end
  ```

#### Manually Reporting Errors
- Report errors manually:
  ```ruby
  begin
    # code
  rescue StandardError => e
    Rails.error.report(e)
  end
  ```

#### Reporting Unexpected Errors
- Report unexpected errors:
  ```ruby
  def edit
    if published?
      Rails.error.unexpected("[BUG] Attempting to edit a published article")
      false
    end
  end
  ```

---

## Error-reporting Options
- Options for `handle`, `record`, and `report`:
  - `handled`: Indicates if the error was handled.
  - `severity`: Describes the severity (`:error`, `:warning`, `:info`).
  - `context`: Provides additional context (e.g., user details).
  - `source`: Specifies the source of the error.

---

## Setting Context Globally
- Use `Rails.error.set_context` to set global context:
  ```ruby
  Rails.error.set_context(section: "checkout", user_id: @user.id)
  ```

---

## Filtering by Error Classes
- Filter errors by class:
  ```ruby
  Rails.error.handle(IOError) do
    1 + "1" # raises TypeError
  end
  ```

---

## Disabling Notifications
- Disable notifications for a block:
  ```ruby
  Rails.error.disable(ErrorSubscriber) do
    1 + "1" # TypeError will not be reported
  end
  ```

---

## Examples

```ruby
# Good ✅ - Proper error handling with context and fallback
class OrdersController < ApplicationController
  def create
    @order = Rails.error.handle(fallback: -> { Order.new }) do
      OrderService.new(order_params).create
    end
    
    if @order.persisted?
      redirect_to @order
    else
      Rails.error.set_context(user_id: current_user.id, action: 'order_creation')
      render :new, status: :unprocessable_entity
    end
  end
end

# Avoid ❌ - No error handling, silent failures
class OrdersController < ApplicationController
  def create
    @order = OrderService.new(order_params).create
    redirect_to @order
  end
end
```

---

## Quick Reference

### Checklist
- [ ] Use `Rails.error.handle` for recoverable errors with fallbacks
- [ ] Use `Rails.error.record` to report and re-raise errors
- [ ] Set context globally with `Rails.error.set_context`
- [ ] Subscribe to error reporter for external logging services
- [ ] Filter errors by class when appropriate
- [ ] Provide meaningful context in error reports

### Enforcement
- Tool: `bin/brakeman`, `bin/rubocop`
- Check: Run `bin/brakeman` and `bin/rubocop` on modified files

## Resources
- [Rails Error Reporting Guide](https://guides.rubyonrails.org/error_reporting.html): Official documentation for error handling.
