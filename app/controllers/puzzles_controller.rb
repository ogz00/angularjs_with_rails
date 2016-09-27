class PuzzlesController < ApplicationController
  before_action :set_puzzle, only: [:show, :edit, :update, :destroy, :calculate_and_save_score]
  before_filter :authenticate_user!, only: [:create, :update]


  respond_to :json

  # PATCH/PUT /puzzles/calculate_score/1
  # PATCH/PUT /puzzles/calculate_score/1.json
  def calculate_and_save_score
      current_score = PuzzlesHelper.calculate_score(@puzzle.id)
      if current_score >= 0
        @puzzle.score = current_score
        @puzzle.save
        respond_to do |format|
          format.json { render :json => @puzzle.score }
        end
      else
        show_error ErrorCodePuzzleHasntAnsweredYet, "Puzzle hasn't Answered Yet"
    end
  end

  def calculate_and_update_all_scores

    @puzzles = PuzzlesHelper.admin
    @puzzles.each do |puzzle|
      current_score = PuzzlesHelper.calculate_score(puzzle.id)
      if current_score >= 0
        puzzle.score = current_score
        puzzle.save
      else
        puzzle.score = 100
        puzzle.save
      end
    end
    respond_to do |format|
      format.json { render :json => PuzzlesHelper.admin }
    end
  end

  # GET /puzzles
  # GET /puzzles.json
  def index
    @puzzles = Puzzle.all
    respond_with @puzzles
  end

  # GET /puzzles/1
  # GET /puzzles/1.json
  def show
  end

  # GET /puzzles/new
  def new
    @puzzle = Puzzle.new
    respond_with(@puzzle)
  end

  def current
    @puzzles = PuzzlesHelper.current
    respond_with @puzzles
  end

  # GET /puzzles/1/edit
  def edit
  end

  # POST /puzzles
  # POST /puzzles.json
  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.image = params[:file]
    @puzzle.score = 100
    @puzzle.save
    respond_to do |format|
      format.json { render :json => @puzzle }
    end
  end

  # PATCH/PUT /puzzles/1
  # PATCH/PUT /puzzles/1.json
  def update
    @puzzle.update(puzzle_params)
    if (!params[:file].nil?)
      @puzzle.image = params[:file]
    end
    @puzzle.save
    respond_to do |format|
      format.json { render :json => @puzzle }
    end
  end

  # DELETE /puzzles/1
  # DELETE /puzzles/1.json
  def destroy
    @puzzle.destroy
    respond_with(@puzzle)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puzzle
      @puzzle = Puzzle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puzzle_params
      params.require(:puzzle).permit(:no, :name, :question, :answer, :publish_date, :publish, :year)
    end
end
