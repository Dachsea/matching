class Member < ApplicationRecord
  validates :name, presence: true
  has_many :round_members, dependent: :destroy
  has_many :round, through: :round_members

  def get_group_numbers_by_date(date)
    rounds = Round.where(date: date)
    RoundMember.where(round_id: rounds).where(member_id: self.id).pluck(:group_number)
  end

  #{round1: 1, round2: 3, round3: 2}
  def get_round_name_and_numbers_by_date(date)
    rounds = Round.where(date: date)
    round_name_and_numbers = {}
    rounds.each do |round|
      number = RoundMember.where(round_id: round.id).find_by(member_id: self.id).group_number
      round_name_and_numbers[round.name] = number
    end

    return round_name_and_numbers
  end
end
