class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.comments.create(comment_params.merge!(:user => signed_in_user))

    redirect_to @post
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
