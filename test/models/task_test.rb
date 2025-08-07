require 'minitest/autorun'
require_relative '../../models/task'

class TaskTest < Minitest::Test
  def test_task_creation
    task = Task.new(name: 'Test Task')
    assert task.valid?
  end

  def test_task_name_presence
    task = Task.new(name: '')
    refute task.valid?
  end

  def test_task_completion
    task = Task.new(name: 'Test Task', completed: false)
    assert_equal false, task.completed
    task.complete!
    assert_equal true, task.completed
  end
end