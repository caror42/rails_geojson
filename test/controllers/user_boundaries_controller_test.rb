require "test_helper"

class UserBoundariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    puts(@user)
    puts(@user.name)
    puts(@user.token)
    # ApplicationController.instance_variable_set(:@current_user, @user)
    # BoundariesController.instance_variable_set(:@current_user, @user)
    # UsersController.instance_variable_set(:@current_user, @user)
    # get users_url, as: :json
    @boundary = boundaries(:one)
  end
  test "should create boundary" do
    raw_boundary_json = file_fixture("27516.json").read
    parsed_boundary_json = JSON.parse(raw_boundary_json)
    paramsy = parsed_boundary_json.as_json.merge("token" => @user.token)
    puts(@user.token)
    paramsy = paramsy.to_json
    #puts(paramsy)
    puts(@user.token)
    assert_difference("Boundary.count") do
      post boundaries_url, params: paramsy, as: :json
    end
    assert_response :created
    new_boundary = JSON.parse(@response.body)
    new_user_boundary = UserBoundary.find_by_boundary_id(new_boundary["id"])
    assert_not_nil(new_user_boundary)
    puts(new_user_boundary["user_id"])
  end
end
