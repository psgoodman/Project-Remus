require_relative "system.rb"
require 'csv'

class Galaxy < ActiveRecord::Base

  has_many :systems, dependent: :destroy
  belongs_to :gm,
    class_name: "User",
    foreign_key: :gm_id

  has_many :factions, dependent: :destroy
  has_many :users, through: :factions

  validates :gm, presence: true
  validates :name, presence: true, uniqueness: true
  validates :rings, numericality: {
    greater_than: 0, less_than: 8, only_integer: true
  }

  def systems_by_rings
    current_ring = 0
    result = []
    until current_ring > rings do
      ring_systems = []
      systems.each do |system|
        if system.ring == current_ring
          ring_systems << system
        end
      end
      result << ring_systems
      current_ring += 1
    end
    result
  end
end
