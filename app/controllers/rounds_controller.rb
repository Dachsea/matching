class RoundsController < ApplicationController
  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
    if @round.save
      flash[:success] = "ラウンドが作成されました"
      redirect_to rounds_url
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
  end

  def edit
  end

  private
    def round_params
      params.require(:round).permit(:name, :date, :group_limit, member_ids: [])
    end
end
