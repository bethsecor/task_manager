require_relative '../test_helper'

class UserDeletesATaskTest < FeatureTest
  def test_user_deletes_a_task
    TaskManager.create({ :title       => "Pet a capybara",
                         :description => "They are cute!"})
    TaskManager.create({ :title       => "Pet a capybara",
                         :description => "They are cute!"})
    TaskManager.create({ :title       => "Pet a capybara",
                         :description => "They are cute!"})

    visit('/tasks')
    # save_and_open_page

    within('.collection') do
      click_button('delete1')
    end

    assert_equal '/tasks', current_path

    within('.collection') do
      refute page.has_content?("1. Pet a capybara")
      refute page.has_css?("delete1")
    end
  end
end
