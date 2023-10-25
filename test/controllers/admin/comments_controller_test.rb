require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get admin_comments_form_url
    assert_response :success
  end

  test "should get index" do
    get admin_comments_index_url
    assert_response :success
  end
end
