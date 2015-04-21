class SystemsController < ApplicationController
  before_action :authenticate_gm!, only: [:edit, :update]

  def show
    @system = System.find(params[:id])
    @unit = Unit.new
  end

  def edit
    @system = System.find(params[:id])
  end

  def update
    @system = System.find(params[:id])
    if @system.update(system_params)
      redirect_to galaxy_system_path(@system.galaxy, @system)
    else
      render 'moves#new'
    end
  end

  private

  def authenticate_gm!
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    elsif current_user.authority != "admin" && current_user != @galaxy.gm
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def system_params
    params.require(:system).permit(units_attributes: [:id, :destination_id])
  end
end
