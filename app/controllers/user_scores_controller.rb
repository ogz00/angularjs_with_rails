class UserScoresController < ApplicationController
  before_action :set_user_score, only: [:show, :edit, :update, :destroy]

  def calculate_user_scores
    @scores = UserScoresHelper.calculate_user_scores
    respond_to do |format|
      format.json { render :json => @scores }
    end
  end
end
