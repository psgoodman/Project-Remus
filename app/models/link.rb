class Link < ApplicationRecord
  belongs_to :origin_system, class_name: "System"
  belongs_to :destination_system, class_name: "System"

  validates :origin_system, presence: true
  validates :destination_system, presence: true

end
