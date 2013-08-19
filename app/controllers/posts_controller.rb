class PostsController < ApplicationController
  before_action :admin_permissions_required, :except => [:index, :show, :show_by_key]
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
  end

  def show_by_key
    key = params.require(:key)
    @post = Post[key]
    if @post
      render :show
    else
      @category = PostCategory[key]
      if @category
        @posts = @category.posts
        render :index
      else
        raise 'Not fownd'
      end
    end
  end

  def new
    @post = Post.new
    render :edit
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :edit
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
        :new_key,
        :title,
        :text,
        :image,
        :remote_image_url,
        :allow_comments,
        :replace_line_brakes,
    )
  end

  def get_category
    @category ||= PostCategory.find(params[:post][:post_category])
  end
end
