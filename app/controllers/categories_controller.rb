class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  
  def index
    #@categories = Category.all
    @categories = Category.paginate(page: params[:page], per_page: 5)
  
  end
  
  def new
    @category = Category.new
  
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfull"
      redirect_to categories_path
    else
      render 'new'
    end
  
  end
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5) 
  end

  ## private methods, only availabe to this controller
  private 
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    ## if not logged in, or logged in and not an admin immediately redirect
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end  
  end
  
  
end