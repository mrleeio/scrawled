---
applyTo: 'test/factories/**/*.rb'
---

# FactoryBot Instructions

You are working with FactoryBot for creating test data in Rails Minitest applications.

## Patterns
- Define factories in `test/factories/` directory
- Use traits for variations and states
- Use sequences for unique attributes
- Use associations for related models
- Prefer `create` for database objects, `build` for memory objects
- Use `attributes_for` for parameter hashes

## Factory Structure
```ruby
# Good ✅ - Complete factory with traits and sequences
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Test User" }
    password { "password123" }
    
    trait :admin do
      role { "admin" }
    end
    
    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 3, user: user)
      end
    end
    
    factory :admin_user, traits: [:admin]
  end
  
  factory :post do
    title { "Test Post" }
    body { "Post content..." }
    association :user
    
    trait :published do
      published_at { Time.current }
    end
  end
end

# Avoid ❌ - Hardcoded values, no flexibility
FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    name { "Test User" }
  end
end
```

## Usage in Tests
```ruby
# Good ✅ - Appropriate method selection
setup do
  @user = FactoryBot.create(:user)              # Database object
  @admin = FactoryBot.create(:user, :admin)     # With trait
  @params = FactoryBot.attributes_for(:user)    # Parameter hash
end

test 'creates user with valid attributes' do
  user = FactoryBot.build(:user)
  assert user.valid?
end

# Avoid ❌ - Inefficient or incorrect usage
setup do
  @user = FactoryBot.create(:user, :with_posts) # Slow, unnecessary associations
end
```

## Quick Reference

### Checklist
- [ ] Factories in `test/factories/` directory
- [ ] Use sequences for unique attributes
- [ ] Define traits for variations
- [ ] Use appropriate creation method (`create`, `build`, `attributes_for`)
- [ ] Avoid hardcoded values that cause conflicts

### Enforcement
- Tool: `bin/rails test`
- Check: Run tests to verify factory functionality

### Enforcement
- Tool: `bin/rails test`
- Check: Run tests to verify factory functionality

## Advanced Features

### Traits
Define traits for variations:
```ruby
trait :admin do
  admin { true }
end
```

### Sequences
Use sequences for unique attributes:
```ruby
sequence(:username) { |n| "user#{n}" }
```

### Configuration
Customize factory paths in `config/application.rb`:
```ruby
config.factory_bot.definition_file_paths = ["custom/factories"]
```

Disable factory generation in Rails generators:
```ruby
config.generators do |g|
  g.factory_bot false
end
```
