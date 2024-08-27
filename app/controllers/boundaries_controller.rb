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
    @boundary = Boundary.new(
      minx: boundary_params["minx"],
      maxx: boundary_params["maxx"],
      miny: boundary_params["miny"],
      maxy: boundary_params["maxy"],
      coordinates: boundary_params["coordinates"]
    )
    if @boundary.save
      render json: @boundary, status: :created, location: @boundary
    else
      render json: @boundary.errors, status: :unprocessable_entity
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boundary
      @boundary = Boundary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def boundary_params
      params.fetch(:boundary)
      #safe_params = params.permit(:minx, :maxx, :miny, :maxy, :coordinates)
    end
end
