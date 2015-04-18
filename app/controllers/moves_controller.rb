class MovesController < ApplicationController
  def new
    @system = System.find(params[:system_id])
  end
end
