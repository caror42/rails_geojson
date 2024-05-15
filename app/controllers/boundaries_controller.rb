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
    def delete_boundary
        boundary = Boundary.delete_by_name(params[:name])
        render json: boundary
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
            render json: is_inside
            return
        end
        render json: "no boundary by this name"
    end
end
