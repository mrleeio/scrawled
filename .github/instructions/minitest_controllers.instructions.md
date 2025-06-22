---
applyTo: 'test/controllers/**/*.rb'
---

# Minitest Controller Test Instructions (Rails)

Best practices for testing Rails controllers with Minitest.

---

## Patterns
- Use `ActionDispatch::IntegrationTest` for end-to-end controller tests (preferred in Rails 7+).
- Use FactoryBot for test data (preferred over fixtures).
- Use `setup` for per-test initialization.
- Test all HTTP actions: index, show, create, update, destroy.
- Use `assert_response`, `assert_redirected_to`, `assert_difference`, and `assert_no_difference`.
- Test JSON and HTML responses as needed.
- Use `post`, `get`, `patch`, `put`, `delete` helpers.
- Prefer integration/system tests for user flows.

## Example
```ruby
require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = FactoryBot.create(:article)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
    assert_select 'h1', 'Articles'
  end

  test 'should create article' do
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: FactoryBot.attributes_for(:article) }
    end
    assert_redirected_to article_path(Article.last)
  end

  test 'should not create invalid article' do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: '', body: '' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should update article' do
    patch article_url(@article), params: { article: { title: 'Updated' } }
    assert_redirected_to article_path(@article)
    @article.reload
    assert_equal 'Updated', @article.title
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_path
  end
end

# Avoid ❌ - Using controller tests with direct instance variables and no integration
class ArticlesControllerTest < ActionController::TestCase
  test 'should create article' do
    post :create, params: { article: { title: '', body: '' } }
    assert assigns(:article).persisted?
    # Uses deprecated ActionController::TestCase and instance variables
  end
end

## Quick Reference

### Checklist
- [ ] Use `ActionDispatch::IntegrationTest`
- [ ] Use FactoryBot for data
- [ ] Test all HTTP actions
- [ ] Use `assert_response`, `assert_redirected_to`, `assert_difference`
- [ ] Prefer integration/system tests for user flows
- [ ] Test both HTML and JSON as needed

### Enforcement
- Tool: `bin/rails test`, `bin/rubocop`
- Check: Run all controller tests and RuboCop on modified controller test files
