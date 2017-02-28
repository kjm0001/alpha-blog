class UsersController < ApplicationController
  ## allows to set the edit, update, show actions prior to any action
  ## with the private method set_user 
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  ## for the destroy action, require admin
  before_action :require_admin, only: [:destroy]
   
  def index
    ## Grab all users
    ##@users = User.all
    ## paginate users
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new 
  end
  
  def create
    ##debugger  
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}" 
      ##redirect_to articles_path
      redirect_to user_path(@user)
    else
      render 'new' 
    end
  end
  
  def edit
    #@user = User.find(params[:id])  
  end
  
  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"  
      redirect_to articles_path
    else
      
    end
  end 
  
  def show
    #@user = User.find(params[:id])  
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  ## allows admin to destroy user and user's articles
  def destroy
    @user = User.find(params[:id])  
    @user.destroy
    flash[:danger] = "User and ALL articles created by user have been deleted."
    redirect_to users_path
  end
    
  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end 
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account!"
      redirect_to root_path
    end  
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action."
      redirect_to root_path
    end
  end
  
end  