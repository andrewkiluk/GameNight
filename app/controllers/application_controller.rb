class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Enforce using HTTPS
  config.force_ssl

  # Require logins by default
  before_action :set_current_user
  before_action :require_login

  private

  def require_login
    unless @current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to :login_form, flash: { redirect_path: request.original_url }
    end
  end

  def set_current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end
end
