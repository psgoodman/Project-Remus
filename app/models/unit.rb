class Unit < ActiveRecord::Base

  belongs_to :system
  belongs_to :destination,
    class_name: "System",
    foreign_key: :destination_id
  belongs_to :faction

  validates :system, presence: true
  validates :name, presence: true

  def move
    if system.links.where(destination_system: destination).count > 0
      destination.units << self
      self.system = destination
      save
    else
      self.destination = self.system
    end
  end
end
