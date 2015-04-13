class Unit < ActiveRecord::Base

  belongs_to :system
  belongs_to :destination, class_name: "System", foreign_key: :destination_id

  validates :name, presence: true

  def set_destination(target)
    if system.links.include?(target)
      destination = target
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
