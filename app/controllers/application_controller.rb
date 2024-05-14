class ApplicationController < ActionController::API
    def inside
        #my_str = InsidePolygon.testing_func
        # hash = JSON.parse request.body.read
        # my_str = hash["note"]
        #my_str = request.raw_post
        my_str2 = InsidePolygon.point_in_poly([19.891395329260575, 0.2818513459221208], request.body.read)
        data = { message: my_str2 }

        render json: data
    end
    def boundary
        new_boundary = Boundary.make(request.body.read)
        render json: new_boundary
    end
    def get_boundary
        boundary = Boundary.find_by_name(params[:name])
        if !boundary
            render json: "no boundary by this name"
            return
        end
        render json: boundary
    end
    def inside_by_name
        boundary = Boundary.find_by_name(params[:name])
        if boundary
            is_inside = InsidePolygon.point_in_poly(request.body.read, boundary.coordinates, boundary.minx, boundary.maxx, boundary.miny, boundary.maxy)
            render json: is_inside
            return
        end
        render json: "no boundary by this name"
    end
end
