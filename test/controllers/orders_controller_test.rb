require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_index_url
    assert_response :success
  end

  test "should get show" do
    get order_show_url
    assert_response :success
  end
end
