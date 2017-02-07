class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end
  
  def create
    # error debug: display what is being passed into
    ##render plain: params[:article].inspect
    # add the passed in params to article
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created."
      # redirect to show action/method
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end  
  
  def show
    @article = Article.find(params[:id]) 
  end
  
  def edit
    @article = Article.find(params[:id]) 
  end
  
  def update
    @article = Article.find(params[:id]) 
    if @article.update(article_params) 
      flash[:notice] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  private
  # private method to set/add in title, description
  def article_params
    # allow the top level key :article permit values :title :description 
    params.require(:article).permit(:title, :description)
  end
  
end  