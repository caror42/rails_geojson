# == Schema Information
#
# Table name: boundaries
#
#  id          :bigint           not null, primary key
#  minx        :float
#  maxx        :float
#  miny        :float
#  maxy        :float
#  coordinates :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#
require "test_helper"

class BoundaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create boundary" do
   boundary_json = file_fixture("27516.json").read
   boundary = Boundary.make(boundary_json)
   assert_equal boundary.name, "27516"
   assert_equal boundary.minx, -79.264575
   assert_equal boundary.maxx, -79.053125
   assert_equal boundary.miny, 35.811339
   assert_equal boundary.maxy, 36.017264
  end
  test "find boundary by name" do
   boundary_json = file_fixture("27516.json").read
   boundary = Boundary.make(boundary_json)
   assert_equal boundary, Boundary.find_by_name("27516")
  end
  test "delete boundary by name" do
   boundary_json = file_fixture("27516.json").read
   boundary = Boundary.make(boundary_json)
   Boundary.delete_by_name(boundary.name)
   assert_nil Boundary.find_by_name("27516")
  end
end
