class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found

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
    else
      render json: @article.errors.full_messages
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors.full_messages
    end
  end

  def destroy
   
    @article = Article.find(params[:id])

    if @article.destroy
      render json: "article delete successfullya"
    else
      render json: @article.errors.full_messages
    end
 
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :body, :avatar)
    end

    def article_not_found
      render json: "Article with given Id Not Available"
    end

end
