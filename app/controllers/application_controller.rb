class ApplicationController < ActionController::API
    require_relative '../interactors/inside_polygon'
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
        #impliment logic to check if zip already exists
        #impliment logic to make a new entry into the database
    end
end
