require "test_helper"

class UsersControllerNonAdminTest < ActionDispatch::IntegrationTest
  #TODO: edit unit tests so names are more informative
  setup do
    @admin_user = users(:one)
    post users_url, params: { name: "new_user", is_admin: false }, as: :json
    @nonadmin_user = JSON.parse(@response.body)
  end
  test "should fail to get index" do
    get users_url, params: { "token" => @nonadmin_user["token"] }
    assert_response :unauthorized
  end
  test "should fail to create user" do
    assert_no_difference("User.count") do
      post users_url, params: { "name" => "invalid user", "token" => @nonadmin_user["token"] }, as: :json
    end
    assert_response :unauthorized
  end
  test "should show user (itself)" do
    get user_url(@nonadmin_user["id"]), params: { "token" => @nonadmin_user["token"] }
    assert_response :success
  end
  test "should fail to show user (other)" do
    get user_url(@admin_user["id"]), params: { "token" => @nonadmin_user["token"] }
    assert_response :unauthorized
  end
  test "should fail to update user" do
    patch user_url(@nonadmin_user["id"]), params: { "name" => "new name", "token" => @nonadmin_user["token"] }, as: :json
    assert_response :unauthorized
  end
  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@nonadmin_user["id"]), params: { "token" => @nonadmin_user["token"] }
    end
    assert_response :no_content
  end
end
