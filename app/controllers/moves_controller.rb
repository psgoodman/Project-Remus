class MovesController < ApplicationController
  def new
    @system = System.find(params[:system_id])
  end

  def create
    @galaxy = Galaxy.find(params[:galaxy_id])
    @galaxy.systems.each do |system|
      system.units.each do |unit|
        unit.move
      end
      system.save
    end
    redirect_to @galaxy
  end
end
