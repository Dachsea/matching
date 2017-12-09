class ResultsController < ApplicationController
  def select
  end

  def table
    @date = params[:date]
    @rounds = Round.where(date: @date)
    @members = @rounds.map{|round| round.members}.flatten.uniq
  end

  def reshuffle
    @round = Round.find(params[:id])
    @round.create_groups
    redirect_to @round
  end

end