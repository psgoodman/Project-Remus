class SystemsController < ApplicationController
  def show
    @system = System.find(params[:id])
    @unit = Unit.new
  end

  def update
    binding.pry
    @system = System.find(params[:id])
    if @system.update(system_params)
      redirect_to galaxy_system_path(@system.galaxy, @system)
    else
      render 'moves#new'
    end
  end

  private

  def system_params
    params.require(:system).permit(units_attributes: [:id, :destination_id])
  end
end
