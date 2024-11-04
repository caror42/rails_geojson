require "test_helper"

class UserBoundariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post users_url, params: { name: "new_user", is_admin: true }, as: :json
    @new_user = JSON.parse(@response.body)
    @boundary = boundaries(:one)
  end
  test "should user_boundary under user id" do
    raw_boundary_json = file_fixture("27516.json").read
    parsed_boundary_json = JSON.parse(raw_boundary_json)
    boundary_and_token = parsed_boundary_json.as_json.merge("token" => @new_user["token"])
    assert_difference("Boundary.count") do
      post boundaries_url, params: boundary_and_token, as: :json
    end
    assert_response :created
    new_boundary = JSON.parse(@response.body)
    new_user_boundary = UserBoundary.find_by_boundary_id(new_boundary["id"])
    assert_not_nil(new_user_boundary)
    assert_equal(new_user_boundary["user_id"], @new_user["id"])
  end
end
