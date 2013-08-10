class RoundsController < ApplicationController
  before_action :season_required, :only => [:new, :create]

  def new
    @round = @season.rounds.build
  end

  def create
    @round = @season.rounds.build(round_params)
    if @round.save
      redirect_to new_round_game_path @round
    else
      render :new
    end
  end

  def destroy
    Round.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def season_required
    raise 'Cant create round withont season' unless @season ||= Season.find(params[:season_id])
  end

  def round_params
    params.require(:round).permit(:begin_date, :end_date)
  end
end
