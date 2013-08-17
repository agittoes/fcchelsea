class SeasonResult
  include Mongoid::Document

  belongs_to :season, :inverse_of => :results
  belongs_to :team, :inverse_of => :results

  field :games, type: Integer, :default => 0

  field :scored_goals, type: Integer, :default => 0
  field :against_goals, type: Integer, :default => 0

  field :wins, type: Integer, :default => 0
  field :loses, type: Integer, :default => 0
  field :draws, type: Integer, :default => 0

  field :points, type: Integer, :default => 0

  def goals_diff
    self.scored_goals - self.against_goals
  end

  index(points: -1, scored_goals: -1)
end
