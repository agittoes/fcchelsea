class CommentsController < ApplicationController
  before_action :signed_in_user_required, :only => [:create]
  before_action :admin_permissions_required, :only => [:update, :destroy]
  before_action :target_post_required, :only => [:index, :create]
  before_action :target_comment_required, :only => [:update, :destroy]

  def index
    @comments = @post.comments

  end

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.create(comment_params.merge!(:user => signed_in_user))

    redirect_to(post_path(@post) + "#comment-#{comment.id}")
  end

  def update
  end

  def destroy
  end

  private

  def target_post_required
    @post = Post.find(params[:post_id])
  end

  def target_comment_required
    @comment = Comment.find(params[:id])
  end


  def comment_params
    params.require(:comment).permit(:text)
  end
end
