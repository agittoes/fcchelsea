class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :comments

  field :title, type: String
  field :text, type: String
  field :image, type: String
end
