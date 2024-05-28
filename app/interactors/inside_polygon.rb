module InsidePolygon
    def self.testing_func
        return "hi"
    end
    #does a horizontal scan to determine if the point is inside, need to look into edge cases more
    def self.point_in_poly params={}

        #validate existence of neccesary params and assign
        if params.key?("point")
            point = params["point"]
        else
            raise "Point param needed to test if a point is in a polygon"
        end
        if params.key?("geojson")
            geojson = params["geojson"]
        else
            raise "Geojson param needed to test if a point is in a polygon"
        end

        #process params
        if point.class == String
            point = JSON.parse(point)
            point = point['point']
        end
        if geojson.class == String
            polygon = self.json_to_polygon(geojson)
        else
            polygon = geojson
        end
        num_vertices = polygon.length
        x, y = point[0], point[1]

        #check if point is entirely out of range and go no furthur....
        if params.key?("minx")
            if x < params["minx"]
                return false
            end
        end
        if params.key?("maxx")
            if x > params["maxx"]
                return false
            end
        end
        if params.key?("miny")
            if y < params["miny"]
                return false
            end
        end
        if params.key?("maxy")
            if y > params["maxy"]
                return false
            end
        end

        inside = false
    
        p1 = polygon[0]
        
        (1..num_vertices).each do |i|
            p2 = polygon[i % num_vertices]
            
            if y > [p1[1], p2[1]].min
                if y < [p1[1], p2[1]].max
                    if x <= [p1[0], p2[0]].max
                        if (p2[1] - p1[1]) != 0
                            x_intersection = (y - p1[1]) * (p2[0] - p1[0]) / (p2[1] - p1[1]) + p1[0]
                            puts([x,y])
                            puts("point in question")
                            puts([p1,p2])
                            if p1[0] == p2[0] || x <= x_intersection
                                puts(x,y)
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