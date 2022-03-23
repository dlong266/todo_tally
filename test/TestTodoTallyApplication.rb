require 'test/unit'
require_relative '../todo_tally_application'

class TestTodoTallyApplication < Test::Unit::TestCase

  def setup
    @todo_response = File.read('../test/test_payload.json')
  end

  def test_completed_items
    puts 'TestTodoTallyApplication - test_completed_items'

    # Arrange

    # Act

    # Assert
    #
  end
end