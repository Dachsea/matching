class RoundMember < ApplicationRecord
  belongs_to :round, optional: true
  belongs_to :member
end
