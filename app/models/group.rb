class Group
  attr_accessor :group_number, :members, :round

  def initialize(args)
    @group_number = args[:group_number]
    @members = args[:members]
    @round = args[:round]
  end
end