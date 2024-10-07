class BoundariesController < ApplicationController
  wrap_parameters false
  before_action :set_boundary, only: %i[ show update destroy ]

  # GET /boundaries
  def index
    if (params.has_key?(:name))
      @boundaries = Boundary.find_by(name: params[:name])
    elsif (params.has_key?(:uuid))
      @boundaries = Boundary.find_by(uuid: params[:uuid])
    else
      @boundaries = Boundary.all
    end

    render json: @boundaries
  end

  # GET /boundaries/1
  def show
    render json: @boundary
  end

  # POST /boundaries
  def create
    if is_geojson_valid(geojson_params)
      @boundary = Boundary.make(geojson_params)
      if @boundary.save
        UserBoundary.create!(
          boundary_id: @boundary.id,
          user_id: @current_user.id,
        )
        render json: @boundary, status: :created, location: @boundary
      else
        render json: @boundary.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "invalid params" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /boundaries/1
  def update
    # works because of implementation -- but maybe should modify to be more specific
    if @boundary.update(geojson_params)
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
    # TODO: encase in try catch and pass errors through if desired
    is_inside = InsidePolygon.point_in_poly(inside_params)
    render json: { is_inside: is_inside }, status: :ok
  end

  private

  def set_boundary
    @boundary = Boundary.find(params[:id])
  end

  def inside_params
    params.permit(:id, point: []).except(:controller, :action)
  end

  # Only allow a list of trusted parameters through.
  def geojson_params
    params.permit!.except(:controller, :action).to_h
  end

  def is_geojson_valid(geojson)
    # validate geojson format and confirm that the type of object is a polygon (ie not a point)
    Geojsonlint.validate(geojson).valid? and geojson[:geometry][:type] == "Polygon"
  end
end
