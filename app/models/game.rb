class Game
  include Mongoid::Document

  field :date_time, type: String
  field :begin_date, type: Time
  field :end_date, type: Time

  field :home_goals_number, type: Integer
  field :visitor_goals_number, type: Integer

  belongs_to :home_team, class_name: 'Team', :inverse_of => :home_games
  belongs_to :visitor_team, class_name: 'Team', :inverse_of => :visitor_games
  has_and_belongs_to_many :teams, :inverse_of => :games

  belongs_to :round, :inverse_of => :games


  before_save :set_teams_list
  before_validation :set_begin_end_dates


  def completted?
    !!self.end_date && (self.end_date < Time.now)
  end

  private

  def set_teams_list
    self.teams = [self.home_team, self.visitor_team]
  end

  def set_begin_end_dates
    dt = DateTime.strptime(self.date_time, '%y.%m.%d %H:%M')
    dt = dt.change(offset: '+0400')

    self.begin_date = dt.to_time
    self.end_date = self.begin_date + 2.hours
  end
end
