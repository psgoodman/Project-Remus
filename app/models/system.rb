class System < ApplicationRecord

  belongs_to :galaxy
  belongs_to :faction
  has_many :units, dependent: :destroy
  has_many :destination_links, class_name: "Link",
    foreign_key: :destination_system_id, dependent: :destroy
  has_many :origin_links, class_name: "Link",
    foreign_key: :origin_system_id, dependent: :destroy
  has_many :linked_systems, class_name: "System",
    foreign_key: :destination_system_id,
    through: :destination_links,
    source: :origin_system

  validates :name, presence: true, uniqueness: {scope: :galaxy_id}
  validates :galaxy_id, presence: true
  validates :faction, presence: true

  accepts_nested_attributes_for :units

  def populate
    new_pop = 0
    self.census.times do
      if rand(10) == 0
        new_pop += 1
      end
    end

    self.census += new_pop
    if self.census > self.max_census
      self.census = self.max_census
    end
  end

  def income
    self.census * self.raw * self.infrastructure
  end

  def add_link(other_system)
    if other_system.class == System
      linked_systems << other_system
    end
  end
end
