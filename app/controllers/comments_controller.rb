class CommentsController < ApplicationController

  def index
    @comments = FetchNewApprovedComments.build.call
  end

  def new
    @comment = Comment.new
  end

  def create
    success, @comment = CreateComment.build.call(comment_params)

    if success
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
