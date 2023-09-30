class CommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :comment_not_found


  def index
    @article=Article.find(params[:article_id])
    render json:@article.comments
  end
  
  def show
    @comment = Article.find(params[:article_id]).comments.find(params[:id])
    render json:@comment
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.destroy()
      render json:"Comment delete Successfully"
    end

  end

  def update
    @comment = Article.find(params[:article_id]).comments.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

    def article_not_found
      render json: "Article with given Id Not Available"
    end

    def comment_not_found
      render json: "Commment with given Id Not Available"
    end

end
