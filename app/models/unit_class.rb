class UnitClass < ApplicationRecord
  belongs_to :faction
  has_many :units

  validates :name, presence: true
  validates :faction, presence: true
end
