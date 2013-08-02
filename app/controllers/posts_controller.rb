class PostsController < ApplicationController
  def index
    @posts = Post.all.sort({created_at: -1})
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to new_post_path
    else
      render :edit
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(
        :title,
        :text,
        :image
    )
  end
end
