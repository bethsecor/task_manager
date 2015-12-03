require_relative '../test_helper'

class UserCreatesATaskTest < FeatureTest
  def test_user_creates_a_task
    visit('/tasks/new')

    within('#new-task-form') do
      fill_in('task[title]', with: "Pet a capybara")
      fill_in('task[description]', with: "They are cute!")
      click_button('Submit')
    end

    assert_equal '/tasks', current_path

    visit('/tasks/1')

    within('.card-content') do
      assert page.has_content?("Pet a capybara")
      assert page.has_content?("They are cute!")
    end
  end
end
