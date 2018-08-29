class SessionsController < ApplicationController


  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path
    else
      msg = "invalid credentials"
      render 'new'
    end
  end


  def destroy
    session[:user_id] = nil
    log_out if logged_in?
    p 'logged out successfully'
    redirect_to root_path
  end


end
