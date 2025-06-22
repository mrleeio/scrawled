---
applyTo: 'app/controllers/**/*.rb'
---

# Ruby on Rails Controllers Instructions

You are working with Ruby on Rails controllers. Controllers handle HTTP requests, parameter sanitization, and response rendering.

---

## Patterns
- Use `before_action` for authentication and setup.
- Use strong parameters (`params.require(...).permit(...)`).
- Keep actions concise; delegate business logic to models/services.
- Render JSON or HTML explicitly; avoid implicit rendering.

## Error Handling
- Use `rescue_from` for predictable error handling.
- Return appropriate HTTP status codes.

## Security
- Always use strong parameters to prevent mass assignment.
- Authenticate users before sensitive actions.
- Ensure CSRF protection is enabled for all forms.

## Examples
```ruby
# Good ✅ - Uses strong params and before_action
class UsersController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

# Avoid ❌ - No strong params, no authentication, implicit rendering
class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    @user.save
  end
end
```

## Quick Reference

### Checklist
- [ ] Use strong parameters
- [ ] Authenticate before sensitive actions
- [ ] Handle errors with status codes

### Enforcement
- Tool: `rubocop`
- Check: Run rubocop only on modified files
