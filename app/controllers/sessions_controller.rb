class SessionsController < ApplicationController
layout "login"
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to places_path, :notice => "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid credentials!"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to places_path, :notice => "Logged out successfully!"
  end
end
