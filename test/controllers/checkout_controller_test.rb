require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_checkout_path
    assert_response :success
  end
end
