class PostCategory
  include Mongoid::Document

  field :key, type: String
  field :title, type: String

  has_many :posts, :inverse_of => :post_category, :dependent => :destroy

  belongs_to :parent, class_name: 'PostCategory', :inverse_of => :children
  has_many :children, class_name: 'PostCategory', :inverse_of => :parent, :autosave => true, :dependent => :destroy

  index({key: 1}, {sparse: true, unique: true})

  before_save :unset_key_if_empty

  def self.parent
    self.where(:parent => nil)
  end

  def self.[](key)
    self.find_by(key: key)
  end

  private

  def unset_key_if_empty
    self.key = nil if !self.key || self.key.empty?
  end
end
