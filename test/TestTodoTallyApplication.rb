require 'test/unit'
require_relative '../todo_tally_application'

class TestTodoTallyApplication < Test::Unit::TestCase

  def setup
    @response_json = JSON.parse(File.read('../test/test_payload.json'))
    @app = TodoTallyApplication.new
  end

  def teardown
    @app = nil
  end

  def test_completed_items
    puts 'TestTodoTallyApplication - test_completed_items'

    completed_items = @app.completed_items(@response_json)
    assert_equal(3, completed_items[1][:total_completed])
    assert_equal(1, completed_items[2][:total_completed])
    assert_equal(3, completed_items[3][:total_completed])
    assert_equal(0, completed_items[4][:total_completed])
  end

  def test_most_completed_items
    puts 'TestTodoTallyApplication - test_most_completed_items'

    # return format [[<num>, {:total_completed=><num>}]]
    most_completed_items = @app.most_completed_items(@response_json)
    assert_equal(3, most_completed_items[0][1][:total_completed])
    # it is possible to have a tie
    assert_equal(3, most_completed_items[1][1][:total_completed])
  end
end