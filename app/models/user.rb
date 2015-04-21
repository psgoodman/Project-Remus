class User < ActiveRecord::Base
  has_many :owned_galaxies, class_name: "Galaxy", foreign_key: :gm_id
  has_many :factions
  has_many :galaxies, through: :factions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
