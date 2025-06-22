# System Testing with Cuprite

This project uses [Cuprite](https://github.com/rubycdp/cuprite) instead of Selenium for system tests. Cuprite is a headless Chrome driver for Capybara that's faster and provides better debugging capabilities.

## Running System Tests

```bash
# Run all system tests (headless)
bin/rails test:system

# Run with visible browser for debugging
HEADLESS=0 bin/rails test:system

# Run a specific test file
bin/rails test test/system/homepage_test.rb
```

## Debugging Features

Cuprite provides several debugging methods you can use in your tests:

- `save_and_open_page` - Saves the current HTML page and opens it in your browser
- `take_screenshot` - Saves a screenshot to `tmp/capybara/screenshots/`
- `pause` - Pauses test execution (requires `HEADLESS=0`)
- `debug` - Opens Chrome DevTools for inspection (requires `HEADLESS=0`)

## Configuration

The Cuprite setup is organized across several files:

- `test/test_helpers/system/cuprite_setup.rb` - Main Cuprite driver configuration
- `test/test_helpers/system/capybara_setup.rb` - Capybara global settings
- `test/test_helpers/system/cuprite_helpers.rb` - Helper methods for debugging
- `test/test_helpers/system/better_rails_system_tests.rb` - Enhanced Rails system test support

## Multi-Session Testing

Cuprite supports testing features that require multiple browser sessions (e.g., real-time features with WebSocket):

```ruby
test "multi-session example" do
  Capybara.using_session("admin") do
    visit admin_path
    # Admin actions
  end

  Capybara.using_session("user") do
    visit user_dashboard_path
    # User actions that might be affected by admin actions
  end
end
```

## Environment Variables

- `HEADLESS=0` (or `n`, `no`, `false`) - Run tests with visible browser
- `CAPYBARA_ARTIFACTS` - Custom path for screenshots and artifacts (default: `./tmp/capybara`)

## Benefits over Selenium

- **Performance**: Faster test execution
- **Debugging**: Better debugging tools with Chrome DevTools integration
- **Reliability**: More stable and less flaky tests
- **Multi-session**: Better support for testing real-time features
- **Screenshots**: Better screenshot support for failure debugging
