class MainController < ApplicationController
  def home
    @last_posts = Post.all.sort({created_at: -1})#.limit(10)
  end

  def contacts

  end

  def page
    render params[:page]
  end
end
