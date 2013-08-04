class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :comments

  field :title, type: String
  field :text, type: String
  field :image, type: String

  mount_uploader :image, PostImageUploader

  around_destroy :remove_folder

  private

  def remove_folder
    store_dir = "#{Rails.root}/public/#{self.image.store_dir}"
    yield
    FileUtils.remove_dir(store_dir, :force => true)
  end
end
