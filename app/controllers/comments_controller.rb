class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to comments_url, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:title, :body)
    end
end
