require 'test_helper'

class Base::PersonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get base_persons_index_url
    assert_response :success
  end

end
