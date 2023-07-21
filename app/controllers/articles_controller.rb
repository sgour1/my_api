class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])


    if stale?(last_modified: @article.updated_at)
      render json: @article
    end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      render json: @article
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :body, :avatar)
    end

end
