class RoundsController < ApplicationController
  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
    if @round.save && @round.create_groups
      flash[:success] = "マッチングが完了しました"
      redirect_to @round
    else
      flash[:danger] = "ラウンド作成に失敗しました"
      redirect_to new_round_url
    end
  end

  def index
    @rounds = Round.all
  end

  def show
    @round = Round.find(params[:id])
    @group_members = @round.get_group_members
  end

  def edit
  end

  private
    def round_params
      params.require(:round).permit(:name, :date, :group_limit, member_ids: [])
    end
end