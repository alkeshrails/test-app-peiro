require "test_helper"

class Api::PingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_ping_index_url
    assert_response :success
  end
end
