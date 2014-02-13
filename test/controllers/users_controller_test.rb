require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  #

  test "add should always return an errCode" do
    post :add, post: {user: "abc", password: "def"}
    assert_response :success
    assert_not_nil assigns(:errCode)
  end

  test "add should handle blank fields" do
    post :add, post: {}
    assert_response :success
    assert assigns(:errCode) != 1
  end

  test "login should handle blank fields" do
    post :login, post: {}
    assert_response :success
    assert assigns(:errCode) != 1
  end

end
