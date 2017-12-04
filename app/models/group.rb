class GroupMaker
  attr_accessor :round, :members

  def initialize(args)
    @round = args[:round]
    @members = args[:members] || default_members
  end



  private
    def default_members
      round.members
    end
end