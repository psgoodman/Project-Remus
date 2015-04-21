class FactionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @galaxy = Galaxy.find(params[:galaxy_id])
    @factions = @galaxy.factions
  end

  def new
    @galaxy = Galaxy.find(params[:galaxy_id])
    @faction = Faction.new
  end

  def create
    @faction = Faction.new(faction_params)
    @galaxy = Galaxy.find(params[:galaxy_id])
    @faction.galaxy = @galaxy
    if current_user == @faction.galaxy.gm
      if @faction.save
        flash[:notice] = "Faction Created"
        redirect_to galaxy_factions_path(@galaxy)
      else
        render :new
      end
    end
  end

  private

  def faction_params
    params.require(:faction).permit(:name, :user_id)
  end
end
