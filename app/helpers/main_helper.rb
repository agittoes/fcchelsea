module MainHelper
  def post_category_for_carousel
    @post_category_for_carousel ||= PostCategory['unofficial']
  end

  def posts_for_corousel
    last_posts = post_category_for_carousel.posts(created_at: -1).limit(18).to_a
    posts = []

    [last_posts.count, 6].min.times do
      posts << last_posts.delete(last_posts[rand last_posts.length])
    end

    posts
  end
end
