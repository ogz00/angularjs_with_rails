class UserScoresController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def calculate_user_scores
    @scores = UserScoresHelper.calculate_user_scores
    respond_to do |format|
      format.json { render :json => @scores }
    end
  end
end
