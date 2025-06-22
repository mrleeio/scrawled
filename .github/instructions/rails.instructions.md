---
applyTo: 'app/**/*.rb'
---

# Ruby on Rails Instructions

You are working with Ruby on Rails. Rails is a web application framework that provides tools for building robust and scalable applications.

## Table of Contents

| Section | Description | Key Topics |
|---------|-------------|------------|
| **[Controllers](rails_controllers.instructions.md)** | Handling HTTP requests, parameter sanitization, and response rendering | Actions, params, rendering |
| **[Views](rails_views.instructions.md)** | Rendering HTML, keeping views logic-light | Templates, partials, helpers |
| **[Models](rails_models.instructions.md)** | Encapsulating business logic, data validation, and database interaction | Validations, associations, callbacks |
| **[Services](rails_services.instructions.md)** | Encapsulating business logic outside models/controllers | Service objects, business logic |
| **[ViewComponents](view_component.instructions.md)** | Creating reusable view components | UI components, parameters, rendering |
| **[Error Handling](rails_error_handling.instructions.md)** | Managing errors using Rails' error reporter | Error reporting, context, fallback |
| **[Active Job](rails_active_job.instructions.md)** | Creating, enqueuing, and managing background jobs | Jobs, queues, callbacks |
| **[Mailers](rails_mailers.instructions.md)** | Creating and managing mailers | Email delivery, templates, testing |

## Domain-Specific Instructions

### Controllers
Refer to [Rails Controllers Instructions](rails_controllers.instructions.md) for guidelines on handling HTTP requests, parameter sanitization, and response rendering.

### Views
Refer to [Rails Views Instructions](rails_views.instructions.md) for best practices on rendering HTML and keeping views logic-light.

### Models
Refer to [Rails Models Instructions](rails_models.instructions.md) for guidelines on encapsulating business logic, data validation, and database interaction.

### Services
Refer to [Rails Services Instructions](rails_services.instructions.md) for best practices on encapsulating business logic outside models and controllers.

### ViewComponents
Refer to [ViewComponents Instructions](view_component.instructions.md) for guidelines on creating reusable view components.

### Error Handling
Refer to [Rails Error Handling Instructions](rails_error_handling.instructions.md) for guidelines on managing errors effectively using Rails' error reporter.

### Active Job
Refer to [Rails Active Job Instructions](rails_active_job.instructions.md) for guidelines on creating, enqueuing, and managing background jobs.

### Mailers
Refer to [Rails Mailers Instructions](rails_mailers.instructions.md) for guidelines on creating and managing mailers.

## Examples

```ruby
# Good ✅ - Follows Rails conventions with proper structure
class ArticlesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end

# Avoid ❌ - Violates conventions, missing structure
class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.save
    redirect_to @article
  end
end
```

## Quick Reference

### Checklist
- [ ] Follow domain-specific instructions.
- [ ] Ensure code adheres to Rails conventions.

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run tests and `bin/rubocop` on modified Rails files
