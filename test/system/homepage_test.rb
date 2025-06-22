require "application_system_test_case"

class HomepageTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    visit root_path

    assert_title "Scrawled"
    assert_text "Welcome to Scrawled"

    # Uncomment these lines to test debugging features (run with HEADLESS=0)
    # save_and_open_page # Will save the html page in /tmp/capybara and open it in your default browser
    # take_screenshot # Will save a screenshot in /tmp/capybara/screenshots
    # pause # To see the current view, requires HEADLESS=0 (or n, no, false)
    # debug # To see the current view with debug tools
  end
end
