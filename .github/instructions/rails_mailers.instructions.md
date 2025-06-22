---
applyTo: 'app/mailers/**/*.rb'
---

# Rails Mailers Instructions

Action Mailer allows you to send emails from your Rails application. It uses mailer classes and views to create and configure emails.

---

## Creating Mailers

Use the Rails generator to create a mailer:

```bash
bin/rails generate mailer MailerName
```

This creates a mailer file in `app/mailers` and corresponding views in `app/views/mailer_name`.

Define methods in your mailer class to specify the emails:

```ruby
class ExampleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
```

---

## Mailer Views

Create views for your mailer actions in `app/views/mailer_name`. For example, for the `welcome_email` action:

### HTML Version

`app/views/example_mailer/welcome_email.html.erb`:

```html
<h1>Welcome, <%= @user.name %>!</h1>
<p>Thank you for joining our platform.</p>
<p><%= link_to 'Login', login_url %></p>
```

### Text Version

`app/views/example_mailer/welcome_email.text.erb`:

```text
Welcome, <%= @user.name %>!

Thank you for joining our platform.

Login here: <%= login_url %>
```

---

## Sending Emails

Call mailer methods from your controllers or background jobs:

```ruby
UserMailer.with(user: @user).welcome_email.deliver_later
```

Use `deliver_now` to send emails immediately:

```ruby
UserMailer.with(user: @user).welcome_email.deliver_now
```

---

## Attachments

Add attachments to emails:

```ruby
class ExampleMailer < ApplicationMailer
  def report_email(user, report_path)
    attachments['report.pdf'] = File.read(report_path)
    mail(to: user.email, subject: 'Your Report')
  end
end
```

---

## Configuration

Set default URL options in `config/application.rb`:

```ruby
config.action_mailer.default_url_options = { host: 'example.com' }
```

Set delivery method and SMTP settings in `config/environments/production.rb`:

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'smtp.example.com',
  port: 587,
  user_name: 'user@example.com',
  password: 'password',
  authentication: 'plain',
  enable_starttls_auto: true
}
```

---

## Testing Mailers

Use Rails test helpers to test mailers:

```ruby
assert_emails 1 do
  UserMailer.with(user: @user).welcome_email.deliver_now
end
```

---

## Quick Reference

### Checklist
- [ ] Mailer classes inherit from ApplicationMailer
- [ ] Both HTML and text versions of emails are provided
- [ ] Emails are sent using `deliver_later` for background processing
- [ ] Default URL options are configured for environment
- [ ] Mailers have appropriate test coverage
- [ ] Attachments are handled securely when used

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run `bin/rails test` and `bin/rubocop` on modified mailer files
