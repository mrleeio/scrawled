---
applyTo: '.github/instructions/**/*.md'
---

# Instruction File Template

You are creating or editing instruction files for a Ruby on Rails application. Follow this template for consistency.

## 🔧 Meta Rules and File Structure

### Frontmatter (REQUIRED)
```yaml
---
applyTo: '<glob-pattern>' # REQUIRED: Specific glob pattern (e.g., 'app/models/**/*.rb')
---
```

### File Naming
- Format: `[domain].instructions.md` (e.g., `ruby.instructions.md`)

### Modular Design
- One primary responsibility per file
- Minimal overlap between files

## 🧱 Instruction Content Structure

### Title and Context (REQUIRED)
```markdown
# [Technology/Domain] Instructions

You are working with [specific technology/domain] in a Ruby on Rails project. [One concise sentence describing use case].
```

### Core Sections (REQUIRED)
Choose 2–4 relevant sections:

#### Code Instructions:
- **Patterns** (required)
- **Error Handling**
- **Performance**
- **Security** (if applicable)

#### Process Instructions:
- **Workflow**
- **Tools**
- **Standards**

### Examples (REQUIRED)
Provide exactly one "Good ✅" and one "Avoid ❌" example:
```ruby
# Good ✅ - Brief explanation
validate_user(user) # Ensures input meets format expectations

# Avoid ❌ - Brief explanation
def process(user)
  # No input validation
end
```

### Quick Reference (REQUIRED)
```markdown
## Quick Reference

### Checklist
- [ ] Actionable requirement 1
- [ ] Actionable requirement 2
- [ ] Actionable requirement 3

### Enforcement
- Tool: `validation_command`
- Check: Brief verification step
```

### Optional Sections (If Applicable)
- **Background** – Link to docs
- **Troubleshooting** – Link to docs

## ✂️ Content Prioritization

### Include
- Core patterns (80% use cases)
- Essential requirements preventing bugs/security issues
- Actionable examples

### Exclude
- Background explanations (link instead)
- Alternative approaches
- Configuration details (reference config files)
- Historical context

## 🔍 Cross-References
Only use cross-references when essential for understanding or implementation. Keep them brief and direct.

```markdown
# Good ✅
See [Ruby Instructions](ruby.instructions.md).

# Avoid ❌
See Ruby file for detailed patterns and approaches.
```

## 🧪 Quality Standards & Validation

### Validation Checklist
- All required sections present
- Clear Good/Avoid examples
- Actionable quick reference
- Proper cross-reference format
- Single primary domain per file

## 🔁 Migration Strategy (When Updating)
1. Identify core pattern clearly
2. Extract essential examples (one good, one avoid)
3. Refine checklist (3–5 critical items)
4. Remove nonessential context
5. Split file if exceeding 100–120 lines