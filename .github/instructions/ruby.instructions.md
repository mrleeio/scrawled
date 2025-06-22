---
applyTo: '**/*.rb'
---

# Ruby Instructions

You are working with Ruby files. This file provides general guidelines for Ruby development, excluding Ruby on Rails-specific content.

## Patterns
- Follow the Ruby style guide (https://rubystyle.guide).
- Use meaningful variable and method names.
- Prefer single responsibility methods.
- Avoid global variables; use constants or class variables if necessary.
- Use `attr_reader`, `attr_writer`, or `attr_accessor` for instance variables.
- Use `freeze` for constants to prevent accidental modification.

## Error Handling
- Use `begin-rescue` blocks for error handling.
- Avoid rescuing `Exception` or `StandardError` broadly; rescue specific exceptions.
- Log errors with meaningful messages.

## Performance
- Prefer lazy enumerators (`map`, `select`) over manual loops.
- Use memoization (`@variable ||= value`) for expensive calculations.
- Avoid unnecessary object creation in loops.

## Security
- Avoid using `eval` or other metaprogramming techniques that execute arbitrary code.
- Sanitize inputs when interacting with external systems.
- Validate and sanitize all external inputs to prevent injection attacks.

## Examples
```ruby
# Good ✅ - Single responsibility method
class Calculator
  def add(a, b)
    a + b
  end
end

# Avoid ❌ - Global variable usage
$global_variable = "value"
```

## Quick Reference

### Checklist
- [ ] Follow Ruby style guide
- [ ] Use meaningful names
- [ ] Avoid global variables
- [ ] Handle errors with specific exceptions

### Enforcement
- Tool: `bin/rubocop`
- Check: Run bin/rubocop on all Ruby files

## ✂️ Content Prioritization

### Include
- General Ruby patterns
- Essential requirements preventing bugs/security issues
- Actionable examples

### Exclude
- Ruby on Rails-specific content
- Alternative approaches
- Historical context
