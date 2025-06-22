---
applyTo: '.github/workflows/**/*.yml'
---

# GitHub Actions Workflow Instructions

You are working with GitHub Actions workflows in a Ruby on Rails project. Use these instructions to ensure CI/CD pipelines are reliable, maintainable, and secure.

## Patterns
- Use descriptive workflow and job names.
- Keep workflows modular: one primary responsibility per workflow file.
- Use reusable actions and composite actions for repeated logic.
- Pin action versions (e.g., `actions/checkout@v4`) to avoid breaking changes.
- Store secrets in GitHub Secrets, never in workflow files.
- Use environment protection rules for production deployments.
- Prefer matrix builds for multi-version or multi-platform testing.
- Use `fail-fast: false` for matrix jobs to see all failures.
- Cache dependencies (e.g., gems, node_modules) to speed up builds.
- Use `actions/upload-artifact` for test reports and build artifacts.
- Add status badges to the README for visibility.

## Error Handling
- Use `continue-on-error: false` unless explicitly testing failure scenarios.
- Add `if: always()` to post-job steps for cleanup or artifact upload.
- Fail fast on lint/test errors; do not allow failures to pass silently.
- Use `timeout-minutes` to prevent stuck jobs.

## Security
- Never echo or print secrets in logs.
- Use the least privilege principle for workflow permissions.
- Use `pull_request_target` only when necessary and with caution.
- Regularly review and update action versions for security patches.

## Examples
```yaml
# Good ✅ - Modular, secure, and clear workflow
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
      - name: Install dependencies
        run: bundle install --jobs 4 --retry 3
      - name: Run tests
        run: bundle exec rails test
```

```yaml
# Avoid ❌ - Unpinned actions, secrets in plain text, unclear names
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Set secret
        run: echo "SECRET=hardcoded" >> $GITHUB_ENV
      - run: rake
```

## Quick Reference

### Checklist
- [ ] Descriptive workflow and job names
- [ ] Actions pinned to specific versions
- [ ] No secrets in workflow files
- [ ] Modular, single-responsibility workflows
- [ ] Proper error handling and timeouts
- [ ] Security best practices enforced

### Enforcement
- Tool: GitHub Actions linter, manual review
- Check: Validate workflows with `act` or GitHub Actions UI

## Background
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [GitHub Actions Security Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
