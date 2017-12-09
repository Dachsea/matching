class GroupMaker
  require 'byebug'
  attr_accessor :round, :group_limit, :members, :matched_groups

  MATCHING_LOOP_LIMIT = 1000

  def initialize(args)
    @round = args[:round]
    @group_limit = args[:group_limit] || default_group_limit
    @members = args[:members] || default_members
    @matched_groups = []
  end

  def matching
    MATCHING_LOOP_LIMIT.times do |n|
      create_matched_groups
      break if matched_groups.length == (members.length / group_limit)
    end
    puts "#{matched_groups.length}"
    puts "(members.length / group_limit)"
    return matched_groups
  end

  #Memberの配列をreturn
  def create_matched_groups
    reset_matched_groups

    #unselected_member_idsはidの配列
    unselected_member_ids = members.ids.to_a

    members.shuffle.each do |member|
      if unselected_member_ids.include?(member.id)
        unselected_member_ids.delete(member.id)
      else
        next
      end

      expected_partners = []
      (group_limit-1).times do |n|
        expected_partners << matchable_partner(unselected_member_ids, member)
        #マッチ済みグループのメンバーをunselected_member_idsから抜く
        unselected_member_ids -= expected_partners.to_a.flatten.map{|item| item.id}
      end

      #自分とそれ以外のメンバーをマッチ済みグループにいれる
      matched_group = []
      matched_group.push(member, expected_partners).flatten!

      #グループが完成したらmatched_groupsにいれる
      @matched_groups << matched_group
    end
  end

  #expected_membersに候補になりえるmember, targetに自分をいれる
  def matchable_partner(expected_members, target)
    Member.where(id: expected_members).where.not(id: other_round_group_members(target)).sample(1)
  end

  #自分が一度所属したグループのメンバーを取得
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