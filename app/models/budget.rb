class Budget < ActiveRecord::Base
  belongs to :faction

  validates :turn, uniqueness: { scope: :faction }, numericality: {
    only_integer: true, greater_than: 0
  }
  validates :faction, presence: true
end
