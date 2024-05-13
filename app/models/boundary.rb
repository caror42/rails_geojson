class Boundary < ApplicationRecord
    def self.make(geojson)
        #make polygon from json
        polygon = self.json_to_polygon(geojson)
        #find max x and min x
        name = self.get_name_from_json(geojson)
        minx = polygon.map(&:first).min
        maxx = polygon.map(&:first).max
        miny = polygon.map(&:last).min
        maxy = polygon.map(&:last).max
        new_boundary = Boundary.create(
            name: name,
            minx: minx,
            maxx: maxx,
            miny: miny,
            maxy: maxy,
            coordinates: polygon
        )
        return new_boundary
    end
    def self.json_to_polygon(geojson)
        obj = JSON.parse(geojson)
        poly_wrapped = obj['geometry']
        poly_unwrapped = poly_wrapped['coordinates']
        return poly_unwrapped[0]
    end
    def self.get_name_from_json(geojson)
        obj = JSON.parse(geojson)
        if obj.key?('name')
            return obj['name']
        end
        #return nil
    end
end
