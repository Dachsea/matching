require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def setup
    @member = members(:worker)
  end

  test "name should be valid" do
    @member.name = " "
    assert_not @member.valid?
  end
end
