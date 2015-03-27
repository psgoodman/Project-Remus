class Unit < ActiveRecord::Base

  belongs_to :system

  validates :name, presence: true

  def initialize
    system.contents << self
    @destination = system
  end


  def set_destination(destination)
    if @location.links.include?(destination)
      @destination = destination
    else
      return false
    end
  end

  def move
    @location.contents.delete(self)
    destination.contents << self
    @location = @destination
  end
end
