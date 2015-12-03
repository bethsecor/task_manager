require_relative '../test_helper'

class UserEditsATaskTest < FeatureTest
  def test_user_edits_a_task
    TaskManager.create({ :title       => "Pet a capybara",
                         :description => "They are cute!"})

    visit('/tasks/1/edit')
    # save_and_open_page

    within('#edit-task-form') do
      fill_in('task[title]', with: "Pet a capybara")
      fill_in('task[description]', with: "They are SOOOO cute!")
      click_button('Submit')
    end

    assert_equal '/tasks/1', current_path

    within('.card-content') do
      assert page.has_content?("Pet a capybara")
      assert page.has_content?("They are SOOOO cute!")
    end
  end
end
