---
applyTo: 'app/services/**/*.rb'
---

# Ruby on Rails Services Instructions

You are working with Ruby on Rails service objects. Services encapsulate business logic that does not belong in models or controllers.

---

## Patterns
- Use PORO (Plain Old Ruby Object) for services.
- Name with a verb phrase (e.g., `SendEmailService`).
- Accept dependencies via initializer.
- Return a result object or boolean.

## Error Handling
- Raise custom exceptions for unrecoverable errors.
- Return error objects for recoverable errors.
- Document the types of exceptions and error objects used.
- Provide fallback mechanisms for recoverable errors.

## Modular Design
- Break down complex services into smaller, focused services.
- Utility services should focus on lightweight, reusable tasks without external dependencies.

## Testing Guidelines
- Write unit tests for each service method independently.
- Validate behavior for edge cases and error scenarios.

## Dependency Injection
- Always inject dependencies via the initializer to improve testability and reduce coupling.

## Examples
```ruby
# Good ✅ - Simple service with clear interface
class ExampleService
  def initialize(dependency)
    @dependency = dependency
  end

  def call
    # Perform the service logic
    true
  end
end

# Avoid ❌ - Service with unclear responsibilities
class ExampleService
  def self.perform_task
    # Static method with no state or injected dependencies
  end
end

# Good ✅ - Modular design with single responsibility
class NotificationService
  def initialize(user, message)
    @user = user
    @message = message
  end

  def call
    # Logic for sending notification
  end
end

class DataProcessingService
  def initialize(data)
    @data = data
  end

  def call
    # Logic for processing data
  end
end
```

# Avoid ❌ - Overloaded service with multiple responsibilities
class ComplexService
  def initialize(data, user, message)
    @data = data
    @user = user
    @message = message
  end

  def call
    # Logic for processing data, sending notifications, and other tasks
  end
end
```

## Quick Reference

### Checklist
- [ ] Service is a PORO
- [ ] Clear interface (`call` method)
- [ ] Handles errors appropriately
- [ ] Stateless and reusable

### Enforcement
- Tool: `bin/rubocop`
- Check: Run bin/rubocop only on modified files
