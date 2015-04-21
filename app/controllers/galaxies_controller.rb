class GalaxiesController < ApplicationController
  include GalaxiesHelper

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @galaxies = Galaxy.all
  end

  def show
    @galaxy = Galaxy.find(params[:id])
  end

  def new
    @galaxy = Galaxy.new
  end

  def create
    @galaxy = Galaxy.new(
      name: galaxy_params[:name],
      rings: galaxy_params[:rings].to_i,
      gm: current_user
    )
    base_faction = Faction.create(
      name: "Unowned",
      galaxy: @galaxy,
      user: @galaxy.gm
    )
    constructor = GalaxyConstructor.new(galaxy_params[:rings].to_i, base_faction)
    @galaxy.save
    @galaxy.systems << constructor.systems.flatten
    if @galaxy.save
      build_links(@galaxy.systems_by_rings)
      flash[:notice] = 'Galaxy Added.'
      redirect_to '/galaxies'
    else
      render :new
    end
  end

  def destroy
    if current_user.authority == "admin"
      @galaxy = Galaxy.find(params[:id])
    else
      @galaxy = Galaxy.find_by!(gm: current_user, id: params[:id])
    end
    @galaxy.destroy
    flash[:notice] = 'galaxy deleted.'
    redirect_to'/galaxies'
  end

  protected

  def galaxy_params
    params.require(:galaxy).permit(:name, :rings)
  end
end
