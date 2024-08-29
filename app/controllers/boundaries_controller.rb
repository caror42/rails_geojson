class BoundariesController < ApplicationController
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
    validated = Geojsonlint.validate(geojson_param).valid?
    if validated.valid?
      @boundary = Boundary.new(geojson_params)
      if @boundary.save
        render json: @boundary, status: :created, location: @boundary
      else
        render json: @boundary.errors, status: :unprocessable_entity
      end
    else
      render json: validated.errors, status: :unprocessable_entity
    end
    # @boundary = Boundary.new(boundary_params)
    # if @boundary.save
    #   render json: @boundary, status: :created, location: @boundary
    # else
    #   render json: @boundary.errors, status: :unprocessable_entity
    # end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boundary
      @boundary = Boundary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def geojson_param
      #can't find a way to strong param coordinates, as it is a 2d array
      params.permit!
      formatted_params = {
        "type": params[:type],
        "geometry": params[:geometry].to_h,
        "properties": params[:properties].to_h
      }
    end
end
