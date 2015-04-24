class FactionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @galaxy = Galaxy.find(params[:galaxy_id])
    @factions = @galaxy.factions
  end

  def show
    @faction = Faction.find(params[:id])
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

  def destroy
    @faction = Faction.find(params[:id])
    @galaxy = @faction.galaxy
    unless @faction.name == "Unowned"
      if current_user.authority == "admin" || current_user == @galaxy.gm
        unowned = @galaxy.factions.find_by(name: "Unowned", user: @galaxy.gm)
        @faction.units.each do |unit|
          unit.faction = unowned
          unit.save
        end
        @faction.systems.each do |system|
          system.faction = unowned
          system.save
        end
        @faction.destroy
      end
    end
    redirect_to galaxy_factions_path(@galaxy)
  end

  private

  def faction_params
    params.require(:faction).permit(:name, :user_id)
  end
end
