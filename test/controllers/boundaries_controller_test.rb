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
    # get boundary_url(name: "27516")
    # assert_response :success
  end
  test "get boundary by non-existent name" do
    unreal_name = "this is not a name"
    get "/boundary/unreal_name"
    assert_response :not_found
    # get boundary_url(unreal_name)
    # assert_response :conflict
  end
end
