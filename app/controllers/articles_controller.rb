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
  
  def show
    @article = Article.find(params[:id]) 
  end
    
  end
  
  private
  # private method to set/add in title, description
  def article_params
    # allow the top level key :article permit values :title :description 
    params.require(:article).permit(:title, :description)
  end
  
end  