class Round
  include Mongoid::Document

  field :number, type: Integer
  field :begin_date, type: DateTime
  field :end_date, type: DateTime

  belongs_to :season, :inverse_of => :rounds
  has_many :games, :inverse_of => :round, :dependent => :destroy

  before_save :generate_number

  def generate_number
    unless self.number
      last = Round.last
      self.number = last ? (last.number + 1) : 1
    end
  end
end
