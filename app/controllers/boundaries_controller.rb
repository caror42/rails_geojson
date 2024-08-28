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
    @boundary = Boundary.new(boundary_params)
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
      #can't find a way to strong param coordinates, as it is a 2d array
      params.require(:boundary).permit(:minx, :maxx, :miny, :maxy).tap do |whitelisted|
        whitelisted[:coordinates] = params[:boundary][:coordinates]
      end
    end
end
