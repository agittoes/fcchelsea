class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :post
  belongs_to :user

  field :text, type: String
end
