class Season
  include Mongoid::Document

  field :title, type: String
  field :begin_date, type: DateTime
  field :end_date, type: DateTime

  has_and_belongs_to_many :teams, :inverse_of => :seasons
  has_many :rounds, :inverse_of => :season, :dependent => :destroy

  has_many :results, :class_name => 'SeasonResult', :inverse_of => :season, :dependent => :destroy

  def calculate_results
    results = {}
    cur_date = DateTime.now

    self.teams.each do |t|
      results[t.id] = {
        wins: 0,
        loses: 0,
        draws: 0,

        points: 0
      }
    end

    self.rounds.each do |r|
      r.games.each do |g|
        next unless g.completted?

        g.teams.each { |t| results[t.id][:games] += 1 }


        if g.home_goals_number == g.visitor_goals_number
          g.teams.each do |t|
            results[t.id][:draws] += 1
            results[t.id][:points] += 1
          end
        elsif g.home_goals_number > g.visitor_goals_number
          results[g.home_team.id][:wins] += 1
          results[g.home_team.id][:points] += 3

          results[g.visitor_team.id][:loses] += 1
        else
          results[g.visitor_team.id][:wins] += 1
          results[g.visitor_team.id][:points] += 3

          results[g.home_team.id][:loses] += 1
        end
      end
    end

    results
  end
end
