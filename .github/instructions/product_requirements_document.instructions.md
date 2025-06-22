---
applyTo: 'docs/product_requirements_documentation/**/*.md'
---

# Product Requirements Document Instructions

You are working with Product Requirements Documents in a Ruby on Rails project. Product Requirements Documents define the goals, features, and constraints for new or updated product functionality.

## Patterns

- Use clear, descriptive section headings for each requirement.
- State the problem, goals, and success criteria up front.
- List user stories or use cases in a structured, testable format.
- Specify acceptance criteria for each feature or requirement.
- Reference source files for technical details (e.g., `.rb`, `.yml`), not hardcoded values.
- Keep language concise and focused on outcomes, not implementation.
- Use tables or bullet lists for clarity when describing features or requirements.

## Examples

```markdown
# Good ✅ - Clear, actionable, and structured
## User Registration

**Goal:** Allow new users to register with email and password.

**User Story:**  
As a visitor, I want to sign up with my email and password so that I can access member features.

**Acceptance Criteria:**
- Email and password fields are required.
- Email must be unique and valid.
- Password must be at least 8 characters.
- Success redirects to dashboard.

# Avoid ❌ - Vague or incomplete requirements
## Registration

Users should be able to sign up.
```

## Quick Reference

### Checklist
- [ ] State problem, goal, and success criteria
- [ ] Use clear, descriptive headings
- [ ] List user stories and acceptance criteria
- [ ] Reference source files for technical details
- [ ] Use tables or lists for clarity

### Enforcement
- Tool: Manual review, PR template
- Check: Product Requirements Document includes all required sections and actionable acceptance criteria

## ✂️ Content Prioritization

### Include
- Core requirements and user stories
- Acceptance criteria for each feature
- References to source files/configs

### Exclude
- Implementation details
- Outdated or hardcoded version numbers
- Background explanations (link to docs instead)

## 🔍 Cross-References

See [Documentation Instructions](documentation.instructions.md) for general documentation standards.
