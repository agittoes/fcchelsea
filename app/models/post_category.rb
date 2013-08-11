class PostCategory
  include Mongoid::Document

  field :title, type: String

  has_many :posts, :inverse_of => :post_category, :dependent => :destroy

  belongs_to :parent, class_name: 'PostCategory', :inverse_of => :children
  has_many :children, class_name: 'PostCategory', :inverse_of => :parent, :autosave => true, :dependent => :destroy

  def self.parent
    self.where(:parent => nil)
  end
end
