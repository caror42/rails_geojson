class BoundariesController < ApplicationController
    def inside
        params = {
            "point" => [19.891395329260575, 0.2818513459221208],
            "geojson" => request.body.read
        }
        is_inside = InsidePolygon.point_in_poly(params)
        render json: is_inside
    end
    def boundary
        new_boundary = Boundary.make(request.body.read)
        if new_boundary == "boundary by this name already exists"
            render json: {error: "boundary by this name already exists"}, status: :conflict
            return
        end
        render json: {boundary: new_boundary}, status: :ok
    end
    def get_boundary
        boundary = Boundary.find_by_name(params[:name])
        if !boundary
            render json: {error:"no boundary by this name"}, status: :not_found
            return
        end
        render json: {boundary: boundary}, status: :ok
    end
    def delete_boundary
        boundary = Boundary.delete_by_name(params[:name])
        render json: boundary
    end
    def inside_by_name
        is_inside = InsidePolygon.point_in_poly_processing(request.body.read, params[:name])
        if is_inside == "no boundary by this name"
            render json: "no boundary by this name", status: :not_found
            return
        end
        render json: {is_inside: is_inside}, status: :ok
    end
end
