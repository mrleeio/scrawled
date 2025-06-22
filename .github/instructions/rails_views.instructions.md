---
applyTo: 'app/views/**/*.erb'
---

# Ruby on Rails Views Instructions

You are working with Ruby on Rails views. Views render HTML for user interfaces and should remain logic-light.

---

## Patterns
- Use helpers for formatting and logic.
- Keep views free of business logic; use partials for reuse.
- Escape all user input (`<%= h(value) %>`) to prevent XSS.

## Performance
- Use fragment caching for expensive partials.
- Minimize database queries in views.
- Optimize partials for rendering efficiency.

## Examples
```erb
<%# Good ✅ - Uses helper and escapes input %>
<p><%= h(user.name) %></p>

<%# Avoid ❌ - Logic and query in view, unoptimized partials %>
<% if User.active.count > 0 %>
  <p>Active users exist</p>
<% end %>
```

## Quick Reference

### Checklist
- [ ] No business logic in views
- [ ] All user input escaped
- [ ] Use partials and helpers

### Enforcement
- Tool: `rubocop`
- Check: Run rubocop only on modified files
