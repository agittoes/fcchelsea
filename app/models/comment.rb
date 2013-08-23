class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :post
  belongs_to :user

  field :text, type: String

  validates :text, length: {minimum: 10, maximum: 1024}
end
