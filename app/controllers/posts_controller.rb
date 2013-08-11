class PostsController < ApplicationController
  before_action :admin_permissions_required, :except => [:index, :show]
  before_action :target_post_required, :only => [:show, :edit, :update, :destroy]

  def index
    if params.include? :post_category
      @category = PostCategory.find(params[:post_category])
      @posts = @category.posts
    else
      @posts = Post.all.sort(created_at: -1)
    end
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
    @post.assign_attributes(post_params)

    if @post.save
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
        :post_category_id,
        :title,
        :text,
        :image,
        :remote_image_url
    )
  end

  def get_category
    @category ||= PostCategory.find(params[:post][:post_category])
  end
end
