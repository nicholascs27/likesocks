require 'test_helper'

class Base::ProductModelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get base_product_models_index_url
    assert_response :success
  end

end
