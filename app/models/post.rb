class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :comments

  field :title, type: String
  field :text, type: String
  field :image, type: String

  mount_uploader :image, PostImageUploader

  around_destroy :remove_folder

  belongs_to :post_category, :inverse_of => :posts, :autosave => true

  def html
    text = self.text.bbcode_to_html({}, false)
    text = text.gsub("\n", '<br/>')
    text.html_safe
  end

  def intro
    html[/(^.+?)(<cut\/>)|(.+)/].html_safe
  end

  def feed
    html[/(^.+)(<cut\/>)|(.+)/].html_safe
  end

  private

  def remove_folder
    store_dir = "#{Rails.root}/public/#{self.image.store_dir}"
    yield
    FileUtils.remove_dir(store_dir, :force => true)
  end
end
