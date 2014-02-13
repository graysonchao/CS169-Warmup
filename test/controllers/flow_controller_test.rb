require 'test_helper'

class FlowControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "index should go to client.html" do
    get :index
    assert_response :success
    assert_template :index
  end

end
