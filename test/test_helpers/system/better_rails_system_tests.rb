module BetterRailsSystemTests
  # Use our `Capybara.save_path` to store screenshots with other capybara artifacts
  # (Rails screenshots path is not configurable https://github.com/rails/rails/blob/49baf092439fc74fc3377b12e3334c3dd9d0752f/actionpack/lib/action_dispatch/system_testing/test_helpers/screenshot_helper.rb#L79)
  def absolute_image_path
    Rails.root.join("#{Capybara.save_path}/screenshots/#{image_name}.png")
  end

  # Make failure screenshots compatible with multi-session setup.
  # That's where we use Capybara.last_used_session introduced before.
  def take_screenshot
    return super unless Capybara.last_used_session

    Capybara.using_session(Capybara.last_used_session) { super }
  end
end
