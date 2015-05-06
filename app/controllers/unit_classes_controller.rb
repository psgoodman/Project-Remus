class UnitClassesController < ApplicationController
  def new
    @unit_class = UnitClass.new
    @faction = Faction.find(params[:faction_id])
  end
end
