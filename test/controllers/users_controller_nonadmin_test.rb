require "test_helper"

class UsersControllerNonAdminTest < ActionDispatch::IntegrationTest
  #comment out :one in users.yml to run these tests
  #this posting details the problem https://github.com/rails/rails/issues/24566
  #TODO: edit unit tests so names are more informative
  setup do
    @nonadmin_user = users(:two)
  end
  # test "should fail to get index" do
  #   get users_url, as: :json
  #   assert_response :unauthorized
  # end
  # test "should fail to create user" do
  #   assert_no_difference("User.count") do
  #     post users_url, params: { name: @nonadmin_user.name, token: @nonadmin_user.token }, as: :json
  #   end

  #   assert_response :unauthorized
  # end
  # test "should show user" do
  #   get user_url(@nonadmin_user), as: :json
  #   assert_response :success
  # end
  # test "should fail to update user" do
  #   patch user_url(@nonadmin_user), params: { name: @nonadmin_user.name, token: @nonadmin_user.token }, as: :json
  #   assert_response :unauthorized
  # end
  # test "should destroy user" do
  #   assert_difference("User.count", -1) do
  #     delete user_url(@nonadmin_user), as: :json
  #   end

  #   assert_response :no_content
  # end
end
