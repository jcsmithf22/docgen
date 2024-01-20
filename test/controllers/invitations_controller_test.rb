require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest

  test "should get new if admin" do
    sign_in_as(users(:john_doe))
    get invitations_new_url
    assert_redirected_to root_url
    sign_in_as(users(:lazaro_nixon))
    get invitations_new_url
    assert_response :success
  end

  test "should get index if admin" do
    sign_in_as(users(:john_doe))
    get invitations_index_url
    assert_redirected_to root_url
    sign_in_as(users(:lazaro_nixon))
    get invitations_index_url
    assert_response :success
  end
end
