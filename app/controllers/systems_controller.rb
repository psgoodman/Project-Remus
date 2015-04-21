class SystemsController < ApplicationController

  def show
    @system = System.find(params[:id])
    @unit = Unit.new
  end

  def edit
    @system = System.find(params[:id])
  end

  def update
    @system = System.find(params[:id])
    if current_user == @system.galaxy.gm
      if @system.update(system_params)
        redirect_to galaxy_system_path(@system.galaxy, @system)
      else
        render 'moves#new'
      end
    end
  end

  private

  def system_params
    params.require(:system).permit(units_attributes: [:id, :destination_id])
  end
end
