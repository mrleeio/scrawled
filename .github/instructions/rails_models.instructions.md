---
applyTo: 'app/models/**/*.rb'
---

# Ruby on Rails Models Instructions

You are working with Ruby on Rails models. Models encapsulate business logic, data validation, and database interaction.

---

## Patterns
- Use `validates` for input validation; always validate presence for required fields.
- Use `enum` for finite sets of values.
- Prefer `scope` for reusable queries.
- Use `before_save`/`after_commit` for side effects, but keep callbacks minimal.
- Avoid business logic in callbacks when possible; prefer service objects.

## Error Handling
- Use `errors.add` for custom validation errors.
- Rescue only specific exceptions; avoid rescuing `StandardError` broadly.

## Performance
- Use `includes` to prevent N+1 queries.
- Prefer batch operations for bulk updates.
- Ensure indexes are used for frequently queried fields.

## Examples
```ruby
# Good ✅ - Validates presence and uses scope
class User < ApplicationRecord
  validates :email, presence: true
  scope :active, -> { where(active: true) }
end

# Avoid ❌ - No validation, logic in callback, missing indexes
class User < ApplicationRecord
  after_save :send_email
  def send_email
    # business logic here
  end
end
```

## Quick Reference

### Checklist
- [ ] All required fields validated
- [ ] Use scopes for queries
- [ ] Avoid business logic in callbacks

### Enforcement
- Tool: `rubocop`
- Check: Run rubocop only on modified files
