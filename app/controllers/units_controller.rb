class UnitsController < ApplicationController
  before_action :authenticate_gm!, only: [:create, :destroy]

  def create
    @system = System.find(params[:unit][:system_id])
    @unit = Unit.new(unit_params)
    @unit.destination = @system

    respond_to do |format|
      if @unit.save
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
    respond_to do |format|
      format.html { redirect_to galaxy_system_path(@system.galaxy, @system) }
      format.json { head :no_content }
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

  def unit_params
    params.require(:unit).permit(:name, :system_id, :destination_id)
  end
end
