require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def create_tasks(num)
    num.times do |n|
      TaskManager.create({ :title       => "title#{n+1}",
                           :description => "description#{n+1}"})
    end
  end

  def test_count_is_zero_when_no_tasks
    tasks_all = TaskManager.all

    assert_equal 0, tasks_all.count
  end

  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
    refute_equal 33, task.id
  end

  def test_it_creates_two_tasks
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    task_1 = TaskManager.find(1)
    assert_equal "a title", task_1.title
    assert_equal "a description", task_1.description
    assert_equal 1, task_1.id

    TaskManager.create({ :title       => "another title!",
                         :description => "another description!"})
    task_1 = TaskManager.find(1)
    task_2 = TaskManager.find(2)
    assert_equal "another title!", task_2.title
    assert_equal "another description!", task_2.description
    assert_equal 2, task_2.id

    refute_equal "another title!", task_1.title
    refute_equal "another description!", task_1.description
    refute_equal 2, task_1.id
  end

  def test_it_creates_two_tasks_and_finds_all
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "another title!",
                         :description => "another description!"})
    tasks_all = TaskManager.all

    assert_equal 2, tasks_all.count
  end

  def test_it_updates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
     task_1 = TaskManager.find(1)
     assert_equal "a title", task_1.title
     assert_equal "a description", task_1.description
     assert_equal 1, task_1.id

     TaskManager.update(1, {:title       => "another title!",
                          :description => "another description!"})
     task_1 = TaskManager.find(1)
     assert_equal "another title!", task_1.title
     refute_equal "unicorns", task_1.title
     assert_equal "another description!", task_1.description
     refute_equal "unicorns", task_1.description
     assert_equal 1, task_1.id
     refute_equal 2, task_1.id
  end

  def test_it_deletes_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    TaskManager.create({ :title       => "another title!",
                         :description => "another description!"})
    tasks_all = TaskManager.all
    assert_equal 2, tasks_all.count
    TaskManager.delete(1)
    tasks_all = TaskManager.all
    assert_equal 1, tasks_all.count
    TaskManager.delete(2)
    tasks_all = TaskManager.all
    assert_equal 0, tasks_all.count
   end

   def test_it_deletes_tasks_out_of_order
     TaskManager.create({ :title       => "a title",
                          :description => "a description"})
     TaskManager.create({ :title       => "another title!",
                          :description => "another description!"})
     tasks_all = TaskManager.all
     assert_equal 2, tasks_all.count
     TaskManager.delete(2)
     tasks_all = TaskManager.all
     assert_equal 1, tasks_all.count
     TaskManager.delete(1)
     tasks_all = TaskManager.all
     assert_equal 0, tasks_all.count
    end
end
