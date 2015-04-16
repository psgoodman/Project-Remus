class GalaxiesController < ApplicationController

  include GalaxiesHelper

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
    @galaxy = Galaxy.new(name: galaxy_params[:name], rings: galaxy_params[:rings].to_i)
    constructor = GalaxyConstructor.new(galaxy_params[:rings].to_i)
    @galaxy.save
    @galaxy.systems << constructor.systems.flatten
    @galaxy.save
    if @galaxy.save
      build_links(@galaxy.systems_by_rings)
      flash[:notice] = 'galaxy added.'
      redirect_to '/galaxies'
    else
      render :new
    end
  end

  def destroy
    @galaxy = Galaxy.find(params[:id])
    @galaxy.destroy
    flash[:notice] = 'galaxy deleted.'
    redirect_to'/galaxies'
  end

  protected
  def galaxy_params
    params.require(:galaxy).permit(:name, :rings)
  end
end
