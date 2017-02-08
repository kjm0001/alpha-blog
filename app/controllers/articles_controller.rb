class ArticlesController < ApplicationController
  
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
      flash[:notice] = "Article was successfully created."
      # redirect to show action/method
      redirect_to article_path(@article)
    else
      # show the new page again
      render 'new'
    end
  end  
  
  # show action set article based on the article id
  def show
    @article = Article.find(params[:id]) 
  end
  # edit action
  def edit
    @article = Article.find(params[:id]) 
  end
  # update action 
  def update
    @article = Article.find(params[:id]) 
    if @article.update(article_params) 
      flash[:notice] = "Article was successfully updated."
      # redirect to show page
      redirect_to article_path(@article)
    else
      # show edit page again 
      render 'edit'
    end
  end
  
  def destroy
    @article = Article.find(params[:id]) 
    @article.destroy
    flash[:notice]  = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  # private method to set/add in title, description
  def article_params
    # allow the top level key :article permit values :title :description 
    params.require(:article).permit(:title, :description)
  end
  
end  