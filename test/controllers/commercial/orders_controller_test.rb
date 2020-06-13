require 'test_helper'

class Commercial::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get commercial_orders_index_url
    assert_response :success
  end

end
