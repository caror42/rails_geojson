require 'json'
module InsidePolygon
    def self.testing_func
        return "hi"
    end
    #does a horizontal scan to determine if the point is inside, need to look into edge cases more
    def self.point_in_poly(point, geojson)
        polygon = self.json_to_polygon(geojson)
        num_vertices = polygon.length
        x, y = point[0], point[1]
        inside = false
    
        #check if point is entirely out of range and go no furthur....
        if x < polygon.map(&:first).min || x > polygon.map(&:first).max || y < polygon.map(&:last).min || y > polygon.map(&:last).max
            puts "completely out of bounds"
            return false
        end

        p1 = polygon[0]
        
        (1..num_vertices).each do |i|
            p2 = polygon[i % num_vertices]
            
            if y > [p1[1], p2[1]].min
                if y <= [p1[1], p2[1]].max
                    if x <= [p1[0], p2[0]].max
                        if (p2[1] - p1[1]) != 0
                            x_intersection = (y - p1[1]) * (p2[0] - p1[0]) / (p2[1] - p1[1]) + p1[0]
                            if p1[0] == p2[0] || x <= x_intersection
                                inside = !inside
                            end
                        else
                            inside = !inside
                        end
                    end
                end
            end
            
            p1 = p2
        end 
        return inside
    end
    def self.json_to_polygon(geojson)
        obj = JSON.parse(geojson)
        poly_wrapped = obj['geometry']
        poly_unwrapped = poly_wrapped['coordinates']
        return poly_unwrapped[0]
    end
end