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
        begin
            new_boundary = Boundary.make(request.body.read)
        rescue Exception
            render json: {error: "an error occured"}, status: :internal_server_error
            return
        end
        if new_boundary == "boundary by this name already exists"
            render json: {error: new_boundary}, status: :conflict
            return
        end
        render json: {boundary: new_boundary}, status: :ok
    end
    def get_boundary
        boundary = Boundary.find_by_name(params[:name])
        if !boundary
            render json: {error: "no boundary by this name"}, status: :not_found
            return
        end
        render json: {boundary: boundary}, status: :ok
    end
    def delete_boundary
        deleted_boundary = Boundary.delete_by_name(params[:name])
        if deleted_boundary == "no boundary by this name exists"
            render json: {error: deleted_boundary}, status: :not_found
            return
        end
        render json: {boundary: deleted_boundary}, status: :ok
    end
    def inside_by_name
        boundary = Boundary.find_by_name(params[:name])
        params = {
            "point" => request.body.read,
            "geojson" => boundary.coordinates,
            "minx" => boundary.minx,
            "maxx" => boundary.maxx,
            "miny" => boundary.miny,
            "maxy" => boundary.maxy
        }
        if boundary
            is_inside = InsidePolygon.point_in_poly(params)
            render json: {is_inside: is_inside}, status: :ok
            return
        end
        render json: "no boundary by this name"
    end
end
