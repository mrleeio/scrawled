require "application_system_test_case"

class CupriteDebugDemoTest < ApplicationSystemTestCase
  test "demonstrate cuprite debugging features" do
    visit root_path

    # Basic assertions
    assert_title "Scrawled"
    assert_text "Welcome to Scrawled"

    # Demo debugging capabilities (commented out for CI, uncomment to test locally):
    #
    # To run with visible browser:
    # HEADLESS=0 rails test test/system/cuprite_debug_demo_test.rb
    #
    # save_and_open_page # Saves HTML and opens in browser
    # take_screenshot    # Saves screenshot to tmp/capybara/screenshots
    # pause              # Pauses execution (requires HEADLESS=0)
    # debug              # Opens Chrome DevTools (requires HEADLESS=0)
  end

  test "demonstrate multi-session capability" do
    # This shows how you can test features requiring multiple browser sessions
    # (e.g., real-time features, WebSocket connections, etc.)

    visit root_path
    assert_text "Welcome to Scrawled"

    # Example of using multiple sessions (though we don't have real-time features yet):
    # Capybara.using_session("admin") do
    #   visit admin_path
    #   # Admin actions
    # end
    #
    # Capybara.using_session("user") do
    #   visit user_dashboard_path
    #   # User actions
    # end
  end
end
