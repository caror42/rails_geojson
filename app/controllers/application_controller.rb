class ApplicationController < ActionController::API
  before_action :authenticate

  def login
    if (session[:token])
      @current_user = User.find_by(token: session[:token])
    else
      @current_user ||= User.find_by(token: params[:token])
      session[:token] = params[:token]
    end
  end

  private

  def authenticate
    render json: { error: "Not Authorized" }, status: :unauthorized unless login
  end
end
