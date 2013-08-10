module SeasonsHelper
  def new_game(round=nil)
    round ? [round, round.games.build] : Game.new
  end
end
