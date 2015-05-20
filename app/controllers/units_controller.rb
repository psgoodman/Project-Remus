class UnitsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @faction = Faction.find(params["faction_id"])
    class_list = []
    @faction.unit_classes.each do |unit_class|
      class_list << {id: unit_class.id, name: unit_class.name}
    end
    render json: class_list
  end

  def create
    @system = System.find(params[:unit][:system_id])
    if current_user.authority == "admin" || current_user == @system.galaxy.gm
      @unit = Unit.new(unit_params)
      @unit.destination = @system

      respond_to do |format|
        if @unit.save
          format.html {
            redirect_to galaxy_system_path(@system.galaxy, @system)
          }
          format.json {
            render json: {
              unit: @unit,
              faction: @unit.faction.name,
              unit_class: @unit.unit_class.name}
          }
        else
          format.html { render "systems/show" }
          format.json {
            render json: @unit.errors, status: :unprocessable_entity
          }
        end
      end
    end
  end

  def update
    @unit = Unit.find(params[:id])

    if @unit.update(unit_params)
      redirect_to unit_path(@unit)
    else
      render :edit
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @system = @unit.system
    if current_user.authority == "admin" || current_user == @system.galaxy.gm
      @unit.destroy
      respond_to do |format|
        format.html { redirect_to galaxy_system_path(@system.galaxy, @system) }
        format.json { head :no_content }
      end
    end
  end

  private

  def unit_params
    params.require(:unit).permit(
      :name, :system_id, :destination_id, :faction_id, :unit_class_id
      )
  end
end
