class TabledUserScoresController < ApplicationController
  before_action :set_tabled_user_score, only: [:show, :edit, :update]

  # GET /tabled_user_scores
  # GET /tabled_user_scores.json
  def index
    @tabled_user_scores = TabledUserScore.all
  end

  # GET /tabled_user_scores/1
  # GET /tabled_user_scores/1.json
  def show
  end

  # GET /tabled_user_scores/new
  def new
    @tabled_user_score = TabledUserScore.new
  end

  # GET /tabled_user_scores/1/edit
  def edit
  end

  def delete_all
    TabledUserScore.delete_all
  end

  # POST /tabled_user_scores
  # POST /tabled_user_scores.json
  def create
    puts "AAAAASDASDSADASDASDASDASDSAD: #{params}"
    @tabled_user_score_params = params[:tabled_user_scores]
    @tabled_user_score_params.each do |tabled_user_score_param|
      puts "22AAAAASDASDSADASDASDASDASDSAD: #{tabled_user_score_param[:user_id]},  #{tabled_user_score_param[:tabled_score]}"

      @tabled_user_score = TabledUserScore.new(:user_id => tabled_user_score_param[:user_id], :score => tabled_user_score_param[:tabled_score] )
      @tabled_user_score.save
    end
    respond_to do |format|
      format.json { render :json => @tabled_user_scores }
    end

  end

  # PATCH/PUT /tabled_user_scores/1
  # PATCH/PUT /tabled_user_scores/1.json
  def update
    respond_to do |format|
      if @tabled_user_score.update(tabled_user_score_params)
        format.html { redirect_to @tabled_user_score, notice: 'Tabled user score was successfully updated.' }
        format.json { render :show, status: :ok, location: @tabled_user_score }
      else
        format.html { render :edit }
        format.json { render json: @tabled_user_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tabled_user_scores/1
  # DELETE /tabled_user_scores/1.json
  def destroy
    @tabled_user_score.destroy
    respond_to do |format|
      format.html { redirect_to tabled_user_scores_url, notice: 'Tabled user score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tabled_user_score
    @tabled_user_score = TabledUserScore.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tabled_user_score_params
    params.require(:tabled_user_score).permit(:user_id, :score)
  end
end
