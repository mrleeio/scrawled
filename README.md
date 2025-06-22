# Scrawled

This is a Ruby on Rails application built with modern development practices and automated workflows.

## Getting Started

### Prerequisites

* Ruby version specified in `.ruby-version`
* PostgreSQL database

### Installation

```bash
# Clone the repository
git clone https://github.com/mrleeio/scrawled.git
cd scrawled

# Setup the application
bin/setup

# Start the development server
bin/dev
```

### Configuration

* Database configuration in `config/database.yml`
* Environment variables should be set in `.env` (not committed to the repository)

### Testing

```bash
# Run the test suite
bin/rails test

# Run system tests
bin/rails test:system
```

## GitHub Workflows

This project uses GitHub Actions for continuous integration. Workflows include:

* Test suite execution with PostgreSQL
* Code quality checks (RuboCop, ERB Lint)
* Security analysis (Brakeman, Bundler Audit, Importmap Audit)
* Documentation validation (Markdownlint, Misspell)

For detailed information on all workflows, see [GitHub Workflows Documentation](docs/workflows.md).

## Services

* **Database**: PostgreSQL
* **Queue**: Using SolidQueue (configured in `config/queue.yml`)
* **Cache**: Rails built-in caching (configured in `config/cache.yml`)

## Deployment

Deployment is managed via Kamal, configured in `config/deploy.yml`.

```bash
# Deploy to production
bin/kamal deploy
```
