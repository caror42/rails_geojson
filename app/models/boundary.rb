class Boundary < ApplicationRecord
    def self.make(geojson)
        #make polygon from json
        name = self.get_name_from_json(geojson)
        if self.find_by_name(name)
            return "boundary by this name already exists"
        end
        polygon = self.json_to_polygon(geojson)
        #find max x and min x
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
    end
    def self.find_by_name(name)
        return Boundary.find_by(name: name)
    end
    def self.delete_by_name(name)
        boundary = self.find_by_name(name)
        if !boundary
            return "no boundary by this name exists"
        end
        boundary.destroy
        return boundary
    end
end
