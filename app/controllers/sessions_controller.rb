class SessionsController < ApplicationController
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def new
  end

  def create
    login = params[:session][:login].downcase
    user = nil
    if VALID_EMAIL_REGEX.match(login)
      user = User.find_by_email(login)
    else
      user = User.find_by_username(login)
    end
    
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Login Successful! Welcome back, #{user.first_name || user.username}"
      redirect_to user
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    flash.now[:info] = "Logout"
    sign_out
    redirect_to root_url
  end
end