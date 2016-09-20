class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:create, :update]

  prepare_params_for :current, :admin, :puzzle_id => [:required, :not_empty, :type => Puzzle]

  respond_to :json

  def current
    @comments = CommentsHelper.current(params[:puzzle_id])
    respond_with @comments
  end

  def admin
    @comments = CommentsHelper.admin(params[:puzzle_id])
    respond_with @comments
  end


  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.publish = false
    @comment.user_id = current_user.id
    if @comment.save
      respond_with(@comment)
    else
      respond_with(@comment.errors)
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.update(comment_params)
    if @comment.save
      respond_with(@comment)
    else
      respond_with(@comment.errors)
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:puzzle_id, :user_id, :subject, :message, :publish, :isCommentTop)
  end
end
