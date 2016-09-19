class PuzzlesController < ApplicationController
  before_action :set_puzzle, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:create, :update]


  respond_to :json

  # GET /puzzles
  # GET /puzzles.json
  def index
    @puzzles = Puzzle.all
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
    @puzzle.save
    respond_with(@puzzle)
  end

  # PATCH/PUT /puzzles/1
  # PATCH/PUT /puzzles/1.json
  def update
    @puzzle.update(puzzle_params)
    if (!params[:file].nil?)
      @puzzle.image = params[:file]
    end
    @puzzle.save
    respond_with(@puzzle)
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
      params.require(:puzzle).permit(:no, :name, :question, :answer, :publish_date, :publish, :year, :score)
    end
end
