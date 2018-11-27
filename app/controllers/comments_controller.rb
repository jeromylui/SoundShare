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
    logger.debug "---------in create---------"
    @comment = Comment.new
    logger.debug @comment.inspect
    logger.debug params
    @comment.content = params[:comment][:content]
    @comment.user_id = current_user.id
    @comment.post_id = @@temp

    respond_to do |format|
      if @comment.save
        logger.debug "---------worked---------"
        format.html { redirect_to posts_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        logger.debug "---------didnt--------"
        logger.debug @comment.errors.inspect
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end


end
