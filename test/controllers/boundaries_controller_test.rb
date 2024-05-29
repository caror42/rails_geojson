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
    response_json = JSON.parse(response.body)
    assert response_json.key?('error')
    error = response_json['error']
    assert_equal error, "boundary by this name already exists"
  end
  test "create invalid boundary (improper format, no name)" do
    boundary_json = file_fixture("27516.json").read
    bparam = JSON.parse(boundary_json)
    improper_param = bparam['geometry']
    post boundary_url, params: improper_param, as: :json
    assert_response :internal_server_error
    response_json = JSON.parse(response.body)
    assert response_json.key?('error')
    error = response_json['error']
    assert_equal error, "an error occured"
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
    response_json = JSON.parse(response.body)
    assert response_json.key?('error')
    error = response_json['error']
    assert_equal error, "no boundary by this name"
  end
  test "delete boundary by name" do
    boundary_json = file_fixture("27516.json").read
    bparam = JSON.parse(boundary_json)
    post boundary_url, params: bparam, as: :json
    delete "/boundary/27516"
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
  test "delete nonexistent boundary" do
    unreal_name = "this_is_not_a_name"
    delete "/boundary/#{unreal_name}"
    assert_response :not_found
    response_json = JSON.parse(response.body)
    assert response_json.key?('error')
    error = response_json['error']
    assert_equal error, "no boundary by this name exists"
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
  test "point is inside zipcode peninsula" do
    boundary_json = file_fixture("27516.json").read
    bparam = JSON.parse(boundary_json)
    post boundary_url, params: bparam, as: :json
    #chosen because the horizontal scan leaves and reenters the polygon
    post "/inside/27516", params: {point: [-79.135343,35.852815]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, true
  end
  test "point is inside polygon negative" do
    small_rectangle_negative = boundaries(:small_rectangle_negative)
    post "/inside/#{small_rectangle_negative.name}", params: {point: [-1,-1]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, true
  end
  test "point is outside polygon left" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [10,5]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  test "point is outside polygon right" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [-2,5]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  test "point is outside polygon up" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [2,20]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  test "point is outside polygon down" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    post "/inside/#{small_rectangle_origin.name}", params: {point: [2,-5]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  test "point is outside polygon negative" do
    small_rectangle_negative = boundaries(:small_rectangle_negative)
    post "/inside/#{small_rectangle_negative.name}", params: {point: [-10,0]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
  #points on horizontal boundary are marked as outside
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
  test "point is on vertical boundary" do
    small_rectangle_origin = boundaries(:small_rectangle_origin)
    #left boundary is in
    post "/inside/#{small_rectangle_origin.name}", params: {point: [0, 2]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, true
    #right boundary is out
    post "/inside/#{small_rectangle_origin.name}", params: {point: [5, 2]}, as: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    assert response_json.key?('is_inside')
    is_inside = response_json['is_inside']
    assert_equal is_inside, false
  end
end
