class MovesController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_gm!, only: [:create]

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

  protected

  def authenticate_gm!
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    elsif current_user.authority != "admin" && current_user != @galaxy.gm
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
