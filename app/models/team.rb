class Team
  include Mongoid::Document

  attr_accessor :key

  field :title, type: String
  mount_uploader :image, TeamImageUploader

  has_many :home_games, class_name: 'Game', :inverse_of => :home_team
  has_many :visitor_games, class_name: 'Game', :inverse_of => :visitor_team

  has_and_belongs_to_many :games, :inverse_of => :teams
  has_and_belongs_to_many :seasons, :inverse_of => :teams

  before_save :prepare_key
  before_save :key_to_id

  def prepare_key
    self.key = self.key.downcase.gsub(' ', '_')
  end

  def key_to_id
    self.id = self.key if self.new_record?
  end
end
