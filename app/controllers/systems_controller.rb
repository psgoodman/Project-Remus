class SystemsController < ApplicationController

  def show
    @system = System.find(params[:id])
    @unit = Unit.new
  end
end
