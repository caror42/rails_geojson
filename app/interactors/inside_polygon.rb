module InsidePolygon
  #does a horizontal scan to determine if the point is inside, need to look into edge cases more
  def self.point_in_poly(params = {})
    #validate existence of neccesary params and assign
    if params.has_key?(:point)
      point = params[:point]
    else
      raise "Point param needed to test if a point is in a polygon"
    end
    if params.has_key?(:id)
      boundary = Boundary.find_by_id(params[:id])
    else
      raise "Id param needed to test if a point is in a polygon"
    end

    polygon = boundary.coordinates

    num_vertices = polygon.length
    x, y = point[0], point[1]

    #check if point is entirely out of range and go no furthur....
    if x < boundary.minx
      return false
    end
    if x > boundary.maxx
      return false
    end
    if y < boundary.miny
      return false
    end
    if y > boundary.maxy
      return false
    end

    inside = false

    p1 = polygon[0]

    (1..num_vertices).each do |i|
      p2 = polygon[i % num_vertices]

      if y > [p1[1], p2[1]].min
        if y < [p1[1], p2[1]].max
          if x < [p1[0], p2[0]].max
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
end
