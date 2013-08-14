module ApplicationHelper
  def format_date(date)
    if date
      date.strftime('%d.%m.%Y')
    else
      '----'
    end
  end

  def select_model_date_range(model)
    (model.begin_date..model.end_date).map {|date| [format_date(date), date]}
  end


  def post_path_ex(post)
    !post.key ? post_path(post) : post_by_key_path(post.key)
  end

  def category_path_ex(category)
    !category.key ? posts_path(:post_category => category.id) : post_by_key_path(category.key)
  end


  def post_categories
    @post_categories ||= PostCategory.parent
  end

  def post_category_for_side_bar
    @post_category_for_side_bar ||= PostCategory['news']
  end
end
