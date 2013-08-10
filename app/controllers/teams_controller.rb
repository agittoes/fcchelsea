class TeamsController < ApplicationController
  def index
    @teams = Team.all.sort([:_id, 1])
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to teams_path
    else
      @teams = Team.all
      render :index
    end
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:key, :title, :image, :remote_image_url)
  end
end
