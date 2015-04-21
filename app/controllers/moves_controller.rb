class MovesController < ApplicationController
  before_action :authenticate_user!

  def new
    @system = System.find(params[:system_id])
  end

  def create
    if current_user.authority == "admin"
      @galaxy = Galaxy.find(params[:id])
    else
      @galaxy = Galaxy.find_by!(gm: current_user, id: params[:id])
    end
    @galaxy.systems.each do |system|
      system.units.each do |unit|
        unit.move
      end
      system.save
    end
    redirect_to @galaxy
  end
end
