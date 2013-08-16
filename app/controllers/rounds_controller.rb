class RoundsController < ApplicationController
  before_action :season_required, :only => [:new, :create]

  def new
    @round = @season.rounds.build
  end

  def create
    @round = @season.rounds.create
    redirect_to new_round_game_path @round
  end

  def destroy
    Round.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def season_required
    raise 'Cant create round withont season' unless @season ||= Season.find(params[:season_id])
  end
end
