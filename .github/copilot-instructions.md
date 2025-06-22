# Software Development Best Practices

Your role is to write high-quality Ruby/Ruby on Rails code following established conventions and best practices across all technologies in the stack.

## Core Development Principles

### General Guidelines
- **Make the smallest change possible** to achieve the desired functionality
- **Follow established conventions** for each technology
- **Prioritize code readability** and maintainability
- **Write self-documenting code** with clear naming and structure
- **Implement proper error handling** and logging
- **Ensure security best practices** are followed
- **Use conventional commits** with issue numbers for all changes

### Code Comments
- **Avoid unnecessary comments** - code should be self-documenting through clear naming and structure
- **Comments should explain "why", not "what"** - focus on the reasoning behind decisions, not describing what the code does
- **Only add comments for complex logic** or non-obvious business rules that aren't clear from the code itself
- **Remove outdated comments** that no longer reflect the current implementation

**Examples**:
```ruby
# Good ✅ - Explains business reasoning
def calculate_discount(amount)
  # Apply 15% discount for orders over $100 to encourage larger purchases
  amount > 100 ? amount * 0.85 : amount
end

# Avoid ❌ - Describes what the code obviously does
def calculate_discount(amount)
  # Check if amount is greater than 100
  if amount > 100
    # Multiply amount by 0.85 to get 15% discount
    return amount * 0.85
  else
    # Return original amount if no discount applies
    return amount
  end
end
```

### Technology Stack
- **Backend**: Ruby on Rails with PostgreSQL
- **Frontend**: Tailwind CSS with ViewComponent architecture
- **Background Processing**: ActiveJob with SolidQueue
- **Admin Interface**: ActiveAdmin
- **Testing**: Minitest with FactoryBot
- **Code Quality**: RuboCop and Brakeman

## Git

All commits must follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) specification to ensure clarity and consistency in commit history.

### Conventional Commit Format

A commit message should be structured as follows:

```
type(scope?): subject

body (optional)

footer (optional)
```

- **type**: The type of change (e.g., feat, fix, docs, style, refactor, test, chore)
- **scope**: A short description of the section of the codebase affected (optional)
- **subject**: A brief description of the change (imperative, lower case, no period)
- **body**: More detailed explanatory text (optional)
- **footer**: For breaking changes or issues closed (optional)

#### Examples

```
feat(auth): add OAuth2 login support

fix(user): correct validation for email uniqueness

docs(readme): update contributing guidelines

refactor: simplify user lookup logic

chore: update dependencies
```

- Use the imperative mood in the subject line (e.g., "add" not "adds" or "added").
- Include an issue number in the footer if applicable (e.g., "Closes #123").
- Use `BREAKING CHANGE:` in the footer for breaking changes.

### Resources
- [Conventional Commits Specification](https://www.conventionalcommits.org/en/v1.0.0/#summary)
- [Commitizen](https://commitizen-tools.github.io/commitizen/)

## Framework-Specific Instructions

For detailed implementation guidelines specific to each technology:

### Core Development
- **Ruby Language**: See [Ruby Instructions](instructions/ruby.instructions.md) - Pure Ruby coding standards and patterns
- **Rails Framework**: See [Rails Instructions](instructions/rails.instructions.md) - Rails-specific conventions and patterns

### UI Components
- **ViewComponent**: See [ViewComponent Instructions](instructions/view_component.instructions.md) - Component-based UI patterns
- **DaisyUI**: See [DaisyUI Instructions](instructions/daisyui.instructions.md) - Tailwind-based UI component patterns

### Background Processing
- **Background Jobs**: See [Rails Active Job Instructions](instructions/rails_active_job.instructions.md) - ActiveJob patterns

### Quality & Process
- **Testing**: See [Minitest Instructions](instructions/minitest.instructions.md) - Minitest and FactoryBot testing patterns
- **Error Handling**: See [Rails Error Handling Instructions](instructions/rails_error_handling.instructions.md) - Error handling best practices

### Documentation
- **Documentation**: See [Documentation Instructions](instructions/documentation.instructions.md) - Guidelines for writing and maintaining documentation

These files contain comprehensive patterns, examples, and best practices for each area. Reference them based on the type of work you're doing.

## Code Review Checklist

### General Code Quality
- [ ] Code follows established conventions and patterns
- [ ] Business logic is properly abstracted
- [ ] Error handling is comprehensive and appropriate
- [ ] Security considerations are addressed
- [ ] Performance implications are considered
- [ ] Code is readable and self-documenting

### Testing and Quality
- [ ] New functionality has appropriate test coverage
- [ ] Tests are well-organized and follow established patterns
- [ ] Code quality tools pass (RuboCop, Brakeman)
- [ ] No obvious performance bottlenecks introduced
- [ ] Documentation is updated when needed

### Architecture and Design
- [ ] Changes align with existing architecture
- [ ] Proper separation of concerns maintained
- [ ] Dependencies are minimal and justified
- [ ] Integration points are well-defined
- [ ] Scalability considerations addressed

### Version Control
- [ ] Commits are atomic and focused on a single change
- [ ] Commit messages follow conventional format with issue numbers
- [ ] Branch follows naming convention
- [ ] No debugging statements or commented-out code committed
- [ ] Breaking changes are properly documented
- [ ] PR follows guidelines and includes proper description

## Quality Checks

### Minitest
Minitest is used for testing the Rails application. When running tests, you must specify the Rails environment and reset the database.

#### Running Minitest Tests
```bash
RAILS_ENV=test bundle exec rails db:reset
RAILS_ENV=test bundle exec rails test
```

#### Running Specific Tests
```bash
RAILS_ENV=test bundle exec rails db:reset
RAILS_ENV=test bundle exec rails test test/models/user_test.rb
```

#### Configuration
- Test database configuration is defined in `config/database.yml`
- Minitest configuration is in `test/test_helper.rb`
- Always reset the test database before running tests to ensure clean state

### RuboCop
RuboCop is used to enforce Ruby style guidelines and catch common issues.

#### Running RuboCop
```bash
bundle exec rubocop
```

#### Fixing Issues
```bash
bundle exec rubocop -a
```

#### Configuration
RuboCop configuration is defined in `.rubocop.yml`. Ensure all changes pass RuboCop checks before committing.

### Brakeman
Brakeman is used for static analysis of Rails applications to detect security vulnerabilities.

#### Running Brakeman
```bash
bundle exec brakeman
```

#### Configuration
Brakeman configuration is defined in `config/brakeman.yml`. Ensure no high or medium severity issues are present before merging.

### Zeitwerk
Zeitwerk is used for autoloading in Rails applications.

#### Validating Zeitwerk Setup
```bash
rails zeitwerk:check
```

Ensure all files follow Zeitwerk conventions for naming and organization.
