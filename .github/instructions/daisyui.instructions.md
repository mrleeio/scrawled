---
applyTo: '**/*.html.erb'
---

# DaisyUI Instructions

You are working with DaisyUI, a Tailwind CSS component library, in a Ruby on Rails project to build accessible, themeable UIs.

---

## Patterns
- Use semantic DaisyUI classes (`btn`, `input`, `card`, `modal`) for consistent theming
- Combine with Tailwind utilities for custom styling
- Prefer semantic color classes (`bg-base-200`, `text-base-content`) over specific colors
- Use component modifiers (`btn-primary`, `input-bordered`, `card-compact`)
- Avoid dynamic class interpolation - Tailwind JIT cannot detect these
- Test accessibility (focus, ARIA, keyboard navigation) for all components

---

## Component Examples

```erb
<%# Good ✅ - Semantic classes with proper structure %>
<div class="card bg-base-100 shadow-xl">
  <div class="card-body">
    <h2 class="card-title"><%= @article.title %></h2>
    <p><%= @article.excerpt %></p>
    <div class="card-actions justify-end">
      <%= link_to "Read More", @article, class: "btn btn-primary" %>
    </div>
  </div>
</div>

<%# Form with DaisyUI styling %>
<%= form_with model: @user, class: "space-y-4" do |f| %>
  <div class="form-control">
    <%= f.label :email, class: "label" %>
    <%= f.email_field :email, class: "input input-bordered" %>
  </div>
  <div class="form-control">
    <%= f.submit "Submit", class: "btn btn-primary" %>
  </div>
<% end %>

<%# Modal component %>
<input type="checkbox" id="my-modal" class="modal-toggle" />
<div class="modal">
  <div class="modal-box">
    <h3 class="font-bold text-lg">Confirmation</h3>
    <p class="py-4">Are you sure you want to delete this item?</p>
    <div class="modal-action">
      <label for="my-modal" class="btn">Cancel</label>
      <label for="my-modal" class="btn btn-error">Delete</label>
    </div>
  </div>
</div>

<%# Avoid ❌ - Dynamic classes, non-semantic styling %>
<button class="btn bg-<%= color %>-500">Submit</button>
<div class="p-4 bg-white border">Content</div>
```

---

## Quick Reference

### Checklist
- [ ] Use DaisyUI semantic component classes
- [ ] Combine with Tailwind utilities appropriately
- [ ] Avoid dynamic class interpolation
- [ ] Test accessibility (focus, ARIA, keyboard navigation)
- [ ] Use semantic colors for theme compatibility

### Enforcement
- Tool: Tailwind JIT compiler
- Check: Verify classes are detected and styles applied correctly

---

## Background
- [DaisyUI Documentation](https://daisyui.com/docs/)
- [DaisyUI GitHub](https://github.com/saadeghi/daisyui)
- [Tailwind CSS Docs](https://tailwindcss.com/docs/)

## Troubleshooting
- [DaisyUI Troubleshooting Guide](https://daisyui.com/docs/faq/)

---

*Versions and dependencies are managed in your `package.json` and Tailwind config files. Always reference these for up-to-date versioning.*
