require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @organization = organizations(:one)
  end

  test "should get redirect without valid token" do
    get users_new_url
    assert_redirected_to root_url
  end

  # test "should sign up" do
  #   assert_difference("User.count") do
  #     post login_url, params: { email: "lazaronixon@hey.com", password: "Secret1*3*5*", password_confirmation: "Secret1*3*5*", organization_id: organizations(:one).id, first_name: "Lazaro", last_name: "Nixon" }
  #   end
  #
  #   assert_redirected_to root_url
  # end
end
