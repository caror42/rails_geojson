require "test_helper"

class InsideInteractorTest < ActionDispatch::IntegrationTest
  test "inside rectangle" do
    assert_equal(true, InsidePolygon.point_in_poly(@params))
  end
  test "outside rectangle" do
    assert_equal(false, InsidePolygon.point_in_poly(@outside_params))
  end
  test "missing point param" do
    assert_raise RuntimeError do
      InsidePolygon.point_in_poly(@id_param_only)
    end
  end
  test "missing id param" do
    assert_raise RuntimeError do
      InsidePolygon.point_in_poly(@point_param_only)
    end
  end
  setup do
    @boundary = boundaries(:one)
    @params = {
      "point": [ 1, 1.5 ],
      "id": @boundary.id
    }
    @outside_params = {
      "point": [ 5, 8 ],
      "id": @boundary.id
    }
    @id_param_only = {
      "id": @boundary.id
    }
    @point_param_only = {
      "point": [ 1, 1.5 ]
    }
  end
end
