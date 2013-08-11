class Game
  include Mongoid::Document

  field :begin_date, type: DateTime
  field :end_date, type: DateTime

  field :home_goals_number, type: Integer, :default => 0
  field :visitor_goals_number, type: Integer, :default => 0

  belongs_to :home_team, class_name: 'Team', :inverse_of => :home_games
  belongs_to :visitor_team, class_name: 'Team', :inverse_of => :visitor_games
  has_and_belongs_to_many :teams, :inverse_of => :games

  belongs_to :round, :inverse_of => :games


  before_save :set_teams_list
  before_save :set_end_date


  def completted?
    self.end_date < DateTime.now
  end

  private

  def set_teams_list
    self.teams = [self.home_team, self.visitor_team]
  end

  def set_end_date
    self.end_date = self.begin_date + 2.hour unless self.end_date
  end
end
