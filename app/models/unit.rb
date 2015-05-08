class Unit < ActiveRecord::Base

  belongs_to :system
  belongs_to :destination,
    class_name: "System",
    foreign_key: :destination_id
  belongs_to :faction
  belongs_to :unit_class

  validates :system, presence: true
  validates :name, presence: true
  validates :unit_class, presence: true

  def move
    if system.linked_systems.where(id: destination.id).count > 0
      destination.units << self
      self.system = destination
      save
    else
      self.destination = self.system
    end
  end
end
