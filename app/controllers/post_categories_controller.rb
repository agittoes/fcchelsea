class PostCategoriesController < ApplicationController
  def index
    post_categories
    @category = PostCategory.new
  end

  def create
    @post_category = PostCategory.create(post_category_params)
    redirect_to request.referer
  end

  def destroy
    PostCategory.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def post_category_params
    params.require(:post_category).permit(:title, :parent_id)
  end
end
