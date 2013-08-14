class PostCategoriesController < ApplicationController
  before_action :target_post_category_required, :only => [:edit, :update, :destroy]

  def index
    @post_category = PostCategory.new
  end

  def edit
    render :index
  end

  def create
    @post_category = PostCategory.create(post_category_params)

    redirect_to post_categories_path
  end

  def update
    @post_category.update_attributes(post_category_params)

    redirect_to post_categories_path
  end

  def destroy
    @post_category.destroy

    redirect_to post_categories_path
  end

  private

  def post_category_params
    params.require(:post_category).permit(:key, :title, :parent_id)
  end

  def target_post_category_required
    @post_category = PostCategory.find(params[:id])
  end
end
