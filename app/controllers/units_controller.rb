class UnitsController < ApplicationController
  def create
    @system = System.find(params[:unit][:system_id])
    @unit = Unit.new(unit_params)
    @unit.destination = @system

    if @unit.save
      flash[:notice] = "Unit Created"
    else
      flash[:notice] = "Failed to Create Unit"
    end

    respond_to do |format|
      format.html { redirect_to system_path(@system) }
      format.js {}
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @system = @unit.system
    @unit.destroy
    flash[:notice] = "Unit Destroyed"
    respond_to do |format|
      format.html { redirect_to system_path(@system) }
      format.js {}
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :system_id)
  end
end
