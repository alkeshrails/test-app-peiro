require "test_helper"

class WebAddressControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_address_index_url
    assert_response :success
  end

  test "should get show" do
    get web_address_show_url
    assert_response :success
  end

  test "should get create" do
    get web_address_create_url
    assert_response :success
  end
end
