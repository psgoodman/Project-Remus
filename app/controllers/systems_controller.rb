class SystemsController < ApplicationController

  def show
    @system = System.find(params[:id])
  end
end
