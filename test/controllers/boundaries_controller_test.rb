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
  test "get boundary by non-existent name" do
    #boundary_json = file_fixture("27516.json").read
    #@small = boundaries(:small_rectangle_origin).name
    @small = "this is not a name"
    puts(@small)
    get boundary_url(name: @small)
    assert_response :not_found
  end
end
