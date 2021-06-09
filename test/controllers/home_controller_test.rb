require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get signin" do
    get home_signin_url
    assert_response :success
  end

  test "should get signup" do
    get home_signup_url
    assert_response :success
  end
end
