require "test_helper"

class BoundariesControllerTest < ActionDispatch::IntegrationTest
  test "create boundary" do
    boundary_json = file_fixture("27516.json").read
    bparam = JSON.parse(boundary_json)
    post boundary_url, params: bparam, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('boundary')
    boundary = response_json['boundary']
    assert_equal boundary['name'], "27516"
    assert_equal boundary['minx'], -79.264575
    assert_equal boundary['maxx'], -79.053125
    assert_equal boundary['miny'], 35.811339
    assert_equal boundary['maxy'], 36.017264
  end
  test "create invalid boundary (same name)" do
    boundary_json = file_fixture("27516.json").read
    bparam = JSON.parse(boundary_json)
    post boundary_url, params: bparam, as: :json
    post boundary_url, params: bparam, as: :json
    assert_response :conflict
  end
  test "get boundary by name" do
    boundary_json = file_fixture("27516.json").read
    bparam = JSON.parse(boundary_json)
    post boundary_url, params: bparam, as: :json
    get "/boundary/27516"
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('boundary')
    boundary = response_json['boundary']
    assert_equal boundary['name'], "27516"
    assert_equal boundary['minx'], -79.264575
    assert_equal boundary['maxx'], -79.053125
    assert_equal boundary['miny'], 35.811339
    assert_equal boundary['maxy'], 36.017264
  end
  test "get boundary by non-existent name" do
    unreal_name = "this_is_not_a_name"
    get "/boundary/#{unreal_name}"
    assert_response :not_found
  end
  test "point is inside polygon" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [1,1]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, true
  end
  test "point is outside polygon" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [-1,-1]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  test "point is on horizontal boundary" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [2, 10]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
    post "/inside/#{small_rectangle_origin.name}", params: {point: [2, 0]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  # test "point is on vertical boundary" do
  #   small_rectangle_origin = boundaries(:small_rectangle_origin)
  #   post "/inside/#{small_rectangle_origin.name}", params: {point: [-1,-1]}, as: :json
  #   assert_response :success
  #   response_json = JSON.parse(response.body)
  #   assert response_json.key?('is_inside')
  #   is_inside = response_json['is_inside']
  #   assert_equal is_inside, false
  # end
end
