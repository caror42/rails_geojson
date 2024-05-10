class ApplicationController < ActionController::API
    def inside
        # my_str = inside_polygon.testing_func()
        data = { message: "success" }

        render json: data
    end
end
