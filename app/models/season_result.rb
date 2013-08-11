class SeasonResult
  include Mongoid::Document

  belongs_to :season, :inverse_of => :results
  belongs_to :team, :inverse_of => :results

  field :wins, type: Integer, :default => 0
  field :loses, type: Integer, :default => 0
  field :ties, type: Integer, :default => 0

  field :score, type: Integer, :default => 0
end
