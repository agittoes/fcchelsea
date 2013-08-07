class PostsController < ApplicationController
  before_action :admin_permissions_required, :except => [:index, :show]
  before_action :target_post_required, :only => [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.sort({created_at: -1})
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def target_post_required
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
        :title,
        :text,
        :image,
        :remote_image_url
    )
  end
end
