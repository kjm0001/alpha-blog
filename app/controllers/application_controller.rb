class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  ## helper_method allows methods to be available to views
  helper_method :current_user, :logged_in?
  
  ## Return User from database if session user_id is stored in browser session hash
  ## Return current_user only if @current_user already exists if not 
  ## else hit the database
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  ## return boolean if @current_user already logged in as 
  ## return true if logged in else return false 
  def logged_in?
    !!current_user
  end
  
  ## only allow if user is logged in the system
  def require_user
    ## if not logged in (if true, not logged in)
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
  
end
