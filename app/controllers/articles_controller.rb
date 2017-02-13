class ArticlesController < ApplicationController
  
  # call the set_article method befor calling the other actions listed
  before_action :set_article, only: [:edit, :update, :show, :destroy] 
  def index
    # Grab all the articles from database
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    # error debug: display what is being passed into
    ##render plain: params[:article].inspect
    # add the passed in params to article
    @article = Article.new(article_params)
    if @article.save
      # flash to show a notice/message back to user
      flash[:success] = "Article was successfully created."
      # redirect to show action/method
      redirect_to article_path(@article)
    else
      # show the new page again
      render 'new'
    end
  end  
  
  # show action set article based on the article id
  def show
  end
  # edit action
  def edit
  end
  # update action 
  def update
    if @article.update(article_params) 
      flash[:success] = "Article was successfully updated."
      # redirect to show page
      redirect_to article_path(@article)
    else
      # show edit page again 
      render 'edit'
    end
  end
  
  def destroy
    @article.destroy
    flash[:danger]  = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  # created this method, as it was repeated 4x in previous instance methods for
  # show, edit, update, destroy
  def set_article
    @article = Article.find(params[:id])  
  end
  
  # private method to set/add in title, description
  def article_params
    # allow the top level key :article permit values :title :description 
    params.require(:article).permit(:title, :description)
  end
  
  
end  