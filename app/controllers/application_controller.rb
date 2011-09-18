class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def authenticate
    logged_in? ? true : access_denied
  end
  
  def is_admin
    admin? ? true : not_allowed
  end

  def logged_in?
    current_user.is_a? User
  end
  
  def admin?
    current_user.level == 0
  end

  helper_method :logged_in?

  def access_denied
    redirect_to login_path, :notice => 'Login is required!' and return false
  end
  
  helper_method :admin?
  
  def not_allowed
    redirect_to places_path, :notice => 'You are not allowed to access this page' and return false
  end
  
end
