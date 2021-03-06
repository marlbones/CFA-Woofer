class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_follow, :toggle_like, :comments]
  before_action :set_current_user, only: [:index, :toggle_follow, :toggle_like, :show, :comments]


  # GET /posts
  # GET /posts.json
  def feed
    @list = current_user.followees(User)
    @feed_posts = []
    @list.each do |item|
      item.posts.each do |post|
      @feed_posts << post
    end
    end
    @feed_posts = @feed_posts.sort! { |a,b| b[:created_at] <=> a[:created_at] }
  end

  def index
    @posts = Post.all

  end

  def toggle_follow
  @user.toggle_follow!(User.find(params[:user_id]))
  redirect_to :back
  end

  def toggle_like
  # sets @post
  @user.toggle_like!(@post)
  redirect_to :back
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  @follow_status = @user.follows?(@post.user) ? 'Unfollow' : 'Follow'
  @like_status  = @user.likes?(@post) ? 'Unlike' : 'Like'
  @likes_num = @post.likers(User).count
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
    @post.user = current_user
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def following
    @list = current_user.followees(User)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_current_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id)
    end
end
