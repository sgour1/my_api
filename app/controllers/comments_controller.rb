class CommentsController < ApplicationController
  

  def index
    @article=Article.find(params[:article_id])
    render json:@article.comments
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
    @comment.destroy()
  end

  private

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
