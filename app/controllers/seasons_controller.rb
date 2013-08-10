class SeasonsController < ApplicationController
  def last
    @season = Season.last
    render :show
  end

  def index
    @seasons = Season.all
  end

  def show
    @season = Season.find(params[:id])
  end

  def new
    @season = Season.new
    @teams = Team.all
  end

  def edit
  end

  def create
    @season = Season.new(season_params)
    @season.teams = Team.all.limit(20)
    if @season.save
      redirect_to @season
    else
      render :new
    end
  end

  def update
  end

  private

  def season_params
    params.require(:season).permit(:title, :begin_date, :end_date)
  end
end
