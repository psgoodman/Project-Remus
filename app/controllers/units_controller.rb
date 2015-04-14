class UnitsController < ApplicationController

  def create
    @system = System.find(params[:unit][:system_id])
    @unit = Unit.new(unit_params)
    @unit.destination = @system

    respond_to do |format|
      if @unit.save
        format.html { redirect_to :back, notice: "Unit Created" }
        format.json { render json: @unit }
      else
        format.html { render "systems/show" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
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
    @unit.destroy
    flash[:notice] = "Unit Destroyed"
    respond_to do |format|
      format.html { redirect_to galaxy_system_path(@system) }
      format.json { head :no_content }
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :system_id)
  end
end
