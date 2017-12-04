class Round < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true

  has_many :round_members, dependent: :destroy
  has_many :members, through: :round_members
  accepts_nested_attributes_for :round_members, allow_destroy: true
end