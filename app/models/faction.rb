class Faction < ActiveRecord::Base
  belongs_to :galaxy
  belongs_to :user
  has_many :systems
  has_many :units
  has_many :unit_classes

  validates :name, presence: true, uniqueness: { scope: :galaxy_id }
  validates :user, presence: true
  validates :galaxy, presence: true

  def total_income
    systems.inject(0) do |sum, system|
      sum + system.income
    end
  end
end
