class Member < ApplicationRecord
  validates :name, presence: true
  has_many :round_members, dependent: :destroy
  has_many :round, through: :round_members
end
