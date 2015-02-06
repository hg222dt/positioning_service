require 'test_helper'

class AdminLoginControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
