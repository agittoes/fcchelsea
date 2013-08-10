class GamesController < ApplicationController
  before_action :round_specified?, :only => [:create]

  def new
    if round_specified?
      @game = @round.games.build
      @teams = @round.season.teams
    else
      @game = Game.new
      @teams = Team.all
    end
  end

  def create
    @game = Game.new(game_params)
    @game.round = @round if round_specified?

    if @game.save
      redirect_to round_specified? ? season_url(@round.season)+"#game-#{@game.id}" : @game
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def round_specified?
    !!(@round = params.include?(:round_id) ? Round.find(params[:round_id]) : nil)
  end

  def game_params
    params.require(:game).permit(
        :begin_date,
        :home_team, :visitor_team,
        :home_goals_number, :visitor_goals_number,
        :commpleted
    )
  end
end
