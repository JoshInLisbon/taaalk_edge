require 'test_helper'

class TlkFollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tlk_follows_create_url
    assert_response :success
  end

  test "should get destroy" do
    get tlk_follows_destroy_url
    assert_response :success
  end

end
