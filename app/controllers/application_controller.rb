class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Enforce using HTTPS
  config.force_ssl

  # Require logins by default
  before_action :set_current_user
  before_action :require_login
  before_action :check_requests

  include Status

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

  def check_requests
    if @current_user
      @friend_requests = User
      .joins("JOIN relations AS rel
              ON rel.user_id = users.id")
      .where("rel.related_user_id == ?", @current_user.id)
      .where("rel.status == ?", Status::PENDING)
      .order("users.name")

      @event_invites = Invitation
      .joins("JOIN users AS u ON invitations.user_id = u.id")
      .joins("JOIN events AS e ON invitations.event_id = e.id")
      .where("u.id = ?", @current_user)
      .where("invitations.status = ?", Status::PENDING)
      .first(500)
    end
  end

end
