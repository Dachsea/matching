class Member < ApplicationRecord
  validates :name, presence: true

  has_many :round_members
end
