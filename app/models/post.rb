class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post_category, :inverse_of => :posts, :autosave => true
  field :key, type: String
  field :title, type: String
  field :text, type: String
  mount_uploader :image, PostImageUploader
  field :allow_comments, type: Mongoid::Boolean, :default => true
  embeds_many :comments
  field :replace_line_brakes, type: Mongoid::Boolean, :default => true

  index({key: 1}, {sparse: true, unique: true})
  index({created_at: -1})

  before_save :unset_key_if_empty
  around_destroy :remove_folder

  def html
    text = self.text.bbcode_to_html({}, false)
    text = text.gsub("\n", '<br/>') if replace_line_brakes?
    text.html_safe
  end

  def intro
    html[/(^.+?)(<cut\/>)|(.+)/].html_safe
  end

  def feed
    html[/(^.+)(<cut\/>)|(.+)/].html_safe
  end

  def allow_comments?
    self.allow_comments
  end

  def replace_line_brakes?
    self.replace_line_brakes
  end

  def self.[](key)
    self.find_by(key: key)
  end

  private

  def remove_folder
    store_dir = "#{Rails.root}/public/#{self.image.store_dir}"
    yield
    FileUtils.remove_dir(store_dir, :force => true)
  end

  def unset_key_if_empty
    self.key = nil if !self.key || self.key.empty?
  end

end
