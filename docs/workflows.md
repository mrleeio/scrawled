# GitHub Workflows

This document details the CI/CD workflows set up for this project using GitHub Actions.

## Main Workflow

The `Continuous Integration` workflow runs on push to main and on pull requests:

* **Test Suite**: Runs the Rails test suite including system tests
* **Code Quality**: Runs RuboCop for Ruby linting
* **Security Checks**: Runs Brakeman for security analysis and Importmap audit
* **Documentation**: Runs Markdownlint to ensure documentation quality

## Individual Workflows

The following workflows can also be triggered manually via workflow dispatch:

| Workflow | Description | Trigger |
|----------|-------------|---------|
| `test.yml` | Runs Rails test suite with PostgreSQL | PR, Main, Manual |
| `rubocop.yml` | Performs Ruby code linting | PR, Main, Manual |
| `brakeman.yml` | Scans for security vulnerabilities | PR, Main, Manual |
| `bundler_audit.yml` | Checks for vulnerable dependencies | PR, Main |
| `importmap_audit.yml` | Checks JavaScript dependencies | PR, Main |
| `markdownlint.yml` | Validates Markdown documentation | PR, Main |
| `misspell.yml` | Checks for spelling mistakes | PR |
| `erb_lint.yml` | Lints ERB templates | PR |

## Workflow Features

* **Pull Request Integration**: Workflows provide inline comments on PRs for issues
* **Auto-cancellation**: Running workflows are cancelled when new commits are pushed
* **Artifact Storage**: Failed test screenshots are stored as artifacts
* **Concurrency Control**: Prevents redundant workflow runs

## Workflow Configuration

### Test Workflow

```yaml
# .github/workflows/test.yml
# This workflow runs the Rails test suite with PostgreSQL
```

The test workflow:

* Sets up a PostgreSQL service container
* Installs required system dependencies
* Sets up Ruby with the version specified in .ruby-version
* Prepares the test database
* Runs the Rails test suite
* Captures screenshots for failed system tests

### Security Workflows

Both Brakeman and Bundler Audit workflows scan the codebase for security vulnerabilities:

* Brakeman performs static code analysis to find potential security issues
* Bundler Audit checks for vulnerable dependencies in the Gemfile.lock
* Importmap Audit checks JavaScript dependencies for known vulnerabilities

### Code Quality Workflows

RuboCop, ERB Lint, and Markdownlint ensure code quality standards:

* RuboCop enforces Ruby style guidelines
* ERB Lint checks ERB templates for best practices
* Markdownlint ensures documentation follows Markdown best practices
* Misspell checks for common spelling mistakes

## Running Workflows Manually

To run a workflow manually:

1. Go to the Actions tab in the GitHub repository
2. Select the workflow you want to run
3. Click the "Run workflow" button
4. Select the branch and configure any inputs
5. Click "Run workflow"

## Workflow Results

Workflow results are accessible from:

1. The GitHub repository's Actions tab
2. Pull request checks section
3. Commit status indicators

Failed workflow runs include detailed logs and any captured artifacts, like screenshots from failed system tests.
