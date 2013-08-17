class Season
  include Mongoid::Document
  @@last_results_calculation_time = {}

  field :title, type: String

  has_and_belongs_to_many :teams, :inverse_of => :seasons
  has_many :rounds, :inverse_of => :season, :dependent => :destroy

  has_many :results, :class_name => 'SeasonResult', :inverse_of => :season, :dependent => :destroy

  def get_results
    if (Time.now - @@last_results_calculation_time.fetch(self.id, Time.new(0))) > 1.minute
      calculate_results
    end

    self.results
  end

  def calculate_results
    results = {}
    cur_date = DateTime.now

    self.teams.each do |t|
      results[t.id] = {
        games: 0,

        scored_goals: 0,
        against_goals: 0,
        scored_against_diff: 0,

        wins: 0,
        loses: 0,
        draws: 0,

        points: 0
      }
    end

    self.rounds.each do |r|
      r.games.each do |g|
        next unless g.completted?
        next unless g.home_goals_number && g.visitor_goals_number

        g.teams.each { |t| results[t.id][:games] += 1 }

        results[g.home_team.id][:scored_goals] += g.home_goals_number
        results[g.home_team.id][:against_goals] += g.visitor_goals_number
        results[g.home_team.id][:scored_against_diff] = g.home_goals_number - g.visitor_goals_number

        results[g.visitor_team.id][:scored_goals] += g.visitor_goals_number
        results[g.visitor_team.id][:against_goals] += g.home_goals_number
        results[g.visitor_team.id][:scored_against_diff] = g.visitor_goals_number - g.home_goals_number


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

    results.keys.each do |team_id|
      se = SeasonResult.find_or_initialize_by(season_id: self.id, team_id: team_id)
      se.assign_attributes(results[team_id])
      se.save

      results[team_id] = se
    end

    @@last_results_calculation_time[self.id] = Time.now
    results
  end
end