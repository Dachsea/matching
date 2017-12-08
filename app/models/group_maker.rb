class GroupMaker
  require 'byebug'
  attr_accessor :round, :group_limit, :members, :matched_groups

  def initialize(args)
    @round = args[:round]
    @group_limit = args[:group_limit] || default_group_limit
    @members = args[:members] || default_members
    @matched_groups = []
  end

  #Memberの配列をreturn
  def matching
    reset_matched_groups

    #unselected_membersはidの配列
    unselected_members = members.ids.to_a

    members.each do |member|
      if unselected_members.include?(member.id)
        unselected_members.delete(member.id)
      else
        next
      end

      expected_partner = Member.where(id: unselected_members).where.not(id: other_round_group_members(member)).sample(group_limit-1)

      #自分とそれ以外のメンバーをマッチ済みグループにいれる
      matched_group = []
      matched_group.push(member, expected_partner).flatten!

      #マッチ済みグループのメンバーをunselected_membersから抜く
      unselected_members -= expected_partner.to_a.map{|item| item.id}

      #グループが完成したらmatched_groupsにいれる
      matched_groups << matched_group
    end
    return matched_groups
  end

  def other_round_group_members(member)
    #自ラウンド以外のラウンドで、自分の所属しているグループを探す
    group_numbers = RoundMember.where(round_id: other_round_ids).where(member_id: member).pluck(:group_number).compact

    #自分の所属しているグループがすでにあれば、そのMemberを配列にいれてreturn
    member_ids = RoundMember.where(group_number: group_numbers).where.not(member_id: member.id).pluck(:member_id)

    return Member.where(id: member_ids)
  end

  private
    def default_group_limit
      round.group_limit
    end

    def default_members
      round.members
    end

    def date_of_event
      round.date
    end

    def other_round_ids
      Round.where(date: round.date).where.not(id: round.id).pluck(:id)
    end

    def reset_matched_groups
      matched_groups.clear
    end

end