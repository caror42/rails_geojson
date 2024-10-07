class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def login
    @current_user ||= User.find_by(token: params[:token])
  end

  def authenticate
    render json: { error: "Not Authorized" }, status: :unauthorized unless login
  end
end
