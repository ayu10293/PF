require "test_helper"

class Public::BagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_bags_index_url
    assert_response :success
  end
end
