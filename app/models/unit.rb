class Unit < ActiveRecord::Base

  belongs_to :system
  belongs_to :destination,
    class_name: "System",
    foreign_key: :destination_id

  validates :name, presence: true

  def set_destination(target)
    if system.links.where(destination_system: target).count > 0
      destination = target
    else
      return false
    end
  end

  def move
    destination.units << self
    self.system = destination
    save
  end
end
