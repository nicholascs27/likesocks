require 'test_helper'

class Base::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get base_products_index_url
    assert_response :success
  end

end
