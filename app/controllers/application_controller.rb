class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Enforce using HTTPS
  config.force_ssl

  # Require logins by default
  before_action :require_login

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

  private

  def require_login
    unless AccountsController.logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path, flash: { redirect_path: request.original_url }
    end
  end


end
