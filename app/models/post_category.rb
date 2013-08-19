class PostCategory
  include Mongoid::Document

  attr_accessor :new_key

  field :key, type: String
  field :title, type: String

  has_many :posts, :inverse_of => :post_category, :dependent => :destroy

  belongs_to :parent, class_name: 'PostCategory', :inverse_of => :children
  has_many :children, class_name: 'PostCategory', :inverse_of => :parent, :autosave => true, :dependent => :destroy

  index({key: 1}, {sparse: true, unique: true})

  before_save :key_if_exists

  def self.parent
    self.where(:parent => nil)
  end

  def self.[](key)
    self.find_by(key: key)
  end

  private

  def key_if_exists
    self.key = new_key unless self.new_key && self.new_key.empty?
  end
end
