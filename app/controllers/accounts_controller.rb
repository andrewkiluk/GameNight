class AccountsController < ApplicationController

  require 'digest'

  skip_before_action :require_login, only: [:welcome, :login_form, :login, :signup, :signup_form]

  def welcome
    # just render
  end

  def login_form

  end

  def login
    user_name = params[:user_name]
    hashed_password = Digest::SHA256.digest params[:password]
    redirect_path = params[:redirect_path] ? params[:redirect_path] : root_path

    current_user = User.where(first_name: 'does not exist').take

    if current_user
      session[:current_user_id] = current_user.id
      redirect_to redirect_path
    else
      flash[:error] = "Username / Password combination not found."
      redirect_to login_path
    end
  end

  def signup_form

  end

  def signup

  end


  def logout
    redirect_to :root
  end

  def self.logged_in?
    true
  end

end
