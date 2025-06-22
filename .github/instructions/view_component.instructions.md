---
applyTo: 'app/components/**/*.rb'
---

# Ruby on Rails ViewComponent Instructions

You are working with Ruby on Rails ViewComponents. ViewComponents encapsulate reusable UI elements with logic and rendering.

## Patterns
- Use ViewComponents for reusable UI elements.
- Keep components small and focused on a single responsibility.
- Use `initialize` to accept parameters and define state.
- Prefer `content_tag` or `tag` helpers for HTML generation.
- Include methods for rendering subcomponents when necessary.

## Testing
- Write unit tests for components to ensure rendering and logic correctness.
- Use `render_inline` for testing component output.

## Examples
```ruby
# Good ✅ - Realistic example matching codebase
class ButtonComponent < ViewComponent::Base
  def initialize(
    variant: 'button',
    text: '',
    style: 'primary',
    pre_icon: nil,
    suf_icon: nil,
    action: nil,
    classes: '',
    icon_classes: '',
    icon_data: {},
    confirm: '',
    data: {},
    disabled: false,
    target: '',
    title: '',
    url: '',
    id: '',
    counter: nil,
    mobile_filter_panel: true,
    data_action: '',
    method: nil,
    remote_link: false,
    tooltip: nil
  )
    super
    @variant = variant
    @text = text
    @style = style.downcase
    @pre_icon = pre_icon
    @suf_icon = suf_icon
    @action = action
    @data_action = data_action
    @classes = classes
    @icon_classes = icon_classes
    @icon_data = icon_data
    @confirm = confirm
    @data = data
    @disabled = disabled
    @target = target
    @title = title
    @url = url
    @id = id
    @counter = counter
    @mobile_filter_panel = mobile_filter_panel
    @method = method
    @remote_link = remote_link
    @tooltip = tooltip
  end

  def render_pre_icon
    return nil if @pre_icon.nil?

    render Ui::Icon::Component.new(
      icon: @pre_icon,
      classes: "pre_icon #{@icon_classes}",
      alt: @pre_icon,
      data: {}
    )
  end

  def render_suf_icon
    return nil if @suf_icon.nil?

    render Ui::Icon::Component.new(
      icon: @suf_icon,
      classes: "suf_icon #{@icon_classes}",
      alt: @suf_icon,
      data: @icon_data
    )
  end

  def classes
    "#{base_style} #{style} #{icon_wrapper_classes} #{disabled_class} #{@classes} tw-button-input-select-textarea-preflight"
  end
end
```

## Quick Reference

### Checklist
- [ ] Component is small and focused
- [ ] Accepts parameters via `initialize`
- [ ] Uses `content_tag` or `tag` helpers for HTML generation
- [ ] Includes unit tests
- [ ] Handles multiple parameters effectively
- [ ] Includes methods for rendering subcomponents

### Enforcement
- Tool: `bin/rubocop`
- Check: Run bin/rubocop only on modified files
