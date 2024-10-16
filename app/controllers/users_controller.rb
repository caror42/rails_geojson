class UsersController < ApplicationController
  before_action :confirm_admin, only: %i[ index create update destroy ]
  before_action :set_user, only: %i[ show update destroy ]
  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    if @current_user.is_admin || @current_user == @user
      render json: @user
    else
      render json: @current_user, status: :unauthorized
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user == @current_user || @current_user.is_admin
      @user.destroy!
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def confirm_admin
    if !@current_user.is_admin
      render json: @current_user, status: :unauthorized
      puts("NOT ADMIN")
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :token, :is_admin)
  end
end
