require "test_helper"

class BoundariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @boundary = boundaries(:one)
  end

  test "should get index" do
    get boundaries_url, as: :json
    assert_response :success
  end

  test "should create boundary" do
    assert_difference("Boundary.count") do
      post boundaries_url, params: { boundary: {} }, as: :json
    end

    assert_response :created
  end

  test "should show boundary" do
    get boundary_url(@boundary), as: :json
    assert_response :success
  end

  test "should update boundary" do
    patch boundary_url(@boundary), params: { boundary: {} }, as: :json
    assert_response :success
  end

  test "should destroy boundary" do
    assert_difference("Boundary.count", -1) do
      delete boundary_url(@boundary), as: :json
    end

    assert_response :no_content
  end
end
