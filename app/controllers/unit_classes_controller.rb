class UnitClassesController < ApplicationController
  def new
    @unit_class = UnitClass.new
    @faction = Faction.find(params[:faction_id])
  end

  def create
    @faction = Faction.find(params[:faction_id])
    @unit_class = UnitClass.new(unit_class_params)
    @unit_class.faction = @faction
    if @unit_class.save
      redirect_to galaxy_faction_path(@faction.galaxy, @faction)
    else
      render :new
    end
  end

  private

  def unit_class_params
    params.require(:unit_class).permit(
      :name, :description
      )
  end
end
