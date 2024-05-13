class ApplicationController < ActionController::API
    require_relative '../interactors/inside_polygon'
    require_relative '../models/boundary'
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
        my_str2 = Boundary.make
        data = {message: my_str2}
        render json: data
        # Boundary.create(
        #     minx: 0.3,
        #     maxx: 1.3,
        #     miny: 0.31,
        #     maxy: 1.31,
        #     coordinates: "I am on Railsyeah!"
        # )
    end
end
