class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.caption = params[:post][:caption]

    respond_to do |format|
      if @post.save
        # Your code here! Send a request to the IFTTT link, with
        # @post.photo.service_url as one of the parameters.
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.caption = params[:post][:caption]
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    Like.all.each do |like|
      if like.post == @post
        like.destroy
      end
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def like
    @post = Post.find(params[:id]) # or, @post = Post.find_by(id: params[:id])
    @like = Like.find_by(user: current_user, post: @post)
    if @like.nil?
      @like = Like.create(user: current_user, post: @post)
    else
      @like.destroy
    end
    redirect_to posts_path # or, redirect_to "/posts"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      #logger.debug "in post_params"
      #logger.debug :user_id
      #params.require(:post).permit(:user_id, :caption)
    end
end
