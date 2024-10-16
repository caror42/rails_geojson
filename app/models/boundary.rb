# == Schema Information
#
# Table name: boundaries
#
#  id          :bigint           not null, primary key
#  minx        :float
#  maxx        :float
#  miny        :float
#  maxy        :float
#  coordinates :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#  uuid        :uuid
#  is_public   :boolean          default(TRUE)
#
class Boundary < ApplicationRecord
  has_many :user_boundary, dependent: :destroy
  has_many :users, through: :user_boundary
  before_save :generate_uuid
  def self.make(geojson)
    name
    if (geojson[:properties].has_key?(:zipCode))
      name = geojson[:properties][:zipCode]
    end
    polygon = geojson[:geometry][:coordinates][0]
    # find max x and min x
    minx = polygon.map(&:first).min
    maxx = polygon.map(&:first).max
    miny = polygon.map(&:last).min
    maxy = polygon.map(&:last).max
    staged_boundary = Boundary.new(
      minx: minx,
      maxx: maxx,
      miny: miny,
      maxy: maxy,
      coordinates: polygon,
      name: name,
    )
    staged_boundary
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
