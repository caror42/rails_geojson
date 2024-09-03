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
#
class Boundary < ApplicationRecord
    def self.make(geojson)
        polygon = geojson[:geometry][:coordinates][0]
        #find max x and min x
        minx = polygon.map(&:first).min
        maxx = polygon.map(&:first).max
        miny = polygon.map(&:last).min
        maxy = polygon.map(&:last).max
        staged_boundary = Boundary.new(
            minx: minx,
            maxx: maxx,
            miny: miny,
            maxy: maxy,
            coordinates: polygon
        )
        return staged_boundary
    end
end
