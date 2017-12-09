class Round < ApplicationRecord
  attr_accessor :matched_groups
  validates :name, presence: true
  validates :date, presence: true

  has_many :round_members, dependent: :destroy
  has_many :members, through: :round_members
  accepts_nested_attributes_for :round_members, allow_destroy: true

  def create_groups
    @matched_groups = GroupMaker.new({round: self}).matching

    group_number = 1
    @matched_groups.each do |group|
      RoundMember.where(member_id: group.map{|item| item.id}).where(round_id: self.id).update_all(group_number: group_number)
      group_number += 1
    end
  end

  #[1: [member1,member2], 2: [member3,member4]]
  def get_group_members
    num_of_groups = RoundMember.where(round_id: self.id).order(:group_number).last.group_number
    group_members = {}

    1.upto num_of_groups do |n|
      member_ids = RoundMember.where(round_id: self.id).where(group_number: n).pluck(:member_id)
      group_members[n] = Member.where(id: member_ids)
    end

    return group_members
  end

  #[name1,name2,name3]
  def get_member_names
    self.members.map{ |member| member.name}
  end

  def get_group_number_by_member(member)
    unless self.round_members.find_by(member_id: member).blank?
      self.round_members.find_by(member_id: member).group_number
    else
      nil
    end
  end
end