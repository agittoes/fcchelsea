class Season
  include Mongoid::Document

  field :title, type: String
  field :begin_date, type: DateTime
  field :end_date, type: DateTime

  has_and_belongs_to_many :teams, :inverse_of => :seasons
  has_many :rounds, :inverse_of => :season, :dependent => :destroy
end
