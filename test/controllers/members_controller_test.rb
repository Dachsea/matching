require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_path
    assert_response :success
  end

  test "should get new" do
    get new_member_path
    assert_response :success
  end

end
