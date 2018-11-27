class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comment = Comment.all
  end

  def new
    @comment = Comment.new
    @@temp = params[:post_id]
  end

  def create
    @comment = Comment.new
    @comment.content = params[:comment][:content]
    @comment.user_id = current_user.id
    @comment.post_id = @@temp

    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
