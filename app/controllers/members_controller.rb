class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    puts "\n\n\n\n\n\n\n#{@member.working_flg}\n\n\n\n\n\n\n"
    if @member.save
      flash[:success] = "メンバーが追加されました"
      redirect_to members_url
    else
      flash[:danger] = "メンバーの追加に失敗しました"
      render "new"
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      flash[:success] = "編集が完了しました"
      redirect_to members_url
    else
      render 'edit'
    end
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    flash[:success] = "#{member.name}の削除が完了しました"
    redirect_to members_url
  end

  private
    def member_params
      params.require(:member).permit(:name, :working_flg)
    end
end
