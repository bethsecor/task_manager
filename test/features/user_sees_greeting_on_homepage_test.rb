require_relative '../test_helper'

class UserSeesGreetingOnHomepage < FeatureTest
  def test_greeting_is_displayed
    # As a guest
    # When I visit the homepage
    visit('/')
    # save_and_open_page
    # Then I see "Welcome to the Task Manager"
    within('#dash-title') do
      assert page.has_content?("Welcome to the Task Manager")
    end
  end
end
