class Unit < ActiveRecord::Base

  belongs_to :system
  belongs_to :destination, class_name: "System", foreign_key: :destination_id

  validates :name, presence: true

  def set_destination(destination)
    if location.links.include?(destination)
      destination = destination
    else
      return false
    end
  end

  def move
    location.contents.delete(self)
    destination.contents << self
    location = destination
  end
end
