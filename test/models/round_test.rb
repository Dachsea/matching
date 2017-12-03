require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  def setup
    @round = Round.new(name: "Test Round", date: "2017-12-03", group_limit: 2)
  end

  test "name should be present" do
    @round.name = " "
    assert_not @round.valid?
  end

  test "date should be present" do
    @round.date = " "
    assert_not @round.valid?
  end
end
