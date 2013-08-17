class GamesController < ApplicationController
  before_action :round_specified?, :only => [:create]
  before_action :target_game_required, :only => [:edit, :update, :destroy]

  def new
    if round_specified?
      @game = @round.games.build
      @teams = @round.season.teams
    else
      @game = Game.new
      @teams = Team.all
    end

    render :edit
  end

  def edit
    @teams = @game.round ? @game.round.season.teams : Team.all
  end

  def create
    @game = Game.new(game_params)
    @game.round = @round if round_specified?

    if @game.save
      @game.round.season.calculate_results if round_specified?

      redirect_to round_specified? ? season_url(@round.season)+"#game-#{@game.id}" : @game
    else
      # TODO : Teams not supplied !
      render :edit
    end
  end

  def update
    @game.assign_attributes(game_params)

    if @game.save
      @game.round.season.calculate_results if @game.round
      redirect_to @game.round ? season_url(@game.round.season)+"#game-#{@game.id}" : @game
    else
      # TODO : Teams not supplied !
      render :edit
    end
  end

  def destroy
    game = Game.find(params[:id])
    season = g.round ? g.round.season : nil

    game.destroy

    season.calculate_results if season
  end

  private

  def round_specified?
    !!(@round = params.include?(:round_id) ? Round.find(params[:round_id]) : nil)
  end

  def target_game_required
    @game ||= Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(
        :date_time,
        :home_team_id, :visitor_team_id,
        :home_goals_number, :visitor_goals_number,
        :commpleted
    )
  end
  
end
