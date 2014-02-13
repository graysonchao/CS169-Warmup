require 'test_helper'

class TestapiControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "resetFixture should respond with only an errCode" do
    post :reset_fixture, post: {}
    assert_response :ok
  end
end
