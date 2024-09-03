class BoundariesController < ApplicationController
  wrap_parameters false
  before_action :set_boundary, only: %i[ show update destroy ]

  # GET /boundaries
  def index
    @boundaries = Boundary.all

    render json: @boundaries
  end

  # GET /boundaries/1
  def show
    render json: @boundary
  end

  # POST /boundaries
  def create
    if is_geojson_valid(geojson_param)
      @boundary = Boundary.make(geojson_param)
      if @boundary.save
        render json: @boundary, status: :created, location: @boundary
      else
        render json: @boundary.errors, status: :unprocessable_entity
      end
    else
      render json: {message: "invalid params"}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /boundaries/1
  def update
    if @boundary.update(boundary_params)
      render json: @boundary
    else
      render json: @boundary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /boundaries/1
  def destroy
    @boundary.destroy!
  end

  def inside
    #TODO: encase in try catch and pass errors through if desired
    is_inside = InsidePolygon.point_in_poly(inside_param)
    render json: {is_inside: is_inside}, status: :ok
  end

  private
    def set_boundary
      @boundary = Boundary.find(params[:id])
    end
    def inside_param
      params.permit(:id, point: []).except(:controller, :action)
    end
    # Only allow a list of trusted parameters through.
    def geojson_param
      params.permit!.except(:controller, :action).to_h
    end
    def is_geojson_valid(geojson)
      #validate geojson format and confirm that the type of object is a polygon (ie not a point)
      Geojsonlint.validate(geojson).valid? and geojson[:geometry][:type] == "Polygon"
    end
end
