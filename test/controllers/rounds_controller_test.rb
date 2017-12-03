require 'test_helper'

class RoundsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @daichi = members(:daichi)
    @misaki = members(:misaki)
    @kaorin = members(:kaorin)
    @kakoi = members(:kakoi)
    @prince = members(:prince)
    @hattori = members(:hattori)
    @two_round = rounds(:round_in_two_members)
    @four_round = rounds(:round_in_four_members)
  end

  test "should get new" do
    get new_round_path
    assert_response :success
  end

  test "should get index" do
    get rounds_path
    assert_response :success
  end

  test "should get edit" do
    get edit_round_path(@two_round)
    assert_response :success
  end

end
