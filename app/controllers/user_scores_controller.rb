class UserScoresController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def calculate_scores
    @scores = UserScoresHelper.calculate_user_scores
    respond_to do |format|
      format.json { render :json => @scores }
    end
  end

  def calculate_tabled_scores

    #puts "puzzleIds: #{params[:puzzle_ids]}"
    @puzzleIds = params[:puzzle_ids]
    @scores = UserScoresHelper.calculate_user_scores(@puzzleIds)
    respond_to do |format|
      format.json { render :json => @scores }
    end
  end
end
