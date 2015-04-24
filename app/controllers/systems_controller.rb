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
    if @system.update(system_params)
      redirect_to galaxy_system_path(@system.galaxy, @system)
    else
      if system_params[:units_attributes]
        render 'moves#new'
      else
        render :edit
      end
    end
  end

  private

  def system_params
    if current_user == @system.galaxy.gm
      params.require(:system).permit(
        :name,
        :census,
        :max_census,
        :raw,
        :infrastructure,
        :faction_id,
        units_attributes: [:id, :destination_id]
      )
    else
      params.require(:system).permit(units_attributes: [:id, :destination_id])
    end
  end
end
