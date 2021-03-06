class AccountsController < ApplicationController

  require 'digest'

  skip_before_action :require_login, only: [:welcome, :login_form, :login, :signup, :signup_form]

  def welcome
  end

  def login_form
  end

  def login
    email = params[:email]
    hashed_password = Digest::SHA256.digest params[:password]
    redirect_path = params[:redirect_path] ? params[:redirect_path] : :root

    @current_user = User.where(email: email).take

    if @current_user
      session[:current_user_id] = @current_user.id
      redirect_to redirect_path
    else
      flash[:error] = "Username / Password combination not found."
      redirect_to :login_form
    end
  end

  def signup_form
    # just render
  end

  def signup
    email = params[:email]
    name = params[:name]
    hashed_password = Digest::SHA256.digest params[:password]
    hashed_password_confirm = Digest::SHA256.digest params[:password_confirm]

    # passwords must match
    if hashed_password != hashed_password_confirm
      flash[:error] = "Passwords do not match."
      signup_form and return
    end

    # email must not be used
    same_email_user = User.where(email: email).take
    if same_email_user
      flash[:error] = "A user with this email address is already signed up."
      redirect_to :signup_form and return
    end

    # attempt user creation
    user = User.make_new_user(name, email, hashed_password)
    if user
      flash[:success] = "Sign up successful!"
      login
    else
      flash[:error] = "Error in signup."
      redirect_to :signup_form
    end
  end


  def logout
    session[:current_user_id] = nil
    redirect_to :root
  end

end
