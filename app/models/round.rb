class Round < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true
  has_many :round_members
end