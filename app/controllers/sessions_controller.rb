class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create ## login
    #render 'new'
    #debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id 
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      # use flash.now when using render 'new'
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'  
    end
  end
  
  def destroy ## log out
    session[:user_id] = nil
    flash[:success]  = "You have logged out"
    redirect_to root_path
  end
  
end