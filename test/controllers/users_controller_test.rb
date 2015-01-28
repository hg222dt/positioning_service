require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "Should not save without name or email" do
  	u = User.new
  	assert_not u.save
  end

end
