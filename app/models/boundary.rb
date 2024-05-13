class Boundary < ApplicationRecord
    def self.make(geojson)
        Boundary.create(
            minx: 0.3,
            maxx: 1.3,
            miny: 0.31,
            maxy: 1.31,
            coordinates: [[1, 4], [2, 5]]
        )
        return "hey"
    end
    def self.json_to_polygon(geojson)
        obj = JSON.parse(geojson)
        poly_wrapped = obj['geometry']
        poly_unwrapped = poly_wrapped['coordinates']
        return poly_unwrapped[0]
    end
end
