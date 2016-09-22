class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:create, :update, :get_user_answer]

  respond_to :json

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end
  # GET /answers/:puzzleId
  def get_user_answer
    answer = AnswersHelper.findUsersPrevAnswers(current_user.id, params[:puzzle_id])
    respond_with answer
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.bonus = AnswersHelper.calculateBonus(@answer)
    if @answer.save
      PuzzlesHelper.calculate_and_save_score_auto(@answer.puzzle_id)
      respond_to do |format|
        format.json { render :json => @answer }
      end
    else
      show_error ErrorCodeAnswerCannotCreate, "Your answer can not create, please try again"
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    @answer.bonus = AnswersHelper.calculateBonus(@answer)
    if @answer.update(answer_params)
      PuzzlesHelper.calculate_and_save_score_auto(@answer.puzzle_id)
      respond_to do |format|
        format.json { render :json => @answer }
      end
    else
      show_error ErrorCodeAnswerCannotUpdate, "Your answer can not update,  please try again"
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    puts(params[:answered][:id])
    @answer = Answer.find(params[:answered][:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answered).permit(:puzzle_id, :answer)
  end
end
